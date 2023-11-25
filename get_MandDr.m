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
% This function is used to return the signal subspace size for MUSIC and
% the resampling rates (number of frequency shifts) given the bandwidth.
%
% Inputs:
%   BW : Bandwidth in MHz used to set outputs
%
% Outputs:
%   M : Number of sources specified for single-channel distance esstimation
%
%   M_320 : Number of sources specified for the 320 MHz multi-channel
%   stitch. 
%
%   Dr : Resampling rate (also the number of frequency shifts)
%
%   Dr_320 : Resampling rate for the 320 MHz multi-channel stitch.


function [M,M_320,Dr,Dr_320] = ...
    get_MandDr(BW)

% Per bandwidth
switch BW
    case 20
        M = 3;
        Dr = 8;
    case 40
        M = 5;
        Dr = 12;
    case 80
        M = 10;
        Dr = 16;
    case 160
        M = 20;
        Dr = 20;
end

% For 320 MHz stitch (always uses 20 Mhz bandwidth)
M_320 = 40;
Dr_320 = 28;