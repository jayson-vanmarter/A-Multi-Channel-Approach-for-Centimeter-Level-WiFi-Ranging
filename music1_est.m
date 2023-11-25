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
% MUSIC function with forward-backward averaging and eigenvalue
% weighting (Eigenvector method). 
%
% Inputs:
%   music : Struct of music parameters
%
%   H : CFR input matrix with the first dimension being across subcarriers
%
%   M : Covariance matrix smoothing subarray size
%
% Outputs :
%   spec_dB : MUSIC pseudospectrum in dB
%
%   dist_est : Estimated distance

function [spec_dB,dist_est] = music1_est(music,H,M)

% Move all additional measurement dimensions (i.e., antennas,
% frequency-shifts) to the second dimension
H = reshape(H,size(H,1),[]);

Nd = size(H,2); % Number of diversity measurements
K = size(H,1); % Number of CFR measurements across frequency

% Get variables from the music struct
N = music.N;
dists = music.dists;
S = music.S;
threshold = music.threshold;

% Combine covariance esimates across antennas and frequency-shifted CFRs
Rd = complex(zeros(K,K));
for k = 1:Nd
    Rd = H(:,k)*H(:,k)' + Rd;
end
Rd = Rd / Nd;

% Smoothing of length N
L = K - N + 1;
RSM = complex(zeros(N,N)); % Correlation matrix
for k = 1:L
    RSM = RSM + Rd(k:k+N-1,k:k+N-1);
end
RSM = RSM / L;

% Forward-backward averaging
J = fliplr(eye(N));
R = (RSM+J*conj(RSM)*J)/2; 

% Compute the eigenvectors and eigenvalues by SVD
[Q,eigenvals_diag,~] = svd(R);
Lambda = diag(real(eigenvals_diag)); % column vector of eigenvalues

% Get the noise eigenvectors and noise eigenvalues
% Q_s = Q(:,1:nsig);
% Lambda_s = Lambda(1:nsig);
Q_n = Q(:,M+1:end);
Lambda_n = Lambda(M+1:end);

% Compute MUSIC spectrum
null_spec = abs((S' * Q_n)).^2 * diag(1./Lambda_n);
null_spec = sum(null_spec,2);
spec = (1 ./ null_spec).';
spec_dB = 10*log10(spec);

% Define peak threshold
spec_T = max(spec) * 10^(threshold/10);

% Find Delays from the peaks of the spectrum sorted by peakage magnitude.
[~,pklocs] = findpeaks(spec,'SortStr','descend','MinPeakHeight',spec_T); 

% Handling if no peaks found
if isempty(pklocs)
    [~,pklocs] = max(spec); % Use max if no peaks found
else
    num_pklocs = min(M,length(pklocs)); % In case we don't detect at least nsig peaks
    pklocs = sort(pklocs(1:num_pklocs),'ascend'); % Sorted by smallest to largest delay.
end

% Get the LOS path distance estimate
dist_est = dists(pklocs(1));