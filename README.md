# A Multi-Channel Approach for Centimeter-Level WiFi Ranging

This repository contains the data and code related to our paper "A Multi-Channel Approach and Testbed for Centimeter-Level WiFi Ranging" (under review). This work proposes methods for phase-coherent multi-channel (PCMC) WiFi ranging using timestamp and CFR measurements supporting 802.11az Next Generation Positioning. Utilizing our proposed PCMC technique with 16 channels, we demonstrate a median error of 2.7 cm and a 90th percentile error of 9.5 cm in line-of-sight conditions.

Full data set will be released upon paper acceptance.

Sample Data Set:
https://utdallas.box.com/v/WiFi-Ranging-Testbed-Data

## Quick Start

1. Download the code and data set.
2. Set the _trialnames_ and corresponding _dist_true_ in _process_data_trials.m_.
3. Set the single-channel bandwidth (e.g., _HESU_80_) in _process_data_trials.m_.
4. Run _process_data_trials.m_ to generate CDF and RMSE results for the single-channel measurements, the equivalent PCMC stitch, and the PCMC 16-channel (B=16) stitch.

## License
[GPL 3.0](https://choosealicense.com/licenses/gpl-3.0/)
