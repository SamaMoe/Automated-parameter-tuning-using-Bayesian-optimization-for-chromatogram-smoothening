# Automated-parameter-tuning-using-Bayesian-optimization-for-chromatogram-smoothening
Scripts and GUI application to automatically tune hyperparamters of Whittaker smoother using Bayesian optimization. GUI also contains an automated baseline correction and peak detection algorithm.

How to use the GUI? 
First download the GUI application (ChromSmoothPeakDetectApp) and the corresponding scripts stored in the folders "Asymmetrical least squares" and "Smoothening Bayesian Optimization". Then open the application and follow these steps: 
1. Load chromatogram as .csv file
2. Correct baseline if necessary 
3. Choose one of the three algorithms for hyperparameter tuning of the Whittaker smoother
4. Denoise
5. Perform peak detection 
6. Load smoothed chromatogram and peak locations
