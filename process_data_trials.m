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
% This script evaluates ranging performance for a given set of trial
% locations and a given bandwidth. The Phase-Coherent Multi-Channel (PCMC)
% Stitch for B=16 20 MHz channels is also evaluated. If the set bandwidth
% is 40, 80, or 160 MHz, then the equivalent multi-channel stitch is
% evaluated using 20 MHz channels.

clear
close all

%% Set the file paths

% File path for the data sets
mainpath = '.\savedata\';

% Path for the calibration measurements
filepath_cal = '.\savedata\Calibration\';

% Get the trial names and true distances for a given data set or across
% multiple data sets
% [trialnames1,dist_true1] = get_trialdir_info("lab_room");
% [trialnames2,dist_true2] = get_trialdir_info("roomtoroom_LOS");
% [trialnames3,dist_true3] = get_trialdir_info("classroom");
% [trialnames4,dist_true4] = get_trialdir_info("indoor_open_space");
% [trialnames,dist_true] = get_trialdir_info("roomtoroom_NLOS"); % NLOS Measurements
% trialnames = [trialnames1;trialnames2;trialnames3;trialnames4]; % Concatenate trial names
% dist_true = [dist_true1;dist_true2;dist_true3;dist_true4]; % Concatenate distances

% Single environment evaluation
[trialnames,dist_true] = get_trialdir_info("indoor_open_space");

td = 2; % Number of measurements across time per LTF type per packet
num_locs = length(trialnames); % Number of unique locations evaluated

%% Set bandwidth to evaluate.
% Bandwidths: 20, 40, 80, 160 MHz

% filename = 'HESU_20'; % HESU, 20 MHz BW
% filename = 'HESU_40'; % HESU, 40 MHz BW
filename = 'HESU_80'; % HESU, 80 MHz BW
% filename = 'HESU_160'; % HESU, 160 MHz BW

% Get the corresponding bandwidth in MHz
BW = str2double(erase(filename,{'HESU_'})); 

%% Set Parameters

% Define the propagation speed
c = 3e8; % For free space measurements
% c = 3e8 / sqrt(1.4); % For wired measurements (dielectric_const = 1.4)

% Define the signal subspace sizes for MUSIC and the resapling rates
% depending on the bandwidth.
[M,M_320,Dr,Dr_320] = get_MandDr(BW);

%% Set channel bounds for 40, 80, and 160 MHz stitches using 20 MHz channels

f_40_cutoff = [2402,2442
    5170,5210
    5210,5250
    5250,5290
    5290,5330
    5490,5530
    5530,5570
    5570,5610
    5610,5650
    5650,5690
    5690,5730
    5735,5775
    5775,5815
    5815,5855
    5855,5895] * 10^6; % 40 MHz upper and lower frequency cutoffs
f_80_cutoff = [5170,5250
    5250,5330
    5490,5570
    5570,5650
    5650,5730
    5735,5815
    5815,5895] * 10^6; % 80 MHz upper and lower frequency cutoffs
f_160_cutoff = [5170,5330
    5490,5650
    5735,5895] * 10^6; % 160 MHz upper and lower frequency cutoffs

%% Evaluate trial location for the given bandwidth

% Load the calibration data
sve_cal = load([filepath_cal,filename]);
sve_cal_20 = load([filepath_cal,'HESU_20']);

% Set parameters
[Delta_f,~,~,~,~] = get_impparams(sve_cal);
num_ch = length(sve_cal.fc); % Number of channels (trials) scanned for the bandwidth

% Accounting for the 40 MHz case having two less channels with 20
% MHz equivalents. These are channels 9-13 and 34.
if sve_cal.fs == 40e6
    dist_est_chstitch = nan(num_locs,num_ch-2,td);
else
    dist_est_chstitch = nan(num_locs,num_ch,td);
end

% Initialize
dist_est = nan(num_locs,num_ch,td);
SNR_est_ch = nan(num_locs,num_ch);
dist_est_chstitch320 = nan(num_locs,td);

