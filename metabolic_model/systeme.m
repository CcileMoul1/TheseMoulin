%This file is writen by hand and not automatically
function dxdt = systeme(t,x,param,order)

	%Get the index
	ind = getIndex(order);

	%Get the fluxes
	fluxes = flux(t,x,param,order);
   
   	mu = fluxes('mu');

	%The equations
	dxdt(ind('G6P')) = fluxes('VHK') - fluxes('VPGI') - fluxes('VG6PDH') - param('dG')*mu - mu*x(ind('G6P'));
	dxdt(ind('F6P')) = fluxes('VPGI') - fluxes('VPFK') + 2*fluxes('VTK') - mu*x(ind('F6P'));
	dxdt(ind('GAP')) = 2*fluxes('VPFK') - fluxes('VPGK') + fluxes('VTK') - mu*x(ind('GAP'));
	dxdt(ind('PEP')) = fluxes('VPGK') - fluxes('VPK') - mu*x(ind('PEP'));
	dxdt(ind('PYR')) = fluxes('VPK') - fluxes('VLDH') - fluxes('VPDH') - fluxes('VPC') + fluxes('VME') - fluxes('VAlaTA') - mu*x(ind('PYR'));
	dxdt(ind('R5P')) = fluxes('VG6PDH') - fluxes('VEP') - fluxes('VTK') - param('dR')*mu - mu*x(ind('R5P'));
	dxdt(ind('X5P')) = fluxes('VEP') - 2*fluxes('VTK') - mu*x(ind('X5P'));
	dxdt(ind('ACCOA')) = fluxes('VPDH') - fluxes('VCS') + fluxes('VACL') - 8*fluxes('VPALM') - mu*x(ind('ACCOA'));
	dxdt(ind('CIT')) = fluxes('VCS') - fluxes('VCITS') - fluxes('VACL') - mu*x(ind('CIT'));
	dxdt(ind('AKG')) = fluxes('VCITS') - fluxes('VAKGDH') + fluxes('VGLDH') + fluxes('VAlaTA') - mu*x(ind('AKG'));
	dxdt(ind('SUC')) = fluxes('VAKGDH') - fluxes('VSDH') - mu*x(ind('SUC'));
	dxdt(ind('MAL')) = fluxes('VSDH') - fluxes('VMLD') - fluxes('VME') - mu*x(ind('MAL'));
	dxdt(ind('OXA')) = -fluxes('VCS') + fluxes('VACL') + fluxes('VMLD') + fluxes('VPC') - mu*x(ind('OXA'));
	dxdt(ind('LAC')) = fluxes('VLDH') - mu*x(ind('LAC'));
	dxdt(ind('PALM')) = fluxes('VPALM') - param('dP')*mu - mu*x(ind('PALM'));
	dxdt(ind('GLU')) = fluxes('VGLS') - fluxes('VGLDH') - fluxes('VAlaTA') - fluxes('VGluT') - mu*x(ind('GLU'));
	
	dxdt(ind('ATP')) = -fluxes('VHK') - fluxes('VPFK') + fluxes('VPGK') + fluxes('VPK') - fluxes('VACL') + fluxes('VAKGDH') - fluxes('VPC')  - fluxes('VATPase') + 4.2*fluxes('Vresp') - fluxes('VAK') - 7*fluxes('VPALM') - param('dA')*mu;
	dxdt(ind('ADP')) = fluxes('VHK') + fluxes('VPFK') - fluxes('VPGK') - fluxes('VPK') + fluxes('VACL') - fluxes('VAKGDH') + fluxes('VPC') + fluxes('VATPase') - 4.2*fluxes('Vresp') + 2*fluxes('VAK') + 7*fluxes('VPALM') + param('dA')*mu;
	dxdt(ind('AMP')) = -fluxes('VAK');
	
	dxdt(ind('NAD')) = -fluxes('VPGK') + fluxes('VLDH') - fluxes('VPDH') - fluxes('VCITS') - fluxes('VAKGDH') - 0.66*fluxes('VSDH') - fluxes('VMLD') - fluxes('VGLDH') + 2*fluxes('Vresp') + 2*fluxes('Vleak');
	dxdt(ind('NADH')) = fluxes('VPGK') - fluxes('VLDH') + fluxes('VPDH') + fluxes('VCITS') + fluxes('VAKGDH') + 0.66*fluxes('VSDH') + fluxes('VMLD') + fluxes('VGLDH') - 2*fluxes('Vresp') - 2*fluxes('Vleak');
	
	dxdt(ind('NADP')) = -2*fluxes('VG6PDH') - fluxes('VME') + fluxes('VNADPHox') + 14*fluxes('VPALM');
	dxdt(ind('NADPH')) = 2*fluxes('VG6PDH') + fluxes('VME') - fluxes('VNADPHox') - 14*fluxes('VPALM');
	
	dxdt(ind('X')) = mu * x(ind('X'));

	dxdt(ind('NH4')) = fluxes('VGLS') + fluxes('VGLDH') - mu*x(ind('NH4'));
	dxdt(ind('ALA')) = fluxes('VAlaTA') - mu*x(ind('ALA'));
	dxdt(ind('EGLU')) = fluxes('VGluT') - mu*x(ind('EGLU'));
	dxdt = dxdt';

end
