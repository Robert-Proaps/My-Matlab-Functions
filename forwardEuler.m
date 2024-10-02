function [x, yp] = forwardEuler(yi, stepSize, finalValue, fode)
%Usage: yi is the initial y value, stepSize is the step size,finalValue is the last x value that will be calculated, fode is the
%first order differnetial equation in terms of x,y and is symbolic.
%Returns: a list of all x values calculated and a list of all values of
%y-prime.
n = finalValue / stepSize;
x = zeros(1,n+1);
yp = zeros(1,n+1);
yp(1,1) = yi;

%Eulers Method
for i = 1:n
    x(1,i+1) = x(i) + stepSize;
    yp(1,i+1) = yp(1,i) + stepSize .* fode(x(1,i),yp(i));
end

end
