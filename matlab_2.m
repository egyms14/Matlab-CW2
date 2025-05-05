% Mohammed Kazim Abbas Shah
% egyms14@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Insert answers here#
clear a
a = arduino();
for i = 1:10   %runs the loop 10 times starting from 1
    writeDigitalPin(a, 'D8', 1); % the 1 means on
    pause(0.5);                   % 0.5 second pause
    writeDigitalPin(a, 'D8', 0);  % the 0 means off
    pause(0.5);                   
end
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% Insert answers here
clear
a = arduino(); 
duration = 600;     % 10 minutes in seconds
interval = 1;       % seconds between samples
samples = duration / interval;
V0 = 0.5;           % volts at 0°C
TC = 0.01;          % volts per °C
voltages = zeros(1, samples);
temperatures = zeros(1, samples);
for i = 1:samples
   v = readVoltage(a, 'A1'); %reads pin A1 on the arudino board
   T = (v - V0) / TC; %voltage to temperature
  
   voltages(i) = v;
   temperatures(i) = T;
   fprintf('Second %d: %.2f °C\n', i-1, T); %shows the current reading
   pause(interval);
end
minTemp = min(temperatures);
maxTemp = max(temperatures);
avgTemp = mean(temperatures);
time = 0:(samples - 1);
figure;
plot(time, temperatures, 'b'); %plots the graph using the variables made, in blue
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
title('Temperature Over Time');

filename = 'cabin_temperature.txt';
fid = fopen(filename, 'w'); %opens the file
fprintf(fid, 'CABIN TEMPERATURE RECORD\n');
fprintf(fid, 'Date: %s\n', datetime("now"));
fprintf(fid, 'Location: Your_Location_Here\n');
fprintf(fid, 'Time\t\tTemperature (°C)\n');
for i = 1:samples
   fprintf(fid, 'Minute %d\t\t%.2f\n', i-1, temperatures(i)); %puts all the readings in the file
end
fprintf(fid, '\nMin Temp:\t%.2f °C\n', minTemp);
fprintf(fid, 'Max Temp:\t%.2f °C\n', maxTemp);
fprintf(fid, 'Avg Temp:\t%.2f °C\n', avgTemp);
fclose(fid);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
% Insert answers here
clear
a  = arduino();
doc temp_monitor %brings the text from the function
temp_monitor(a);%calls on the function
    
%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
% Insert answers here
clear
a = arduino();
doc temp_prediction
temp_prediction(a);

%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]
% Insert reflective statement here (400 words max)
% in the future an improvement i could make is to have an end point in the
% code as at the moment the code for task 2 and 3 goes on infinitely, i
% would implement a feature where you can choose at what point to end the
% code, or rather stop the sensor from measuring temperature externally
% opposed to using a duration in the code, some challenges in the code were
% how to format the while loops and if, else and elsif statements in the
% correct order to make sure the code performed as intended which was
% helped by making the flowcharts to then have a visual representation of
% what order it should be done in. A major limitation was perhaps that the
% thermistor only measures the temperature over the small area it covers,
% in the future there could potentially be multiple sensors at different
% points within the area to then get a more accurate value of the
% temperature as, for example, my thermistor was quite close to the window
% at times resulting in lower readings than if it would've been in a
% different area

%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.