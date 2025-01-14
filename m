Return-Path: <linux-pm+bounces-20424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFDA10C76
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230D716823E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B31C3BF0;
	Tue, 14 Jan 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mM7CWI4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E01885BF;
	Tue, 14 Jan 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872779; cv=none; b=A03+ureErdisbJP7pbRf4gasjkzYqOQDUPPXdNsZtqgxGGDO0Z0V2/GR+vQ3j+Toow9K4eB2A/zgrFBn6bWiVvRaPJ6uG5zgB/sD8ykwCnMa3wSp3JDfHwYh12KDzZyLg6nzogcsY1FTdsgDjiMTJiLfK285YQr4dhNQqw11HS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872779; c=relaxed/simple;
	bh=G+02xMCSnTIHgRkxJgupT5ZhBd7y4ERZTauD+RaXvxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvPP0ovhH0Dt094VCQEzbhIFNdylqgUA1YgYgtV4Zkpb0frOtx8udPKQbE3NIHBK7xm5hPAmMpVbTa//xEa4mrBVXWwLi7eVO0Ihel7Xk8DPy3vZOrN6120SdrAxd0jW6jZTprqggE+x5S2j69JNAM4Fb3qe5Up4a6sUS4DZlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mM7CWI4P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736872778; x=1768408778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G+02xMCSnTIHgRkxJgupT5ZhBd7y4ERZTauD+RaXvxw=;
  b=mM7CWI4PON+y2FqvrSKZrBnDMTzBbtA6LAz98l9sX/dLWwhQpYA2PJ9J
   Pnzh9YoiKxoH4uu4QteKbMIcbuvtOUjTndxKwuoaSNZRgcVmyzc1RMPWP
   +iPfY6vu3WkCWssjiV6TpIeXiipSzFUgDjcxXhytPxbb/mt839+ekoXoU
   sgajYnDN8Em+N89UtSJr2RvexK5Ak8mbhKWzfZ5KSNMjA+aCJxXdnvcIm
   5swoFYi564MTqmVUGQb9s4ufqpbL9QBIV6c5XSQSkimqx0Cg5lFHKKKH/
   jGquZiYjRUGrXDDTyigWZ0z3AStCT5Hw1b/EZROhsaB22lnnQrBweSiVs
   Q==;
X-CSE-ConnectionGUID: woPnB8IzSgS7PkocTC9MnQ==
X-CSE-MsgGUID: tugZrhc4T9ORdy5QzZGplw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48586977"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48586977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:39:37 -0800
X-CSE-ConnectionGUID: OqisrosVRNCsuif5L1e4lg==
X-CSE-MsgGUID: wUssAdpwRS+Il/XHtLRIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104690208"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.145.9]) ([10.246.145.9])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:39:37 -0800
Message-ID: <a6239ca1-8eae-48e3-ba49-0bab81438b68@linux.intel.com>
Date: Tue, 14 Jan 2025 08:39:35 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] platform/x86/intel/pmc: Create architecture
 specific callback
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com,
 david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
 <20250110002612.244782-5-xi.pardee@linux.intel.com>
 <63e0fb3a-e1ab-e756-fea7-1f317eaad009@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <63e0fb3a-e1ab-e756-fea7-1f317eaad009@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/10/2025 3:50 AM, Ilpo Järvinen wrote:
> On Thu, 9 Jan 2025, Xi Pardee wrote:
>
>> Add architecture specific callback field in pmc_dev_info structure.
>> Architecture specific action could be handled in this callback instead
>> of per architecture init functions. Convert Arrow Lake, Lunar Lake,
>> Meteor Lake and Tiger Lake platforms to use this field.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  | 15 +++++++--------
>>   drivers/platform/x86/intel/pmc/core.c |  3 +++
>>   drivers/platform/x86/intel/pmc/core.h |  7 +++++++
>>   drivers/platform/x86/intel/pmc/lnl.c  | 15 +++++++--------
>>   drivers/platform/x86/intel/pmc/mtl.c  | 15 +++++++--------
>>   drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----------
>>   6 files changed, 36 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index dedf752237ca0..9ff90d32a635f 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -698,16 +698,15 @@ static struct pmc_dev_info arl_pmc_dev = {
>>   	.map = &arl_socs_reg_map,
>>   	.suspend = cnl_suspend,
>>   	.resume = arl_resume,
>> +	.arch_specific = arl_specific_init,
>>   };
>>   
>> -int arl_core_init(struct pmc_dev *pmcdev)
>> +void arl_specific_init(struct pmc_dev *pmcdev)
>>   {
>> -	int ret;
>> -
>> -	ret = generic_core_init(pmcdev, &arl_pmc_dev);
>> -	if (ret)
>> -		return ret;
>> -
>>   	arl_d3_fixup();
>> -	return 0;
>> +}
> As I tried to explain already earlier I think the older form is better
> here because it would allow arch specific things in any order:
>
> void xx_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
> {
> 	int ret;
>
> 	xx_pre_fixup();
>
> 	ret = generic_core_init(pmcdev, pmc_dev_info);
> 	if (ret)
> 		return ret;
>
> 	xx_post_fixup();
>
> 	return 0;
> }
>
> If you make it a callback, you have pick either pre or post but cannot do
> both with a single callback. My suggestion would also allow replacing
> generic_core_init() completely if needed in future.
>
> Note how I pass the info parameter above to xx_init() so it can call into
> generic_core_init(). In the core, you'd do this to pick which init
> function to use:
>
> 	if (pmc_dev_info->init)
> 		ret = pmc_dev_info->init(pmcdev, pmc_dev_info);
> 	else
> 		ret = generic_core_init(pmcdev, pmc_dev_info);


Thanks for the feedback. I will change back to init function per 
architect in next version.

Xi


