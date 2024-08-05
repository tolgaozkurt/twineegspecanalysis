load('eeg1_int_int.mat')
load('eeg2_int_int.mat')
load('eeg3_int_int.mat')
load('eeg4_int_int.mat')

% Fig. 2A

lenseg = 200;
fs = 100;

eeg1_int_int = eeg1_int_int(2:end)  - mean(eeg1_int_int(2:end));

[P,W] = pwelch(eeg1_int_int,hann(lenseg),0.5*lenseg,lenseg,fs);
figure, 
subplot(4,1,1)
plot(W(4:end),P(4:end),'Color','k','LineWidth',3)
set(gca,'FontSize',14)
axis tight

eeg2_int_int = eeg2_int_int(2:end)  - mean(eeg2_int_int(2:end));

[P,W] = pwelch(eeg2_int_int,hann(lenseg),0.5*lenseg,lenseg,fs);
subplot(4,1,2), plot(W(4:end),P(4:end),'Color','k','LineWidth',3)
set(gca,'FontSize',14)
axis tight

eeg3_int_int = eeg3_int_int(2:end)  - mean(eeg3_int_int(2:end));

[P,W] = pwelch(eeg3_int_int,hann(lenseg),0.5*lenseg,lenseg,fs);
subplot(4,1,3), plot(W(4:end),P(4:end),'Color','k','LineWidth',3)
set(gca,'FontSize',14)
axis tight

eeg4_int_int = eeg4_int_int(2:end)  - mean(eeg4_int_int(2:end));

[P,W] = pwelch(eeg4_int_int,hann(lenseg),0.5*lenseg,lenseg,fs);
subplot(4,1,4), plot(W(4:end),P(4:end),'Color','k','LineWidth',3)
set(gca,'FontSize',14)
axis tight

% Fig. 2B

[Pxx,f] = spectrum_multitapered(eeg4_int_int, 2, lenseg, 0.5*lenseg, lenseg, fs);
midway = floor(200/2)+1;

[a,b,c] = spectrogram_regress_pink( Pxx(11:midway)', f(11:midway));

figure, plot(f(11:midway),Pxx(11:midway),'Color','k','LineWidth',3)

hold on, plot(f(11:midway),b,'Color','b','LineWidth',3)

axis tight

figure, plot(f(11:midway),Pxx(11:midway) - b,'Color','k','LineWidth',3)
set(gca,'FontSize',14)
xlabel('frequency (Hz)');


axis tight



