#!/bin/sh
#	$Id$
# Testing grdfft

ps=gfilter.ps

# Do a 100 km Gaussian filter on some topography
grdfft topo.nc -fg -F-/100000 -Glow.nc -N+l
makecpt -Crainbow -T0/1700/100 -Z > t.cpt
grdgradient topo.nc -Nt1 -fg -A45 -Gitopo.nc
grdgradient low.nc -Nt1 -fg -A45 -Gilow.nc
grdimage topo.nc -Iitopo.nc -Ct.cpt -JM6i -Y6i -Xc -K -P -B5WSne > $ps
echo "315 -10 Original" | pstext -Rtopo.nc -J -O -K -F+jTR+f14p -T -Gwhite -W1p -Dj0.1i >> $ps
grdimage low.nc -Iilow.nc -Ct.cpt -J -Y-4.6i -K -O -B5WSne >> $ps
echo "315 -10 100 km Gaussian" | pstext -R -J -O -K -F+jTR+f14p -T -Gwhite -W1p -Dj0.1i >> $ps
psscale -D3i/-0.4i/5i/0.15ih -O -Ct.cpt -B500 -E+n >> $ps

