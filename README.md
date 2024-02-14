# A Multi-Channel Approach for Centimeter-Level WiFi Ranging

This repository contains the data and code related to our paper "A Multi-Channel Approach and Testbed for Centimeter-Level WiFi Ranging." This work proposes methods for phase-coherent multi-channel (PCMC) WiFi ranging using timestamp and CFR measurements supporting IEEE 802.11az Next Generation Positioning. Utilizing our proposed PCMC technique with 16 channels, we demonstrate a median error of 2.7 cm and a 90th percentile error of 9.5 cm in line-of-sight conditions.

Full Data Set:
https://utdallas.box.com/v/WiFi-Ranging-Testbed-Data

If you are interested in collaborating with the WiFi ranging testbed, please get in touch with Murat Torlak at torlak@utdallas.edu.

Paper accepted as of 2/12/2024. If you use our code/methods or data in your research, please cite our paper:  
```
@article{VanMarter-PCMCWiFiRanging,
  author = {Van Marter, Jayson P. and Ben-Shachar, Matan and Alpert, Yaron and Dabak, Anand G. and Al-Dhahir, Naofal and Torlak, Murat},
  journal = {IEEE Journal of Indoor and Seamless Positioning and Navigation}, 
  title = {A Multi-Channel Approach and Testbed for Centimeter-Level WiFi Ranging}, 
  year = {2024},
}
```

## Quick Start

1. Download the code and data set and place them in the same folder.
2. Set the _trialnames_ and corresponding _dist_true_ in _process_data_trials.m_.
3. Set the single-channel bandwidth (e.g., _HESU_80_) in _process_data_trials.m_.
4. Run _process_data_trials.m_ in MATLAB to generate CDF and RMSE results for the single-channel measurements, the equivalent PCMC stitch, and the PCMC 16-channel (B=16) stitch.

## License
[GPL 3.0](https://choosealicense.com/licenses/gpl-3.0/)
