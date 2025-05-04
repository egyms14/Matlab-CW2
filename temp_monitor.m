function temp_monitor(a)

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
figure;
startTime = datetime('now');

    while true
        V = readVoltage(a, tempPin);
        TempC = (V - V0) / TCo;
        fprintf('Temperature, %.2f °C\n', TempC);
        Timenow = datetime('now') - startTime;
        tempData(end+1) = TempC;
        timeData(end+1) = seconds(Timenow);

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
             writeDigitalPin(a, red, 0);
             pause(1);

        elseif TempC < 18
             writeDigitalPin(a, green, 0);
             writeDigitalPin(a, yellow, 1);
             pause(0.5);
             writeDigitalPin(a, yellow, 0);
             pause(0.5);

        else
             writeDigitalPin(a, green, 0);
             writeDigitalPin(a, red, 1);
             pause(0.25);
             writeDigitalPin(a, red, 0);
             pause(0.25);
        end
    end