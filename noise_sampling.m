%% Parameters
fs   = 1e7;        % sampling frequency (Hz)
T    = 1;          % signal duration (s)
N    = fs * T;     % number of samples
noise_var = 2;     % desired noise variance (power)

%% 1) Generate white Gaussian noise
noise = sqrt(noise_var) * randn(1, N);

%% 2) Plot noise in time domain
t = (0:N-1)/fs;
figure;
plot(t, noise);
xlabel('Time (s)');
ylabel('Amplitude');
title('White Gaussian Noise');

%% 3) Sample the noise (decimation)
M = 100;                               % decimation factor
sampled_noise = noise(1:M:end);
ts = t(1:M:end);

figure;
stem(ts, sampled_noise, 'filled');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Noise');

%% 4) Compute sampled noise power
original_power = mean(noise.^2);
fprintf('Original noise power = %.4f\n', original_power);
sampled_power = mean(sampled_noise.^2);
fprintf('Sampled noise power = %.4f\n', sampled_power);

%% 5) Spectrum of the original noise
Nfft = 2^nextpow2(N);       % FFT length
f = fs/2 * linspace(0,1,Nfft/2+1);
Y = fft(noise, Nfft)/N;
PSD = 2*abs(Y(1:Nfft/2+1)).^2;   % power spectrum

figure;
plot(f, 10*log10(PSD));
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
title('Spectrum of Original Noise');
grid on;

%% 6) Spectrum of the sampled noise
fs_s = fs/M;                      % new sampling frequency
Ns   = length(sampled_noise);
Nfft_s = 2^nextpow2(Ns);
f_s = fs_s/2 * linspace(0,1,Nfft_s/2+1);
Y_s = fft(sampled_noise, Nfft_s)/Ns;
PSD_s = 2*abs(Y_s(1:Nfft_s/2+1)).^2;

figure;
plot(f_s, 10*log10(PSD_s));
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
title('Spectrum of Sampled Noise');
grid on;
