Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2758D61CA1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 11:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfGHJ5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 05:57:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45773 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfGHJ5i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 05:57:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so16297555wre.12
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Z4Zy/yy02cZ7cfJACkDZqkVyEHIaNLqNuc6/9m0tSI=;
        b=tFJ0VobaM+UNZpxALtrmNPxbgcpFx2gTrjXvCWRahSKmjR7aTX030mv5jiRocwLX2M
         sP9feDxTwjpAprwLEFM9RdBNfheJ0CNJC/yLEKvmXy8MgdocdOLEiM9ETxur0lnJZtKe
         P4QAlwfnDlA5msNKnPwdWinQ6OW0Hizjxhjtv9ofvoM3PhBiCTFMaLcQT/JsE9WWeGLy
         eCfvWtTt9wT9atfL6KVrxMmRJNwXFGJF+56y87RjvlZjmtK8Fe0p4NGkAdFmOlyDub18
         zAnWRu/M1SbXxz1shtmdXVbPSbaY5B0Y6PSWUaCR9nbKYAtdqrPHJx4NPJbGm8ZT331h
         tpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Z4Zy/yy02cZ7cfJACkDZqkVyEHIaNLqNuc6/9m0tSI=;
        b=raoOpV1gX3rKTIO+icmEBt4NDoSnQy+7ggv+FRO7U3boX9S7wzpLsTQem13t4qW0jL
         044E9RdoqOrql/J0z9lYD0HWB03rxlxtN8DSwRiZF6GrYhZ/z644MHOsbGHeCbIcdiMT
         fs93IlkoZhhiK6IinT4RV5UAQCvOyXpX1ImgBOxsAWq65w20/lIaTI7kVMtLBBXOH4Lx
         z3F5J2If4XydrOPaPjn5BjaMJmnTJsuwuv/CQ1Ow7w14eL6+1rXPRjlKn3vMKKEnrQXA
         CsRIG4DMwYH4UGEpaTYlLLphKF6QdMXo5LlGTFLB4U76U2w1xqJskHzKbshJuaoA71Iy
         Iw1g==
X-Gm-Message-State: APjAAAUSMJ+VINNd+oBbceTaCgknTQK7JigxayD1T2DhJiDdXkY+IdGT
        JOEK9hGVV/A7uwBE/D1eI/7SNjHceXw=
X-Google-Smtp-Source: APXvYqw+xGBPi0xCfYcgQxKoRpx7fbiGuWxSoVUBrcUHBt3ypH6eQkFAwku700C8Z904WLMseVa4Rw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr18780740wrm.235.1562579853798;
        Mon, 08 Jul 2019 02:57:33 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 91sm17913409wrp.3.2019.07.08.02.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 02:57:33 -0700 (PDT)
Subject: Re: [PATCH] cpuidle/drivers/mobile: Add new governor for
 mobile/embedded systems
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org>
 <8334994.XHaO1tGd4f@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6dd366d4-5625-254b-1933-17520d68aa79@linaro.org>
Date:   Mon, 8 Jul 2019 11:57:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8334994.XHaO1tGd4f@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

On 04/07/2019 12:14, Rafael J. Wysocki wrote:
> On Thursday, June 20, 2019 1:58:08 PM CEST Daniel Lezcano wrote:
>> The objective is the same for all the governors: save energy, but at
>> the end the governors menu, ladder and teo aim to improve the
>> performances with an acceptable energy drop for some workloads which
>> are identified for servers and desktops (with the help of a firmware).
>>
>> The ladder governor is designed for server with a periodic tick
>> configuration.
>>
>> The menu governor does not behave nicely with the mobile platform and
>> the energy saving for the multimedia workloads is worst than picking
>> up randomly an idle state.
>>
>> The teo governor acts efficiently, it promotes shallower state for
>> performances which is perfect for the servers / desktop but inadequate
>> for mobile because the energy consumed is too high.
>>
>> It is very difficult to do changes in these governors for embedded
>> systems without impacting performances on servers/desktops or ruin the
>> optimizations for the workloads on these platforms.
>>
>> The mobile governor is a new governor targeting embedded systems
>> running on battery where the energy saving has a higher priority than
>> servers or desktops. This governor aims to save energy as much as
>> possible but with a performance degradation tolerance.
>>
>> In this way, we can optimize the governor for specific mobile workload
>> and more generally embedded systems without impacting other platforms.
>>
>> The mobile governor is built on top of the paradigm 'separate the wake
>> up sources signals and analyze them'. Three categories of wake up
>> signals are identified:
>>  - deterministic : timers
>>  - predictable : most of the devices interrupt
>>  - unpredictable : IPI rescheduling, random signals
>>
>> The latter needs an iterative approach and the help of the scheduler
>> to give more input to the governor.
>>
>> The governor uses the irq timings where we predict the next interrupt
>> occurrences on the current CPU and the next timer. It is well suited
>> for mobile and more generally embedded systems where the interrupts
>> are usually pinned on one CPU and where the power is more important
>> than the performances.
>>
>> The multimedia applications on the embedded system spawn multiple
>> threads which are migrated across the different CPUs and waking
>> between them up. In order to catch this situation we have also to
>> track the idle task rescheduling duration with a relative degree of
>> confidence as the scheduler is involved in the task migrations. The
>> resched information is in the scope of the governor via the reflect
>> callback.
>>
>> The governor begins with a clean foundation basing the prediction on
>> the irq behavior returned by the irq timings, the timers and the idle
>> task rescheduling. The advantage of the approach is we have a full
>> view of the wakeup sources as we identify them separately and then we
>> can control the situation without relying on biased heuristics.
>>
>> This first iteration provides a basic prediction but improves on some
>> mobile platforms better energy for better performance for multimedia
>> workloads.
>>
>> The scheduling aspect will be optimized iteratively with non
>> regression testing for previous identified workloads on an Android
>> reference platform.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Note that there are build issues reported by 0-day that need to be fixed.
> Also, IMO this really should be documented better in the tree, not just in the changelog.
> At least the use case to be covered by this governor should be clearly documented and
> it would be good to describe the algorithm.

