% Mohammed Kazim Abbas Shah
% egyms14@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

% Insert answers here#
clear a
a = arduino('COM3', 'Uno');
for i = 1:10   
    writeDigitalPin(a, 'D8', 1); 
    pause(0.5);                   
    writeDigitalPin(a, 'D8', 0);  
    pause(0.5);                   
end
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
% Insert answers here
clear
a = arduino('COM3', 'Uno'); 
duration = 600;     % 10 minutes
interval = 1;       % seconds between samples
samples = duration / interval;
V0 = 0.5;           % volts at 0°C
TC = 0.01;          % volts per °C
voltages = zeros(1, samples);
temperatures = zeros(1, samples);
for i = 1:samples
   v = readVoltage(a, 'A1');
   T = (v - V0) / TC;
  
   voltages(i) = v;
   temperatures(i) = T;
   fprintf('Second %d: %.2f °C\n', i-1, T);
   pause(interval);
end
minTemp = min(temperatures);
maxTemp = max(temperatures);
avgTemp = mean(temperatures);
time = 0:(samples - 1);
figure;
plot(time, temperatures, 'b');
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
title('Temperature Over Time');

filename = 'cabin_temperature.txt';
fid = fopen(filename, 'w');
fprintf(fid, 'CABIN TEMPERATURE RECORD\n');
fprintf(fid, 'Date: %s\n', datetime("now"));
fprintf(fid, 'Location: Your_Location_Here\n');
fprintf(fid, 'Time\t\tTemperature (°C)\n');
for i = 1:samples
   fprintf(fid, 'Minute %d\t\t%.2f\n', i-1, temperatures(i));
end
fprintf(fid, '\nMin Temp:\t%.2f °C\n', minTemp);
fprintf(fid, 'Max Temp:\t%.2f °C\n', maxTemp);
fprintf(fid, 'Avg Temp:\t%.2f °C\n', avgTemp);
fclose(fid);

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
% Insert answers here
clear
a  = arduino();
temp_monitor(a);
    
%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
% Insert answers here
clear


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.