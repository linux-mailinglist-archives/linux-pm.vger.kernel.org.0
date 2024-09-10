Return-Path: <linux-pm+bounces-13976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C297461E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 00:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C58D288396
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC51AB52E;
	Tue, 10 Sep 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DulLMIPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD31A2C3C;
	Tue, 10 Sep 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008380; cv=none; b=JEaf7S8RYCpeVfWMHqaiN6YY81CLWHLjAuax7nxQN+EWO0yzik2MyZ/XNBTZNzBppeELzJrwRVNbF4Qt8KfsvM5Z32qIfZjemQ0rrNy5Pf5OgYV6rJ/nVVZazYlWphXX/25fUgIEkZDsb/WbbjW3Ra7nuOYwrO/GGEQmSrFF7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008380; c=relaxed/simple;
	bh=WdKoHLpVfWvlMw3f3dM3iIgg7qJfDG0nK0s2WlXg9Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfa2eFonnjTqI/Xj1KE4MbkPb4GvwMdlFzClpVAj8jQz5ZQm33vDRAA3sEXVTADws8fBv37MPDnksAz0/UYGZU2a+O4sNrfFTVKupmBodr2XBESNnDfrb1E8EiK93zNSQgOIOxlT//aqlX7p8HI1A0y6oqs6oET92bV2utj1x7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DulLMIPY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726008378; x=1757544378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WdKoHLpVfWvlMw3f3dM3iIgg7qJfDG0nK0s2WlXg9Us=;
  b=DulLMIPY+UsFurcMbCImlnLWy18KFHEo4W+2Rw/eAvTn4066Oku1B1pv
   WttrD+YsWE/OgI4lMgKtVOfv7oLjcR9mku0/EktmbOzq5fQXoc6PN/XWi
   CVWCjSHdTGCdEEY+sddQpZCvWPHs2FzZ8AsoNtmpX05/2tB8Yn/B0LtMj
   KEqBK8Y9Vtg9fU8uBwu3JpVM0rl1Dv/T39kd03WCbqAOSohGasSCPIOxO
   Oq2UfRZHYqfLSDDrfBfe+nydcuqbIhosMH27EtCWEWVIZ98hVu330GlyR
   R37kEF4vNzuagkW4WIsKDUBrUj3hDuegSclzRfms5zQRlOcm1bLe+LF99
   g==;
