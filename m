Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F420423B66
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhJFKYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 06:24:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55590 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFKYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 06:24:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633515737; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=MW3nFYrTI99YklII5kEMzaQv4cQ84XOAnQJk6NTuoNA=; b=t4WgDk3UjVMdzC1auPXIe7+TpbvclVU1COpg6+0AJzAwmLhnf6quoAEtYIlZSI2Y5Br79juE
 Ao+zTNri8t38XVkdek9iSf5PytvxIf5z9B0ostQufEdWgYa8L7vg0pZ9FiveRa3060apzvC4
 ijNADwZINJAhUVTg3QhMSZDrXaw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 615d78d87ae92c7fc98a2172 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 10:22:16
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED2F8C43618; Wed,  6 Oct 2021 10:22:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.129] (unknown [49.36.85.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E58F3C4338F;
        Wed,  6 Oct 2021 10:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E58F3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH 1/2] cpuidle: Avoid calls to cpuidle_resume|pause() for
 s2idle
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinivas Rao L <lsrao@codeaurora.org>
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-2-ulf.hansson@linaro.org>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <07e6821c-c221-e90d-c977-4d6b55c1ab8d@codeaurora.org>
Date:   Wed, 6 Oct 2021 15:52:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929144451.113334-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/29/2021 8:14 PM, Ulf Hansson wrote:
> In s2idle_enter(), cpuidle_resume|pause() are invoked to re-allow calls to
> the cpuidle callbacks during s2idle operations. This is needed because
> cpuidle is paused in-between in dpm_suspend_noirq() and dpm_resume_noirq().
> 
> However, calling cpuidle_resume|pause() from s2idle_enter() looks a bit
> superfluous, as it also causes all CPUs to be waken up when the first CPU
> wakes up from s2idle.

Thanks for the patch. This can be good optimization to avoid waking up 
all CPUs always.

> 
> Therefore, let's drop the calls to cpuidle_resume|pause() from
> s2idle_enter(). To make this work, let's also adopt the path in the
> cpuidle_idle_call() to allow cpuidle callbacks to be invoked for s2idle,
> even if cpuidle has been paused.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/cpuidle/cpuidle.c |  7 ++++++-
>   include/linux/cpuidle.h   |  2 ++
>   kernel/power/suspend.c    |  2 --
>   kernel/sched/idle.c       | 40 ++++++++++++++++++++++-----------------
>   4 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ef2ea1b12cd8..c76747e497e7 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -49,7 +49,12 @@ void disable_cpuidle(void)
>   bool cpuidle_not_available(struct cpuidle_driver *drv,
>   			   struct cpuidle_device *dev)
>   {
> -	return off || !initialized || !drv || !dev || !dev->enabled;
> +	return off || !drv || !dev || !dev->enabled;
> +}
> +
> +bool cpuidle_paused(void)
> +{
> +	return !initialized;
>   }
>   
>   /**
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index fce476275e16..51698b385ab5 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -165,6 +165,7 @@ extern void cpuidle_pause_and_lock(void);
>   extern void cpuidle_resume_and_unlock(void);
>   extern void cpuidle_pause(void);
>   extern void cpuidle_resume(void);
> +extern bool cpuidle_paused(void);
>   extern int cpuidle_enable_device(struct cpuidle_device *dev);
>   extern void cpuidle_disable_device(struct cpuidle_device *dev);
>   extern int cpuidle_play_dead(void);
> @@ -204,6 +205,7 @@ static inline void cpuidle_pause_and_lock(void) { }
>   static inline void cpuidle_resume_and_unlock(void) { }
>   static inline void cpuidle_pause(void) { }
>   static inline void cpuidle_resume(void) { }
> +static inline bool cpuidle_paused(void) {return true; }
>   static inline int cpuidle_enable_device(struct cpuidle_device *dev)
>   {return -ENODEV; }
>   static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index eb75f394a059..388a5de4836e 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -97,7 +97,6 @@ static void s2idle_enter(void)
>   	raw_spin_unlock_irq(&s2idle_lock);
>   
>   	cpus_read_lock();
> -	cpuidle_resume();
>   
>   	/* Push all the CPUs into the idle loop. */
>   	wake_up_all_idle_cpus();

wake_up_all_idle_cpus() will still cause all CPUs to be woken up when 
first cpu wakes up.

say for example,
1. device goes to s2idle suspend.
2. one CPU wakes up to handle irq (irq is not a wake irq but left 
enabled at GIC because of IRQF_NOSUSPEND flag) so such irq will not 
break suspend.
3. The cpu handles the irq.
4. same cpu don't break s2idle_loop() and goes to s2idle_enter() where 
it wakes up all existing idle cpus due to wake_up_all_idle_cpus()
5. all of CPUs again enter s2idle.

to avoid waking up all CPUs in above case, something like below snip may 
help (i have not tested yet),

when CPUs are in s2idle_loop(),

1. set the s2idle state to enter.
2. wake up all cpus from shallow state, so that they can re-enter 
deepest state.
3. Forever loop until a break with some wake irq.
4. clear the s2idle state.
5. wake up all cpus from deepest state so that they can now stay in 
shallow state/running state.

void s2idle_loop(void)
{

+       s2idle_state = S2IDLE_STATE_ENTER;
+       /* Push all the CPUs to enter deepest available state */
+       wake_up_all_idle_cpus();
         for (;;) {
                 if (s2idle_ops && s2idle_ops->wake) {
                         if (s2idle_ops->wake())
				..
                 s2idle_enter();
         }
+       s2idle_state = S2IDLE_STATE_NONE;
+       /* Push all the CPUs to enter default_idle() from this point */
+       wake_up_all_idle_cpus();
}

Thanks,
Maulik


> @@ -105,7 +104,6 @@ static void s2idle_enter(void)
>   	swait_event_exclusive(s2idle_wait_head,
>   		    s2idle_state == S2IDLE_STATE_WAKE);
>   
> -	cpuidle_pause();
>   	cpus_read_unlock();
>   
>   	raw_spin_lock_irq(&s2idle_lock);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index d17b0a5ce6ac..3bc3a2c46731 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -158,6 +158,17 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>   	return cpuidle_enter(drv, dev, next_state);
>   }
>   
> +static void cpuidle_deepest_state(struct cpuidle_driver *drv,
> +				  struct cpuidle_device *dev,
> +				  u64 max_latency_ns)
> +{
> +	int next_state;
> +
> +	tick_nohz_idle_stop_tick();
> +	next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> +	call_cpuidle(drv, dev, next_state);
> +}
> +
>   /**
>    * cpuidle_idle_call - the main idle function
>    *
> @@ -189,6 +200,7 @@ static void cpuidle_idle_call(void)
>   	 */
>   
>   	if (cpuidle_not_available(drv, dev)) {
> +default_idle:
>   		tick_nohz_idle_stop_tick();
>   
>   		default_idle_call();
> @@ -204,25 +216,19 @@ static void cpuidle_idle_call(void)
>   	 * timekeeping to prevent timer interrupts from kicking us out of idle
>   	 * until a proper wakeup interrupt happens.
>   	 */
> +	if (idle_should_enter_s2idle()) {
> +		entered_state = call_cpuidle_s2idle(drv, dev);
> +                if (entered_state <= 0)
> +			cpuidle_deepest_state(drv, dev, U64_MAX);
> +		goto exit_idle;
> +	}
>   
> -	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
> -		u64 max_latency_ns;
> -
> -		if (idle_should_enter_s2idle()) {
> -
> -			entered_state = call_cpuidle_s2idle(drv, dev);
> -			if (entered_state > 0)
> -				goto exit_idle;
> -
> -			max_latency_ns = U64_MAX;
> -		} else {
> -			max_latency_ns = dev->forced_idle_latency_limit_ns;
> -		}
> -
> -		tick_nohz_idle_stop_tick();
> +	if (cpuidle_paused())
> +		goto default_idle;
>   
> -		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> -		call_cpuidle(drv, dev, next_state);
> +	if (dev->forced_idle_latency_limit_ns) {
> +		cpuidle_deepest_state(drv, dev,
> +				      dev->forced_idle_latency_limit_ns);
>   	} else {
>   		bool stop_tick = true;
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
