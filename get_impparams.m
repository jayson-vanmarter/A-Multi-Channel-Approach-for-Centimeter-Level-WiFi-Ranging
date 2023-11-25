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
% This function is used to get the parameters for the bandwidth obtained
% from a loaded file in sve. sve contains a set of two-way measurements for
% a given location and bandwidth. These measurements span all channels for
% the given bandwidth and all antennas.
%
% Outputs:
%   Delta_f : HE-LTF frequency spacing
%
%   K : Number of frequency measurements after interpolation for null
%   subcarriers on the given channel using the HE-LTF.
% 
%   chIdx : Frequency measurement indices for the HE-LTF.
% 
%   chIdxInterp : Frequency measurement indices after interpolation across
%   null subcarrier gaps for the HE-LTF.
%
%   p_idx : Frequency indices to use for linear fitting the 160 MHz phase
%   response. The fitted response is used for mitigation of nonlinear
%   low-pass filter effects in the phase. 


function [Delta_f,K,chIdx,chIdxInterp,p_idx] = get_impparams(sve)

if sve.implementation == 0
    Delta_f = 78.125e3; % Frequency spacing
    if sve.fs == 20e6
        K = 245; % Number of CFR frequencies for MUSIC
        p_idx = nan;
        chIdx = [-122:-2,2:122];
        chIdxInterp = -122:122;
    elseif sve.fs == 40e6
        K = 489; % Number of CFR frequencies for MUSIC
        p_idx = nan;
        chIdx = [-244:-3,3:244];
        chIdxInterp = -244:244;
    elseif sve.fs == 80e6
        K = 1001; % Number of CFR frequencies for MUSIC
        p_idx = nan;
        chIdx = [-500:-3,3:500];
        chIdxInterp = -500:500;
    elseif sve.fs == 160e6
        K = 2025; % Number of CFR frequencies for MUSIC
        p_idx = (-500:500) + 1013; % Indexes for 160 MHz phase calibration
        chIdx = [-1012:-515,-509:-12,...
            12:509,515:1012];
        chIdxInterp = -1012:1012;
    end
end