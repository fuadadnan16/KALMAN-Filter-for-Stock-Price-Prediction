# Kalman Filter–Based State Estimation

This project implements a **discrete-time Kalman Filter** for estimating the state
of a linear dynamical system from noisy measurements. The work is based on the
(Random Processes & Estimation) course project.

## Problem Overview
We consider a linear state-space model:

xₖ₊₁ = A xₖ + wₖ  
yₖ   = C xₖ + vₖ

where:
- wₖ ~ N(0, Q) is process noise  
- vₖ ~ N(0, R) is measurement noise  

The objective is to optimally estimate the hidden state xₖ given noisy observations yₖ.

## Methodology
- Prediction step using system dynamics
- Measurement update using Kalman gain
- Recursive estimation of:
  - State mean
  - Error covariance

## Implementation
- Language: **MATLAB**
- Core script: `data_kalman_part_3.m`
- Includes:
  - State prediction
  - Kalman gain computation
  - Error covariance evolution
  - Visualization of estimation performance

## Results
The following results are generated:
- True vs estimated state trajectories


### State Estimation
![State Estimation](results/trajectory.png)



## Files
- `matlab/data_kalman_part_3.m` – Kalman filter implementation
- `results/` – Output plot



## Author
Mirza Fuad Adnan
