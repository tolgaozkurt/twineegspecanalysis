sig1 = eeg3_int_int;
sig2 = eeg4_int_int;

flow1 = 2:2:38;
flow2 = flow1 + 4;
srate = 100;
seglen = 1000;

segnum = (3000 - seglen) / 100 + 1 ;

tmp = zeros(19,segnum);

for jj = 1:19  % frequencies
    

    for ii = 1:segnum
    
    alpha1=eegfilt(sig1((ii-1)*100+1:(ii-1)*100+seglen)',srate,flow1(jj),flow2(jj));  %Compute the low freq signal. (EEGLab function) 
    alpha2=eegfilt(sig2((ii-1)*100+1:(ii-1)*100+seglen)',srate,flow1(jj),flow2(jj)); 
    
    amp1 = abs(hilbert(alpha1)); 
    amp2 = abs(hilbert(alpha2)); 
    
    tmp(jj,ii) = ((amp1-mean(amp1))./std(amp1))*((amp2-mean(amp2))./std(amp2))';
    tmp(jj,ii) = tmp(jj,ii) ./ seglen;
    
    end

end

mt = mean(tmp');

figure, plot(flow1(2:end)+2,mt(2:end),'Color','k','LineWidth',2)
xlabel('frequency (Hz)');
set(gca,'FontSize',14)

xlim([3 50])
axis tight

% temporal evolution of alpha amplitude co-variation
tim = 0:0.1:2; 
figure, plot(tim,tmp(4,:),'Color','k','LineWidth',2)
axis tight
xlabel('time')
set(gca,'FontSize',14)