X-CSE-ConnectionGUID: Dcwj2bjXQiGufJ1kyghiXA==
X-CSE-MsgGUID: sLyiSCyiSb2XOkh8JBE7eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36162810"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="36162810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:46:18 -0700
X-CSE-ConnectionGUID: zrAuAWM+Q96BsSpVZRzLYA==
X-CSE-MsgGUID: DgE16REfSzuHUPCTqPmxKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71552631"
Received: from rjingar-mobl1.amr.corp.intel.com (HELO [10.124.19.183]) ([10.124.19.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:46:17 -0700
Message-ID: <696207c6-3157-45ba-8ff6-4e8751d2271d@linux.intel.com>
Date: Tue, 10 Sep 2024 15:45:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/pmc: Add Arrow Lake U/H support to
 intel_pmc_core driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: xi.pardee@linux.intel.com, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20240909232842.2896965-1-rajvi.jingar@linux.intel.com>
 <4481a9c5-05b1-fef8-a011-4bbdad19c35b@linux.intel.com>
Content-Language: en-US
From: "rajvi.jingar" <rajvi.jingar@linux.intel.com>
In-Reply-To: <4481a9c5-05b1-fef8-a011-4bbdad19c35b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for reviewing the patch.

Restructuring the code to handle platform variations won't be that 
straightforward, so we will be sending the next version in next cycle rc1.

Thanks,

Rajvi

On 9/10/2024 2:32 AM, Ilpo Järvinen wrote:

> On Mon, 9 Sep 2024, Rajvi Jingar wrote:
>
>> Add Arrow Lake U and Arro Lake H support in intel_pmc_core driver
> Arrow
>
> Add . to the end of sentence.
>
>> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  | 65 ++++++++++++++++++++++-----
>>   drivers/platform/x86/intel/pmc/core.c |  2 +
>>   drivers/platform/x86/intel/pmc/core.h |  7 +++
>>   3 files changed, 64 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index e10527c4e3e0..964f5f040dd9 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -16,6 +16,7 @@
>>   #define IOEP_LPM_REQ_GUID	0x5077612
>>   #define SOCS_LPM_REQ_GUID	0x8478657
>>   #define PCHS_LPM_REQ_GUID	0x9684572
>> +#define SOCM_LPM_REQ_GUID	0x2625030
>>   
>>   static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
>>   
>> @@ -650,6 +651,7 @@ const struct pmc_reg_map arl_pchs_reg_map = {
>>   	.etr3_offset = ETR3_OFFSET,
>>   };
>>   
>> +#define PMC_DEVID_SOCM 0x777f
>>   #define PMC_DEVID_SOCS 0xae7f
>>   #define PMC_DEVID_IOEP 0x7ecf
>>   #define PMC_DEVID_PCHS 0x7f27
>> @@ -669,11 +671,17 @@ static struct pmc_info arl_pmc_info_list[] = {
>>   		.devid	= PMC_DEVID_PCHS,
>>   		.map	= &arl_pchs_reg_map,
>>   	},
>> +	{
>> +		.guid	= SOCM_LPM_REQ_GUID,
>> +		.devid	= PMC_DEVID_SOCM,
>> +		.map	= &mtl_socm_reg_map,
>> +	},
>>   	{}
>>   };
>>   
>>   #define ARL_NPU_PCI_DEV			0xad1d
>>   #define ARL_GNA_PCI_DEV			0xae4c
>> +#define ARL_H_GNA_PCI_DEV 		0x774c
>>   /*
>>    * Set power state of select devices that do not have drivers to D3
>>    * so that they do not block Package C entry.
>> @@ -684,6 +692,12 @@ static void arl_d3_fixup(void)
>>   	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
>>   }
>>   
>> +static void arl_h_d3_fixup(void)
>> +{
>> +	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
>> +	pmc_core_set_device_d3(ARL_H_GNA_PCI_DEV);
>> +}
>> +
>>   static int arl_resume(struct pmc_dev *pmcdev)
>>   {
>>   	arl_d3_fixup();
>> @@ -692,16 +706,47 @@ static int arl_resume(struct pmc_dev *pmcdev)
>>   	return pmc_core_resume_common(pmcdev);
>>   }
>>   
>> +static int arl_h_resume(struct pmc_dev *pmcdev)
>> +{
>> +	arl_h_d3_fixup();
>> +	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>> +
>> +	return pmc_core_resume_common(pmcdev);
>> +}
>> +
>> +int arl_h_core_init(struct pmc_dev *pmcdev)
>> +{
>> +	arl_h_d3_fixup();
>> +
>> +	return arl_core_generic_init(pmcdev, SOC_M);
>> +}
>> +
>>   int arl_core_init(struct pmc_dev *pmcdev)
>>   {
>> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>> +	arl_d3_fixup();
>> +
>> +	return arl_core_generic_init(pmcdev, SOC_S);
>> +}
>> +
>> +int arl_core_generic_init(struct pmc_dev *pmcdev, int soc_tp)
> This function has no callers outside or arl.c and should be made static
> and the code should be reordered such that no prototype is needed.
>
>> +{
>>   	int ret;
>> -	int func = 0;
>> +	int func;
>>   	bool ssram_init = true;
>> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>>   
>> -	arl_d3_fixup();
>>   	pmcdev->suspend = cnl_suspend;
>> -	pmcdev->resume = arl_resume;
>> +
>> +	if (soc_tp == SOC_M) {
>> +		func = 2;
>> +		pmcdev->resume = arl_h_resume;
>> +	} else if (soc_tp == SOC_S) {
>> +		func = 0;
>> +		pmcdev->resume = arl_resume;
> It would be preferrable to make an info structure to describe this kind
> of platform variations so that if () forests like this are avoided.
>
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>>   	pmcdev->regmap_list = arl_pmc_info_list;
>>   
>>   	/*
>> @@ -711,7 +756,10 @@ int arl_core_init(struct pmc_dev *pmcdev)
>>   	ret = pmc_core_ssram_init(pmcdev, func);
>>   	if (ret) {
>>   		ssram_init = false;
>> -		pmc->map = &arl_socs_reg_map;
>> +		if (soc_tp == SOC_M)
>> +			pmc->map = &mtl_socm_reg_map;
>> +		else
>> +			pmc->map = &arl_socs_reg_map;
> As with above, use an info struct.
>

