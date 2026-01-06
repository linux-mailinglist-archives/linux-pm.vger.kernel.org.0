Return-Path: <linux-pm+bounces-40340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43943CFB605
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 00:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE1A83003B3C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96D31D38B;
	Tue,  6 Jan 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6p0m6SM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48531D362;
	Tue,  6 Jan 2026 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743128; cv=none; b=qzwkNM2EJTzuvaH1quOWEPR3gsCQ+tNF6c7K0I9V0Sldvr4UBgZTSKIGHpqU01laLvg/CStlHBcZHG6IUjWuTugp0ENNDqcpb5qaVmDCIqTVIUrh+i8rnWeHSOHVUV3P3Pr70mHixUrnuLlwKPKGjhWVxiAbR3X61UDHKkh0250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743128; c=relaxed/simple;
	bh=TMgxkcSBBdBBt6dwVKsJzh+5rmtR3LX83lcFSJNMUnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9uuOXl4mkKBjiO4mCPr+DmwyD1+R996edjCtIROKwTjDWmqDmf0hVubKzzxDysLCzco68cwGv6UyEt5kvMLGWpsJD8Fqf/I0V9pqu0sSrUYmu4N1/GZsPlJWoH3GUMXalcHOmGheoRuGw1bF0lJr+WXus5rdGNmBbAGB4+m0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6p0m6SM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767743126; x=1799279126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TMgxkcSBBdBBt6dwVKsJzh+5rmtR3LX83lcFSJNMUnk=;
  b=G6p0m6SMODk6Hk9XTQAGlhYuQBvb4ZgMMMkd2KL2bh8rUV06e979YufB
   vELBI87vqPbyo7eyCDfjbZpFPTLuTIInIGpyONZVvKgS1agLPhkX+OAXu
   UQyNkNWA7h+mN6eaLX37cq2LzneEb9IWhjPV7j3ATGh8zXc+CdzNlpGCG
   vYSZ+F1HT2uFKPOA7RSyhS3Dlh0N/wWRXMeeCbHUOsET1o6EpnQALe0G5
   ff9VWpEwya7H0ohhyXKfBQFFA/iko2yda19qtZjRkxcqqNTPUVdorS3I4
   /8DJ9SsbzjwTuLk8sw9FogxqjwvvaUxjLyR9C++V05OaK6QlrggdXPhAG
   w==;
X-CSE-ConnectionGUID: FCk+GkVkSk28vQa7X+Dn9Q==
X-CSE-MsgGUID: 3uz0x3G9S/KBssYLPBSHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72744607"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72744607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 15:45:25 -0800
X-CSE-ConnectionGUID: MryDhUyYQZaU5L9XHr1Lcg==
X-CSE-MsgGUID: bffes8gETHiYE5+vbUIE5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207836582"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 15:45:25 -0800
Message-ID: <11077f24-72e4-4ba0-87b5-5a6e4dbd1eb0@linux.intel.com>
Date: Tue, 6 Jan 2026 15:45:12 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/intel/pmc: Change LPM mode fields to u8
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20251217002343.2289577-1-xi.pardee@linux.intel.com>
 <20251217002343.2289577-2-xi.pardee@linux.intel.com>
 <0de42147-16c3-e610-caae-e7aba5406782@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <0de42147-16c3-e610-caae-e7aba5406782@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for reviewing the patch. My response is inline.

On 12/23/2025 4:29 AM, Ilpo Järvinen wrote:
> On Tue, 16 Dec 2025, Xi Pardee wrote:
>
>> Change the datatypes pf num_lpm_modes and lpm_en_modes[] from int
>> to u8. The u8 type is more appropriate and improves the readability
>> and maintainability of the code.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 18 ++++++++++--------
>>   drivers/platform/x86/intel/pmc/core.h |  4 ++--
>>   2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 7d7ae8a40b0ec..3e916228e7ed2 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -779,7 +779,7 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>>   	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>>   	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
>>   	u32 offset = pmc->map->lpm_residency_offset;
>> -	int mode;
>> +	u8 mode;
>>   
>>   	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
>>   
>> @@ -838,7 +838,7 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
>>   					      enum header_type type)
>>   {
>>   	struct pmc_dev *pmcdev = s->private;
>> -	int mode;
>> +	u8 mode;
>>   
>>   	seq_printf(s, "%40s |", "Element");
>>   	pmc_for_each_mode(mode, pmcdev)
>> @@ -880,7 +880,7 @@ static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
>>   			const struct pmc_bit_map *map;
>>   
>>   			for (map = maps[r_idx]; map->name; map++) {
>> -				int mode;
>> +				u8 mode;
>>   
>>   				if (!map->blk)
>>   					continue;
>> @@ -953,7 +953,8 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   			u32 lpm_status;
>>   			u32 lpm_status_live;
>>   			const struct pmc_bit_map *map;
>> -			int mode, i, len = 32;
>> +			int i, len = 32;
>> +			u8 mode;
>>   
>>   			/*
>>   			 * Capture the requirements and create a mask so that we only
>> @@ -1065,7 +1066,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>>   	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>>   	bool c10;
>>   	u32 reg;
>> -	int mode;
>> +	u8 mode;
>>   
>>   	reg = pmc_core_reg_read(pmc, pmc->map->lpm_sts_latch_en_offset);
>>   	if (reg & LPM_STS_LATCH_MODE) {
>> @@ -1097,8 +1098,9 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
>>   	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>>   	bool clear = false, c10 = false;
>>   	unsigned char buf[8];
>> -	int m, mode;
>> +	int mode;
>>   	u32 reg;
>> +	u8 m;
>>   
>>   	if (count > sizeof(buf) - 1)
>>   		return -EINVAL;
>> @@ -1490,8 +1492,8 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
>>   {
>>   	const u8 *lpm_indices;
>>   	int num_maps, mode_offset = 0;
>> -	int ret, mode;
>> -	int lpm_size;
>> +	int ret, lpm_size;
>> +	u8 mode;
>>   
>>   	lpm_indices = pmc->map->lpm_reg_index;
>>   	num_maps = pmc->map->lpm_num_maps;
> Why is "mode" in pmc_core_get_low_power_modes() left untouched?
>
> (Unrelated to the patch, it seems to contain a double empty line as well.)

I missed this function. Will change the type of "mode" in 
pmc_core_get_low_power_modes() in next version.

Will add another patch to remove one empty line in next version.

Thanks!

Xi

>
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index 272fb4f57f346..ead2f33ed3ed5 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -462,8 +462,8 @@ struct pmc_dev {
>>   	struct mutex lock; /* generic mutex lock for PMC Core */
>>   
>>   	u64 s0ix_counter;
>> -	int num_lpm_modes;
>> -	int lpm_en_modes[LPM_MAX_NUM_MODES];
>> +	u8 num_lpm_modes;
>> +	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
>>   	void (*suspend)(struct pmc_dev *pmcdev);
>>   	int (*resume)(struct pmc_dev *pmcdev);
>>   
>>

