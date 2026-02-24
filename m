Return-Path: <linux-pm+bounces-43075-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB6dE3MCnWnhMQQAu9opvQ
	(envelope-from <linux-pm+bounces-43075-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:44:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC4180A0F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 085693112B07
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E989234966;
	Tue, 24 Feb 2026 01:42:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6761C3BF7;
	Tue, 24 Feb 2026 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897352; cv=none; b=PGp4yuom6MZ7YT64Ygiy5yMHKnIpmZgRpCvriWC6T0ujxlOgAxvOthSxPm1WPBM44RZyVSFo59R8v/WUzLs4ekrPjmaqHgcYJ06aSR/Ethl7t15IS55sSo6Qj3L655IfVukYUf1veJVOoH1YImEs2vMZSLn+u/Zltg71lVxdlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897352; c=relaxed/simple;
	bh=nJjYYyOiKPJyY7kGgwygL7hZYm43Ic22siXrJEEdDtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S8vFMyePUbLc+qdR6MISuibfaGmS197Jpi46YrLURTRCkqIpCjOzJ8dfQzHJo3Cx+qVOPCI8y24oJXiSZtiSiX3gcnQ54hmX2hTIawfHbHFJPgHKvZ98tl9c06SORydumAqdj8U+TCuBAcpbD78563ktaXrwwbNKKGS37LVxVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fKgM36y9yzcbMR;
	Tue, 24 Feb 2026 09:37:19 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DFE740567;
	Tue, 24 Feb 2026 09:42:18 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 09:42:17 +0800
Message-ID: <b4c98160-e6b4-44a5-9396-0acc8334a39c@hisilicon.com>
Date: Tue, 24 Feb 2026 09:42:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
To: Sumit Gupta <sumitg@nvidia.com>, Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <zhenglifeng1@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>, <beata.michalska@arm.com>,
	<pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>
References: <20260127080700.3565546-1-sumitg@nvidia.com>
 <3c6d58b2-b4c9-4dc7-a705-b7626e127f33@hisilicon.com>
 <aXoJUYDrhuJgkXEr@willie-the-truck> <aZyciAy8zCvrvGB7@willie-the-truck>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <aZyciAy8zCvrvGB7@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjie9@hisilicon.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43075-lists,linux-pm=lfdr.de];
	NEURAL_HAM(-0.00)[-0.976];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hisilicon.com:mid,hisilicon.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: D8CC4180A0F
X-Rspamd-Action: no action



On 2/24/2026 2:29 AM, Will Deacon wrote:
> On Wed, Jan 28, 2026 at 01:04:17PM +0000, Will Deacon wrote:
>> On Wed, Jan 28, 2026 at 06:50:42PM +0800, Jie Zhan wrote:
>>> On 1/27/2026 4:07 PM, Sumit Gupta wrote:
>>>> The counters_read_on_cpu() function warns when called with IRQs disabled
>>>> to prevent deadlock in smp_call_function_single(). However, this warning
>>>> is spurious when reading counters on the current CPU since no IPI is
>>>> needed for same-CPU reads.
>>>>
>>>> Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks
>>>> for non-PCC regs") changed the CPPC Frequency Invariance Engine to read
>>>> AMU counters directly from the scheduler tick for non-PCC register
>>>> spaces (like FFH), instead of deferring to a kthread. This means
>>>> counters_read_on_cpu() is now called with IRQs disabled from the tick
>>>> handler, triggering the warning:
>>>>
>>>> | WARNING: arch/arm64/kernel/topology.c:410 at counters_read_on_cpu
>>>> | ...
>>>> | Call trace:
>>>> |  counters_read_on_cpu+0x88/0xa8 (P)
>>>> |  cpc_read_ffh+0xdc/0x148
>>>> |  cpc_read+0x260/0x518
>>>> |  cppc_get_perf_ctrs+0xf0/0x398
>>>> |  __cppc_scale_freq_tick+0x4c/0x148 [cppc_cpufreq]
>>>> |  cppc_scale_freq_tick+0x44/0x88 [cppc_cpufreq]
>>>> |  topology_scale_freq_tick+0x34/0x58
>>>> |  sched_tick+0x58/0x300
>>>> |  update_process_times+0xcc/0x120
>>>> |  tick_nohz_handler+0xa8/0x260
>>>> |  __hrtimer_run_queues+0x154/0x360
>>>> |  hrtimer_interrupt+0xf4/0x2b0
>>>> |  arch_timer_handler_phys+0x4c/0x78
>>>> |  ....
>>>> |  CPPC Cpufreq:__cppc_scale_freq_tick: failed to read perf counters
>>>> |  ....
>>>>
>>>> Fix this by calling the counter read function directly for same-CPU
>>>> case, bypassing smp_call_function_single() entirely. Use get_cpu() to
>>>> disable preemption as the counter read functions call this_cpu_has_cap()
>>>> which requires a non-preemptible context.
>>>>
>>>> Fixes: 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>
>>> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
>>>
>>> Looks fine for me except for the minor comment wrapping.
>>>
>>> Thanks for spotting this.
>>> I may have missed the warning log in the FFH test.
>>>
>>> This happens during the short window in cpufreq_policy_online() between
>>> driver->init() and the CREATE_POLICY notifier that gets AMU FIE ready.
>>> After that, CPPC FIE will be stopped.
>>>
>>> Ideally this can be merged together with Viresh's PR since the CPPC FIE
>>> changes are there.
>>> https://lore.kernel.org/all/j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p/
>>
>> Right, looks like this should go via Rafael but if it doesn't make the merge
>> window then I can pick it up at -rc1 (please remind me :)
> 
> Looks like this fix is still needed. Please can you post a new version,
> based on -rc1, so that I can pick it up?
> 
> You'll also need to fix the SHA in the commit message and the Fixes: tag,
> as 12eb8f4fff24 doesn't match the upstream change.
> 
> Will
> 
I believe this goes to Sumit because he's the author.

Sumit, can you update this patch?

Jie

