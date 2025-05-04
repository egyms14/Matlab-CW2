function temp_prediction(a)
% this function monitors the temperature and caluclates the rate at which
% it changes while also using said rate to give a prediction for the
% temperature 5 minutes ahead, it measures the temperature every second and
% then calculates dtemp/dtime
green = 'D2';
yellow = 'D6';
red = 'D4';
tempPin = 'A1';
configurePin(a, green, 'DigitalOutput');
configurePin(a, yellow, 'DigitalOutput');
configurePin(a, red, 'DigitalOutput');
V0 = 0.5;
TCo = 0.01;
tempData = [];
timeData = [];
startTime = datetime('now');
figure;
while true
   V = readVoltage(a, tempPin);
       TempC = (V - V0) / TCo;
       nowTime = seconds(datetime('now') - startTime);
       tempData(end+1) = TempC;
       timeData(end+1) = nowTime;
       if length(tempData) >= 2
           n = min(5, length(tempData));
           dT = tempData(end) - tempData(end - n + 1);
           dt = timeData(end) - timeData(end - n + 1);
           rateCps = dT / dt;
           T_future = TempC + rateCps * 300; 
           fprintf('Temp: %.2f°C Rate: %.4f°C/s Temp in 5 mins: %.2f°C\n', ...
               TempC, rateCps, T_future);
         
           writeDigitalPin(a, green, 0);
           writeDigitalPin(a, yellow, 0);
           writeDigitalPin(a, red, 0);
           if TempC >= 18 && TempC <= 24
               writeDigitalPin(a, green, 1); 
           elseif rateCps > 0.0667 % 0.0667 is equivalent to 4 degrees per min
               writeDigitalPin(a, red, 1);  
           elseif rateCps < -0.0667
               writeDigitalPin(a, yellow, 1);
           end
      end
       plot(timeData, tempData, '-r');
       xlabel('Time (s)');
       ylabel('Temperature (°C)');
       grid on;
       drawnow;
       pause(1);
    end
end
