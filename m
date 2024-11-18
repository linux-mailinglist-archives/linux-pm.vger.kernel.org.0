Return-Path: <linux-pm+bounces-17694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36059D0C9C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8422814F9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84618E03A;
	Mon, 18 Nov 2024 09:52:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334517C98;
	Mon, 18 Nov 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923543; cv=none; b=logkfrUbAeKOc/vEdapdIpSKnkoeKiUIS7UFWRxbLatUl0cJzE5TFWWnbRX9SWCXVi8yAv0aYEtUSSMwipzknSe9ne02Tlrdf8IyCjuFq22Yyqyo4V1RHmE8zKIYfOeL+wAuuz9HzsAnJjuhT48aJsex2kKMr58oXQ18bLaME2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923543; c=relaxed/simple;
	bh=nTqKUs0rjZ0pPtnSJnjBvOshyGK89aQ9Ln3VXHzAYe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMqEZO5tdtaIjLSnZat1zMZRRdbXBg1qiQj/g9/gBf6w7c4eHzl5Fr1gSHfWlBwO9W5KSfjdAk5wrgo05XE05zmOjpT/r8e0XP0c86pFFXuYlnoBYRu8DLnNWUN8MuqToIOVi/mJrpYJpFmJhhUbNNBwQCV0NPzpYOr83CKMiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0C21682;
	Mon, 18 Nov 2024 01:52:49 -0800 (PST)
Received: from [10.1.31.25] (e127648.arm.com [10.1.31.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D7D3F5A1;
	Mon, 18 Nov 2024 01:52:14 -0800 (PST)
Message-ID: <2df83343-2198-4193-8452-f6a27585b999@arm.com>
Date: Mon, 18 Nov 2024 09:52:12 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>,
 Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-6-saravanak@google.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241114220921.2529905-6-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 22:09, Saravana Kannan wrote:
> As of today, the scheduler doesn't spread out all the kworker threads
> across all the available CPUs during suspend/resume. This causes
> significant resume latency during the dpm_resume*() phases.
> 
> System resume latency is a very user-visible event. Reducing the
> latency is more important than trying to be energy aware during that
> period.
> 
> Since there are no userspace processes running during this time and
> this is a very short time window, we can simply disable EAS during
> resume so that the parallel resume of the devices is spread across all
> the CPUs.
> 
> On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> plus disabling EAS for resume yields significant improvements:
> +---------------------------+-----------+------------+------------------+
> | Phase			    | Old full sync | New full async | % change |
> |			    |		    | + EAS disabled |		|
> +---------------------------+-----------+------------+------------------+
> | Total dpm_suspend*() time |        107 ms |          62 ms |     -42% |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_resume*() time  |         75 ms |          61 ms |     -19% |
> +---------------------------+-----------+------------+------------------+
> | Sum			    |        182 ms |         123 ms |     -32% |
> +---------------------------+-----------+------------+------------------+
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  kernel/power/suspend.c  | 16 ++++++++++++++++
>  kernel/sched/topology.c | 13 +++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..7304dc39958f 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
>  	local_irq_enable();
>  }
>  
> +/*
> + * Intentionally not part of a header file to avoid risk of abuse by other
> + * drivers.
> + */
> +void sched_set_energy_aware(unsigned int enable);
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
>  
>   Platform_wake:
>  	platform_resume_noirq(state);
> +	/*
> +	 * We do this only for resume instead of suspend and resume for these
> +	 * reasons:
> +	 * - Performance is more important than power for resume.
> +	 * - Power spent entering suspend is more important for suspend. Also,
> +	 *   stangely, disabling EAS was making suspent a few milliseconds
> +	 *   slower in my testing.

s/stangely/strangely
s/suspent/suspend
I'd also be curious why that is. Disabling EAS shouldn't be that expensive.
What if you just hack the static branch switch (without the sd rebuild)?

> +	 */
> +	sched_set_energy_aware(0);
>  	dpm_resume_noirq(PMSG_RESUME);
>  
>   Platform_early_resume:
> @@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>   Resume_devices:
>  	suspend_test_start();
>  	dpm_resume_end(PMSG_RESUME);
> +	sched_set_energy_aware(1);
>  	suspend_test_finish("resume devices");
>  	trace_suspend_resume(TPS("resume_console"), state, true);
>  	resume_console();
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..c069c0b17cbf 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
>  	mutex_unlock(&sched_energy_mutex);
>  }
>  
> +void sched_set_energy_aware(unsigned int enable)

bool enable?

> +{
> +	int state;
> +
> +	if (!sched_is_eas_possible(cpu_active_mask))
> +		return;
> +
> +	sysctl_sched_energy_aware = enable;
> +	state = static_branch_unlikely(&sched_energy_present);
> +	if (state != sysctl_sched_energy_aware)
> +		rebuild_sched_domains_energy();
> +}
> +

This definitely shouldn't just overwrite
sysctl_sched_energy_aware, otherwise you enable EAS
for users that explicitly disabled it.

If it ever comes to other users wanting this we might
need a eas_pause counter so this can be nested, but
let's just hope that's never needed.

Regards,
Christian


