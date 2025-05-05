function temp_monitor(a)
% this function reads temperature from the thermistor and then lights up
% LEDs according to what range the temperature is within, between 18-24
% degrees a constant green light will show, anything below this rage will
% present a blinking yellow light and anything above a blinking red light
green = 'D2';
yellow = 'D6';
red = 'D4';
tempPin = 'A1'; %assigns the variable name to where the LEDs and thermistor are connected to on the arduino board
configurePin(a, green, 'DigitalOutput');
configurePin(a, yellow, 'DigitalOutput');
configurePin(a, red, 'DigitalOutput');
V0 = 0.5;
TCo = 0.01;
tempData = [];
timeData = [];%creates empty array to store data in
startTime = datetime('now');

figure;

    while true
        V = readVoltage(a, tempPin);
        TempC = (V - V0) / TCo; %voltage to temp equation
        fprintf('Temperature, %.2f °C\n', TempC);
        Timenow = datetime('now') - startTime; %time that has passed from start
        tempData(end+1) = TempC; %puts the tempC into the tempData array
        timeData(end+1) = seconds(Timenow); %converts to seconds

        plot(timeData, tempData, '-b');
        xlabel('Time (s)');
        ylabel('Temperature in degrees');
        ylim([10 40]);
        xlim([max(0, timeData(end)-60), timeData(end)+1]);
        drawnow;
        grid on;

            writeDigitalPin(a, green, 0);
            writeDigitalPin(a, yellow, 0);
            writeDigitalPin(a, red, 0);
        if TempC >= 18 && TempC <= 24
             writeDigitalPin(a, green, 1);
             writeDigitalPin(a, yellow, 0);
             writeDigitalPin(a, red, 0); % 0 means off and 1 means on
             pause(1); %1 second pause

        elseif TempC < 18  %this elseif command only used when previosu command is not true
             writeDigitalPin(a, green, 0);
             writeDigitalPin(a, yellow, 1);
             pause(0.5);
             writeDigitalPin(a, yellow, 0);
             pause(0.5);

        else %also only used when previous command is not true
             writeDigitalPin(a, green, 0);
             writeDigitalPin(a, red, 1);
             pause(0.25);
             writeDigitalPin(a, red, 0);
             pause(0.25);
        end
    end