Return-Path: <linux-pm+bounces-29849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449EAEE5EE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C4E3E007F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8B28F95F;
	Mon, 30 Jun 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFQmWjGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C623FC5F;
	Mon, 30 Jun 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304913; cv=none; b=ZmxAJgQeYb1z8+LPtN8Ky2IVTFj81vFhIG+OsjO5BneCecsk2r3gIsk9FCleT3tBD4Nu/RxFD5/lwFFKzBdwuru94gwABqN+Gdvpz8JMn07oN9d48t5kO5JOg3ooFkj9jyhMbxLcn/NTzUvbTB+C8xqJ5q7TUCL2SkGFoIelZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304913; c=relaxed/simple;
	bh=xQeYx7QXVrleUZqeEO9jUP9OtSFphSkSEPBbT9PSwg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUHJdu5/zYkYklxdHFemqazBzVtuK3wdcCZXbp9OgLjT/5/5PHKNG8WlKIKuEQGeJ1tNB0BEcUAMTGaOcVJeDswyUwKSQgWI1u+JZx08XnoIzr57cXiAV0dQeP0OXog8k8X0QoH0InP0zP/T1Bzg71mxW7G5KzOy9rddDqk0KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFQmWjGz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751304912; x=1782840912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xQeYx7QXVrleUZqeEO9jUP9OtSFphSkSEPBbT9PSwg4=;
  b=DFQmWjGzNnJ90Cu2dVZll3z4C0T0UUdHIdTP3vCvZQ+2iGXhV3j+88zC
   uEbtm4AbvsrzGElqja6MxYP5LRkNQADQvfqV32J1jGal2LEfXQzXmH64X
   h4RZ61xgnh+s7yUa7pkb4H6/pp0RrnO+RMAk0GTIdmyaqyUuh1+Fqtu8e
   Az1ff8dIT0YVQGA/i9EVKN8lOtmVOPWdIOGLwlmYqLcK1+FdAHS7RYUTx
   KzTc2XOqxCB7sOsEp9kY2f/XtrLH2UaPh0Di8HzihC3xUXEQkp+0t2UvN
   DMqZcHAaNrFWaFSOsuHC+1+6Lpe3pzNQZ7U7pk/zgdCo4D4b2VZLAJizN
   w==;
X-CSE-ConnectionGUID: 7wxKU6h+TuaJMNwo2qoDyg==
X-CSE-MsgGUID: bo1U9xmQSIyoVYBvaQ/Uxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57318378"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="57318378"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 10:35:11 -0700
X-CSE-ConnectionGUID: 8oPblvrlQzqh6ZOYoezrgQ==
X-CSE-MsgGUID: yizalB3GRkGYsX2Sx9ix3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="159242713"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 10:35:11 -0700
Message-ID: <67da5800-e8b3-4f80-a0e6-c9becae60c07@linux.intel.com>
Date: Mon, 30 Jun 2025 10:35:10 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] platform/x86:intel/pmc: Improve function to show
 substate header
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20250625063145.624585-1-xi.pardee@linux.intel.com>
 <20250625063145.624585-4-xi.pardee@linux.intel.com>
 <951682a6-66e7-cd1a-4798-c5b4f88c79ec@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <951682a6-66e7-cd1a-4798-c5b4f88c79ec@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for reviewing the patch. My response is inline.

On 6/30/2025 4:34 AM, Ilpo Järvinen wrote:
> On Tue, 24 Jun 2025, Xi Pardee wrote:
>
>> Refactor pmc_core_substate_req_header_show() to accept a new argument.
>> This is a preparation patch to introduce a new way to show Low Power
>> Mode substate requirement data for platforms starting from Panther
>> Lake. Increased the size for the name column as the Low Power Mode
>> requirement register name is longer in newer platforms.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a1dd80bdbd413..47cc5120e7dd6 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -828,17 +828,20 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>>   
>> -static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
>> +static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index, char *name)
>>   {
>>   	struct pmc_dev *pmcdev = s->private;
>>   	int mode;
>>   
>> -	seq_printf(s, "%30s |", "Element");
>> +	seq_printf(s, "%40s |", "Element");
>>   	pmc_for_each_mode(mode, pmcdev)
>>   		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
>>   
>> -	seq_printf(s, " %9s |", "Status");
>> -	seq_printf(s, " %11s |\n", "Live Status");
>> +	if (!strcmp(name, "Status")) {
> I'm not very happy passing this as string. Could we use an
> internal defines/enum instead for this differentiation?
Will use enum in next version.
>
>> +		seq_printf(s, " %9s |", name);
>> +		seq_printf(s, " %11s |\n", "Live Status");
>> +	} else
>> +		seq_printf(s, " %9s |\n", name);
> Please always use braces symmetrically in both blocks.

Will use braces in next version.

Thanks!

Xi

>
>>   }
>>   
>>   static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>> @@ -872,7 +875,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   			continue;
>>   
>>   		/* Display the header */
>> -		pmc_core_substate_req_header_show(s, pmc_index);
>> +		pmc_core_substate_req_header_show(s, pmc_index, "Status");
>>   
>>   		/* Loop over maps */
>>   		for (mp = 0; mp < num_maps; mp++) {
>> @@ -910,7 +913,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   				}
>>   
>>   				/* Display the element name in the first column */
>> -				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
>> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
>>   
>>   				/* Loop over the enabled states and display if required */
>>   				pmc_for_each_mode(mode, pmcdev) {
>>

