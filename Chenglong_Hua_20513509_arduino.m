%Chenglong_Hua_20513509
%ssych3@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

a = arduino; %Initialize the Arduino Uno Board
%Note: If the Arduino is needed to be tested, clear the variable assigned
%using "clear a", to make sure the repitition of connection.

for i = 1:5 %Execute 5 times
    writeDigitalPin(a, 'd13', 1); %Set the Digital Pin 13 HIGH
    pause(1); %Keep 0.5s
    writeDigitalPin(a, 'd13', 0); %Set the Digital Pin 13 LOW
    pause(1); %Keep 0.5s
end %End for

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

a = arduino; %Initialize the Arduino Uno Board

va=linspace(0,0,601); %Set a empty array to store the voltage read
i=1; %Counter for second
while 1 %Waiting for 10mins
    v=a.readVoltage('A0'); %Read the voltage on the Analog Pin 0
    pause(1); %Wait for 1s;
    va(i)=v; %Assign the values in order into the array
    i=i+1; %Shift the counter
    if i == 602 %Exit the loop after 10mins' measurements
        break; %Break the infinite loop
    end
end

T=(va-0.5)/0.01; %Convert the voltage to temperature, Tc = 10mV/deg. T_0deg = 500mV
t=1:1:601; %Set the time (s)
Tavg=mean(T); %Get the average of the temperature measured
Tmax=max(T); %Get the maximum of the temperature measured
Tmin=min(T); %Get the minimum of the temperature measured
plot(t,T); %Plot the graph T-t
xlabel("Time (s)");
ylabel("Temperature (\circC)");
xlim([0 601]);

fp = fopen("cabin_temperature.txt", "w"); %Open the file as written
fprintf(fp, "Data logging initiated - 5/4/2024\nLocation - Nottingham\n\n"); %Write the title of the file
for i = 0:10 %Print the data of Minute 0 to Minute 10
    t_txt = sprintf("Minute\t\t\t%d\n", i); %Use format specifier to assign the Minute to a string
    T_txt = sprintf("Temperature\t\t%.2f C\n",T(i*60+1)); %Use format specifier to assign the Temperature to a string
    fprintf(fp, t_txt); %Write the format specifier of the Minute
    fprintf(fp, T_txt); %Write the format specifier of the Temperature 
    fprintf(fp, "\n");
end
fprintf(fp, "Max temp\t\t%.2f C\nMin temp\t\t%.2f C\nAverage temp\t%.2f C\n\nData logging terminated", Tmax, Tmin, Tavg);
fclose(fp);
fp = fopen("cabin_temperature.txt", "r"); %Read the file
fcontent = fscanf(fp, "%s"); %Get the strings in the file
disp(fcontent); %Print the read content in the command window

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

% Insert answers here


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert answers here