Ok, I will add some documentation.

>> ---
>>  drivers/cpuidle/Kconfig            |  11 ++-
>>  drivers/cpuidle/governors/Makefile |   1 +
>>  drivers/cpuidle/governors/mobile.c | 151 +++++++++++++++++++++++++++++
>>  3 files changed, 162 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/cpuidle/governors/mobile.c
>>
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index a4ac31e4a58c..e2376d85e288 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -5,7 +5,7 @@ config CPU_IDLE
>>  	bool "CPU idle PM support"
>>  	default y if ACPI || PPC_PSERIES
>>  	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
>> -	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO
>> +	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO && !CPU_IDLE_GOV_MOBILE
>>  	help
>>  	  CPU idle is a generic framework for supporting software-controlled
>>  	  idle processor power management.  It includes modular cross-platform
>> @@ -33,6 +33,15 @@ config CPU_IDLE_GOV_TEO
>>  	  Some workloads benefit from using it and it generally should be safe
>>  	  to use.  Say Y here if you are not happy with the alternatives.
>>  
>> +config CPU_IDLE_GOV_MOBILE
>> +	bool "Mobile governor"
>> +	select IRQ_TIMINGS
>> +	help
>> +	  The mobile governor is based on irq timings measurements and
>> +	  pattern research combined with the next timer. This governor
>> +	  suits very well on embedded systems where the interrupts are
>> +	  grouped on a single core and the power is the priority.
>> +
>>  config DT_IDLE_STATES
>>  	bool
>>  
>> diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
>> index 42f44cc610dd..f09da7178670 100644
>> --- a/drivers/cpuidle/governors/Makefile
>> +++ b/drivers/cpuidle/governors/Makefile
>> @@ -6,3 +6,4 @@
>>  obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
>>  obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
>>  obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
>> +obj-$(CONFIG_CPU_IDLE_GOV_MOBILE) += mobile.o
>> diff --git a/drivers/cpuidle/governors/mobile.c b/drivers/cpuidle/governors/mobile.c
>> new file mode 100644
>> index 000000000000..8fda0f9b960b
>> --- /dev/null
>> +++ b/drivers/cpuidle/governors/mobile.c
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019, Linaro Ltd
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + */
>> +#include <linux/cpuidle.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/tick.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/sched/clock.h>
>> +
>> +struct mobile_device {
>> +	u64 idle_ema_avg;
>> +	u64 idle_total;
>> +	unsigned long last_jiffies;
>> +};
>> +
>> +#define EMA_ALPHA_VAL		64
>> +#define EMA_ALPHA_SHIFT		7
>> +#define MAX_RESCHED_INTERVAL_MS	100
>> +
>> +static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
>> +
>> +static int mobile_ema_new(s64 value, s64 ema_old)
>> +{
>> +	if (likely(ema_old))
>> +		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
>> +				  EMA_ALPHA_SHIFT);
>> +	return value;
>> +}
>> +
>> +static void mobile_reflect(struct cpuidle_device *dev, int index)
>> +{
>> +        struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
>> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +	struct cpuidle_state *s = &drv->states[index];
>> +	int residency;
>> +
>> +	/*
>> +	 * The idle task was not rescheduled since
>> +	 * MAX_RESCHED_INTERVAL_MS, let's consider the duration is
>> +	 * long enough to clear our stats.
>> +	 */
>> +	if (time_after(jiffies, mobile_dev->last_jiffies +
>> +		       msecs_to_jiffies(MAX_RESCHED_INTERVAL_MS)))
>> +		mobile_dev->idle_ema_avg = 0;
> 
> Why jiffies?  Any particular reason?

I used jiffies to not use the local_clock() call for the overhead. I
agree the resolution could be too low. Perhaps it makes more sense to
move idle start and idle end variable from the cpuidle_enter function to
the cpuidle device structure, so the information can be reused by the
subsequent users.

>> +
>> +	/*
>> +	 * Sum all the residencies in order to compute the total
>> +	 * duration of the idle task.
>> +	 */
>> +	residency = dev->last_residency - s->exit_latency;
>> +	if (residency > 0)
>> +		mobile_dev->idle_total += residency;
>> +
>> +	/*
>> +	 * We exited the idle state with the need_resched() flag, the
>> +	 * idle task will be rescheduled, so store the duration the
>> +	 * idle task was scheduled in an exponential moving average and
>> +	 * reset the total of the idle duration.
>> +	 */
>> +	if (need_resched()) {
>> +		mobile_dev->idle_ema_avg = mobile_ema_new(mobile_dev->idle_total,
>> +						      mobile_dev->idle_ema_avg);
>> +		mobile_dev->idle_total = 0;
>> +		mobile_dev->last_jiffies = jiffies;
>> +	}
>> +}
>> +
>> +static int mobile_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>> +		       bool *stop_tick)
>> +{
>> +	struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
>> +	int latency_req = cpuidle_governor_latency_req(dev->cpu);
>> +	int i, index = 0;
>> +	ktime_t delta_next;
>> +	u64 now, irq_length, timer_length;
>> +	u64 idle_duration_us;
>> +
>> +	/*
>> +	 * Get the present time as reference for the next steps
>> +	 */
>> +	now = local_clock();
>> +
>> +	/*
>> +	 * Get the next interrupt event giving the 'now' as a
>> +	 * reference, if the next event appears to have already
>> +	 * expired then we get the 'now' returned which ends up with a
>> +	 * zero duration.
>> +	 */
>> +	irq_length = irq_timings_next_event(now) - now;
>> +
>> +	/*
>> +	 * Get the timer duration before expiration.
>> +	 */
> 
> This comment is rather redundant and the one below too. :-)

