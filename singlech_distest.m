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
% This function sets the MUSIC parameters and does resampling before
% passing the single-channel CFR data to music1_est for distance estimation
% using MUSIC.
%
% Inputs:
%   fInterp : Interpolated subcarrier channel frequencies
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
%   Dr : Resampling rate / Number of frequency shifts
%
% Outputs:
%   dist_est : Estimated distance
%
%   MUSIC_spec : Computed MUSIC pseudospectrum

function [dist_est,MUSIC_spec] = ...
    singlech_distest(fInterp,chanEst_2W,Delta_f,M,c,Dr)

%% Inputs
P = size(chanEst_2W,2); % Number of antenna pairs
K = length(fInterp); % Number of CFR measurements for the channel after null subcarrier interpolation
K_Dr = floor((K - Dr)/Dr) + 1; % Number of CFR measurements after resampling and truncation

%% MUSIC parameters
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

music.dists = (music.dist_min:music.delta:music.dist_max); % Steering matrix distances considered

% Compute steering matrix for the set of possible delays we are considering
music.S = zeros(music.N,length(music.dists));
for m = 1:length(music.dists)
    music.S(:,m) = exp(-1i*4*pi*music.Delta_f*(music.dists(m)/music.c)*music.k(1:music.N));
end

%% Resample to obtain the frequency-shifted measurements
chanEst_2W_deci = nan(K_Dr,P,Dr);
for d = 1:Dr
    chanEst_2W_deci_full = chanEst_2W(d:Dr:end,:); % Downsample
    chanEst_2W_deci(:,:,d) = chanEst_2W_deci_full(1:K_Dr,:); % Truncate
end

%% Distance Estimation
[MUSIC_spec,dist_est] = music1_est(music,chanEst_2W_deci,M);