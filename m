Return-Path: <linux-pm+bounces-38533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E0C84066
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048C43B0143
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC272D8DAF;
	Tue, 25 Nov 2025 08:37:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A3D2D7DD9
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059853; cv=none; b=qEe3ut/C83dbF69f692xWqq9KvbSlvrq+sNgh6r3Ai5kJ5qYrNMVYk41cy7ZWSzwYxczmho53BpCwKMNfxwxiZToLuFb8hFXjt33Go+gEh/lhhIQREYgF2WZIg6xILOEWdIpUtyHDvjKkzoOOTBs5qXDJYz5Y5vmbQomJtvVfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059853; c=relaxed/simple;
	bh=w4dNPzREZ+3z3lBmHJj3VFKe/CMNYkzmsRrwm2oQOGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUGFsFM8RW1o6ulrpi9S3APvQs4IzQIoSKhdzmiU+q9spDN4zQVRVDKLfYUsjFogEfP51j66eyySYyl0gmL8Av3uCJpV/42bbHoCr3+PRU2rG7gcgKmaTKdYMfrBYt33yPTZr9m+OD1YSrGYLydNWD9n0hAeRCFFMdcDfqmOWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1C21477;
	Tue, 25 Nov 2025 00:37:22 -0800 (PST)
Received: from [10.57.75.71] (unknown [10.57.75.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E65F3F86F;
	Tue, 25 Nov 2025 00:37:26 -0800 (PST)
Message-ID: <4f5ee76e-1409-4064-b765-3c9aed25cf0e@arm.com>
Date: Tue, 25 Nov 2025 08:37:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-pm@vger.kernel.org, Beata Michalska <Beata.Michalska@arm.com>,
 Ionela Voinescu <Ionela.Voinescu@arm.com>
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 03:24, Kaushlendra Kumar wrote:
> In sugov_next_freq_shared(), the CPU capacity is retrieved only
> for the CPU that triggered the update (sg_cpu->cpu) and then
> incorrectly applied to all CPUs in the shared frequency domain
> during the loop.On heterogeneous systems with CPUs of different
> capacities sharing a frequency domain, this causes incorrect
> frequency selection.

Then this needs a fixes tag?
Maybe even the intel_pstate setup changes? I think the
policy <=> capacity assumption made here was true before that?

> 
> Calculate per-CPU capacity in the loop and track maximum across
> all CPUs for proper frequency calculation.

s/all CPUs/all policy CPUs/ maybe?

> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 0ab5f9d4bc59..9fdbc7a6063d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -492,15 +492,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  {
>  	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>  	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned long util = 0, max_cap;
> +	unsigned long util = 0, max_cap = 0;
>  	unsigned int j;
>  
> -	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
> -
>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> -		unsigned long boost;
> +		unsigned long boost, j_max_cap;
>  
> +		j_max_cap = arch_scale_cpu_capacity(j);

nit: j_max_cap is only used once...

> +		max_cap = max(max_cap, j_max_cap);
>  		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);

I find this a bit strange, you might as well argue that this
sets the wrong frequency with your patch (boost being determined by the
highest frequency seen in this loop so far?)
My understanding was that this "different capacity, same cluster" was just
a technicality and because the capacities are still really close (1-2%?) we
essentially don't care about the difference. Why do we care here/now?

>  		sugov_get_util(j_sg_cpu, boost);
>  

