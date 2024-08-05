sig1 = eeg3_int_int;
sig2 = eeg4_int_int;

lenseg = 100;
NW = 2;

[cohc2,fr2] = mscohere_multitapered(sig1,sig2,NW,lenseg, 0.5*lenseg,lenseg,fs);

midway = floor(lenseg/2)+1;

figure, plot(fr2(5:midway),cohc2(5:midway),'Color','k','LineWidth',2)
xlabel('frequency (Hz)');
set(gca,'FontSize',14)

confls = find_confidence_lev_mscoherence_multitapered(sig1,sig2, NW, lenseg, fs, 1000);

axis tight
xlim([3 50])
title('multitapering')