% For each location
for p = 1:num_locs

    % Load in the data for the given bandwidth
    sve = load([mainpath,trialnames{p},'\',filename]);

    % Load in the 20 MHz data for stitching
    sve_20 = load([mainpath,trialnames{p},'\','HESU_20']);

    % Format, calibration, and interpolate for null subcarriers within each
    % channel
    [chanEst,fInterp,SNR_est] = ...
        format_calibrate(sve,sve_cal,c); % Single-channel
    [chanEst_20,fInterp_20,SNR_est_20] = ...
        format_calibrate(sve_20,sve_cal_20,c); % 20 MHz channels for stitch

    % Loop for each individual channel
    for k = 1:num_ch

        % Set the lower and upper cutoffs for the 20 MHz channel
        % measurements to use as stitches
        switch sve.fs
            case 40e6
                if k <= num_ch-2
                    f_cutoff = f_40_cutoff(k,:);
                end
            case 80e6
                f_cutoff = f_80_cutoff(k,:);
            case 160e6
                f_cutoff = f_160_cutoff(k,:);
            otherwise
                f_cutoff = nan;
        end

        % Distance estimation per channel and for the equivalent stitch if
        % specified single-channel bandwidth is 40, 80, or 160 MHz.
        for j = 1:td
            % Per channel
            dist_est(p,k,j) = singlech_distest(...
                fInterp(:,k),squeeze(chanEst(:,k,:,j)),Delta_f,M,c,Dr);
            
            % Equivalent stitch
            if (sve.fs == 40e6 && k <= num_ch-2) || sve.fs == 80e6 || sve.fs == 160e6
                dist_est_chstitch(p,k,j) = multich_distest(...
                    fInterp_20,squeeze(chanEst_20(:,:,:,j)),Delta_f,M,c,Dr,f_cutoff);
            end
        end

        % Average SNR estimates across antennas and time for the
        % channel
        SNR_est_ch(p,k) = mean(SNR_est(k,:,:),'all'); 

        % Console output
        disp(['Location ',num2str(p),'/',num2str(num_locs),...
            ', Channel ',num2str(k),'/',num2str(length(sve.fc)),...
            ', Dist Errs: ',num2str(dist_est(p,k,1)-dist_true(p)),', ',num2str(dist_est(p,k,2)-dist_true(p))]);
    
    end

    % Estimate distance for the B=16 (320 MHz) stitch
    for j = 1:td
        dist_est_chstitch320(p,j) = chstitch320M_distest(...
            fInterp_20,squeeze(chanEst_20(:,:,:,j)),Delta_f,M_320,c,Dr_320);
    end

    % Console output
    disp('---')
    disp(['Location ',num2str(p),'/',num2str(num_locs),...
        ', 320 MHz Stitch Dist Errs: ',num2str(dist_est_chstitch320(p,1)-dist_true(p)),...
        ', ',num2str(dist_est_chstitch320(p,2)-dist_true(p))]);
    disp('---')

end

%% Process the results and compute statistics

% Case for 20 MHz single-channel measurements only (no stitches)
if sve.fs == 20e6
    dist_est_chstitch = dist_est;
end

% Calculate error
dist_err = dist_est - dist_true;
dist_err_chstitch = dist_est_chstitch - dist_true;
dist_err_chstitch320 = dist_est_chstitch320 - dist_true;

% Calculate RMSE
dist_rmse = sqrt(mean(dist_err(:).^2));
dist_rmse_chstitch = sqrt(mean(dist_err_chstitch(:).^2));
dist_rmse_chstitch320 = sqrt(mean(dist_err_chstitch320(:).^2));

%% Plot CDFs
close all

p_lim = 200; % Plot x-axis limit in centimeters

% CDFs per bandwidth -----------------------------------------------------%
figure(1);
subplot(2,1,1);
hold on
cdfp(1) = cdfplot(100*dist_err(:));
cdfp(2) = cdfplot(100*dist_err_chstitch(:));
cdfp(3) = cdfplot(100*dist_err_chstitch320(:));
set(cdfp,'linewidth',2)
hold off
xlim([-p_lim p_lim])
grid on
set(gca,'TickLabelInterpreter','latex')
title([erase(filename,"_"),' CDFs'],'interpreter','latex')
xlabel('Error (cm)','interpreter','latex')
ylabel('CDF','interpreter','latex')

subplot(2,1,2);
hold on
abscdfp(1) = cdfplot(abs(100*dist_err(:)));
abscdfp(2) = cdfplot(abs(100*dist_err_chstitch(:)));
abscdfp(3) = cdfplot(abs(100*dist_err_chstitch320(:)));
set(abscdfp,'linewidth',2)
xlim([0 p_lim])
hold off
grid on
set(gca,'TickLabelInterpreter','latex')
title('')
xlabel('Absolute Error (m)','interpreter','latex')
ylabel('CDF','interpreter','latex')
legend(['Per Channel, RMSE: ',num2str(round(100*dist_rmse,1)),' m'],...
    ['PCMC Equivalent Stitch, RMSE: ',num2str(round(100*dist_rmse_chstitch,1)),' m'],...
    ['PCMC (B=16) Stitch, RMSE: ',num2str(round(100*dist_rmse_chstitch320,1)),' m'],...
    'location','best','fontsize',12,'interpreter','latex')

p_width = 680;
p_height = 600;
set(1,'Position',[1920/2-p_width/2,1080/2-p_height/2,p_width,p_height])