function [Cxy,f] = mscohere_multitapered(x, y, NW, winLength, noverlap, nfft, fs)
    % Input parameters:
    % x, y      - Input signals
    % window    - Window function (e.g., hamming, hanning, etc.)
    % noverlap  - Number of overlapping samples
    % nfft      - Number of FFT points
    % fs        - Sampling frequency
    
  
  
    % Segment length
    % winLength = segmentlength;
    
  

    % Number of tapers (2*NW - 1)
    KK = 2 * NW - 1;

    % 
    % Compute discrete prolate spheroidal sequences (Slepian sequences)
    E = dpss(winLength, NW, KK);
    
    % Number of segments
    nSegments = floor((length(x) - noverlap) / (winLength - noverlap));
    
    % Initialize power spectral densities
    Pxx = zeros(nfft, nSegments);
    Pyy = zeros(nfft, nSegments);
    Pxy = zeros(nfft, nSegments);
    
  
    
    for ii = 1:nSegments   % Compute the FFT for each segment 

        % Segment indices
        idx = (ii-1) * (winLength - noverlap) + (1:winLength);

        for jj=1:KK % weight and fft for each taper
        
      
            % Apply taper
            xw = x(idx) .* E(:, jj);
            yw = y(idx) .* E(:, jj);
            
            % Compute FFT
            X = fft(xw, nfft);
            Y = fft(yw, nfft);
            
            % Compute power spectral densities
            Pxx(:,ii) = Pxx(:,ii) + (X .* conj(X)) / (winLength * fs);
            Pyy(:,ii) = Pyy(:,ii) + (Y .* conj(Y)) / (winLength * fs);
            Pxy(:,ii) = Pxy(:,ii) + (X .* conj(Y)) / (winLength * fs);

        end
        Pxx(:,ii) = Pxx(:,ii) ./ KK;
        Pyy(:,ii) = Pyy(:,ii) ./ KK;
        Pxy(:,ii) = Pxy(:,ii) ./ KK;
        
    end
    
    % Average the power spectral densities
    Pxx = mean(Pxx,2);
    Pyy = mean(Pyy,2);
    Pxy = mean(Pxy,2);
    
    % Compute magnitude-squared coherence
    Cxy = (abs(Pxy) .^ 2) ./ (Pxx .* Pyy);
    
    % % Plot the coherence
    %  midway = floor(nfft/2)+1;
    f = (0:nfft-1) * (fs / nfft);
    % % plot(f, Cxy);
    % figure, plot(f(10:midway),Cxy(10:midway),'LineWidth',2)
    % xlabel('Frequency (Hz)');
    % ylabel('Coherence');
    % title('Multitapered Coherence');
end
