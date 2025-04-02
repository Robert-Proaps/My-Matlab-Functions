%Clean the workspace.
clc;
clear;

%Data
dataPoints = [3.6 2.5;5.9 -3.4;10.5 13.5;15.3 -4.9;19.3 14;23.5 29.9;27.3 34.9]; %Table of collected datapoints.
xData = dataPoints(:,1); %Isolated x values from the data.
yData = dataPoints(:,2); %Isolated y values from the data.
A = [ones(height(xData),1) xData xData.^2 xData.^3 xData.^4 xData.^5 xData.^6]; %Coeffecient matrix for calculating p6.
A = [A, yData]; %Augmented matrix for performing gaussian elemination.

%Gauss-Jordan Elemination

    for i = 1:height(A)
        %Ensure the pivot element is non-zero
        if A(i, i) == 0
            % Swap with a row below that has a non-zero pivot
            for k = i+1:height(A)
                if A(k, i) ~= 0
                    A([i k], :) = A([k i], :); % Swap rows i and k
                    break;
                end
            end
        end

        %Make the pivot element A(i, i) equal to 1
        A(i, :) = A(i, :) / A(i, i);

        %Eliminate all other elements in column i
        for j = 1:height(A)
            if j ~= i
                A(j, :) = A(j, :) - A(j, i) * A(i, :);
            end
        end
    end

%Forming the polynomial
polyCoeffecients = A(:,end)';
%we must flip the array because matlab expects the highest order term
%first.
polyCoeffecients = fliplr(polyCoeffecients);

plotDomain = linspace(0,30,100);
y = polyval(polyCoeffecients, plotDomain);

%Solution output.
disp("The coeffecients of the 6th degree polynomial are as follows, from highest order to lowest order.");
disp(polyCoeffecients);

%Make and stylize the plot.
figure(1)
hold on;
plot(plotDomain,y); %Smooth Polynomial
scatter(xData,yData);

