clear all
close all
clc

% Sector masses: contents of the file post_ANGLE/SectorMasses_ANGLE.txt
%
%   the first eight values are sector masses
%   the ninth is the sum of all sectors
%   the tenth is the total particle mass
%
%   Example:
%       # Fix print output for fix printSectorMasses
%       769.6198 778.7329 783.0256 732.2876 617.2651 733.2376 783.2716 781.2663 5999.9946 5999.9946


% load start angles values
load ("startAngles.txt","-ascii")

% create color space for plotting
cc = hsv(max(size(startAngles)));
% create data structur for the legend
legendData = {};
% create a counter
i = 0;

% create figure
figure(1)
hold on
grid on

% loop over all start angles
for curAngle = startAngles'
    if exist(["post_",num2str(curAngle)])
        if exist(["post_",num2str(curAngle),"/SectorMasses_",num2str(curAngle),".txt"])
            disp([" ... processing data for angle ",num2str(curAngle),"°"])
            % read sectoral masses
            dataImp = importdata (["post_",num2str(curAngle),"/SectorMasses_",num2str(curAngle),".txt"], " ", 1);
            dataVal = dataImp.data;
            % increment counter
            i++;
            % plot normalized sector masses
            plot([1:8],dataVal(1:8)*8/dataVal(9),'o-','color',cc(i,:))
            % add current angle to the plot's legend
            legendData{i} = num2str(curAngle);
        else
            disp(["No sectoral-mass data available for angle ",num2str(curAngle)," available yet."])
        end
    else
        disp(["No solution-data directory for angle ",num2str(curAngle)," found!"])
    endif
end

%celldisp(legendData)
legend(legendData,"location","NorthEastOutside")

xlabel('Sector No.')
ylabel('Sector mass ratio')

title('Comparison of circumferential mass distributions w.r.t. chute start angles')

saveas(gcf,'circumferentialMassDistribution.png','png')

