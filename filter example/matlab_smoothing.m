%% Filtering example in Matlab
% for comparison with Julia, Python, Octave...
% Pierre Haessig, June 2018

%% 1. Test the function (plot)

% Input vector (a kind of random walk) with 1000 pts
rng(0) % seed the RNG
u = cumsum(randn(1000,1));

% Compute and plot
a = 0.95;
figure;
hold on;
plot(u);
line = plot(smooth(u, a), 'LineWidth', 5);
line.Color(4) = 0.5; % semi-tranparent
legend(["original signal", "smoothed"]);


%% 2. Timing, with 10^7 pts input

u = cumsum(randn(10^7, 1));

% log console output to a file
diary('matlab_log.txt')

disp(version)
disp("Timing of the smoothing filter in Matlab, for 10^7 pts")
disp("1. iterative implementation")

tic();
smooth(u, 0.9);
toc();

disp("2. Matlab filter function")
% Timing of Matlab filter function (https://mathworks.com/help/matlab/ref/filter.html)
tic();
y = filter([.1], [1, -0.9], u);
toc();

diary off % disable logging to file

%% Smoothing function implementation (local function)
% Note:  including functions in scripts requires MATLAB R2016b or later.

function y = smooth(u, a)
    y = zeros(length(u),1);
    
    y(1) = (1-a)*u(1);
    for k=2:length(u)
        y(k) = a*y(k-1) + (1-a)*u(k);
    end
end