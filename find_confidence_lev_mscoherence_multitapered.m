function [boot_coherence, conf_levels,fr] = find_confidence_lev_mscoherence_multitapered(x, y, NW, lensegment, fs, nboot)

midway = floor(0.5*lensegment)+1;
boot_coherence = zeros(nboot,midway);

% segments of data
numofseg = floor((length(x) / lensegment ));

x_seg_mat = reshape(x,[lensegment,numofseg]);


% Bootstrapping
for ii = 1:nboot
    
    resample_segx = randperm(numofseg);

    x_resampled_seg = x_seg_mat(:,resample_segx);

    x_shuffled = reshape(x_resampled_seg,[],1);

    [cohc_boot,fr] = mscohere_multitapered(x_shuffled,y,NW,lensegment, 0.5*lensegment,lensegment,fs);
    
    boot_coherence(ii,:) = cohc_boot(1:midway)';
end

conf_levels = prctile(boot_coherence, [0, 90]);

hold on, plot(fr(5:midway),conf_levels(2,5:midway),'--','Color','g','LineWidth',2)
