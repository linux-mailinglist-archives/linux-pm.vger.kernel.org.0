Return-Path: <linux-pm+bounces-19578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645F9F91B7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 12:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8321896461
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9281C4A34;
	Fri, 20 Dec 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrTiTe0g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314A1C3039;
	Fri, 20 Dec 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695584; cv=none; b=rxDvAkq0F7yxsX0/yBYXpbMAKKp1dJauKfF51IWgnLevlre8R710Yllm18c0X7mFuAbY17nx0f+EzAcTvamzdTMeK7iS127fUV9rRYQKWg0jTZIK6Qvb1keALrcB02XM7H4lym/4qaYQsDpyTKROBEKOMm/P3W6nDMe0oUxQvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695584; c=relaxed/simple;
	bh=XvzABePPikVvfX7pE9KmLzEeL8EC4fMD4a8JD8rVtH8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gj+VUqpSx/740oNl0wkdSjKjgFvxzMpliHP1DsFZLqyjoRrThl3DcyysxYp10fsVJ1xM9uuyYu6fREdErSpgzo60bWUqexNhhyTNbifLmFrgRFaIubY32CWI03fqrfKPgHuo4kvvSNmUqe7j37kIsutw4yZtKwYHlNNx0IhAeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrTiTe0g; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734695582; x=1766231582;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XvzABePPikVvfX7pE9KmLzEeL8EC4fMD4a8JD8rVtH8=;
  b=LrTiTe0gpw2IKCXDZyj1WIQqrAwA5k92gnqBGEGpG2bursaSjfEZHwNA
   vsP0B8bTB3OhGsSerl0kpM6WhQpyla7opISUnoLc8FF2nzMf0COTIh8Fx
   uOv7jxEmS82AKdBIkJ6mJEby576pVOYXgX1jxYsaVPj8XpTXcXdUupiBc
   vAUdmQ1v4Uoa+uN0DuSbFekYB0EAPb5DVZExGjLmrDbOfFiPYICELT0LJ
   s6G2PpjHrnU/TR9iVrNamJz4+6gmubQCzpoF4ywEkFz5MnzhinUlPOpzc
   ozTrjKpZzSq1+jggIcHw4ry4DRe8RE25lcbgLODKFouKdYuReFevQfTvX
   g==;
X-CSE-ConnectionGUID: nLxlXn6+QRqj25lWPuMPMQ==
X-CSE-MsgGUID: lkWBoluuS7iDT1yW5dr0PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="57714701"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="57714701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 03:53:02 -0800
X-CSE-ConnectionGUID: 3hKWJvp0Q3aoGTqcXhk5sw==
X-CSE-MsgGUID: rI44pdAAS3+s/kNjcUfIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98966589"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 03:52:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Dec 2024 13:52:55 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] platform/x86:intel/pmc: Create generic_core_init()
 for all platforms
In-Reply-To: <20241219235543.236592-3-xi.pardee@linux.intel.com>
Message-ID: <5f694390-079a-13e6-5c93-38b938125044@linux.intel.com>
References: <20241219235543.236592-1-xi.pardee@linux.intel.com> <20241219235543.236592-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Dec 2024, Xi Pardee wrote:

> Create a generic_core_init() function for all architecture to reduce
> duplicate code in each architecture file. Create an info structure
> to catch the variations between each architecture and pass it to the
> generic init function.
> 
> Convert all architectures to call the generic core init function.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>

This looks much better!

