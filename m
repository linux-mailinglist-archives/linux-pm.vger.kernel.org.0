Return-Path: <linux-pm+bounces-34001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40A1B45F4E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826EF483DE2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1876309F00;
	Fri,  5 Sep 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGB3P2iM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9513D521;
	Fri,  5 Sep 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091030; cv=none; b=Y6x/s8aBBRztgT73PtxpyzcEuo/jqQpO0DufE9q7cBjVLMZ6bJhURbk2SZDiNVOunbCM2wpnnbPMXmqAk3zhJdFQSPHZ62KPFV2fHpH+597/BjRQ2ozVHpzaBWUfFhwuTCT5OLfQIfhMeBT5j1fQfN7s8ypTW1JqNdirJl8BPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091030; c=relaxed/simple;
	bh=yUYr8lfgw7Ezjxm5y8LIwiBEBgQiQHHRl18d7pJaH1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkUNgOszpeI9tLX9/fcD7uHec+2IW7ynfVXLxnop3gCUlubUHuPfFBOU0fuCmfkMRNyIURIBBI8EFScVu3B7i/uyjEBNpU/fSx8bsHVZVNkHvCzqdJWaOO4lSx/sAI1JX1KOjxVuPdRuTBcwHvw2OeKsc1lk7RdTRJSS/6H5Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGB3P2iM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757091030; x=1788627030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yUYr8lfgw7Ezjxm5y8LIwiBEBgQiQHHRl18d7pJaH1E=;
  b=YGB3P2iM9G5Ud37xPfiw6KUfCU0qQxB5Ayy7N4frqmCLhZBU9rJ7WNAX
   t9pvKa1Uhcm+kYU6JH/BlZ9p7S9zB2Izi+8zM5EU3b0z5cc2B15hhwUga
   YngjfBm10fBNY70HW55GOPckI6YVLlUzpNLIDzp4kRn4OJ3BY1BLZpB2t
   kQq1n1+SOu+p7FYC1r8+jFB1cXyl3RMyI9OUlliutOd/fOUdLbnpNmpmC
   E6JsHshWJB92WPfqkmB/BWpCeJYvtxnP1HgFG+hMVfH/6CDXQxVSDLv4T
   dPpzLY5KEMpn3yhabBqbTW3ncLkOyswGIjV0fuATv+ycJADdDJGbVfhfJ
   A==;
X-CSE-ConnectionGUID: GkzybTIxTWiz+lf45egObQ==
X-CSE-MsgGUID: HAoGGA2oRiqoOfFxxCAkCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="76901233"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="76901233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:50:29 -0700
X-CSE-ConnectionGUID: LKk3Kgu3ToKbM7kJTBy9BA==
X-CSE-MsgGUID: x7K9VjbfTma86iNioWs/7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="195864277"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.246.154.149]) ([10.246.154.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:50:27 -0700
Message-ID: <faa53dac-f2f3-4e49-a141-f13290c37240@linux.intel.com>
Date: Fri, 5 Sep 2025 09:50:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] platform/x86:intel/pmc: Improve function to show
 substate header
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
 <20250815224611.2460255-4-xi.pardee@linux.intel.com>
 <6690bc98-a396-0d8a-dae6-b141a8667585@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <6690bc98-a396-0d8a-dae6-b141a8667585@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Thanks for the view.

On 8/28/2025 6:09 AM, Ilpo Järvinen wrote:
> On Fri, 15 Aug 2025, Xi Pardee wrote:
>
>> Refactor pmc_core_substate_req_header_show() to accept a new argument.
>> This is a preparation patch to introduce a new way to show Low Power
>> Mode substate requirement data for platforms starting from Panther
>> Lake. Increased the size for the name column as the Low Power Mode
>> requirement register name is longer in newer platforms.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a1dd80bdbd413..cbfdcdc50ad21 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -11,6 +11,11 @@
>>   
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> +enum header_type {
>> +	HEADER_STATUS,
>> +	HEADER_VALUE
> Please have the comma in any non-terminating entry.

Will add comma in next version.

Xi

>
>> +};
>> +
>>   #include <linux/bitfield.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>> @@ -828,17 +833,22 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>>   
>> -static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
>> +static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
>> +					      enum header_type type)
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
>> +	if (type == HEADER_STATUS) {
>> +		seq_printf(s, " %9s |", "Status");
>> +		seq_printf(s, " %11s |\n", "Live Status");
>> +	} else {
>> +		seq_printf(s, " %9s |\n", "Value");
>> +	}
>>   }
>>   
>>   static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>> @@ -872,7 +882,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   			continue;
>>   
>>   		/* Display the header */
>> -		pmc_core_substate_req_header_show(s, pmc_index);
>> +		pmc_core_substate_req_header_show(s, pmc_index, HEADER_STATUS);
>>   
>>   		/* Loop over maps */
>>   		for (mp = 0; mp < num_maps; mp++) {
>> @@ -910,7 +920,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>>   				}
>>   
>>   				/* Display the element name in the first column */
>> -				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
>> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
>>   
>>   				/* Loop over the enabled states and display if required */
>>   				pmc_for_each_mode(mode, pmcdev) {
>>