Right.

>> +	timer_length = ktime_to_ns(tick_nohz_get_sleep_length(&delta_next));
>> +
>> +	/*
>> +	 * Get the smallest duration between the timer and the irq next event.
>> +	 */
>> +	idle_duration_us = min_t(u64, irq_length, timer_length) / NSEC_PER_USEC;
>> +
>> +	/*
>> +	 * Get the idle task duration average if the information is
>> +	 * available.
> 
> IMO it would be good to explain this step in more detail, especially the purpose of it.

Ok.

>> +	 */
>> +	if (mobile_dev->idle_ema_avg)
>> +		idle_duration_us = min_t(u64, idle_duration_us,
>> +					 mobile_dev->idle_ema_avg);
>> +
>> +	for (i = 0; i < drv->state_count; i++) {
>> +		struct cpuidle_state *s = &drv->states[i];
>> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
>> +
>> +		if (s->disabled || su->disable)
>> +			continue;
>> +
>> +		if (s->exit_latency > latency_req)
>> +			break;
>> +
>> +		if (idle_duration_us > s->exit_latency)
>> +			idle_duration_us = idle_duration_us - s->exit_latency;
> 
> Why do you want this?
> 
> It only causes you to miss an opportunity to select a deeper state sometimes,
> so what's the reason?

On the mobile platform the exit latencies are very high (with an order
of magnitude of several milliseconds) for a very limited number of idle
states. The real idle duration must be determined to compare to the
target residency. Without this test, the governor is constantly choosing
wrongly a deep idle state.

> Moreover, I don't think you should update idle_duration_us here, as the updated
> value will go to the next step if the check below doesn't trigger.

Right, I spotted it also and fixed with:

+               if (s->exit_latency >= idle_duration_us)
+                       break;

+               if (s->target_residency > (idle_duration_us -
s->exit_latency))
                        break;

>> +
>> +		if (s->target_residency > idle_duration_us)
>> +			break;
>> +
>> +		index = i;
>> +	}
>> +
>> +	if (!index)
>> +		*stop_tick = false;
> 
> Well, this means that the tick is stopped for all idle states deeper than state 0.
> 
> If there are any states between state 0 and the deepest one and they are below
> the tick boundary, you may very well suffer the "powernightmares" problem
> because of this.

What would you suggest?

if (!index || ((idle_duration_us < TICK_USEC) &&
		!tick_nohz_tick_stopped()))
	*stop_tick = false;

?

There are too few idle states to restart a selection at this point, so
preventing stopping the tick is enough at this point IMO.


>> +	return index;
>> +}
>> +
>> +static struct cpuidle_governor mobile_governor = {
>> +	.name =		"mobile",
>> +	.rating =	20,
>> +	.select =	mobile_select,
>> +	.reflect =	mobile_reflect,
>> +};
>> +
>> +static int __init init_governor(void)
>> +{
>> +	irq_timings_enable();
>> +	return cpuidle_register_governor(&mobile_governor);
>> +}
>> +
>> +postcore_initcall(init_governor);
>>
> 
> 
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

