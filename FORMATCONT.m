function FORMATCONT(f,figpos,ixlog,iylog,ieq)

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
set(ax1,'box','on');
set(ax1,'LineWidth',lwd,'ticklength',1.4*get(gca,'ticklength'))  % <-- modify tick size
set(ax1,'tickdir','out','XMinorTick','on')  % <-- modify tick orientation
set(ax1,'tickdir','out','YMinorTick','on')  % <-- modify tick orientation
set(ax1,'fontsize', figfontsize) % <-- axis font size (redundant?)

lgd = findobj(gcf, 'Type', 'Legend'); % <-- get legend
if isempty(lgd)==1
 % Do nothing to figure
 % This line seems to help text size appropriately...
else
 % Modify legend font size if it exists
 % fontsize(lgd,12,'points');
 fontsize(lgd,16,'points');
 % fontsize(lgd,18,'points');
end

% % Create second x-y axis pair (top/right)
% ax2 = axes('Position', get(ax1, 'Position'),'Color', 'none');

if(ieq==1)
 % Fix to equal size if needed
 axis equal 
end

% 
% % Make second set of axis markeers identical to first one
% set(ax2,'LineWidth',lwd,'ticklength',1.4*get(gca,'ticklength'))
% set(ax2, 'XAxisLocation', 'top','YAxisLocation','Right');
% set(ax2, 'XLim', get(ax1, 'XLim'),'YLim', get(ax1, 'YLim'));
% set(ax2, 'XTick', get(ax1, 'XTick'), 'YTick', get(ax1, 'YTick'));
% set(ax2,'tickdir','in','XMinorTick','on')
% set(ax2,'tickdir','in','YMinorTick','on')
% set(ax2, 'XMinorTick', get(ax1, 'XMinorTick'));
% set(ax2, 'YMinorTick', get(ax1, 'YMinorTick'));

% Logarithmic scaling modifications for second x-axis
if(ixlog==1)
 set(ax1, 'XScale', 'log');
 % set(ax2, 'XScale', 'log');

 if ixlog == 1 && any(get(ax1, 'XLim') <= 0)
  % Log axis returns error if limits <= 0
  % Ensure use of (small) positive values in this case
  error('Log scale requires positive x-limits.');
 end

end

% Logarithmic scaling modifications for second y-axis
if(iylog==1)
 set(ax1, 'YScale', 'log');
 % set(ax2, 'YScale', 'log');

 if iylog == 1 && any(get(ax1, 'YLim') <= 0)
  error('Log scale requires positive y-limits.');
 end
end

% Include labels on second axis set tick marks 
% yticklabels({}); % <-- Clears labels (no words appear)
% xticklabels({}); % <-- Clears labels (no words appear)
% set(ax2, 'XTick', get(ax1, 'XTick'), 'YTick', get(ax1, 'YTick')); % <-- copies ax1 labels

% Wrap figure in outer black box

borderpos = tightPosition(ax1);
% borderpos = tightPosition(ax2);
annotation("rectangle",borderpos,Color="black",LineWidth=1.5)
% annotation("rectangle",borderpos,Color="white",LineWidth=1.5)

end