Return-Path: <linux-pm+bounces-19589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA89F9ABB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 20:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FB07A1B88
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88257221466;
	Fri, 20 Dec 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HznplIQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659C2210D2;
	Fri, 20 Dec 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724556; cv=none; b=o57dkjlhkhDxjkoARNm72E5db9DXDIrl1q8WJn8slsBEe9+wyOwApD3oxqeUT51S8Z44SqfjggWd3BbbI64vN5GWfvLaPp7TNxhKr3NkLGgozlV2Bj3hHYREfu40ZORG4IZE2gc35KlCFRDzNZdD2IwShT998jOooge9CTOcz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724556; c=relaxed/simple;
	bh=NGjF7CBf3IskvZgoqedXKvL5Dt3xMGrw7T8hhviz9CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0Icji+0jP9SNAWV7IghNgdT4c5hnupxA7GbEn2qUUgw8q3UlasgqRB0zHQ0cfkR33xRYT7/Xx2X/hnapnJiq4A0HtztfkkE8HyGa2ndVb3fkyEuBNebtSuhWUOKxhuyVC5vVSOY/4OZRY7oFhjJZn/IPi5Uny1VOjdNoQsRatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HznplIQz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734724554; x=1766260554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGjF7CBf3IskvZgoqedXKvL5Dt3xMGrw7T8hhviz9CU=;
  b=HznplIQzqx2nh6B9KyW0xOLzWwMdIO9bJMi2Ruhl5cU1cOf/dSRBvaZ0
   iSUsUDsysoyZSVYihwhk4Q3IheDugAWyLwqHXa/8kpDM2y1XK7U9tGPT0
   oIKaIA8mJF0TFfieYoUu8S8Sp2GeoGN/83nulOnSoIZ6EeTWPz/aBdwr9
   VdSKYfMSIfdnKrntq2RQpfpB2H9jPVFmieN4/T1v+dhsYmkYpniI9QJ46
   Uy0Bs6e7PUFk+tWcway7bHFyM4yntiigIY1CiZtsCNuYLypRSUBo8X/Z5
   pG4Je7TTX2OJD0zgxvOAOkA5frw8GkfkgztF/qTgLfWw9oUa4hJ1lL1PN
   g==;
X-CSE-ConnectionGUID: 0dUb3rEGQvC/ktQRgGWPSQ==
X-CSE-MsgGUID: gGSzOFg6TM2zXc84tUlVSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="52688176"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="52688176"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:55:54 -0800
X-CSE-ConnectionGUID: PEjB/yHETKyBtuAhLdOx9w==
X-CSE-MsgGUID: 6bktVCmYTSagbmPSIr3LuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98807251"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.124.164.46]) ([10.124.164.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:55:53 -0800
Message-ID: <0810bc98-ea48-4d30-bfb1-bd009ee485de@linux.intel.com>
Date: Fri, 20 Dec 2024 11:55:39 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] platform/x86:intel/pmc: Create generic_core_init()
 for all platforms
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20241219235543.236592-1-xi.pardee@linux.intel.com>
 <20241219235543.236592-3-xi.pardee@linux.intel.com>
 <5f694390-079a-13e6-5c93-38b938125044@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <5f694390-079a-13e6-5c93-38b938125044@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks!

My comments are inline.

Xi

