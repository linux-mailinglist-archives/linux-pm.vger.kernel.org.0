Return-Path: <linux-pm+bounces-13928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339F972DB5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7CA2871BE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A88188CD2;
	Tue, 10 Sep 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+c0JXYu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330D18595E;
	Tue, 10 Sep 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960780; cv=none; b=j++g5W39K/4rFcOo+2vfb6OGN8Hs2IhyKpVFuK+ssipIZjMDkpITi5PDc7SCdcnF4MDtKlD1G0QEHe0SsT1VQNfHp1/maqYaM9zwmdSLmq9Q6EtLBGD4c/SafWOv1wLEjmT5EtStXXV+GlultpTEo/wRYw+Jma98qzERSvxeTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960780; c=relaxed/simple;
	bh=I3/4yorClfjkVCr8bmjnPr9cVL52OsbEuW9h0Dutdnc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j+ZJs9rtp57ZbOVeH23h1VaLdHzkdkHdifRAgvpHzocd5GoC61GpAZvTy55JZLTdhnBRkdtPXPMkSI6DrvCn1kMlATTBnQq07bW4aF4lK6cSzFfdPFswgDSL4TSqQ23wz2C4z5KetGS/LTRXw1iLQ0Mo9AKalKddqtEXwwmLH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+c0JXYu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725960778; x=1757496778;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I3/4yorClfjkVCr8bmjnPr9cVL52OsbEuW9h0Dutdnc=;
  b=C+c0JXYuVgdRkfNLEHJpaTUd0U7paqpeCz/J44o7tyHyS5QhHEDIQQfV
   Jx3aJatBhMFFDEiXppZeyoxtiBmKap10uOHb0reI40XEHDUtM7HVn4rAX
   ViUKU5/BzW45QvUbX654e9yby6nU1I1x3jaZ9gZOeMQ9NkUHMasin8c8A
   BWA0gqgjCtEy/08QgQOvzmxDwCq3nJT37vk7wJJOMxcHG7n0I19CuhltG
   PJtwvPgRdAzFwrApLvz0N6SsZ5NearAF1L1BvWgEjl9paSLZZCa35yx6x
   EijMq5eJDtEwXs2z/ao2Aw+XL32pI4kiKgadiZoWdz0ZAnmWi/VK11emV
   Q==;
X-CSE-ConnectionGUID: 7QMBpcRtRkyQniO2kdh64Q==
X-CSE-MsgGUID: XWQmg/RGSiCnLRZExymtRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24801251"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24801251"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:32:58 -0700
X-CSE-ConnectionGUID: Ww0eZmwNSZKsGLVOctnFHg==
X-CSE-MsgGUID: xkGeG7LgTYid0Ypj5U5b6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71566297"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:32:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Sep 2024 12:32:50 +0300 (EEST)
To: Rajvi Jingar <rajvi.jingar@linux.intel.com>
cc: xi.pardee@linux.intel.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmc: Add Arrow Lake U/H support to
 intel_pmc_core driver
In-Reply-To: <20240909232842.2896965-1-rajvi.jingar@linux.intel.com>
Message-ID: <4481a9c5-05b1-fef8-a011-4bbdad19c35b@linux.intel.com>
References: <20240909232842.2896965-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Sep 2024, Rajvi Jingar wrote:

> Add Arrow Lake U and Arro Lake H support in intel_pmc_core driver

Arrow

Add . to the end of sentence.

> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  | 65 ++++++++++++++++++++++-----
>  drivers/platform/x86/intel/pmc/core.c |  2 +
>  drivers/platform/x86/intel/pmc/core.h |  7 +++
>  3 files changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index e10527c4e3e0..964f5f040dd9 100644
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
> +#define ARL_H_GNA_PCI_DEV 		0x774c
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
> @@ -692,16 +706,47 @@ static int arl_resume(struct pmc_dev *pmcdev)
>  	return pmc_core_resume_common(pmcdev);
>  }
>  
> +static int arl_h_resume(struct pmc_dev *pmcdev)
> +{
> +	arl_h_d3_fixup();
> +	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> +
> +	return pmc_core_resume_common(pmcdev);
> +}
> +
> +int arl_h_core_init(struct pmc_dev *pmcdev)
> +{
> +	arl_h_d3_fixup();
> +
> +	return arl_core_generic_init(pmcdev, SOC_M);
> +}
> +
>  int arl_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
> +	arl_d3_fixup();
> +
> +	return arl_core_generic_init(pmcdev, SOC_S);
> +}
> +
> +int arl_core_generic_init(struct pmc_dev *pmcdev, int soc_tp)

This function has no callers outside or arl.c and should be made static 
and the code should be reordered such that no prototype is needed.

> +{
>  	int ret;
> -	int func = 0;
> +	int func;
>  	bool ssram_init = true;
> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>  
> -	arl_d3_fixup();
>  	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = arl_resume;
> +
> +	if (soc_tp == SOC_M) {
> +		func = 2;
> +		pmcdev->resume = arl_h_resume;
> +	} else if (soc_tp == SOC_S) {
> +		func = 0;
> +		pmcdev->resume = arl_resume;

It would be preferrable to make an info structure to describe this kind 
of platform variations so that if () forests like this are avoided.

> +	} else {
> +		return -EINVAL;
> +	}
> +
>  	pmcdev->regmap_list = arl_pmc_info_list;
>  
>  	/*
> @@ -711,7 +756,10 @@ int arl_core_init(struct pmc_dev *pmcdev)
>  	ret = pmc_core_ssram_init(pmcdev, func);
>  	if (ret) {
>  		ssram_init = false;
> -		pmc->map = &arl_socs_reg_map;
> +		if (soc_tp == SOC_M)
> +			pmc->map = &mtl_socm_reg_map;
> +		else
> +			pmc->map = &arl_socs_reg_map;

As with above, use an info struct.

-- 
 i.

>  
>  		ret = get_primary_reg_base(pmc);
>  		if (ret)
> @@ -721,11 +769,8 @@ int arl_core_init(struct pmc_dev *pmcdev)
>  	pmc_core_get_low_power_modes(pmcdev);
>  	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
>  
> -	if (ssram_init)	{
> -		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
> -		if (ret)
> -			return ret;
> -	}
> +	if (ssram_init)
> +		return pmc_core_ssram_get_lpm_reqs(pmcdev);
>  
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 01ae71c6df59..046791f21619 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1319,6 +1319,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
>  	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
>  	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	arl_h_core_init),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	arl_h_core_init),
>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
>  	{}
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ea04de7eb9e8..5771f40185c2 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -365,6 +365,11 @@ struct pmc_info {
>  	const struct pmc_reg_map *map;
>  };
>  
> +enum soc_type {
> +	SOC_M,
> +	SOC_S
> +};
> +
>  /**
>   * struct pmc - pmc private info structure
>   * @base_addr:		contains pmc base address
> @@ -599,6 +604,8 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
>  int adl_core_init(struct pmc_dev *pmcdev);
>  int mtl_core_init(struct pmc_dev *pmcdev);
>  int arl_core_init(struct pmc_dev *pmcdev);
> +int arl_h_core_init(struct pmc_dev *pmcdev);
> +int arl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
>  int lnl_core_init(struct pmc_dev *pmcdev);
>  
>  void cnl_suspend(struct pmc_dev *pmcdev);
> 

