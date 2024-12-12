Return-Path: <linux-pm+bounces-19122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B29EE647
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0472218811A0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27DE211A1E;
	Thu, 12 Dec 2024 12:06:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB41A841D;
	Thu, 12 Dec 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005191; cv=none; b=MKGQIbfE7qJgQpyaWD7tLW8CsoZQQp8YM6R6Uhi3M1MDXQHx5VGzda78Kbj8FTYHV7+n4Ya+Nuh4J8CKQGk+7/eRrx2+oJl3XVDofFjubK3dJXvHZO7BYkKBAZIO47QtyOTIFtjl6J/0Ey2EHJMYWds3Ru+94tkA2aR+Dy/oG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005191; c=relaxed/simple;
	bh=hBlpEh26Bst9cNZHzQZCHocOCXzfhyNIb15FPFX9j/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sj8S4o2p5ibRjs2Wk/kDNZS1KKb/+A+p12jpJFZbN15zo8XG2uovEZjuax3AsqCIkReDrRbU8xcOdmK9fRe9JwBlJsUiKKCTiE4biA21xANCYbdjM2xLFKirD9tnXh5gNMeHBXmV/RYkiNBUw9R+bjcKUi2o3DxA7CkD9zdNKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0330E153B;
	Thu, 12 Dec 2024 04:06:55 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38713F720;
	Thu, 12 Dec 2024 04:06:22 -0800 (PST)
Message-ID: <a383eb2a-7752-4c2c-8792-dda9a05b2a53@arm.com>
Date: Thu, 12 Dec 2024 12:06:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: schedutil: Ignore rate limit when scaling up
 with FIE present
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Beata Michalska <Beata.Michalska@arm.com>, Qais Yousef
 <qyousef@layalina.io>, Pierre Gondois <pierre.gondois@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241212015734.41241-1-sultan@kerneltoast.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 01:57, Sultan Alsawaf wrote:
> From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>

Hi Sultan,
(Adding further CCs that might be interested in this)
Good to see some input here again, if it becomes a regular thing,
which I would welcome, you might want to look into git send-email
or b4 relay, at least in my inbox this series looks strange.
Also no cover letter.

> 
> When schedutil disregards a frequency transition due to the transition rate
> limit, there is no guaranteed deadline as to when the frequency transition
> will actually occur after the rate limit expires. For instance, depending
> on how long a CPU spends in a preempt/IRQs disabled context, a rate-limited
> frequency transition may be delayed indefinitely, until said CPU reaches
> the scheduler again. This also hurts tasks boosted via UCLAMP_MIN.

Realistically this will be the tick at worst for the systems you care about,
I assume.

> 
> For frequency transitions _down_, this only poses a theoretical loss of
> energy savings since a CPU may remain at a higher frequency than necessary
> for an indefinite period beyond the rate limit expiry.

theoretical?

> 
> For frequency transitions _up_, however, this poses a significant hit to
> performance when a CPU is stuck at an insufficient frequency for an
> indefinitely long time. In latency-sensitive and bursty workloads
> especially, a missed frequency transition up can result in a significant
> performance loss due to a CPU operating at an insufficient frequency for
> too long.

The term significant implies you have some numbers, please go ahead and
share them then.

I'm not sure if you're aware of Qais' series that also intends to ignore the
rate-limit (in certain cases).
https://lore.kernel.org/lkml/20240728184551.42133-1-qyousef@layalina.io/
I would mostly agree with your below argument regarding FIE and did lean
towards dropping it altogether. The main issue I had with Qais' series
was !fast_switch platforms and the resulting preemption by the DL task
(Often on a remote, possibly idle CPU of the same perf-domain).
Unlimited frequency updates can really hurt both power and throughput there.

Fortunately given the low-pass filter nature of PELT, without some special
workloads, most calls to cpufreq_update_util() are dropped because there
is no resulting frequency change anyway.

You keeping the rate-limit when reducing the frequency might be enough to
work around the issue though. I will run some experiments like I did for
Qais' series.

I'll also go and check for unintended changes in iowait boost (that
interacts with the rate-limit too).

> 
> When support for the Frequency Invariant Engine (FIE) _isn't_ present, a
> rate limit is always required for the scheduler to compute CPU utilization
> with some semblance of accuracy: any frequency transition that occurs
> before the previous transition latches would result in the scheduler not
> knowing the frequency a CPU is actually operating at, thereby trashing the
> computed CPU utilization.
> 
> However, when FIE support _is_ present, there's no technical requirement to
> rate limit all frequency transitions to a cpufreq driver's reported
> transition latency. With FIE, the scheduler's CPU utilization tracking is
> unaffected by any frequency transitions that occur before the previous
> frequency is latched.
> 
> Therefore, ignore the frequency transition rate limit when scaling up on
> systems where FIE is present. This guarantees that transitions to a higher
> frequency cannot be indefinitely delayed, since they simply cannot be
> delayed at all.
> 
> Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 35 +++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e51d5ce730be..563baab89a24 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -59,10 +59,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_rate_limit(struct sugov_policy *sg_policy, u64 time)
>  {
> -	s64 delta_ns;
> +	s64 delta_ns = time - sg_policy->last_freq_update_time;
> +
> +	return delta_ns < sg_policy->freq_update_delay_ns;
> +}
>  
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +{
>  	/*
>  	 * Since cpufreq_update_util() is called with rq->lock held for
>  	 * the @target_cpu, our per-CPU data is fully serialized.
> @@ -87,17 +92,37 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  		return true;
>  	}
>  
> -	delta_ns = time - sg_policy->last_freq_update_time;
> +	/*
> +	 * When frequency-invariant utilization tracking is present, there's no
> +	 * rate limit when increasing frequency. Therefore, the next frequency
> +	 * must be determined before a decision can be made to rate limit the
> +	 * frequency change, hence the rate limit check is bypassed here.
> +	 */
> +	if (arch_scale_freq_invariant())
> +		return true;
>  
> -	return delta_ns >= sg_policy->freq_update_delay_ns;
> +	return !sugov_should_rate_limit(sg_policy, time);
>  }
>  
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> +	/*
> +	 * When a frequency update isn't mandatory (!need_freq_update), the rate
> +	 * limit is checked again upon frequency reduction because systems with
> +	 * frequency-invariant utilization bypass the rate limit check entirely
> +	 * in sugov_should_update_freq(). This is done so that the rate limit
> +	 * can be applied only for frequency reduction when frequency-invariant
> +	 * utilization is present. Now that the next frequency is known, the
> +	 * rate limit can be selectively applied to frequency reduction on such
> +	 * systems. A check for arch_scale_freq_invariant() is omitted here
> +	 * because unconditionally rechecking the rate limit is cheaper.
> +	 */
>  	if (sg_policy->need_freq_update)
>  		sg_policy->need_freq_update = false;
> -	else if (sg_policy->next_freq == next_freq)
> +	else if (next_freq == sg_policy->next_freq ||
> +		 (next_freq < sg_policy->next_freq &&
> +		  sugov_should_rate_limit(sg_policy, time)))
>  		return false;
>  
>  	sg_policy->next_freq = next_freq;

Code seems to match your description FWIW.
Maybe the comments could be trimmed somewhat.

Regards,
Christian

