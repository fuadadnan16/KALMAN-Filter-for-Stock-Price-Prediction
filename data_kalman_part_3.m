% Load the CSV file
data = readtable('HistoricalQuotes.csv');

% Extract the relevant columns
dates = datetime(data.Date, 'InputFormat', 'MM/dd/yyyy'); % Assuming first column is dates
closing_prices = data.Close; % Assuming second column is closing prices

% Step 1: Calculate daily returns
returns = diff(closing_prices) ./ closing_prices(1:end-1); % Daily returns

% Step 2: Calculate rolling volatility
window_size = 5; % Rolling window size
volatility = movstd(returns, window_size); % Rolling standard deviation

% Step 3: Initialize Kalman filter parameters
n = length(closing_prices) - 1; % Number of observations
P = zeros(n, 1); % Predicted prices
Q = 0.0001; % Process noise covariance
R = 0.01; % Observation noise covariance

x_est = closing_prices(1); % Initial state estimate
P_est = 1; % Initial error covariance estimate

% Kalman Filter Implementation
for t = 2:n
    % Prediction step
    x_pred = x_est + volatility(t); % Predicted state
    P_pred = P_est + Q; % Predicted error covariance
    
    % Update step
    K = P_pred / (P_pred + R); % Kalman gain
    x_est = x_pred + K * (closing_prices(t) - x_pred); % Updated state estimate
    P_est = (1 - K) * P_pred; % Updated error covariance
    
    % Store predictions
    P(t) = x_est;
end

% Step 4: Plot results
figure;
plot(dates(2:end), closing_prices(2:end), 'b', 'DisplayName', 'Actual Prices');
hold on;
plot(dates(2:end), P, 'r', 'DisplayName', 'Predicted Prices');
xlabel('Date');
ylabel('Price');
title('Kalman Filter Prediction of Stock Prices');
legend('show');
grid on;

% Step 5: Analyze performance
errors = closing_prices(2:end) - P(1:end);
mse = mean(errors .^ 2); % Mean Squared Error
disp(['Mean Squared Error: ', num2str(mse)]);
