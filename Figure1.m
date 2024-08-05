load eeg1_int_int 
load eeg2_int_int 
load eeg3_int_int 
load eeg4_int_int 

%% plot the waves

tim = 1/100 * (0:2999);

figure(1) 

subplot(2,1,1)
axis tight
plot(tim, eeg1_int_int,'Color','k','LineWidth',1)
ylim([-20 30])
set(gca,'XTick',[])
set(gca,'FontSize',14)

subplot(2,1,2)
axis tight
plot(tim, eeg2_int_int,'Color','k','LineWidth',1)
ylim([-20 30])
xlabel('time (s)')
set(gca,'FontSize',14)

figure(2) 

subplot(2,1,1)
axis tight
plot(tim, eeg3_int_int,'Color','k','LineWidth',1)
ylim([-20 30])
set(gca,'XTick',[])
set(gca,'FontSize',14)

subplot(2,1,2)
axis tight
plot(tim, eeg4_int_int,'Color','k','LineWidth',1)
ylim([-20 30])
xlabel('time (s)')
set(gca,'FontSize',14)

