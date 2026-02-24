# KCLIDE: Single Image Detail Enhancement Based on Kirchhoff's Current Law

This is the source code of paper named "Single Image Detail Enhancement Based on Kirchhoff's Current Law". This paper is submitted to IEEE Signal Processing Letters.
## Introduction
This repository contains the implementation of **KCLIDE** (Kirchhoff's Current Law Inspired Detail Enhancement), a single image detail enhancement algorithm. 

Existing residual learning-based methods often adopt greedy search strategies, leading to premature convergence to local optima.
To address this, KCLIDE models the image patch matching process as the dynamic behavior of current within a circuit. 
By formulating matching errors as "resistance," the optimization path naturally converges toward regions of minimum resistance (global optimality) without requiring manual parameter tuning.

![Framework](path/to/framework_figure.png)
*Figure 1: The KCLIDE optimization framework."Current" flows to high-matching regions, adjusting search paths to escape local optima.*

## Features
* Physically-Driven Optimization:** Inspired by KCL, utilizing current and resistance concepts to drive patch matching.
* Global Optimality:** Escapes local optima found in greedy search strategies.
* Parameter Free:** Converges to a steady state without manual parameter tuning.
* Superior Performance:** Outperforms state-of-the-art methods (including QWLS, ILS, and Deep Learning methods) on BSDS200, RealSRSet, and T91 datasets.

## System Requirements
The code was developed and tested on the following platform:
*Software:** MATLAB 2022b.

## Usage

### 1. Setup
Clone the repository and add the folders to your MATLAB path.

### 2. Running the Demo
Run the main script to enhance an input image. The default parameters are set according to the paper's experimental settings:

```matlab
% Example Configuration
T_max = 4;  % Maximum iterations
N = 10;     % Population size
alpha = 0.001;% Regularization weight
beta = 0.001; % Regularization weight
% Run KCLIDE
I_enhanced = KCLIDE(I_input, T_max, N, alpha, beta);
