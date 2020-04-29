%manipolatore seriale con 6 giunti rotoidali
clear();
clc();

%parametri del puma 560
L(1) = Link('d',0.0,'a',0.0,'alpha',pi/2,'revolute');
L(2) = Link('d',0.0,'a',0.4323,'alpha',0.0,'revolute');
L(3) = Link('d',0.1501,'a',0,'alpha',-pi/2,'revolute');
L(4) = Link('d',0.4331,'a',0.0,'alpha',pi/2,'revolute');
L(5) = Link('d',0.0,'a',0.0,'alpha',-pi/2,'revolute');
L(6) = Link('d',0.0,'a',0.0,'alpha',0.0,'revolute');

manipolatore_seriale = SerialLink(L, 'name','manipolatore_seriale');

%manipolatore_seriale.plot([pi/2,-pi/4,pi/8,pi/10,pi/4,pi/3])








