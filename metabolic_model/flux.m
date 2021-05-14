%This file is writen by hand and not automatically
function fluxes = flux(t,x,param,order)

	fluxes = containers.Map;

	%Get the index
	ind = getIndex(order);
	
	%Compute the fluxes
	fluxes('VHK') = param('vmax_VHK') * activation(param('Conc_EGLC'),x(ind('AMP'))/x(ind('ATP')), param('km_VHK_EGLC'), param('ka_VHK_AMP_ATP'), param('alpha_VHK_AMP_ATP'), param('beta_VHK_AMP_ATP')) * mm(x(ind('ATP'))/x(ind('ADP')), param('km_VHK_ATP_ADP')) * inhibition(x(ind('G6P')), param('ki_VHK_G6P'));
	fluxes('VPGIdir') = param('vmax_VPGI') * mm(x(ind('G6P')), param('km_VPGI_G6P')) * inhibition(x(ind('PEP')), param('ki_VPGI_PEP'));
	fluxes('VPGIrev') = param('vmaxr_VPGI') * mm(x(ind('F6P')), param('km_VPGI_F6P'));
	fluxes('VPGI') = fluxes('VPGIdir') - fluxes('VPGIrev');
	fluxes('VPFK') = param('vmax_VPFK') * activation(x(ind('F6P')),x(ind('AMP'))/x(ind('ATP')), param('km_VPFK_F6P'), param('ka_VPFK_AMP_ATP'), param('alpha_VPFK_AMP_ATP'), param('beta_VPFK_AMP_ATP')) * mm(x(ind('ATP'))/x(ind('ADP')), param('km_VPFK_ATP_ADP')) * inhibition(x(ind('CIT')), param('ki_VPFK_CIT'));
	fluxes('VPGK') = param('vmax_VPGK') * mm(x(ind('GAP')), param('km_VPGK_GAP')) * mm(x(ind('ADP'))/x(ind('ATP')), param('km_VPGK_ADP_ATP')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VPGK_NAD_NADH'));
	fluxes('VPK') = param('vmax_VPK') * activation(x(ind('PEP')),x(ind('F6P')), param('km_VPK_PEP'), param('ka_VPK_F6P'), param('alpha_VPK_F6P'), param('beta_VPK_F6P')) * mm(x(ind('ADP'))/x(ind('ATP')), param('km_VPK_ADP_ATP'));
	fluxes('VLDH') = param('vmax_VLDH') * activation(x(ind('PYR')),x(ind('AMP'))/x(ind('ATP')), param('km_VLDH_PYR'), param('ka_VLDH_AMP_ATP'), param('alpha_VLDH_AMP_ATP'), param('beta_VLDH_AMP_ATP')) * mm(x(ind('NADH'))/x(ind('NAD')), param('km_VLDH_NADH_NAD'));
	fluxes('VG6PDH') = param('vmax_VG6PDH') * mm(x(ind('G6P')), param('km_VG6PDH_G6P')) * mm(x(ind('NADP'))/x(ind('NADPH')), param('km_VG6PDH_NADP_NADPH'));
	fluxes('VEP') = param('vmax_VEP') * mm(x(ind('R5P')), param('km_VEP_R5P'));
	fluxes('VTK') = param('vmax_VTK') * mm(x(ind('R5P')), param('km_VTK_R5P')) * mm(x(ind('X5P')), param('km_VTK_X5P'));
	fluxes('VPDH') = param('vmax_VPDH') * mm(x(ind('PYR')), param('km_VPDH_PYR')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VPDH_NAD_NADH'));
	fluxes('VCS') = param('vmax_VCS') * mm(x(ind('ACCOA')), param('km_VCS_ACCOA')) * mm(x(ind('OXA')), param('km_VCS_OXA'));
	fluxes('VCITS') = param('vmax_VCITS') * mm(x(ind('CIT')), param('km_VCITS_CIT')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VCITS_NAD_NADH'));
	fluxes('VACL') = param('vmax_VACL') * mm(x(ind('CIT')), param('km_VACL_CIT')) * mm(x(ind('ATP'))/x(ind('ADP')), param('km_VACL_ATP_ADP'));
	fluxes('VAKGDH') = param('vmax_VAKGDH') * mm(x(ind('AKG')), param('km_VAKGDH_AKG')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VAKGDH_NAD_NADH')) * mm(x(ind('ADP'))/x(ind('ATP')), param('km_VAKGDH_ADP_ATP'));
	fluxes('VSDH') = param('vmax_VSDH') * mm(x(ind('SUC')), param('km_VSDH_SUC')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VSDH_NAD_NADH'));
	fluxes('VMLD') = param('vmax_VMLD') * mm(x(ind('MAL')), param('km_VMLD_MAL')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VMLD_NAD_NADH'));
	fluxes('VPC') = param('vmax_VPC') * mm(x(ind('PYR')), param('km_VPC_PYR')) * mm(x(ind('ATP'))/x(ind('ADP')), param('km_VPC_ATP_ADP'));
	fluxes('VME') = param('vmax_VME') * mm(x(ind('MAL')), param('km_VME_MAL')) * mm(x(ind('NADP'))/x(ind('NADPH')), param('km_VME_NADP_NADPH'));
	fluxes('VGLS') = param('vmax_VGLS') * mm(param('Conc_EGLN'), param('km_VGLS_EGLN'));
	fluxes('VGLDH') = param('vmax_VGLDH') * mm(x(ind('GLU')), param('km_VGLDH_GLU')) * mm(x(ind('NAD'))/x(ind('NADH')), param('km_VGLDH_NAD_NADH'));
	fluxes('VAlaTA') = param('vmax_VAlaTA') * mm(x(ind('GLU')), param('km_VAlaTA_GLU')) * mm(x(ind('PYR')), param('km_VAlaTA_PYR'));
	fluxes('VGluT') = param('vmax_VGluT') * mm(x(ind('GLU')), param('km_VGluT_GLU'));
	fluxes('VATPase') = param('vmax_VATPase') * mm(x(ind('ATP')), param('km_VATPase_ATP'));
	fluxes('VNADPHox') = param('vmax_VNADPHox') * mm(x(ind('NADPH')), param('km_VNADPHox_NADPH'));
	fluxes('Vresp') = param('vmax_Vresp') * mm(x(ind('NADH'))/x(ind('NAD')), param('km_Vresp_NADH_NAD')) * mm(x(ind('ADP'))/x(ind('ATP')), param('km_Vresp_ADP_ATP')) * mm(param('Conc_O2'), param('km_Vresp_O2'));
	fluxes('Vleak') = param('vmax_Vleak') * mm(x(ind('NADH')), param('km_Vleak_NADH'));
	fluxes('VAKdir') = param('vmax_VAK') * mm(x(ind('ATP')), param('km_VAK_ATP')) * mm(x(ind('AMP')), param('km_VAK_AMP'));
	fluxes('VAKrev') = param('vmaxr_VAK') * mm(x(ind('ADP')), param('km_VAK_ADP'));
	fluxes('VAK') = fluxes('VAKdir') - fluxes('VAKrev');
	fluxes('VPALM') = param('vmax_VPALM') * mm(x(ind('ACCOA')), param('km_VPALM_ACCOA')) * mm(x(ind('ATP'))/x(ind('ADP')), param('km_VPALM_ATP_ADP')) * mm(x(ind('NADPH'))/x(ind('NADP')), param('km_VPALM_NADPH_NADP'));
	fluxes('mu') = param('mumax') * mm(x(ind('ATP')), param('km_Vgrowth_ATP')) * mm(x(ind('G6P')), param('km_Vgrowth_G6P')) * mm(x(ind('R5P')), param('km_Vgrowth_R5P')) * mm(x(ind('PALM')), param('km_Vgrowth_PALM'));

end
