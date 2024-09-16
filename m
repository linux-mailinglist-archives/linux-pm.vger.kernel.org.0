Return-Path: <linux-pm+bounces-14350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F897A927
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 00:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC5284F5B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED5165EE9;
	Mon, 16 Sep 2024 22:22:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27975258;
	Mon, 16 Sep 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525356; cv=none; b=g004wUCaTD4ChD6y8o/YfpZey/gMysSeTj5sAcbfluKmpikTDCcc0Ghkxl5L5go2Ebw5yHdkvzIBZu7KsXSGx4HzVvffPmWdreg1czWlbgx/w0r4WuJsVvnBpDo/s8weDzPDAWfjZBmGS6371JPsMByfilEnSR5ZXM38kImmKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525356; c=relaxed/simple;
	bh=auBgNEBcAMKWNFC3hweH8p3LS9IGL2A17duVFRN5WYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqtAenLkBUwk3XZQ+7qzvD8pDkceplN6CfteUO66XEwn0oMw877H8qbW7FAf54OoReBN0j/RXscr/0kWpi84aHYFw/EtYig0ZG/yyfaHcUMGSdL9r52BHPm2gFTNnRp2syeG27QZBQyMuxn6+VJg76DumxeGNK4zwq/ePN9+X8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F6F81063;
	Mon, 16 Sep 2024 15:23:01 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463D23F71A;
	Mon, 16 Sep 2024 15:22:29 -0700 (PDT)
Message-ID: <c55339cd-85d6-4777-beec-41c4d9931b9a@arm.com>
Date: Tue, 17 Sep 2024 00:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/16] sched/schedutil: Add a new tunable to dictate
 response time
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-7-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240820163512.1096301-7-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 18:35, Qais Yousef wrote:
> The new tunable, response_time_ms,  allow us to speed up or slow down
> the response time of the policy to meet the perf, power and thermal
> characteristic desired by the user/sysadmin. There's no single universal
> trade-off that we can apply for all systems even if they use the same
> SoC. The form factor of the system, the dominant use case, and in case
> of battery powered systems, the size of the battery and presence or
> absence of active cooling can play a big role on what would be best to
> use.
> 
> The new tunable provides sensible defaults, but yet gives the power to
> control the response time to the user/sysadmin, if they wish to.
> 
> This tunable is applied before we apply the DVFS headroom.
> 
> The default behavior of applying 1.25 headroom can be re-instated easily
> now. But we continue to keep the min required headroom to overcome
> hardware limitation in its speed to change DVFS. And any additional
> headroom to speed things up must be applied by userspace to match their
> expectation for best perf/watt as it dictates a type of policy that will
> be better for some systems, but worse for others.
> 
> There's a whitespace clean up included in sugov_start().
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst |  17 +++-
>  drivers/cpufreq/cpufreq.c                |   4 +-
>  include/linux/cpufreq.h                  |   3 +
>  kernel/sched/cpufreq_schedutil.c         | 115 ++++++++++++++++++++++-
>  4 files changed, 132 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 6adb7988e0eb..fa0d602a920e 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -417,7 +417,7 @@ is passed by the scheduler to the governor callback which causes the frequency
>  to go up to the allowed maximum immediately and then draw back to the value
>  returned by the above formula over time.
>  
> -This governor exposes only one tunable:
> +This governor exposes two tunables:
>  
>  ``rate_limit_us``
>  	Minimum time (in microseconds) that has to pass between two consecutive
> @@ -427,6 +427,21 @@ This governor exposes only one tunable:
>  	The purpose of this tunable is to reduce the scheduler context overhead
>  	of the governor which might be excessive without it.
>  
> +``respone_time_ms``
> +	Amount of time (in milliseconds) required to ramp the policy from
> +	lowest to highest frequency. Can be decreased to speed up the
                  ^^^^^^^^^^^^^^^^^

This has changed IMHO. Should be the time from lowest (or better 0) to
second highest frequency.

https://lkml.kernel.org/r/20230827233203.1315953-6-qyousef@layalina.io

[...]

> @@ -59,6 +63,70 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> +static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
> +{
> +	int cpu = cpumask_first(sg_policy->policy->cpus);
> +	unsigned long cap = arch_scale_cpu_capacity(cpu);
> +	unsigned int max_freq, sec_max_freq;
> +
> +	max_freq = sg_policy->policy->cpuinfo.max_freq;
> +	sec_max_freq = __resolve_freq(sg_policy->policy,
> +				      max_freq - 1,
> +				      CPUFREQ_RELATION_H);
> +
> +	/*
> +	 * We will request max_freq as soon as util crosses the capacity at
> +	 * second highest frequency. So effectively our response time is the
> +	 * util at which we cross the cap@2nd_highest_freq.
> +	 */
> +	cap = sec_max_freq * cap / max_freq;
> +
> +	return approximate_runtime(cap + 1);
> +}

Still uses the CPU capacity value based on dt-entry

  capacity-dmips-mhz = <578> (CPU0 on juno-r0)
                        ^^^

i.e. frequency invariance is not considered.

[    1.943356] CPU0 max_freq=850000 sec_max_freq=775000 cap=578 cap_at_sec_max_opp=527 runtime=34
                                                        ^^^^^^^    
[    1.957593] CPU1 max_freq=1100000 sec_max_freq=950000 cap=1024 cap_at_sec_max_opp=884 runtime=92


# cat /sys/devices/system/cpu/cpu*/cpu_capacity
446
^^^
1024
1024
446
446
446

[...]

