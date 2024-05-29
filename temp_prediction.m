%Chenglong_Hua_20513509
%ssych3@nottingham.edu.cn



%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
function temp_prediction
n=1;
data=1; %current data
count=1;
while n>2
    v=a.readVoltage('A0'); %Read the voltage on the Analog Pin 0
    temperature=(v-0.5)/0.01/Tc; %The relationship between temperature and voltage
    data(count)=temperature;
    if count>1
        rate=data(count)-data(count-1);%the rate of change in temperature
        fprintf('The rate of change in temperature is %.2f°C/s',rate)
        if rate>4 %When the rate of change in temperature > 4, a constant Red LED 
        writeDigitalPin(a, 'd13', 0); %The Green LED is off
        writeDigitalPin(a, 'd11', 0); %The Yellow LED is off

        writeDigitalPin(a, 'd12', 1); %Set the Digital Pin 12 (Red) HIGH
        end
        if rate>-4 %When the rate of change in temperature > -4, a constant Yellow LED
        writeDigitalPin(a, 'd13', 0); %The Green LED is off
        writeDigitalPin(a, 'd12', 0); %The Red LED is off

        writeDigitalPin(a, 'd11', 1); %Set the Digital Pin 11 (Yellow) HIGH
        end
        if (-4<rate)<4 % When the rate of change in temperature belong -4 to 4, a constant Green LED
        writeDigitalPin(a, 'd11', 0);
        writeDigitalPin(a, 'd12', 0);
        
        writeDigitalPin(a, 'd13', 1); %Set the Digital Pin 13 (Green) High constantly
        end
        predict_temperature=data(count)+rate*300; %Predict the temperature and 300=5min*60s/min
    end
end
end

%Explainarion is in the file of 'doc_tem_prediction.m'


