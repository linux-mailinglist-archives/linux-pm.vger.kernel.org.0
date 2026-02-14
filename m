Return-Path: <linux-pm+bounces-42639-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WaX/ET+VkGm/bQEAu9opvQ
	(envelope-from <linux-pm+bounces-42639-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 16:31:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECD13C53E
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A88873005A93
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46004257431;
	Sat, 14 Feb 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ61s5Wh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0288188735;
	Sat, 14 Feb 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083068; cv=none; b=oMH+hqb7GE1sLt52BWi+k1edUiloDWRMDB5qwNUVqo4HWoRlgNX4MiBFoKXyqv/v1quyoJ5nQCoJrrkw+sScCjNtW4MhbJz6cO9MhGvm6Cm0pl5hT9PQxSUiDyn5Jvri1XRzAvl18+ZLjR8C26LWwoqs1ZUP1i4SDALWPryPmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083068; c=relaxed/simple;
	bh=vGIL3BuB/5aamhytd5Q98MRpGYl9sercOliR51UCm+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnP6neBRac00eZbKiR1FTmCzSsuEB3zSsVmd2grsnLVE60SwaBY9/LAyMqfQ8k9YCfiwhGqvKT7SNVxAdfQbuvKcbI3XZqEQslQtMQWQ2Rq6PPDFwpfdX/Pf4WGl8rHXWyfRTDql6w68D0PZB+8goIYBuWfozYkRsiKHm8bsPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ61s5Wh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771083066; x=1802619066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vGIL3BuB/5aamhytd5Q98MRpGYl9sercOliR51UCm+E=;
  b=hZ61s5Whbb0XvZTacLKBuSoYA8f1V9iLArJWorx7Jl53AgJJ/v7AjCQo
   SmCFKz0omRjBGJJo5/F8dor10t+mySMpk6vnNMdGN3/b8bRnyyWn30ZRF
   PC/+bPNuBIEJ7bssFf5XCTsnNesgjyDl6Ul/ctM8CjmSTpNVnYme9fEef
   zk6+y5OVWx501goBAR50KM9iC0Kh9Q8450gWHQ0J9Zi9TmUNgqhC1r+g9
   GBK0IyDVmjUR/5xfafcTK9gjSZE+wYR1G7UPBEoUXC0c2C5iJTUL5ybaF
   V5X/eQ9eZwIhFNKtaBynm1jr8lAqmDuoe9MY9m/rxCEHci6oM7aS0TpT5
   Q==;
X-CSE-ConnectionGUID: 3y9Bf6foSgKKILM71qVEUQ==
X-CSE-MsgGUID: 7/PMnCLZRFOHWs87LgtVhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="72286134"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="72286134"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 07:31:05 -0800
X-CSE-ConnectionGUID: otnivZSvSFemPpJW7tZlGQ==
X-CSE-MsgGUID: ZAleDi4gSgiAFh4LUd8eCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="250855510"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 07:31:05 -0800
Received: from [10.125.109.70] (unknown [10.125.109.70])
	by linux.intel.com (Postfix) with ESMTP id B98B120A8401;
	Sat, 14 Feb 2026 07:31:04 -0800 (PST)
Message-ID: <3cf5e862-b723-492a-8a1e-044e846b62c3@linux.intel.com>
Date: Sat, 14 Feb 2026 07:31:04 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] powercap: intel_rapl: Prepare read_raw interface
 for atomic-context callers
To: Raag Jadav <raag.jadav@intel.com>, sk.anirban@intel.com,
 kamil.konieczny@intel.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20251121000539.386069-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAYHb0kO8eS0Z_5@black.igk.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aZAYHb0kO8eS0Z_5@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-42639-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 5FECD13C53E
X-Rspamd-Action: no action


On 2/13/26 10:37 PM, Raag Jadav wrote:
> On Thu, Nov 20, 2025 at 04:05:38PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> The current read_raw() implementation of the TPMI, MMIO and MSR
>> interfaces does not distinguish between atomic and non-atomic callers.
>>
>> rapl_msr_read_raw() uses rdmsrq_safe_on_cpu(), which can sleep and
>> issue cross CPU calls. When MSR-based RAPL PMU support is enabled, PMU
>> event handlers can invoke this function from atomic context where
>> sleeping or rescheduling is not allowed. In atomic context, the caller
>> is already executing on the target CPU, so a direct rdmsrq() is
>> sufficient.
>>
>> To support such usage, introduce an atomic flag to the read_raw()
>> interface to allow callers pass the context information. Modify the
>> common RAPL code to propagate this flag, and set the flag to reflect
>> the calling contexts.
>>
>> Utilize the atomic flag in rapl_msr_read_raw() to perform direct MSR
>> read with rdmsrq() when running in atomic context, and a sanity check
>> to ensure target CPU matches the current CPU for such use cases.
>>
>> The TPMI and MMIO implementations do not require special atomic
>> handling, so the flag is ignored in those paths.
>>
>> This is a preparatory patch for adding MSR-based RAPL PMU support.
> ...
>
>> -static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
>> +static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool atomic)
>>   {
>> +	/*
>> +	 * When called from atomic-context (eg PMU event handler)
>> +	 * perform MSR read directly using rdmsrq().
>> +	 */
>> +	if (atomic) {
>> +		if (unlikely(smp_processor_id() != cpu))
>> +			return -EIO;
> This series breaks[1] our application[2] in cases where the reads are
> issued from any available CPU it is scheduled on. This issue is not seen on
> older platforms which use the original arch/x86 RAPL implementation.
>
> Can someone please shed some light on the change of userspace expectations?
> Or did I miss any points in the documentation?
>
> [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6935
> [2] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/lib/igt_power.c

The access with non-lead CPUs is fixed by following series:

https://lore.kernel.org/linux-pm/CAJZ5v0gh_3y4+2qepC5Mqos+y+kBfGgeEKdmL5s6J4MBGcrQzw@mail.gmail.com/T/#mabe68b0d5c3e5571c9333ff915d38562ec7fed71

Can you please re-test with this above series?


> Raag
>
>> +		rdmsrq(ra->reg.msr, ra->value);
>> +		goto out;
>> +	}
>> +
>>   	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
>>   		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
>>   		return -EIO;
>>   	}
>> +
>> +out:
>>   	ra->value &= ra->mask;
>>   	return 0;
>>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


