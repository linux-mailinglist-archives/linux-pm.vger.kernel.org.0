Return-Path: <linux-pm+bounces-41437-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFxRBFJxdml0QwEAu9opvQ
	(envelope-from <linux-pm+bounces-41437-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:38:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4C823DE
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862ED30036FF
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02EB243376;
	Sun, 25 Jan 2026 19:38:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647720DD52;
	Sun, 25 Jan 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369934; cv=none; b=oLXuCRTlhHfUo/VHZT8+dMi23JZwYY+lUttV1kd1N4JNtkm/STFp3ACHWQxltmfl3qiw2ZVqJGVKzsmMsu+5pT/QHCrVYnaNy2aV+zjVsTjVKsbs9nfHkiCp8+X8ogcarICZ1nxyDGQn/9CXQua2D+Nv2mjcalLaa+F6ScGHwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369934; c=relaxed/simple;
	bh=ur0b9alrq7gNeL3e9bOlHL96DFJ3VB+08Vi3FNyHgUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leH+vkgoomaXs7/SRGg/w/+hhd3vbtj00N94ds+iJ4JgL93A05REtxqTwop7Y/aUjJDp82k5zFfGBRJs/IrC0hJnewYggjwZQp4Nm72Am1ihZhImOTuJn6LL90UysV3bga7XVTkOJXATj6QOlvN5uaT2S7DQiWw7hRMR2r4Jrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA4C339;
	Sun, 25 Jan 2026 11:38:38 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2993F3F73F;
	Sun, 25 Jan 2026 11:38:43 -0800 (PST)
Message-ID: <f3d6be2f-d08d-4731-951c-3439deabdd1c@arm.com>
Date: Sun, 25 Jan 2026 19:38:41 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Update][PATCH v1.1 4/5] cpuidle: governors: teo: Adjust the
 classification of wakeup events
To: Doug Smythies <dsmythies@telus.net>,
 "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'LKML' <linux-kernel@vger.kernel.org>,
 'Linux PM' <linux-pm@vger.kernel.org>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
 <4707705.LvFx2qVVIh@rafael.j.wysocki>
 <004301dc8e1e$fa328450$ee978cf0$@telus.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <004301dc8e1e$fa328450$ee978cf0$@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41437-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:mid]
X-Rspamd-Queue-Id: 41F4C823DE
X-Rspamd-Action: no action

On 1/25/26 17:21, Doug Smythies wrote:
> On 2026.01.20 07:30 Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If differences between target residency values of adjacent idle states
>> of a given CPU are relatively large, the corresponding idle state bins
>> used by the teo governors are large either and the rule by which hits
>> are distinguished from intercepts is inaccurate.
>>
>> Namely, by that rule, a wakeup event is classified as a hit if the
>> sleep length (the time till the closest timer other than the tick)
>> and the measured idle duration, adjusted for the entered idle state
>> exit latency, fall into the same idle state bin.  However, if that bin
>> is large enough, the actual difference between the sleep length and
>> the measured idle duration may be significant.  It may in fact be
>> significantly greater than the analogous difference for an event where
>> the sleep length and the measured idle duration fall into different
>> bins.
>>
>> For this reason, amend the rule in question with a check that will
>> only allow a wakeup event to be counted as a hit if the difference
>> between the sleep length and the measured idle duration is less than
>> LATENCY_THRESHOLD_NS (which means that the difference between the
>> sleep length and the raw measured idle duration is below the sum of
>> LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
>> Otherwise, the event will be counted as an intercept.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> v1 -> v1.1
>>   * Drop the change in teo_select() along with the corresponding
>>     part of the changelog (after receiving testing feedback from
>>     Christian)
> 
> With this updated patch I have not observed any difference in testing
> results or power consumption between kernels without or with the
> 5 patch set:
> 
> c66de7fc0157 (HEAD -> rjw-1-1) cpuidle: governors: teo: Adjust the classification of wakeup events
> 25f70be81668 Revert "cpuidle: governors: teo: Adjust the classification of wakeup events"
> f0ae302c4635 cpuidle: governors: teo: Refine intercepts-based idle state lookup
> f5ad355214de cpuidle: governors: teo: Adjust the classification of wakeup events
> 1c5b66c336ea cpuidle: governors: teo: Refine tick_intercepts vs total events check
> 36148eea2ec2 cpuidle: governors: teo: Avoid fake intercepts produced by tick
> 8b1ad7bc8a7f cpuidle: governors: teo: Avoid selecting states with zero-size bins
> 0f61b1860cc3 (tag: v6.19-rc5, origin/master, origin/HEAD, master) Linux 6.19-rc5
> 
> My test system:
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
> HWP: Enabled.
> state0/name:POLL
> state1/name:C1_ACPI
> state2/name:C2_ACPI
> state3/name:C3_ACPI
> 
> @Christian: I noticed that you like "idle misses" in test results. I have added
> percent "idle misses" to my test results. An example graph is attached.

Thanks for the test!
So rjw-1-1 looks pretty much the same on rc5 as well, that's good.
I guess since the v1 of 4/5 change that did have an affect was added by Rafael
to mitigate the more liberal intercept counting, that should be fine then.
Interestingly here (in overall idle_misses) rjw (with 4/5 v1) has significantly
fewer idle_misses, while in state2 aboves it was much worse as per your previous
test results.

> 
> Legend:
> rc5 = kernel 6.19-rc5
> rjw = kernel 6.19-rc5 + original 5 patch set
> rjw-1-1 = kernel 6.19-rc5 + current 5 patch set
> 
> See also my previous email [1] about the original 5 patch set:
> 
> [1] https://lore.kernel.org/linux-pm/003201dc895f$8cfb2540$a6f16fc0$@telus.net/
> 
> ... Doug
> 


