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
% This function stitches 320 MHz of CFR measurements, sets the MUSIC
% parameters, and does rersampling/frequency-shifting before passing the
% multi-channel stitched CFR data to music1_est for distance estimation
% using MUSIC.
%
% Inputs:
%   f : Subcarrier channel frequencies corresponding to the two-way CFR
%   measurements
%
%   chanEst_2W : Two-way CFR measurements across channels and antennas
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
    

function [dist_est,MUSIC_spec] = chstitch320M_distest(f,chanEst_2W,Delta_f,M,c,Dr)

%% Obtain the frequencies of interest

% Number of antenna measurements
P = size(chanEst_2W,3);

% Concatenate CFR measurements across channels
chanEst_all = reshape(chanEst_2W,[],P);

% Obtain 320 MHz (16 channels) of CFR measurements
f_all = f(:); % Concatenate measurement frequencies across channels
fcutoff_l = 5.470e9; % Lower cutoff for frequencies to include
fcutoff_u = 5.795e9; % Upper curoff for frequencies to include
incl_idx = find((f_all>fcutoff_l) & (f_all<fcutoff_u)); % Indices of measurements to include
f_vec = f_all(incl_idx); % Index the set of included subcarrier channel frequencies 
chanEst_vec = chanEst_all(incl_idx,:); % Index the set of included CFR measurements

%% Inputs
fInterp = (f_vec(1):Delta_f:f_vec(end)).'; % Interpolated channel indices
K_B = length(fInterp); % Number of CFR measurements across stitched channels including subcarrier gaps
K_Dr = floor((K_B - Dr)/Dr) + 1; % Number of CFR measurements after resampling and truncation

%% MUSIC struct of parameters
music.threshold = -15; % MUSIC peak threshold in dB down from the max
music.Delta_f = Dr*Delta_f; % Subcarrier spacing after resampling
music.c = c; % Propagation speed
music.k = 0:K_Dr-1; % CFR measurement indices
music.N = round(0.5*K_Dr); % Smoothing subarray size
% music.N = K_Dr;

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

music.dists = (music.dist_min:music.delta:music.dist_max); % Steering matrix distances considered

% Compute steering matrix for the set of possible delays we are considering
music.S = zeros(music.N,length(music.dists));
for m = 1:length(music.dists)
    music.S(:,m) = exp(-1i*4*pi*music.Delta_f*(music.dists(m)/music.c)*music.k(1:music.N));
end

%% Interpolate
chanEst_interp = nan(K_B,P);
for p = 1:P
    % Interpolate magnitude and phase seperately
    interpMag = interp1(f_vec,abs(chanEst_vec(:,p)),fInterp,'linear');
    interpPhase = interp1(f_vec,unwrap(angle(chanEst_vec(:,p))),fInterp,'linear');
    chanEst_interp(:,p) = interpMag .* exp(1i*interpPhase);
end

%% Resample
chanEst_2W_deci = nan(K_Dr,P,Dr);
for d = 1:Dr
    chanEst_2W_deci_full = chanEst_interp(d:Dr:end,:);
    chanEst_2W_deci(:,:,d) = chanEst_2W_deci_full(1:K_Dr,:);
end

%% Distance estimation
[MUSIC_spec,dist_est] = music1_est(music,chanEst_2W_deci,M);