Return-Path: <linux-pm+bounces-38537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A86C84206
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E04E6F70
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBF2FE05B;
	Tue, 25 Nov 2025 09:03:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197782FE075
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061427; cv=none; b=g6+QprK8NK2pcsizmp8+WJXBoC3sNC9QSQxHiP1RifGRw1jJ+WOVEFnEFBcz4OMxxCgQy9dwO+mD8tAXagL2d6VObx6fgdurU62dsZcS1I/0p7K6s+LMXdnHhYqddYCZBCbkc4lLGMIPMcGPNtwR1J85La/lKdYIxMHD0sNH6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061427; c=relaxed/simple;
	bh=Vj7NW6lihrGqiDwObGb7TUl3WohCMVwL3aqwpIq4YKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzNBA5+cht52VmqnSm5DZGJNTC6aM0oOzji3ZE1fAQk+n0rNa4v4WCaXvJlx5rkU3Tp8oaSSb0SNro17iLbPAGo6o7A9cDZ+UY4snuRpPmlGo7E81DEaWgyt2QaT3RCQYyZJhfswiP/c4NUhSPKo2iCXA5JLiZgCqEI5zzn+354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0CF51477;
	Tue, 25 Nov 2025 01:03:36 -0800 (PST)
Received: from [10.57.40.104] (unknown [10.57.40.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157A83F66E;
	Tue, 25 Nov 2025 01:03:41 -0800 (PST)
Message-ID: <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com>
Date: Tue, 25 Nov 2025 09:04:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, vschneid@redhat.com,
 mgorman@suse.de, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 peterz@infradead.org, viresh.kumar@linaro.org, mingo@redhat.com,
 vincent.guittot@linaro.org, bsegall@google.com
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kaushlendra,

On 11/25/25 03:24, Kaushlendra Kumar wrote:
> In sugov_next_freq_shared(), the CPU capacity is retrieved only
> for the CPU that triggered the update (sg_cpu->cpu) and then
> incorrectly applied to all CPUs in the shared frequency domain
> during the loop.On heterogeneous systems with CPUs of different
> capacities sharing a frequency domain, this causes incorrect
> frequency selection.

How is this possible?
Is it old or new Intel SoC (a chip name would be also welcome)?

I would like to hear Rafael's view on such platform configuration.

It looks like a hack and the next needed step would be a similar
hack to calm down EAS and EM in the energy estimation code...

Do we really want to support such configuration in the generic code?

> 
> Calculate per-CPU capacity in the loop and track maximum across
> all CPUs for proper frequency calculation.

I've changed that loop to speed-up the hot code path triggered
from the scheduler. For most platforms (till now) it's fine
to get the cpu capacity once for all cpus in the policy.
A lot of code is based on this assumption.

> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   kernel/sched/cpufreq_schedutil.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 0ab5f9d4bc59..9fdbc7a6063d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -492,15 +492,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>   {
>   	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>   	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned long util = 0, max_cap;
> +	unsigned long util = 0, max_cap = 0;
>   	unsigned int j;
>   
> -	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
> -
>   	for_each_cpu(j, policy->cpus) {
>   		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> -		unsigned long boost;
> +		unsigned long boost, j_max_cap;
>   
> +		j_max_cap = arch_scale_cpu_capacity(j);
> +		max_cap = max(max_cap, j_max_cap);
>   		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
>   		sugov_get_util(j_sg_cpu, boost);
>   

My gut feeling tells me that it won't be the last needed code change
if we go that path...

Regards,
Lukasz

