Return-Path: <linux-pm+bounces-13918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC222972656
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FF6B221E0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7F55C3E;
	Tue, 10 Sep 2024 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvUYPHeI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940B23AB;
	Tue, 10 Sep 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929394; cv=none; b=cY/oMNwSgLGpbmtlKPQd3iQDryFC2tLDjs2vBPXCU1Q0hTKmoqew5Ka2N906C8hR0Pd9wMB30B42yR6wZee5Cq22F2xJ4RgYodrm4wy7p8DrUjSBvgyUh+m4AbMdcqmyT6XaCO+Ug0pkegbm4r1H33l1CJSKjMmqd/avyzoGqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929394; c=relaxed/simple;
	bh=KKBmHIDnxYEzDcPUAEcWXq86Vrmi5Fw/4OjA7wXDUHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJb+NNSxPgsjKTlBe67PwI/HV8COvu2/qAXD2h8QczKtvOWaL4lLYJp4HAiyG0VQFsSl2tmJma1kXSQpNs46dcfr0jLn5ngTgss3BZCSMRV7XcqSSgiwG4z59zZvtsk5SUSgO6aODifidBh/ERQ57bN92StaM9nbZ9bHJHAoI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvUYPHeI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725929393; x=1757465393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KKBmHIDnxYEzDcPUAEcWXq86Vrmi5Fw/4OjA7wXDUHI=;
  b=MvUYPHeI69YceV7so1nBDaM0EjQFoUtpEOqOlD+AWLqOw2SSGYyyQjmD
   Pw40NC3rbPr0nfFX9QOOdrjn40VBGxH4qFpOBs2vGujHhPys6RHCAckPd
   IiiHi9RC7dvqQBoDdbK1ZnarDCJlw8IIIK4Z/YwvFH3BMEuBf+YCDvGLc
   oTAqisNnSxUVPNIONW7hVJMzCRRaYqZAdJ5Ku6DB+MYa1Xt/iU7aJ2CJl
   HncgJxQwiCTPcM2F/nKoq2oWVD7E2UgAR5De/KRb4i9Zd6w+INlocAIZV
   gA2puJamRf501OqmdJCpB10mCS9UlxF3s9BYkxS54Qr21p7Gk+Ny+QzaG
   g==;
X-CSE-ConnectionGUID: d3JEz/PLSg2a5FiCkG0djg==
X-CSE-MsgGUID: sg0xEQraQfizLwRsCO0YhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42133120"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="42133120"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:49:52 -0700
X-CSE-ConnectionGUID: pqNkPw70ToWZ0/N04HPcOA==
X-CSE-MsgGUID: T0B/ezBGTA2+ACdPC2PSFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71820323"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.67.115]) ([10.125.67.115])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:49:52 -0700
Message-ID: <cd2a5552-0ab5-4d85-a419-7af3e97ffcb7@linux.intel.com>
Date: Mon, 9 Sep 2024 17:49:51 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] platform/x86:intel/pmc: Get LPM information for
 Lunar Lake
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
 <20240828222932.1279508-12-xi.pardee@linux.intel.com>
 <d270b60b-f136-a520-1703-efa4cbfb0aba@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <d270b60b-f136-a520-1703-efa4cbfb0aba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/2024 5:13 AM, Ilpo Järvinen wrote:
> On Wed, 28 Aug 2024, Xi Pardee wrote:
>
>> Add support to find and read the requirements from the telemetry
>> entries for Lunar Lake platforms.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/lnl.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
>> index 109b08d43fc8..f5fee9e105e2 100644
>> --- a/drivers/platform/x86/intel/pmc/lnl.c
>> +++ b/drivers/platform/x86/intel/pmc/lnl.c
>> @@ -13,8 +13,13 @@
>>   
>>   #include "core.h"
>>   
>> +#define SOCM_LPM_REQ_GUID	0x15099748
>> +
>> +static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
>> +
>>   static struct pmc_info lnl_pmc_info_list[] = {
>>   	{
>> +		.guid	= SOCM_LPM_REQ_GUID,
>>   		.devid	= PMC_DEVID_LNL_SOCM,
>>   		.map	= &lnl_socm_reg_map,
>>   	},
>> @@ -536,6 +541,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
>>   	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
>>   	.s0ix_blocker_maps = lnl_blk_maps,
>>   	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
>> +	.lpm_reg_index = LNL_LPM_REG_INDEX,
>>   };
>>   
>>   #define LNL_NPU_PCI_DEV		0x643e
>> @@ -561,6 +567,8 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>>   
>>   int lnl_core_init(struct pmc_dev *pmcdev)
>>   {
>> +	bool ssram_init = true;
>> +	int func = 2;
>>   	int ret;
>>   	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>>   
>> @@ -578,6 +586,7 @@ int lnl_core_init(struct pmc_dev *pmcdev)
>>   
>>   	/* If regbase not assigned, set map and discover using legacy method */
>>   	if (ret) {
>> +		ssram_init = false;
>>   		pmc->map = &lnl_socm_reg_map;
>>   		ret = get_primary_reg_base(pmc);
>>   		if (ret)
>> @@ -586,5 +595,11 @@ int lnl_core_init(struct pmc_dev *pmcdev)
>>   
>>   	pmc_core_get_low_power_modes(pmcdev);
>>   
>> +	if (ssram_init)	{
>> +		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, func);
>> +		if (ret)
>> +			return ret;
> There's quite much duplication related to this legacy/ssram init in
> the per arch core init functions. And some inconsistencies too which
> seem incidental such as mtl.c using return directly here.
I will try to extract the duplicate code to a common function and remove 
the
inconsistencies between different architecture in next version.

Xi


