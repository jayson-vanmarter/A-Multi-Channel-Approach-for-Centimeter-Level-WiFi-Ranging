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
% This function loads the trial names (directories), distances, and
% locations on a 3D map (if available) for a given data set name

function [trialnames,dist_true,locs] = get_trialdir_info(set_name)

% Force to string
set_name = string(set_name);

switch set_name
    case "wired"
        trialnames = {'Measurement Sets\Wired\54 dB Att - No Wire (1)'
            'Measurement Sets\Wired\54 dB Att - No Wire (2)' 
            'Measurement Sets\Wired\54 dB Att - No Wire (3)'
            'Measurement Sets\Wired\54 dB Att - 1 Wire (1)'
            'Measurement Sets\Wired\54 dB Att - 1 Wire (2)'
            'Measurement Sets\Wired\54 dB Att - 2 Wires (1)'
            'Measurement Sets\Wired\54 dB Att - 2 Wires (2)'
            'Measurement Sets\Wired\54 dB Att - 3 Wires (1)'
            'Measurement Sets\Wired\54 dB Att - 3 Wires (2)'};

        % Rounded to the nearest mm
        dist_true = [0+0.001 % Single female-to-female connector
            0+0.001 % Single female-to-female connector
            0+0.001 % Single female-to-female connector
            1.829 % No connector
            1.829 % No connector
            3.658+0.016 % 1x male-to-male connector
            3.658+0.016 % 1x male-to-male connector
            5.486+0.032 % 2x male-to-male connector
            5.486+0.032]; % 2x male-to-male connector

    case "anechoic_chamber"

        trialnames = {'Measurement Sets\Wireless\Anechoic Chamber\4x2 126cm'
        'Measurement Sets\Wireless\Anechoic Chamber\4x2 218cm'};
    
        dist_true = [1.26
            2.18];

    case "lab_room"
        trialnames = {'Measurement Sets\Wireless\Lab Room\4x2 363cm'
            'Measurement Sets\Wireless\Lab Room\4x2 159cm'
            'Measurement Sets\Wireless\Lab Room\4x2 167cm'
            'Measurement Sets\Wireless\Lab Room\4x2 183cm'
            'Measurement Sets\Wireless\Lab Room\4x2 144cm'
            'Measurement Sets\Wireless\Lab Room\4x2 221cm'
            'Measurement Sets\Wireless\Lab Room\4x2 265cm'
            'Measurement Sets\Wireless\Lab Room\4x2 286cm'
            'Measurement Sets\Wireless\Lab Room\4x2 340cm'
            'Measurement Sets\Wireless\Lab Room\4x2 373cm'
            'Measurement Sets\Wireless\Lab Room\4x2 511cm'
            'Measurement Sets\Wireless\Lab Room\4x2 443cm'
            'Measurement Sets\Wireless\Lab Room\4x2 463cm'
            'Measurement Sets\Wireless\Lab Room\4x2 559cm'
            'Measurement Sets\Wireless\Lab Room\4x2 518cm'
            'Measurement Sets\Wireless\Lab Room\4x2 647cm'
            'Measurement Sets\Wireless\Lab Room\4x2 608cm'
            'Measurement Sets\Wireless\Lab Room\4x2 676cm'
            'Measurement Sets\Wireless\Lab Room\4x2 730cm'
            'Measurement Sets\Wireless\Lab Room\4x2 659cm'
            'Measurement Sets\Wireless\Lab Room\4x2 434cm'
            'Measurement Sets\Wireless\Lab Room\4x2 430cm'
            'Measurement Sets\Wireless\Lab Room\4x2 669cm'
            'Measurement Sets\Wireless\Lab Room\4x2 776cm'
            'Measurement Sets\Wireless\Lab Room\4x2 808cm'
            'Measurement Sets\Wireless\Lab Room\4x2 887cm'
            'Measurement Sets\Wireless\Lab Room\4x2 770cm'
            'Measurement Sets\Wireless\Lab Room\4x2 745cm'
            'Measurement Sets\Wireless\Lab Room\4x2 857cm'
            'Measurement Sets\Wireless\Lab Room\4x2 1019cm'
            'Measurement Sets\Wireless\Lab Room\4x2 939cm'
            'Measurement Sets\Wireless\Lab Room\4x2 859cm'
            'Measurement Sets\Wireless\Lab Room\4x2 1016cm'
            'Measurement Sets\Wireless\Lab Room\4x2 995cm'
            'Measurement Sets\Wireless\Lab Room\4x2 1081cm'
            'Measurement Sets\Wireless\Lab Room\4x2 1085cm'
            'Measurement Sets\Wireless\Lab Room\4x2 957cm'
            'Measurement Sets\Wireless\Lab Room\4x2 890cm'
            'Measurement Sets\Wireless\Lab Room\4x2 578cm'
            'Measurement Sets\Wireless\Lab Room\4x2 1011cm'};
    
        dist_true = [3.63
            1.59
            1.67
            1.83
            1.44
            2.21
            2.65
            2.86
            3.40
            3.73
            5.11
            4.43
            4.63
            5.59
            5.18
            6.47
            6.08
            6.76
            7.30
            6.59
            4.34
            4.30
            6.69
            7.76
            8.08
            8.87
            7.70
            7.45
            8.57
            10.19
            9.39
            8.59
            10.16
            9.95
            10.81
            10.85
            9.57
            8.90
            5.78
            10.11];

    case "roomtoroom_NLOS"
        trialnames = {'Measurement Sets\Wireless\Room-to-room\4x2 878cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1100cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1097cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 997cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 850cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 630cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 648cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 756cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1106cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 820cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 979cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1153cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 973cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 977cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 769cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 765cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1086cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 951cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 847cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 712cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 882cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 865cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1015cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1002cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 770cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 769cm NLOS (Door Open) 2'
            'Measurement Sets\Wireless\Room-to-room\4x2 706cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 682cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1052cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1058cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 957cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 869cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 874cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 681cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 643cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 784cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 805cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1132cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 1006cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 931cm NLOS (Door Open)'
            'Measurement Sets\Wireless\Room-to-room\4x2 504cm NLOS (Same Room)'
            'Measurement Sets\Wireless\Room-to-room\4x2 450cm NLOS (Same Room)'};
    
        dist_true = [8.78
            11.00
            10.97
            9.97
            8.50
            6.30
            6.48
            7.56
            11.06
            8.20
            9.79
            11.53
            9.73
            9.77
            7.69
            7.65
            10.86
            9.51
            8.47
            7.12
            8.82
            8.65
            10.15
            10.02
            7.70
            7.69
            7.06
            6.82
            10.52
            10.58
            9.57
            8.69
            8.74
            6.81
            6.43
            7.84
            8.05
            11.32
            10.06
            9.31
            5.04
            4.50];
    
        locs = [-1.50 - 7.24, 1.83 - 1.00, -0.20
            -1.50 - 7.24 - 2.25, 1.83 - 2.19, -0.15
            -1.50 - 7.24 - 2.21, 1.83 - 1.44, 0.51
            -1.50 - 7.24 - 0.82, 1.83 - 4.66, -0.15
            -1.50 - 6.98, 1.83 - 1.58 - 0.54, -0.42
            -1.50 - 6.98 + 2.18, 1.83 - 1.72, -0.15
            -1.50 - 6.98 + 2.08, 1.83 - 2.82, -0.15
            -1.50 - 6.98 + 1.41, 1.83 - 4.49, -0.20
            -1.50 - 6.98 - 2.49, 1.83 - 3.25, -0.20
            -1.50 - 5.96, 1.83 + 1.57, -0.15
            -1.50 - 7.65,1.83 + 1.65,-0.15
            -1.50 - 7.65 - 2.20,1.83 + 0.20,-0.20
            -1.50 - 7.65 - 0.48, 1.83 - 3.15, -0.40
            -1.50 - 7.65 - 0.61,1.83 - 1.50,-0.40
            -1.50 - 5.99, 1.83 - 3.53, -0.40
            -1.50 - 5.92, 1.83, -0.40
            -1.50 - 8.76, 1.83 + 1.71, -0.20
            -1.50 - 7.71, 1.83 + 0.51, -0.40
            -1.50 - 6.44, 1.83 - 4.22 - 0.53, -0.40
            -1.50 - 5.61, 1.83 - 1.98, -0.40
            -1.50 - 7.07, 1.83 - 3.93, -0.13
            -1.50 - 7.07, 1.83 - 2.96, -0.13
            -1.50 - 8.51, 1.83 - 3.49, -0.13
            -1.50 - 8.51, 1.83 - 2.25, -0.13
            -1.50 - 6.18, 1.83 - 2.42, -0.13
            -1.50 - 6.18, 1.83 - 1.46, -0.13
            -1.50 - 5.27, 1.83 - 3.82, -0.13
            -1.50 - 5.27, 1.83 - 1.04, -0.13
            -1.50 - 8.95, 1.83 - 0.65, -0.25
            -1.50 - 8.76, 1.83 + 0.73, -0.15
            -1.50 - 7.97, 1.83 - 0.46, -0.25
            -1.50 - 6.99, 1.83, -0.13
            -1.50 - 6.80, 1.83 + 0.91, -0.13
            -1.50 - 4.68, 1.83 + 1.03, -0.25
            -1.50 - 4.72, 1.83 - 0.20, -0.13
            -1.50 - 5.81, 1.83 + 1.00, -0.13
            -1.50 - 6.44, 1.83 - 0.52, -0.13
            -1.50 - 9.47, 1.83 + 0.94, -0.13
            -1.50 - 8.94, 1.83, -0.13
            -1.50 - 7.78, 1.83 - 2.56, -0.13
            -1.50 - 3.25, 1.83 - 0.16, -0.13
            -4.39, 0.99, -0.07]; % Coordinates relative to the initiator in m

    case "roomtoroom_LOS"

        trialnames = {'Measurement Sets\Wireless\Room-to-room\4x2 250cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 320cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 285cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 418cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 529cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 422cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 380cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 160cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 486cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 163cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 250cm LOS 2'
            'Measurement Sets\Wireless\Room-to-room\4x2 532cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 461cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 241cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 338cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 273cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 156cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 350cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 494cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 39cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 291cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 336cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 121cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 260cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 420cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 455cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 150cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 266cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 365cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 323cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 278cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 121cm LOS 2'
            'Measurement Sets\Wireless\Room-to-room\4x2 377cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 185cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 142cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 175cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 476cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 436cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 388cm LOS'
            'Measurement Sets\Wireless\Room-to-room\4x2 222cm LOS'};
    
        dist_true = [2.50
            3.20
            2.85
            4.18
            5.29
            4.22
            3.80
            1.60
            4.86
            1.63
            2.50
            5.32
            4.61
            2.41
            3.38
            2.73
            1.56
            3.50
            4.94
            0.39
            2.91
            3.36
            1.12
            2.60
            4.20
            4.55
            1.50
            2.66
            3.65
            3.23
            2.78
            1.21
            3.77
            1.85
            1.42
            1.75
            4.76
            4.36
            3.88
            2.22];
    
        locs = [-1.22, -2.14, 0
            -1.92, -2.54, 0
            -2.49, -1.28, 0
            -3.98, -1.17, 0
            -5.18, -0.59, 0
            -3.38, -2.46, 0
            -3.77, 0.31, 0
            -1.32, -0.91, 0
            -4.50, -1.85, 0
            -1.63, 0, 0
            -2.46, -0.55, 0
            -1.50 - 3.19, 1.83 + 0.648, 0
            -1.50 - 2.72, 1.83, 0
            -2.14, 1.05, 0
            -2.71, 2.05, 0
            -1.64, 2.20, 0
            -0.89, 1.27, 0
            -1.03, 3.31, 0
            -3.65, 3.28, 0
            -0.39, 0, 0
            -2.90, 0.13, 0
            -2.99, 1.48, 0
            0, 1.21, 0
            -0.61, 2.52, 0
            -2.67, 3.23, 0
            -2.67 - 1.15, 2.38, 0
            -0.13, -1.49, 0
            -0.59, -2.56, 0
            -3.14, -1.73, 0
            -3.14, -0.64, 0
            -1.98, -1.93, 0
            -1.09, 0.55, 0
            -2.00, 3.23, 0
            -1.47, 1.16, 0
            -0.83, -1.10, 0
            -0.49, 1.70, 0
            -4.76, 0, 0
            -4.26, -0.85, 0
            -3.81, -0.55, 0
            -2.19, 0.33, 0];

    case "classroom"
        trialnames = {'Measurement Sets\Wireless\Classroom\4x2 278cm seat1-1'
            'Measurement Sets\Wireless\Classroom\4x2 200cm seat1-2'
            'Measurement Sets\Wireless\Classroom\4x2 120cm seat1-3'
            'Measurement Sets\Wireless\Classroom\4x2 75cm seat1-4'
            'Measurement Sets\Wireless\Classroom\4x2 345cm seat2-1'
            'Measurement Sets\Wireless\Classroom\4x2 279cm seat2-2'
            'Measurement Sets\Wireless\Classroom\4x2 223cm seat2-3'
            'Measurement Sets\Wireless\Classroom\4x2 210cm seat2-4'
            'Measurement Sets\Wireless\Classroom\4x2 433cm seat3-1'
            'Measurement Sets\Wireless\Classroom\4x2 395cm seat3-2'
            'Measurement Sets\Wireless\Classroom\4x2 367cm seat3-3'
            'Measurement Sets\Wireless\Classroom\4x2 354cm seat3-4'
            'Measurement Sets\Wireless\Classroom\4x2 561cm seat4-1'
            'Measurement Sets\Wireless\Classroom\4x2 536cm seat4-2'
            'Measurement Sets\Wireless\Classroom\4x2 511cm seat4-3'
            'Measurement Sets\Wireless\Classroom\4x2 503cm seat4-4'
            'Measurement Sets\Wireless\Classroom\4x2 525cm seat1-8'
            'Measurement Sets\Wireless\Classroom\4x2 448cm seat1-7'
            'Measurement Sets\Wireless\Classroom\4x2 326cm seat1-6'
            'Measurement Sets\Wireless\Classroom\4x2 258cm seat1-5'
            'Measurement Sets\Wireless\Classroom\4x2 570cm seat2-8'
            'Measurement Sets\Wireless\Classroom\4x2 471cm seat2-7'
            'Measurement Sets\Wireless\Classroom\4x2 380cm seat2-6'
            'Measurement Sets\Wireless\Classroom\4x2 307cm seat2-5'
            'Measurement Sets\Wireless\Classroom\4x2 714cm seat5-1'
            'Measurement Sets\Wireless\Classroom\4x2 684cm seat5-2'
            'Measurement Sets\Wireless\Classroom\4x2 663cm seat5-3'
            'Measurement Sets\Wireless\Classroom\4x2 658cm seat5-4'
            'Measurement Sets\Wireless\Classroom\4x2 611cm seat3-8'
            'Measurement Sets\Wireless\Classroom\4x2 550cm seat3-7'
            'Measurement Sets\Wireless\Classroom\4x2 467cm seat3-6'
            'Measurement Sets\Wireless\Classroom\4x2 408cm seat3-5'
            'Measurement Sets\Wireless\Classroom\4x2 691cm seat4-8'
            'Measurement Sets\Wireless\Classroom\4x2 641cm seat4-7'
            'Measurement Sets\Wireless\Classroom\4x2 574cm seat4-6'
            'Measurement Sets\Wireless\Classroom\4x2 529cm seat4-5'
            'Measurement Sets\Wireless\Classroom\4x2 800cm seat5-8'
            'Measurement Sets\Wireless\Classroom\4x2 765cm seat5-7'
            'Measurement Sets\Wireless\Classroom\4x2 724cm seat5-6'
            'Measurement Sets\Wireless\Classroom\4x2 695cm seat5-5'
            'Measurement Sets\Wireless\Classroom\4x2 857cm seat6-4'
            'Measurement Sets\Wireless\Classroom\4x2 837cm seat6-3'
            'Measurement Sets\Wireless\Classroom\4x2 826cm seat6-2'
            'Measurement Sets\Wireless\Classroom\4x2 819cm seat6-1'
            'Measurement Sets\Wireless\Classroom\4x2 185cm behind1'
            'Measurement Sets\Wireless\Classroom\4x2 175cm behind2'
            'Measurement Sets\Wireless\Classroom\4x2 368cm behind3'};
    
        dist_true = [2.78
            2.00
            1.20
            0.75
            3.45
            2.79
            2.23
            2.10
            4.33
            3.95
            3.67
            3.54
            5.61
            5.36
            5.11
            5.03
            5.25
            4.48
            3.26
            2.58
            5.70
            4.71
            3.80
            3.07
            7.14
            6.84
            6.63
            6.58
            6.11
            5.50
            4.67
            4.08
            6.91
            6.41
            5.74
            5.29
            8.00
            7.65
            7.24
            6.95
            8.57
            8.37
            8.26
            8.19
            1.85
            1.75
            3.68];
    
        locs = [-2.68,-0.62,-0.36
            -1.86,-0.62,-0.36
            -0.97,-0.62,-0.36
            0,-0.71,-0.36
            -2.67,-2.12,-0.36
            -1.82,-2.12,-0.36
            -0.71,-2.12,-0.36
            0,-2.08,-0.36
            -2.51,-3.56,-0.36
            -1.78,-3.56,-0.36
            -0.91,-3.56,-0.36
            0,-3.54,-0.36
            -2.56,-5.05,-0.36
            -1.78,-5.09,-0.36
            -0.54,-5.09,-0.36
            0,-5.03,-0.36
            5.22,-0.73,-0.36
            4.31,-0.73,-0.36
            3.17,-0.73,-0.36
            2.43,-0.73,-0.36
            5.44,-1.80,-0.36
            4.29,-1.80,-0.36
            3.30,-1.80,-0.36
            2.44,-1.80,-0.36
            -2.63,-6.62,-0.36
            -1.82,-6.62,-0.36
            -0.77,-6.62,-0.36
            0,-6.58,-0.36
            5.14,-2.98,-0.36
            4.42,-2.98,-0.36
            3.35,-2.98,-0.36
            2.49,-2.98,-0.36
            4.79,-4.63,-0.36
            4.12,-4.63,-0.36
            3.05,-4.63,-0.36
            2.29,-4.63,-0.36
            4.77,-6.47,-0.36
            4.10,-6.47,-0.36
            3.20,-6.47,-0.36
            2.44,-6.47,-0.36
            2.45,-8.19,-0.36
            1.62,-8.19,-0.36
            0.66,-8.19,-0.36
            -0.35,-8.19,-0.36
            -1.14,1.45,-0.36
            1.06,1.32,-0.36
            3.36,1.33,-0.36];

    case "indoor_open_space"
        trialnames = {'Measurement Sets\Wireless\Indoor Open Space\4x2 1205cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1196cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1121cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 972cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1063cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1044cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1019cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 863cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 802cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 858cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 894cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 763cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 599cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 635cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 737cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 1130cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 958cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 887cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 684cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 644cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 508cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 559cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 580cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 585cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 491cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 427cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 387cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 520cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 430cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 347cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 362cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 264cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 418cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 244cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 97cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 179cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 132cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 256cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 251cm'
            'Measurement Sets\Wireless\Indoor Open Space\4x2 354cm'};
    
        dist_true = [12.05
             11.96
             11.21
             9.72
             10.63
             10.44
             10.19
             8.63
             8.02
             8.58
             8.94
             7.63
             5.99
             6.35
             7.37
             11.30
             9.58
             8.87
             6.84
             6.44
             5.08
             5.59
             5.80
             5.85
             4.91
             4.27
             3.87
             5.20
             4.30
             3.47
             3.62
             2.64
             4.18
             2.44
             0.97
             1.79
             1.32
             2.56
             2.51
             3.54];
    
        locs = [-12.05,0,0
            -11.88,1.61,0
            -10.64,3.80,0
            -9.47,2.61,0
            -10.55,1.58,0
            -10.44,0.51,0
            -9.43,3.95,0
            -8.40,2.17,0
            -7.97,0.87,0
            -8.58,0,0
            -8.27,3.40,0
            -7.44,2.03,0
            -5.99,0,0
            -6.24,1.61,0
            -6.60,3.34,0
            -10.96,2.72,0
            -9.41,1.99,0
            -8.82,1.22,0
            -6.40,2.52,0
            -6.43,0.40,0
            -5.08,0,0
            -5.49,1.30,0
            -5.13,2.67,0
            -4.53,3.69,0
            -4.47,2.00,0
            -4.18,0.98,0
            -3.87,0,0
            -3.59,3.76,0
            -3.37,2.67,0
            -3.06,1.63,0
            -3.52,0.96,0
            -2.60,0.54,0
            -2.12,3.56,0
            -1.51,1.91,0
            -0.97,0,0
            -0.78,1.59,0
            -0.93,0.90,0
            -0.71,2.45,0
            -1.35,2.10,0
            -2.37,2.61,0]; % Locations in 3D space relative to the initiator

    otherwise
        error('Invalid Measurement Set Name')
end