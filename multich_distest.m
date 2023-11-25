%% Copyright(C) 2023 The University of Texas at Dallas
% Developed by: Jayson P. Van Marter
% Advisor: Prof. Murat Torlak
% Department of Electrical and Computer Engineering
%
%  This work was supported by the Semiconductor Research Corporation (SRC)
%  task 2810.076 through The University of Texas at Dallas' Texas Analog
%  Center of Excellence (TxACE).
%
%  Redistributions and use of source must retain the above copyright notice

%%
% This function sets the MUSIC parameters, stitches based on the given
% cutoff frequencies, resamples, and passes the multi-channel CFR data to
% music1_est for distance estimation using MUSIC.
%
% Inputs:
%   f : Interpolated subcarrier channel frequencies
%
%   chanEst_2W : Two-way CFR measurements
%
%   Delta_f : Frequency measurement spacing
%
%   M : Number of sources (MPCs) specified for subspace decomposition
%
%   c : Propagation speed. This changes the scan window and resolution
%   depending on if we are looking at wireless (3e8) or wired
%   (3e8/sqrt(1.4) measurements
%
%   Dr : Resampling rate
%
% Outputs:
%   dist_est : Estimated distance
%
%   MUSIC_spec : Computed MUSIC pseudospectrum

function [dist_est,MUSIC_spec] = ...
    multich_distest(f,chanEst_2W,Delta_f,M,c,Dr,fcutoff)

%% Obtain the frequencies of interest

% Number of antenna pairs
P = size(chanEst_2W,3);

% Concatenate channel frequencies and CFR measurements
f_all = f(:);
chanEst_all = reshape(chanEst_2W,[],P); % (subcarriers x antenna pairs)

% Obtain the frequencies corresponding channel measurements to stitch
incl_idx = find((f_all>fcutoff(1)) & (f_all<fcutoff(2))); % Indices of measurements to include
f_vec = f_all(incl_idx); 
chanEst_vec = chanEst_all(incl_idx,:);

%% Average any overlapping measurements
% This is for the 40 MHz stitch in the 2.4 GHz band

f_unq = unique(f_vec);
K_unq = length(f_unq);

chanEst_avg = nan(K_unq,P);
for i = 1:K_unq
    chanEst_avg(i,:) = mean(chanEst_vec(f_vec == f_unq(i),:),1);
end

%% Inputs
fInterp = (f_unq(1):Delta_f:f_unq(end)).'; % Interpolated channel indices
K = length(fInterp); % Number of CFR measurements for the channel after null subcarrier interpolation
K_Dr = floor((K - Dr)/Dr) + 1; % Number of CFR measurements after resampling and truncation

%% MUSIC struct of parameters
music.threshold = -15; % MUSIC peak threshold in dB down from the max
music.Delta_f = Dr*Delta_f; % Subcarrier spacing after resampling
music.c = c; % Propagation speed
music.k = 0:K_Dr-1; % CFR measurement indices
music.N = round(0.5*K_Dr); % Smoothing subarray size

switch c
    case 3e8 % Wireless
        music.dist_min = 0; % Min distance considered in meters
        music.dist_max = 15; % Max distance considered in meters
        music.delta = 0.02; % MUSIC scan resolution in m
    case 3e8 / sqrt(1.4) % Wired
        music.dist_min = -1; % Min distance considered in meters
        music.dist_max = 15; % Max distance considered in meters.
        music.delta = 0.001; % MUSIC scan resolution in m
end

% Steering matrix distances considered
music.dists = (music.dist_min:music.delta:music.dist_max); 

% Compute steering matrix for the set of possible delays we are considering
music.S = zeros(music.N,length(music.dists));
for m = 1:length(music.dists)
    music.S(:,m) = exp(-1i*4*pi*music.Delta_f*(music.dists(m)/music.c)*music.k(1:music.N));
end

%% Interpolate across gaps between channels
chanEst_interp = nan(length(fInterp),P);
for i = 1:P
    interpMag = interp1(f_unq,abs(chanEst_avg(:,i)),fInterp,'linear');
    interpPhase = interp1(f_unq,unwrap(angle(chanEst_avg(:,i))),fInterp,'linear');
    
    chanEst_interp(:,i) = interpMag .* exp(1i*interpPhase);
end

%% Resample to obtain the frequency-shifted measurements
chanEst_2W_deci = nan(K_Dr,P,Dr);
for i = 1:Dr
    for p = 1:P
        chanEst_2W_deci_full = chanEst_interp(i:Dr:end,p);
        chanEst_2W_deci(:,p,i) = chanEst_2W_deci_full(1:K_Dr);
    end
end

%% Distance estimation
[MUSIC_spec,dist_est] = music1_est(music,chanEst_2W_deci,M);