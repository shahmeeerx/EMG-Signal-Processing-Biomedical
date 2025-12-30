% Step 1: Initialize Parameters
Fs = 1000; % Sampling frequency (Hz)
t = 0:1/Fs:1; % Time vector (1 second duration)

% Step 2: Generate Noise and Burst
noise = 0.5 * randn(size(t)); %  noise
burst = sin(2 * pi * 50 * t) .* (t > 0.2 & t < 0.5); % Sine wave burst
emg_signal = noise + burst; % Combine noise and burst

% Step 3: Plot Original EMG-like Signal
figure;
subplot(311); % First plot: Original signal
plot(t, emg_signal, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original EMG-like Signal');
grid on;

% Step 4: Full-Wave Rectification
rectified = abs(emg_signal); % Full-wave rectification

% Step 5: Design Moving Average Filter
M = 50; % Number of taps for the filter
filter = ones(1, M) / M; % Moving average filter

% Step 6: Smooth the Rectified Signal
smoothed_emg = conv(rectified, filter, 'same'); %filter

% Step 7: Plot Rectified and Smoothed Signals
subplot(312); 
plot(t, rectified, 'r', 'LineWidth', 1.5);
hold on;
plot(t, smoothed_emg, 'g', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Rectified and Smoothed EMG Signal');
legend('Rectified', 'Smoothed');
grid on;

% Step 8: Perform Auto-Correlation
[correlation, lag] = xcorr(rectified, 'biased'); 

% Step 9: Plot Auto-Correlation
subplot(313); 
stem(lag, correlation, 'm', 'LineWidth', 1.5);
xlabel('Lag');
ylabel('Correlation');
title('Auto-Correlation of Rectified EMG Signal');
grid on;


