function h = plot_number(t,number,line,plabel)
% Plots number of constructed relations
%   t           Values of a thresholding parameter
%   number      Number of relations
%   line        Type of line e.g. '-' for solid '--' for dashed
%   plabel      X label (varying parameter)

grid on;
h = plot(t,number,line);
set(h,'LineWidth',1.5);
ylabel('Number of relations'); 
xlabel(plabel);

end