> ---
>  drivers/platform/x86/intel/pmc/adl.c  | 21 ++++--------
>  drivers/platform/x86/intel/pmc/arl.c  | 47 ++++++++-------------------
>  drivers/platform/x86/intel/pmc/cnp.c  | 21 ++++--------
>  drivers/platform/x86/intel/pmc/core.c | 45 +++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h | 25 ++++++++++++++
>  drivers/platform/x86/intel/pmc/icl.c  | 18 ++++------
>  drivers/platform/x86/intel/pmc/lnl.c  | 24 +++++---------
>  drivers/platform/x86/intel/pmc/mtl.c  | 45 +++++++------------------
>  drivers/platform/x86/intel/pmc/spt.c  | 18 ++++------
>  drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++---------
>  10 files changed, 145 insertions(+), 150 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
> index e7878558fd909..ac37f4ece9c70 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -311,20 +311,13 @@ const struct pmc_reg_map adl_reg_map = {
>  	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
>  };
>  
> +static struct pmc_dev_info adl_pmc_dev = {
> +	.map = &adl_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
> +
>  int adl_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	int ret;
> -
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = cnl_resume;
> -
> -	pmc->map = &adl_reg_map;
> -	ret = get_primary_reg_base(pmc);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -
> -	return 0;
> +	return generic_core_init(pmcdev, &adl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 05dec4f5019f3..137a1fdfee715 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -691,40 +691,19 @@ static int arl_resume(struct pmc_dev *pmcdev)
>  	return cnl_resume(pmcdev);
>  }
>  
> +static struct pmc_dev_info arl_pmc_dev = {
> +	.func = 0,
> +	.ssram = true,
> +	.dmu_guid = ARL_PMT_DMU_GUID,
> +	.regmap_list = arl_pmc_info_list,
> +	.map = &arl_socs_reg_map,
> +	.fixup = arl_d3_fixup,

I think the fixups should be left to be called from the per architecture 
init funcs.

> +	.suspend = cnl_suspend,
> +	.resume = arl_resume,
> +};
> +
>  int arl_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
> -	int ret;
> -	int func = 0;
> -	bool ssram_init = true;
> -
> -	arl_d3_fixup();
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = arl_resume;
> -	pmcdev->regmap_list = arl_pmc_info_list;
> -
> -	/*
> -	 * If ssram init fails use legacy method to at least get the
> -	 * primary PMC
> -	 */
> -	ret = pmc_core_ssram_init(pmcdev, func);
> -	if (ret) {
> -		ssram_init = false;
> -		pmc->map = &arl_socs_reg_map;
> -
> -		ret = get_primary_reg_base(pmc);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
> -
> -	if (ssram_init)	{
> -		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +	return generic_core_init(pmcdev, &arl_pmc_dev);
>  }
> +
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index fc5193fdf8a88..6d268058e40b9 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -274,20 +274,13 @@ int cnl_resume(struct pmc_dev *pmcdev)
>  	return pmc_core_resume_common(pmcdev);
>  }
>  
> +static struct pmc_dev_info cnp_pmc_dev = {
> +	.map = &cnp_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
> +
>  int cnp_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	int ret;
> -
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = cnl_resume;
> -
> -	pmc->map = &cnp_reg_map;
> -	ret = get_primary_reg_base(pmc);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -
> -	return 0;
> +	return generic_core_init(pmcdev, &cnp_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 3e7f99ac8c941..8b73101dcfe95 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1344,6 +1344,51 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>  	}
>  }
>  
> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> +{
> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> +	void (*fixup)(void) = pmc_dev_info->fixup;
> +	bool ssram;
> +	int ret;
> +
> +	if (fixup)
> +		fixup();
> +
> +	pmcdev->suspend = pmc_dev_info->suspend;
> +	pmcdev->resume = pmc_dev_info->resume;
> +
> +	/*
> +	 * If ssram init fails use legacy method to at least get the
> +	 * primary PMC
> +	 */

This comment feels misplaced. I think you could simply make it a function 
comment instead as it describes the general level behavior within the 
function.

> +	ssram = pmc_dev_info->ssram;
> +	if (ssram) {
> +		pmcdev->regmap_list = pmc_dev_info->regmap_list;

I wonder why the pmc_dev_info->ssram is necessary, doesn't ->regmap_list 
!= NULL tell the same information already? You might also want to mention 
it in the struct pmc_dev_info documentation that it implies SSRAM.

So you could do:

	ssram = pmc_dev_info->ssram != NULL;
	if (ssram) {
		...

> +		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->func);
> +		if (ret) {
> +			dev_warn(&pmcdev->pdev->dev,
> +				 "ssram init failed, %d, using legacy init\n", ret);
> +			ssram = false;
> +		}
> +	}
> +
> +	if (!ssram) {
> +		pmc->map = pmc_dev_info->map;
> +		ret = get_primary_reg_base(pmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pmc_core_get_low_power_modes(pmcdev);
> +	if (pmc_dev_info->dmu_guid)
> +		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
> +
> +	if (ssram)
> +		return pmc_core_ssram_get_lpm_reqs(pmcdev);
> +
> +	return 0;
> +}
> +
>  static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
>  	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index a1886d8e1ef3e..82be953db9463 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -436,6 +436,30 @@ enum pmc_index {
>  	PMC_IDX_MAX
>  };
>  
> +/**
> + * struct pmc_dev_info - Structure to keep pmc device info
> + * @func:		Function number of the primary pmc

Capitalize "PMC" in the comments.

> + * @ssram:		Bool shows if platform has ssram support
> + * @dmu_guid:		DMU GUID
> + * @regmap_list:	Pointer to a list of pmc_info structure that could be
> + *			available for the platform
> + * @map:		Pointer to a pmc_reg_map struct that contains platform
> + *			specific attributes of the primary pmc
> + * @fixup:		Function to perform platform specific fixup
> + * @suspend:		Function to perform platform specific suspend
> + * @resume:		Function to perform platform specific resume
> + */
> +struct pmc_dev_info {
> +	u8 func;
> +	bool ssram;
> +	u32 dmu_guid;
> +	struct pmc_info *regmap_list;
> +	const struct pmc_reg_map *map;
> +	void (*fixup)(void);
> +	void (*suspend)(struct pmc_dev *pmcdev);
> +	int (*resume)(struct pmc_dev *pmcdev);
> +};
> +
>  extern const struct pmc_bit_map msr_map[];
>  extern const struct pmc_bit_map spt_pll_map[];
>  extern const struct pmc_bit_map spt_mphy_map[];
> @@ -592,6 +616,7 @@ extern void pmc_core_set_device_d3(unsigned int device);
>  
>  extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
>  
> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>  int spt_core_init(struct pmc_dev *pmcdev);
>  int cnp_core_init(struct pmc_dev *pmcdev);
>  int icl_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
> index 71b0fd6cb7d84..f044546e1aa5e 100644
> --- a/drivers/platform/x86/intel/pmc/icl.c
> +++ b/drivers/platform/x86/intel/pmc/icl.c
> @@ -50,18 +50,12 @@ const struct pmc_reg_map icl_reg_map = {
>  	.etr3_offset = ETR3_OFFSET,
>  };
>  
> +static struct pmc_dev_info icl_pmc_dev = {
> +	.map = &icl_reg_map,
> +};
> +
>  int icl_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	int ret;
> -
> -	pmc->map = &icl_reg_map;
> -
> -	ret = get_primary_reg_base(pmc);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -
> -	return ret;
> +	return generic_core_init(pmcdev, &icl_pmc_dev);
>  }
> +
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index be029f12cdf40..8f6b2a8d30438 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -550,22 +550,14 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>  	return cnl_resume(pmcdev);
>  }
>  
> +static struct pmc_dev_info lnl_pmc_dev = {
> +	.map = &lnl_socm_reg_map,
> +	.fixup = lnl_d3_fixup,
> +	.suspend = cnl_suspend,
> +	.resume = lnl_resume,
> +};
> +
>  int lnl_core_init(struct pmc_dev *pmcdev)
>  {
> -	int ret;
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];

Hmm, so PMC_IDX_SOC and PMC_IDX_MAIN are set to same value which I 
haven't noticed before. I don't know why they were separate to begin with 
but I think you just removed all user of PMC_IDX_SOC so perhaps that it 
should be removed from enum as well?

> -
> -	lnl_d3_fixup();
> -
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = lnl_resume;
> -
> -	pmc->map = &lnl_socm_reg_map;
> -	ret = get_primary_reg_base(pmc);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -
> -	return 0;
> +	return generic_core_init(pmcdev, &lnl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 02949fed76e91..b7a752e8adbc6 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -990,39 +990,18 @@ static int mtl_resume(struct pmc_dev *pmcdev)
>  	return cnl_resume(pmcdev);
>  }
>  
> +static struct pmc_dev_info mtl_pmc_dev = {
> +	.func = 2,
> +	.ssram = true,
> +	.dmu_guid = MTL_PMT_DMU_GUID,
> +	.regmap_list = mtl_pmc_info_list,
> +	.map = &mtl_socm_reg_map,
> +	.fixup = mtl_d3_fixup,
> +	.suspend = cnl_suspend,
> +	.resume = mtl_resume,
> +};
> +
>  int mtl_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
> -	int ret;
> -	int func = 2;
> -	bool ssram_init = true;
> -
> -	mtl_d3_fixup();
> -
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = mtl_resume;
> -	pmcdev->regmap_list = mtl_pmc_info_list;
> -
> -	/*
> -	 * If ssram init fails use legacy method to at least get the
> -	 * primary PMC
> -	 */
> -	ret = pmc_core_ssram_init(pmcdev, func);
> -	if (ret) {
> -		ssram_init = false;
> -		dev_warn(&pmcdev->pdev->dev,
> -			 "ssram init failed, %d, using legacy init\n", ret);
> -		pmc->map = &mtl_socm_reg_map;
> -		ret = get_primary_reg_base(pmc);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
> -
> -	if (ssram_init)
> -		return pmc_core_ssram_get_lpm_reqs(pmcdev);
> -
> -	return 0;
> +	return generic_core_init(pmcdev, &mtl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index ab993a69e33ee..09d3ce09af736 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -134,18 +134,12 @@ const struct pmc_reg_map spt_reg_map = {
>  	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>  };
>  
> +static struct pmc_dev_info spt_pmc_dev = {
> +	.map = &spt_reg_map,
> +};
> +
>  int spt_core_init(struct pmc_dev *pmcdev)
>  {
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	int ret;
> -
> -	pmc->map = &spt_reg_map;
> -
> -	ret = get_primary_reg_base(pmc);
> -	if (ret)
> -		return ret;
> -
> -	pmc_core_get_low_power_modes(pmcdev);
> -
> -	return ret;
> +	return generic_core_init(pmcdev, &spt_pmc_dev);
>  }
> +
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index 4fec43d212d01..43a2aec4a5673 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -285,35 +285,36 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
>  	ACPI_FREE(out_obj);
>  }
>  
> -static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
> -{
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	int ret;
> +static struct pmc_dev_info tgl_l_pmc_dev = {
> +	.map = &tgl_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
>  
> -	if (pch_tp == PCH_H)
> -		pmc->map = &tgl_h_reg_map;
> -	else
> -		pmc->map = &tgl_reg_map;
> +static struct pmc_dev_info tgl_pmc_dev = {
> +	.map = &tgl_h_reg_map,
> +	.suspend = cnl_suspend,
> +	.resume = cnl_resume,
> +};
>  
> -	pmcdev->suspend = cnl_suspend;
> -	pmcdev->resume = cnl_resume;
> +static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> +{
> +	int ret;
>  
> -	ret = get_primary_reg_base(pmc);
> +	ret = generic_core_init(pmcdev, &tgl_l_pmc_dev);
>  	if (ret)
>  		return ret;
>  
> -	pmc_core_get_low_power_modes(pmcdev);
>  	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
> -
>  	return 0;
>  }
>  
>  int tgl_l_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, PCH_LP);
> +	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
>  }
>  
>  int tgl_core_init(struct pmc_dev *pmcdev)
>  {
> -	return tgl_core_generic_init(pmcdev, PCH_H);
> +	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
>  }
> 

It might be also worth to consider what is stored into those 
X86_MATCH_VFM()s so that the simple init functions could be removed 
entirely but it could be done in another patch on top of this one.

-- 
 i.