On 12/20/2024 3:52 AM, Ilpo Järvinen wrote:
> On Thu, 19 Dec 2024, Xi Pardee wrote:
>
>> Create a generic_core_init() function for all architecture to reduce
>> duplicate code in each architecture file. Create an info structure
>> to catch the variations between each architecture and pass it to the
>> generic init function.
>>
>> Convert all architectures to call the generic core init function.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> This looks much better!
>
>> ---
>>   drivers/platform/x86/intel/pmc/adl.c  | 21 ++++--------
>>   drivers/platform/x86/intel/pmc/arl.c  | 47 ++++++++-------------------
>>   drivers/platform/x86/intel/pmc/cnp.c  | 21 ++++--------
>>   drivers/platform/x86/intel/pmc/core.c | 45 +++++++++++++++++++++++++
>>   drivers/platform/x86/intel/pmc/core.h | 25 ++++++++++++++
>>   drivers/platform/x86/intel/pmc/icl.c  | 18 ++++------
>>   drivers/platform/x86/intel/pmc/lnl.c  | 24 +++++---------
>>   drivers/platform/x86/intel/pmc/mtl.c  | 45 +++++++------------------
>>   drivers/platform/x86/intel/pmc/spt.c  | 18 ++++------
>>   drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++---------
>>   10 files changed, 145 insertions(+), 150 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
>> index e7878558fd909..ac37f4ece9c70 100644
>> --- a/drivers/platform/x86/intel/pmc/adl.c
>> +++ b/drivers/platform/x86/intel/pmc/adl.c
>> @@ -311,20 +311,13 @@ const struct pmc_reg_map adl_reg_map = {
>>   	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
>>   };
>>   
>> +static struct pmc_dev_info adl_pmc_dev = {
>> +	.map = &adl_reg_map,
>> +	.suspend = cnl_suspend,
>> +	.resume = cnl_resume,
>> +};
>> +
>>   int adl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> -	int ret;
>> -
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = cnl_resume;
>> -
>> -	pmc->map = &adl_reg_map;
>> -	ret = get_primary_reg_base(pmc);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -
>> -	return 0;
>> +	return generic_core_init(pmcdev, &adl_pmc_dev);
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index 05dec4f5019f3..137a1fdfee715 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -691,40 +691,19 @@ static int arl_resume(struct pmc_dev *pmcdev)
>>   	return cnl_resume(pmcdev);
>>   }
>>   
>> +static struct pmc_dev_info arl_pmc_dev = {
>> +	.func = 0,
>> +	.ssram = true,
>> +	.dmu_guid = ARL_PMT_DMU_GUID,
>> +	.regmap_list = arl_pmc_info_list,
>> +	.map = &arl_socs_reg_map,
>> +	.fixup = arl_d3_fixup,
> I think the fixups should be left to be called from the per architecture
> init funcs.

Will rename the fixup field to platform_specifc (more explanation at the 
end).

>
>> +	.suspend = cnl_suspend,
>> +	.resume = arl_resume,
>> +};
>> +
>>   int arl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>> -	int ret;
>> -	int func = 0;
>> -	bool ssram_init = true;
>> -
>> -	arl_d3_fixup();
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = arl_resume;
>> -	pmcdev->regmap_list = arl_pmc_info_list;
>> -
>> -	/*
>> -	 * If ssram init fails use legacy method to at least get the
>> -	 * primary PMC
>> -	 */
>> -	ret = pmc_core_ssram_init(pmcdev, func);
>> -	if (ret) {
>> -		ssram_init = false;
>> -		pmc->map = &arl_socs_reg_map;
>> -
>> -		ret = get_primary_reg_base(pmc);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
>> -
>> -	if (ssram_init)	{
>> -		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	return 0;
>> +	return generic_core_init(pmcdev, &arl_pmc_dev);
>>   }
>> +
>> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
>> index fc5193fdf8a88..6d268058e40b9 100644
>> --- a/drivers/platform/x86/intel/pmc/cnp.c
>> +++ b/drivers/platform/x86/intel/pmc/cnp.c
>> @@ -274,20 +274,13 @@ int cnl_resume(struct pmc_dev *pmcdev)
>>   	return pmc_core_resume_common(pmcdev);
>>   }
>>   
>> +static struct pmc_dev_info cnp_pmc_dev = {
>> +	.map = &cnp_reg_map,
>> +	.suspend = cnl_suspend,
>> +	.resume = cnl_resume,
>> +};
>> +
>>   int cnp_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> -	int ret;
>> -
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = cnl_resume;
>> -
>> -	pmc->map = &cnp_reg_map;
>> -	ret = get_primary_reg_base(pmc);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -
>> -	return 0;
>> +	return generic_core_init(pmcdev, &cnp_pmc_dev);
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 3e7f99ac8c941..8b73101dcfe95 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1344,6 +1344,51 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>>   	}
>>   }
>>   
>> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>> +{
>> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> +	void (*fixup)(void) = pmc_dev_info->fixup;
>> +	bool ssram;
>> +	int ret;
>> +
>> +	if (fixup)
>> +		fixup();
>> +
>> +	pmcdev->suspend = pmc_dev_info->suspend;
>> +	pmcdev->resume = pmc_dev_info->resume;
>> +
>> +	/*
>> +	 * If ssram init fails use legacy method to at least get the
>> +	 * primary PMC
>> +	 */
> This comment feels misplaced. I think you could simply make it a function
> comment instead as it describes the general level behavior within the
> function.
Will move the comment to be a function comment for the 
generic_core_init() function.
>> +	ssram = pmc_dev_info->ssram;
>> +	if (ssram) {
>> +		pmcdev->regmap_list = pmc_dev_info->regmap_list;
> I wonder why the pmc_dev_info->ssram is necessary, doesn't ->regmap_list
> != NULL tell the same information already? You might also want to mention
> it in the struct pmc_dev_info documentation that it implies SSRAM.
>
> So you could do:
>
> 	ssram = pmc_dev_info->ssram != NULL;
> 	if (ssram) {
> 		...
Thanks! We don't need ssram field as regmap_list indicates that if ssram 
support is enabled
for each architecture. Will remove ssram in the next version.
>> +		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->func);
>> +		if (ret) {
>> +			dev_warn(&pmcdev->pdev->dev,
>> +				 "ssram init failed, %d, using legacy init\n", ret);
>> +			ssram = false;
>> +		}
>> +	}
>> +
>> +	if (!ssram) {
>> +		pmc->map = pmc_dev_info->map;
>> +		ret = get_primary_reg_base(pmc);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	pmc_core_get_low_power_modes(pmcdev);
>> +	if (pmc_dev_info->dmu_guid)
>> +		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
>> +
>> +	if (ssram)
>> +		return pmc_core_ssram_get_lpm_reqs(pmcdev);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>   	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
>>   	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index a1886d8e1ef3e..82be953db9463 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -436,6 +436,30 @@ enum pmc_index {
>>   	PMC_IDX_MAX
>>   };
>>   
>> +/**
>> + * struct pmc_dev_info - Structure to keep pmc device info
>> + * @func:		Function number of the primary pmc
> Capitalize "PMC" in the comments.
Will change it.
>
>> + * @ssram:		Bool shows if platform has ssram support
>> + * @dmu_guid:		DMU GUID
>> + * @regmap_list:	Pointer to a list of pmc_info structure that could be
>> + *			available for the platform
>> + * @map:		Pointer to a pmc_reg_map struct that contains platform
>> + *			specific attributes of the primary pmc
>> + * @fixup:		Function to perform platform specific fixup
>> + * @suspend:		Function to perform platform specific suspend
>> + * @resume:		Function to perform platform specific resume
>> + */
>> +struct pmc_dev_info {
>> +	u8 func;
>> +	bool ssram;
>> +	u32 dmu_guid;
>> +	struct pmc_info *regmap_list;
>> +	const struct pmc_reg_map *map;
>> +	void (*fixup)(void);
>> +	void (*suspend)(struct pmc_dev *pmcdev);
>> +	int (*resume)(struct pmc_dev *pmcdev);
>> +};
>> +
>>   extern const struct pmc_bit_map msr_map[];
>>   extern const struct pmc_bit_map spt_pll_map[];
>>   extern const struct pmc_bit_map spt_mphy_map[];
>> @@ -592,6 +616,7 @@ extern void pmc_core_set_device_d3(unsigned int device);
>>   
>>   extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
>>   
>> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
>>   int spt_core_init(struct pmc_dev *pmcdev);
>>   int cnp_core_init(struct pmc_dev *pmcdev);
>>   int icl_core_init(struct pmc_dev *pmcdev);
>> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
>> index 71b0fd6cb7d84..f044546e1aa5e 100644
>> --- a/drivers/platform/x86/intel/pmc/icl.c
>> +++ b/drivers/platform/x86/intel/pmc/icl.c
>> @@ -50,18 +50,12 @@ const struct pmc_reg_map icl_reg_map = {
>>   	.etr3_offset = ETR3_OFFSET,
>>   };
>>   
>> +static struct pmc_dev_info icl_pmc_dev = {
>> +	.map = &icl_reg_map,
>> +};
>> +
>>   int icl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> -	int ret;
>> -
>> -	pmc->map = &icl_reg_map;
>> -
>> -	ret = get_primary_reg_base(pmc);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -
>> -	return ret;
>> +	return generic_core_init(pmcdev, &icl_pmc_dev);
>>   }
>> +
>> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
>> index be029f12cdf40..8f6b2a8d30438 100644
>> --- a/drivers/platform/x86/intel/pmc/lnl.c
>> +++ b/drivers/platform/x86/intel/pmc/lnl.c
>> @@ -550,22 +550,14 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>>   	return cnl_resume(pmcdev);
>>   }
>>   
>> +static struct pmc_dev_info lnl_pmc_dev = {
>> +	.map = &lnl_socm_reg_map,
>> +	.fixup = lnl_d3_fixup,
>> +	.suspend = cnl_suspend,
>> +	.resume = lnl_resume,
>> +};
>> +
>>   int lnl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	int ret;
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
> Hmm, so PMC_IDX_SOC and PMC_IDX_MAIN are set to same value which I
> haven't noticed before. I don't know why they were separate to begin with
> but I think you just removed all user of PMC_IDX_SOC so perhaps that it
> should be removed from enum as well?
Will remove PMC_IDX_SOC from enum in next version.
>
>> -
>> -	lnl_d3_fixup();
>> -
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = lnl_resume;
>> -
>> -	pmc->map = &lnl_socm_reg_map;
>> -	ret = get_primary_reg_base(pmc);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -
>> -	return 0;
>> +	return generic_core_init(pmcdev, &lnl_pmc_dev);
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
>> index 02949fed76e91..b7a752e8adbc6 100644
>> --- a/drivers/platform/x86/intel/pmc/mtl.c
>> +++ b/drivers/platform/x86/intel/pmc/mtl.c
>> @@ -990,39 +990,18 @@ static int mtl_resume(struct pmc_dev *pmcdev)
>>   	return cnl_resume(pmcdev);
>>   }
>>   
>> +static struct pmc_dev_info mtl_pmc_dev = {
>> +	.func = 2,
>> +	.ssram = true,
>> +	.dmu_guid = MTL_PMT_DMU_GUID,
>> +	.regmap_list = mtl_pmc_info_list,
>> +	.map = &mtl_socm_reg_map,
>> +	.fixup = mtl_d3_fixup,
>> +	.suspend = cnl_suspend,
>> +	.resume = mtl_resume,
>> +};
>> +
>>   int mtl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>> -	int ret;
>> -	int func = 2;
>> -	bool ssram_init = true;
>> -
>> -	mtl_d3_fixup();
>> -
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = mtl_resume;
>> -	pmcdev->regmap_list = mtl_pmc_info_list;
>> -
>> -	/*
>> -	 * If ssram init fails use legacy method to at least get the
>> -	 * primary PMC
>> -	 */
>> -	ret = pmc_core_ssram_init(pmcdev, func);
>> -	if (ret) {
>> -		ssram_init = false;
>> -		dev_warn(&pmcdev->pdev->dev,
>> -			 "ssram init failed, %d, using legacy init\n", ret);
>> -		pmc->map = &mtl_socm_reg_map;
>> -		ret = get_primary_reg_base(pmc);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
>> -
>> -	if (ssram_init)
>> -		return pmc_core_ssram_get_lpm_reqs(pmcdev);
>> -
>> -	return 0;
>> +	return generic_core_init(pmcdev, &mtl_pmc_dev);
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
>> index ab993a69e33ee..09d3ce09af736 100644
>> --- a/drivers/platform/x86/intel/pmc/spt.c
>> +++ b/drivers/platform/x86/intel/pmc/spt.c
>> @@ -134,18 +134,12 @@ const struct pmc_reg_map spt_reg_map = {
>>   	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>>   };
>>   
>> +static struct pmc_dev_info spt_pmc_dev = {
>> +	.map = &spt_reg_map,
>> +};
>> +
>>   int spt_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> -	int ret;
>> -
>> -	pmc->map = &spt_reg_map;
>> -
>> -	ret = get_primary_reg_base(pmc);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pmc_core_get_low_power_modes(pmcdev);
>> -
>> -	return ret;
>> +	return generic_core_init(pmcdev, &spt_pmc_dev);
>>   }
>> +
>> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
>> index 4fec43d212d01..43a2aec4a5673 100644
>> --- a/drivers/platform/x86/intel/pmc/tgl.c
>> +++ b/drivers/platform/x86/intel/pmc/tgl.c
>> @@ -285,35 +285,36 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
>>   	ACPI_FREE(out_obj);
>>   }
>>   
>> -static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
>> -{
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>> -	int ret;
>> +static struct pmc_dev_info tgl_l_pmc_dev = {
>> +	.map = &tgl_reg_map,
>> +	.suspend = cnl_suspend,
>> +	.resume = cnl_resume,
>> +};
>>   
>> -	if (pch_tp == PCH_H)
>> -		pmc->map = &tgl_h_reg_map;
>> -	else
>> -		pmc->map = &tgl_reg_map;
>> +static struct pmc_dev_info tgl_pmc_dev = {
>> +	.map = &tgl_h_reg_map,
>> +	.suspend = cnl_suspend,
>> +	.resume = cnl_resume,
>> +};
>>   
>> -	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = cnl_resume;
>> +static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
>> +{
>> +	int ret;
>>   
>> -	ret = get_primary_reg_base(pmc);
>> +	ret = generic_core_init(pmcdev, &tgl_l_pmc_dev);
>>   	if (ret)
>>   		return ret;
>>   
>> -	pmc_core_get_low_power_modes(pmcdev);
>>   	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
>> -
>>   	return 0;
>>   }
>>   
>>   int tgl_l_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	return tgl_core_generic_init(pmcdev, PCH_LP);
>> +	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
>>   }
>>   
>>   int tgl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	return tgl_core_generic_init(pmcdev, PCH_H);
>> +	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
>>   }
>>
> It might be also worth to consider what is stored into those
> X86_MATCH_VFM()s so that the simple init functions could be removed
> entirely but it could be done in another patch on top of this one.
Right now we store the init function pointer for each architecture in 
X86_MATCH_VFM()
structure. We could change it to be a pointer to the pmc_dev_info 
structure instead. Most
of the per architecture init function call the generic_init function 
directly except for TGL
init function. The TGL case can be handled by adding a new callback 
function pointer field named
platform_specific and this field can also be used to replace the fixup 
field.

Thanks!

Xi

>

