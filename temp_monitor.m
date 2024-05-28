%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

figure;

va=linspace(0,0,601); %Set a empty array to store the voltage read
T=linspace(0,0,601);
i=1; %Counter for second

while true
    v=a.readVoltage('A0'); %Read the voltage on the Analog Pin 0
    va(i)=v; %Assign the values in order into the array
    
    if i == 602 %Exit the loop after 10mins' measurements
        break; %Break the infinite loop
    end
    T(i)=(va(i)-0.5)/0.01; %Convert the voltage to temperature, Tc = 10mV/deg. T_0deg = 500mV
    t=1:1:601; %Set the time (s)
    Tavg=mean(T); %Get the average of the temperature measured
    Tmax=max(T); %Get the maximum of the temperature measured
    Tmin=min(T); %Get the minimum of the temperature measured
    plot(t,T); %Plot the graph T-t
    xlabel("Time (s)");
    ylabel("Temperature (\circC)");
    title("Real Temperature Plot");
    drawnow;
    xlim([0 601]);
    if T(i) <= 24 && T(i) >= 18
        writeDigitalPin(a, 'd11', 0);
        writeDigitalPin(a, 'd12', 0);
        
        writeDigitalPin(a, 'd13', 1); %Set the Digital Pin 13 (Green) High constantly
        pause(2);
    end
    if T(i) < 18
        writeDigitalPin(a, 'd13', 0);
        writeDigitalPin(a, 'd12', 0);

        writeDigitalPin(a, 'd11', 1); %Set the Digital Pin 11 (Yellow) HIGH
        pause(1); %Keep 0.5s
        writeDigitalPin(a, 'd11', 0); %Set the Digital Pin 11 (Yellow) LOW
        pause(1); %Keep 0.5s
    end
    if T(i) > 24
        writeDigitalPin(a, 'd13', 0);
        writeDigitalPin(a, 'd11', 0);

        writeDigitalPin(a, 'd12', 1); %Set the Digital Pin 12 (Red) HIGH
        pause(0.5); %Keep 0.25s
        writeDigitalPin(a, 'd12', 0); %Set the Digital Pin 12 (Red) LOW
        pause(0.5); %Keep 0.25s
    end
    i=i+1; %Shift the counter
end