Return-Path: <linux-pm+bounces-21540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035ACA2C5B3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861AE166A10
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7823ED74;
	Fri,  7 Feb 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZDiHM6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515742206A0;
	Fri,  7 Feb 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939164; cv=none; b=mSQErec7TXgus0iC7lvPdID4Q6+ZrSbBGJw84EqxcdaaKOQQv5TDfGQnRhHmzfeXDixMcSukZRwOsl5Iyx14/EVEbfd0X9k6xHB6RXKgWne18BBjBfd0xnx87TJjWdxPDt1hVs/9QHQsSRU93kHBMI+78gBYaGmCDXEbEYbPwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939164; c=relaxed/simple;
	bh=WX2weuHovWSP5rerh3+sJhzBIsvChXP6sCz8+E0z/D8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qsVsn4H0OmIusqa0EGmE/U497rajI26p9C/IOGyQQgx9cNTSh6XgVAc/eNN443z3itsn+pXevZsl5MZ3ccINDd4CnvjONqhNmsNmcRhwgmA9NtouWpm0pbXLTHjegZX9Fnc9N7VZt8C+ki+RIonVWBZKw1nTAiOs1Wl47b4dtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZDiHM6K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738939162; x=1770475162;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WX2weuHovWSP5rerh3+sJhzBIsvChXP6sCz8+E0z/D8=;
  b=GZDiHM6K1wInYU/9m/xbcxk+02jvYlHBEyju9oQ8nsbvFg/XAshN7yVB
   W06JJ43Yws+jqbA1vkkObxNyOSi6zayre9RUkoT4uxiLXVDvZOxDR5Bj1
   H4JBlQxW5kkulbUcjCGuD8/NeaZ7hDiNga0jaP/G7kbHr7cf2mARqy+Z9
   /X8XmVGr2ciA1JGIkyOTcc4eUq65ClTuEO1ZkijamPWZ93gYpLWaFlLkP
   JpyFopzzdmUqpJ4G6+kX0UQ4X1ytWpYyo85HuMSkn45sRQYhtTKY/yNC6
   mkWzuprhNDHGLeBGyO1nC/xuTFe81+u/ItrDZCl98Si2nXHwYvgtIkC6V
   w==;
X-CSE-ConnectionGUID: vMa0zDw7RrqSp/tJPQB1RQ==
X-CSE-MsgGUID: 86Xb5EYeRJe5XEkgYJ2APA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50200995"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50200995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:39:22 -0800
X-CSE-ConnectionGUID: lPNAxEStQIyGEJ3GrS7vBA==
X-CSE-MsgGUID: RLyj55TBR6y4JLkdfOWPuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="112052091"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:39:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Feb 2025 16:39:15 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 5/5] platform/x86/intel/pmc: Add Arrow Lake U/H support
 to intel_pmc_core driver
In-Reply-To: <20250205001601.689782-6-xi.pardee@linux.intel.com>
Message-ID: <49869a94-ef6d-7f77-298e-493c25ae0679@linux.intel.com>
References: <20250205001601.689782-1-xi.pardee@linux.intel.com> <20250205001601.689782-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Xi Pardee wrote:

> Add Arrow Lake U and Arrow Lake H support in intel_pmc_core driver.
> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  | 37 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.c |  2 ++
>  drivers/platform/x86/intel/pmc/core.h |  2 ++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 2e604f934f068..f62763865207b 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -16,6 +16,7 @@
>  #define IOEP_LPM_REQ_GUID	0x5077612
>  #define SOCS_LPM_REQ_GUID	0x8478657
>  #define PCHS_LPM_REQ_GUID	0x9684572
> +#define SOCM_LPM_REQ_GUID	0x2625030
>  
>  static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
>  
> @@ -650,6 +651,7 @@ const struct pmc_reg_map arl_pchs_reg_map = {
>  	.etr3_offset = ETR3_OFFSET,
>  };
>  
> +#define PMC_DEVID_SOCM 0x777f
>  #define PMC_DEVID_SOCS 0xae7f
>  #define PMC_DEVID_IOEP 0x7ecf
>  #define PMC_DEVID_PCHS 0x7f27
> @@ -669,11 +671,17 @@ static struct pmc_info arl_pmc_info_list[] = {
>  		.devid	= PMC_DEVID_PCHS,
>  		.map	= &arl_pchs_reg_map,
>  	},
> +	{
> +		.guid	= SOCM_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_SOCM,
> +		.map	= &mtl_socm_reg_map,
> +	},
>  	{}
>  };
>  
>  #define ARL_NPU_PCI_DEV			0xad1d
>  #define ARL_GNA_PCI_DEV			0xae4c
> +#define ARL_H_GNA_PCI_DEV		0x774c
>  /*
>   * Set power state of select devices that do not have drivers to D3
>   * so that they do not block Package C entry.
> @@ -684,6 +692,12 @@ static void arl_d3_fixup(void)
>  	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
>  }
>  
> +static void arl_h_d3_fixup(void)
> +{
> +	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
> +	pmc_core_set_device_d3(ARL_H_GNA_PCI_DEV);
> +}
> +
>  static int arl_resume(struct pmc_dev *pmcdev)
>  {
>  	arl_d3_fixup();
> @@ -691,6 +705,13 @@ static int arl_resume(struct pmc_dev *pmcdev)
>  	return cnl_resume(pmcdev);
>  }
>  
> +static int arl_h_resume(struct pmc_dev *pmcdev)
> +{
> +	arl_h_d3_fixup();
> +
> +	return cnl_resume(pmcdev);
> +}
> +
>  struct pmc_dev_info arl_pmc_dev = {
>  	.pci_func = 0,
>  	.dmu_guid = ARL_PMT_DMU_GUID,
> @@ -701,8 +722,24 @@ struct pmc_dev_info arl_pmc_dev = {
>  	.init = arl_core_init,
>  };
>  
> +struct pmc_dev_info arl_h_pmc_dev = {
> +	.pci_func = 2,
> +	.dmu_guid = ARL_PMT_DMU_GUID,
> +	.regmap_list = arl_pmc_info_list,
> +	.map = &mtl_socm_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = arl_h_resume,
> +	.init = arl_h_core_init,
> +};

This struct should come after the init function so you don't need to 
forward declare the init function and can make the init function a static 
one (as with the other cases in patch 4).

> +
>  int arl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>  {
>  	arl_d3_fixup();
>  	return generic_core_init(pmcdev, pmc_dev_info);
>  }
> +
> +int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> +{
> +	arl_h_d3_fixup();
> +	return generic_core_init(pmcdev, pmc_dev_info);
> +}
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 628cb22221fbc..d819478fea29a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1410,6 +1410,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_pmc_dev),
>  	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_pmc_dev),
>  	X86_MATCH_VFM(INTEL_ARROWLAKE,		&arl_pmc_dev),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&arl_h_pmc_dev),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&arl_h_pmc_dev),
>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_pmc_dev),
>  	{}
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 94039930422b3..0f0ee97ee00a8 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -624,9 +624,11 @@ extern struct pmc_dev_info tgl_pmc_dev;
>  extern struct pmc_dev_info adl_pmc_dev;
>  extern struct pmc_dev_info mtl_pmc_dev;
>  extern struct pmc_dev_info arl_pmc_dev;
> +extern struct pmc_dev_info arl_h_pmc_dev;
>  extern struct pmc_dev_info lnl_pmc_dev;
>  
>  int arl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
> +int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);

Not needed.

>  int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>  int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>  int tgl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
> 

-- 
 i.


