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
       