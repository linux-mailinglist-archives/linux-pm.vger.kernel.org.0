Return-Path: <linux-pm+bounces-34015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9497B46282
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858DC7A6037
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896827467F;
	Fri,  5 Sep 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQqPVBcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3C2737E7;
	Fri,  5 Sep 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097828; cv=none; b=LYxrURVqVuIZsCtb847QaQfSQlA7zLQ5KRaUeZfVpWMtE7SsG321IJDFD66o0LOe8LD5eb1qijLHHE8SOf+RsPIMPUeZBMnfqrOlBACuADo+Ncjg4oYwRJelZU/vVym1u9NS5SbXmLjkNYkaiZ4iCm1bw1rYorMAXJx69LDC4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097828; c=relaxed/simple;
	bh=F60wNoG+WGHTQCcsGL07856RUgL+Eiwk+zU7KZono2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Za3tpX9s2SRGotIzpbV50qbDnCOTcS24Ge+zZkhKVif/X6a/F/LdGHZGZhVTXANnBGGBCFCjpk/UCr9kSTRKKYYeGQRlIhvA+8cHNQX8mCo7BG2TAF1g/of8tMZT4ZeXrXnDMFuCDR+Au4NclZ0yPzSNb9b7Tvfg8+XRNQhY5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQqPVBcd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757097827; x=1788633827;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=F60wNoG+WGHTQCcsGL07856RUgL+Eiwk+zU7KZono2A=;
  b=VQqPVBcdCz/WAxtToxBhdXT1Oxr6nBefN9jYolIWvlFJhMo4ldAXEa0q
   KKmLnMRExLixkmZGGLCFs/Mt/Mm2dgaJokLtdvBBcW0/EJDrQeEyd6r3o
   NvhJMjBDJVafFhogZdDiGR7Ub4sqRSvIMcNK2lZv0x7m/Ga5opuzRuGXO
   KhLq2fPoQOOUJ0TyYxF/KZMI1+e42Xs51FOeqhKHk4Vff93wTudlszt4z
   EnCcglrc360U+Nj4xVUkRpKegtI2SGs0TLR0m98dMMAuZ0rMEsszl/WQk
   8fx7HBksAkp0UsXCTpJurxFEuBm9Wn8q1Z5ImGjGCFf/2ZsY7nztnO5Io
   g==;
X-CSE-ConnectionGUID: o5jKojw8TRiIeFScbWwtqA==
X-CSE-MsgGUID: hNqmiovQRRufhpIZipiCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="58665111"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="58665111"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:43:46 -0700
X-CSE-ConnectionGUID: ZSAvoQKOSlWx9rMUHSGufw==
X-CSE-MsgGUID: tbUkbG1WTzuGpH3gZm7EcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="173032678"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:43:45 -0700
Message-ID: <7714a30a-6505-43c8-949a-43f48049c1c9@linux.intel.com>
Date: Fri, 5 Sep 2025 11:43:44 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] platform/x86:intel/pmc: Show substate requirement
 for S0ix blockers
To: Russell Haley <yumpusamongus@gmail.com>, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
 <20250815224611.2460255-5-xi.pardee@linux.intel.com>
 <60e6b6da-ba46-4a75-b571-8b62f3186008@gmail.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <60e6b6da-ba46-4a75-b571-8b62f3186008@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,

Thanks for the review.

On 9/1/2025 4:52 PM, Russell Haley wrote:
> On 8/15/25 5:46 PM, Xi Pardee wrote:
>> Add support to read and show S0ix blocker substate requirements.
>> Starting from Panther Lake, substate requirement data is provided
>> based on S0ix blockers instead of all low power mode requirements.
>> For platforms that support this new feature, add support to display
>> substate requirements based on S0ix blockers.
>>
>> Change the "substate_requirements" attribute of Intel PMC Core
>> driver to show the substate requirements for each S0ix blocker
>> and the corresponding S0ix blocker value.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  |   4 +
>>   drivers/platform/x86/intel/pmc/core.c | 126 ++++++++++++++++++++++++--
>>   drivers/platform/x86/intel/pmc/core.h |  14 +++
>>   drivers/platform/x86/intel/pmc/lnl.c  |   2 +
>>   drivers/platform/x86/intel/pmc/mtl.c  |   2 +
>>   5 files changed, 138 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index 9d66d65e75779..17ad87b392abe 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -725,9 +725,11 @@ struct pmc_dev_info arl_pmc_dev = {
>>   	.dmu_guid = ARL_PMT_DMU_GUID,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &arl_socs_reg_map,
>> +	.sub_req_show = &pmc_core_substate_req_regs_fops,
>>   	.suspend = cnl_suspend,
>>   	.resume = arl_resume,
>>   	.init = arl_core_init,
>> +	.sub_req = pmc_core_pmt_get_lpm_req,
>>   };
>>   
>>   struct pmc_dev_info arl_h_pmc_dev = {
>> @@ -735,7 +737,9 @@ struct pmc_dev_info arl_h_pmc_dev = {
>>   	.dmu_guid = ARL_PMT_DMU_GUID,
>>   	.regmap_list = arl_pmc_info_list,
>>   	.map = &mtl_socm_reg_map,
>> +	.sub_req_show = &pmc_core_substate_req_regs_fops,
>>   	.suspend = cnl_suspend,
>>   	.resume = arl_h_resume,
>>   	.init = arl_h_core_init,
>> +	.sub_req = pmc_core_pmt_get_lpm_req,
>>   };
> The cover letter and commit messages say Panther Lake, but I see a bunch
> of "arl" here. Is this just confusing file and struct names, or is my
> Arrow Lake 265K getting idle-blocker-cause debug info? If so it should
> probably be mentioned in the changelog.
>
> Same question about patch 5.

This patch series enables SSRAM supports of Lunar Lake and Panther Lake 
platforms in intel_pmc_core driver. It would not modify the 
functionality of intel_pmc_core driver in Arrow Lake platforms. Arrow 
Lake would not get s0ix_blocker information with this patch series.

Starting from Panther Lake, the "substate_requirements" attribute in the 
newer platforms will show only the requirements of s0ix blockers instead 
of every substate status register. In order to support these two mutual 
exclusive features, additional fields have been added to pmc_dev_info 
struct. This change would not change the functionality of intel_pmc_core 
driver in Arrow Lake platforms.

Thanks for the suggestion, I will add this information to the changelog 
of next version.

Thanks!

Xi

>
> - Russell Haley
>

