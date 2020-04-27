function [m,mu,t0,r0,dotr0,tf,rL,hL,vL,orbitalPeriod, meanRadius] = ops_zadani_2_2019_data(id)
%OPS_ZADANI_2_2019_DATA Parametry zadani semestralni prace z OPS
%   [m,mu,t0,r0,dotr0,tf,rf,hf,vf] = ops_zadani_2_2019_data(id) pro
%   cislo zadani id vrati
%   m - hmotnost lunarniho modulu [kg]
%   mu - gravitacni parametr Mesice [m^3/s^2]
%   t0 - pocatecni cas [s]
%   r0 - pocatecni polohu lunarniho modulu [m]
%   dotr0 - pocatecni rychlost lunarniho modulu [m/s]
%   tf - koncovy cas [s]
%   rL - pozadovane misto pristani na Mesici
%   hL - pozadovana vyska nad mistem pristani
%   vL - pozadovana koncova rychlost smerem k Mesici ve vysce hL nad rL

% Parametry Mesice
meanRadius = 1737.1e3; % [m]
mu = 4.9048695e12; % [m^3/s^2]

% Parametry pocatecni orbity
periluneSurface = 15e3;
apoluneSurface = 100e3;
perilune = meanRadius+periluneSurface; % [m]
apolune = meanRadius+apoluneSurface; % [m]
semiMajorAxis = (perilune+apolune)/2; % [m]
foci = semiMajorAxis - meanRadius - periluneSurface; % [m]
semiMinorAxis = sqrt(semiMajorAxis^2-foci^2); % [m]
eccentricity = foci/semiMajorAxis; % [-]
orbitalPeriod = 2*pi*sqrt(semiMajorAxis^3/mu); % [s]


switch id
    case 1
        m = 10e3; % [kg]
        t0 = 0; % [s]
        r0 = [-0.478640266034590
            1.739494328920576]*1e6; % [m]
        dotr0 = [-0.001594723874536
            -0.000400294396076]*1e6; % [m/s]
        tf = 1200; %[s]
        phif = 0.8*pi; % [rad]
        rL = [meanRadius*cos(phif)
            meanRadius*sin(phif)]; % [m]
        hL = 1; % [m]
        vL = 1; % [m/s]
    case 2
        m = 11e3; % [kg]
        t0 = 0; % [s]
        r0 = [1.072153086236514
            1.405900603010110]*1e6; % [m]
        dotr0=[-0.001315205026093
            0.001041420882193]*1e6; % [m/s]
        tf = 1500; %[s]
        phif = pi/2; % [rad]
        rL = [meanRadius*cos(phif)
            meanRadius*sin(phif)]; % [m]
        hL = 10; % [m]
        vL = 3; % [m/s]
    otherwise
        error('Nezname cislo zadani')
        m = 10e3; % [kg]
        t0 = 0; % [s]
        r0 = [perilune
            0]; % [m]
        dotr0 = [0
            sqrt(mu*(2/(semiMajorAxis-foci)-1/semiMajorAxis))]; % [m/s]
        tf = 1200; %[s]
        phif = pi/8; % [rad]
        rL = [meanRadius*cos(phif)
            meanRadius*sin(phif)]; % [m]
        hL = 1; % [m]
        vL = 3; % [m/s]
end

end