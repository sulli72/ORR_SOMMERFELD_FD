function FORMATFIG(f,figpos,ixlog,iylog,ieq)

%%% INPUTS:
% f = Figure you are modifying
% figpos = desired figure position vector
% ixlog = X-axis log scale
% iylog = Y-axis log scale
% ieq = turn on 'axis equal' command (good for high aspect ratio plots)


% Attain figure position
f.Position=figpos;

% Convert figure scaling from pixels to inches (preserves sizing across
% monitors w/ different resolutions)
% Try w/ 100 pixels/inch approximation
posvec = figpos/100;
set(f, 'Units', 'inches', 'Position', posvec);


% General style parameters
% figfontsize=16; % <-- font size
figfontsize=20; % <-- font size
grid off        % <-- grid overlay on/off 
lwd=.5;         % <-- tick size

% Fix font size
fontsize(gcf,figfontsize,'points')

% Modify first set of axes (original x-y (bottom-left) axis pair
ax1=gca;
set(ax1,'box','on'); % <-- flag to duplicate x-y axis style on opposite sides
set(ax1,'LineWidth',lwd,'ticklength',1.4*get(gca,'ticklength'))  % <-- modify tick size
set(ax1,'tickdir','in','XMinorTick','on')  % <-- modify tick orientation
set(ax1,'tickdir','in','YMinorTick','on')  % <-- modify tick orientation
set(ax1,'fontsize', figfontsize) % <-- axis font size (redundant?)

lgd = findobj(gcf, 'Type', 'Legend'); % <-- get legend
if isempty(lgd)==1
 % Do nothing to figure
 % This line seems to help text size appropriately...
else
 % Modify legend font size if it exists
 % fontsize(lgd,12,'points');
 fontsize(lgd,20,'points');
 % fontsize(lgd,18,'points');
end

% Logarithmic scaling modifications for second x-axis
if(ixlog==1)
 set(ax1, 'XScale', 'log');

 if ixlog == 1 && any(get(ax1, 'XLim') <= 0)
  % Log axis returns error if limits <= 0
  % Ensure use of (small) positive values in this case
  error('Log scale requires positive x-limits.');
 end

end

% Logarithmic scaling modifications for second y-axis
if(iylog==1)
 set(ax1, 'YScale', 'log');

 if iylog == 1 && any(get(ax1, 'YLim') <= 0)
  error('Log scale requires positive y-limits.');
 end
end

if(ieq==1)
 % Fix to equal size if needed
 axis equal 
end

% Wrap figure in outer black box
borderpos = tightPosition(ax1);
annotation("rectangle",borderpos,Color="black",LineWidth=1.5)

end