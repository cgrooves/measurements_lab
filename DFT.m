% DFT function
% Takes data points comprising of a signal period and reconstructs the
% frequencies
function [a, b, c, f] = DFT(waveform,NTerms)

    % Step 1. Load data
    % separate out values for t and y
    t = waveform(:,1);
    y = waveform(:,2);  
    
    % get values such as N, dt, and fs
    N = size(waveform,1)-1;
    
    if mod(42,2)
        N = N - 1;
    end
    
    dt = t(2)-t(1);
    
    % Step 2. Calculate coefficients a and b
    % DFT algorithm
    a0 = 0;
    
    for r = 1:N
        a0 = a0 + 2/N*y(r);
    end
    
    a = zeros(N/2,1);
    b = zeros(N/2,1);
    
    for k = 1:N/2-1
        for r = 1:N
            a(k) = a(k) + 2/N*y(r)*cos(2*pi*r*k/N);
            b(k) = b(k) + 2/N*y(r)*sin(2*pi*r*k/N);
        end
    end
        
    k = floor(N/2);
    
    for r = 1:N
        a(k) = a(k) + 2/N*y(r)*cos(2*pi*r*k/N);
    end
    
    % Step 3. Calculate coefficients c_k
    c = zeros(N/2,1);
    
    for k = 1:N/2
        c(k) = c(k) + sqrt(a(k)^2 + b(k)^2);
    end
    
    c = [a0; c];
    
    % Step 4. Calculate frequences f
    f = zeros(N/2,1);
    
    for k = 1:N/2
        f(k) = k/(N*dt);
    end
    
    f = [0; f];
    
    % Step 5. Plot Amplitude Spectrum
    figure(1)
    stem(f,c)
    xlabel('Frequency (Hz)')
    ylabel('C_k (N)')
    
    y_r = zeros(N,1);
    
    % Step 6. Reconstruct waveform based on a and b values
    for r = 1:N
        
        p = 0;
        
        for k = 1:NTerms
            
            p = p + a(k)*cos(2*pi*r*k/N) + b(k)*sin(2*pi*r*k/N);
        
        end
        
        y_r(r) = a0/2 + p;
        
        if NTerms == N/2
            y_r(r) = y_r(r) + a(N/2)/2*cos(pi*r);
        end
        
    end
    
    % Step 7. Plot original and reconstructed waveforms on top of each
    % other
    figure(2)
    plot(t(1:N),y(1:N),'.')
    hold on;
    plot(t(1:N),y_r(1:N),'-')
    legend('Measured','DFT')
    xlabel('Time')
    xlim([t(1) t(N)])
    
end