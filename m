Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0C6532B3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLUOwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUOwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 09:52:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E3FAD5
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 06:52:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1625121wms.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j64WQGqKwaG4BHg6/nlP4Yhn5l14VzblKxdzA8aXC90=;
        b=bQA1XlwR6Uj8RKJnIxga5+wVX0KS6YziDEQKdHJUpsDI9gn5a2Jfazkg8DLZ2JQ/5z
         48+Dhid7D1tlOiYS8SeC7M21qtT8t/Iw5Tt3fgTUyvEb4SIPfpCeWZZyBVjHZq4vAfGv
         awzs2FnWF9CLeVwtAXFjUUHslIgOB1p/LDF1443zSeDnR4wCcXrCwn30SJR2fOkQnU4O
         PEUp5+NR4B6gVGgp6YAZfk/DoUz+E+pQTli2RBlp3eqjpzmYMkvCfnifygODOs+whPvY
         CyQBaRiPBB5Mum/kIS5ZKlyJpmsvSPVnzDcuEbvCHaNH/GQv465qm8ld9N+V1mqg2nYF
         OtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j64WQGqKwaG4BHg6/nlP4Yhn5l14VzblKxdzA8aXC90=;
        b=RvidHDdVTldVrFfxNF+ztZYb3BWc4ljOBbjKsgpAG+Uyzv2vBlfKm5XzPsvvK+QCne
         nw4964bKBbxRj7nTRhgO0163H+8NIA5MBafEGK/SXxeM20Fy2hKFT15S9KIYssj2qHjL
         h6dQUTosd0zHo6r6Z4gYfe0yLV6tEzaac4qEgkMB6Y0C2SpOX+NTRu6tAWoFiVKZSxdn
         wv/MvKV6FRfEonPf9hkStU31cSDb9i0mspE20LfGTSiU5HitAUxSUxK/9Ezo57AMeq7S
         3+GpsynA3Nd286rDN3CYHXVUSIgu0k3fGNlSG/vUzeG9+Idi27RNZrbEHhEL+Y+VDEhG
         wB1g==
X-Gm-Message-State: AFqh2kp8LTTHwqJ8Qeg6ECp1YzSOPK0MtDQ5A9lMACXaiHdp6LUUYJnx
        uRVyxTt3rpEuih6WHnir0DXkuw==
X-Google-Smtp-Source: AMrXdXuh/bdFBwi/XlRH45EovYiMxdXDz8dukvRtk1rHvS3so85Z9sfTH15R3BmjmjcrU0CguK8z9A==
X-Received: by 2002:a05:600c:4e08:b0:3d2:139e:f64f with SMTP id b8-20020a05600c4e0800b003d2139ef64fmr2026272wmq.40.1671634357076;
        Wed, 21 Dec 2022 06:52:37 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iv7-20020a05600c548700b003d35c09d4b9sm3047827wmb.40.2022.12.21.06.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 06:52:36 -0800 (PST)
Message-ID: <e2af7a4b-99f4-f88e-fbe7-5d3595d6211b@linaro.org>
Date:   Wed, 21 Dec 2022 15:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete
 callbacks
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
 <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Srinivas,

On 30/11/2022 00:34, Srinivas Pandruvada wrote:
> The actual idle percentage can be less than the desired because of
> interrupts. Since the objective for CPU Idle injection is for thermal
> control, there should be some way to compensate for lost idle percentage.
> Some architectures provide interface to get actual idle percent observed
> by the hardware. So, the idle percent can be adjusted using the hardware
> feedback. For example, Intel CPUs provides package idle counters, which
> is currently used by intel powerclamp driver to adjust idle time.
Can you provide an example in terms of timings?

I'm not getting how 'prepare' would do by returning a positive value to 
skip the play_idle_precise() and what will do 'complete' ?


> The only way this can be done currently is by monitoring hardware idle
> percent from a different software thread. This can be avoided by adding
> callbacks.
> 
> Add a capability to register a prepare and complete callback during idle
> inject registry. Add a new register function idle_inject_register_full()
> which also allows to register callbacks.
> 
> If they are not NULL, then prepare callback is called before calling
> play_idle_precise() and complete callback is called after calling
> play_idle_precise().
> 
> If prepare callback is present and returns non 0 value then
> play_idle_precise() is not called to avoid over compensation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> - Replace begin/end with prepare/complete
> - Add new interface idle_inject_register_full with callbacks
> - Update kernel doc
> - Update commit description
> 
>   drivers/powercap/idle_inject.c | 62 +++++++++++++++++++++++++++++++---
>   include/linux/idle_inject.h    |  4 +++
>   2 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index dfa989182e71..f48e71501429 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -63,13 +63,31 @@ struct idle_inject_thread {
>    * @idle_duration_us: duration of CPU idle time to inject
>    * @run_duration_us: duration of CPU run time to allow
>    * @latency_us: max allowed latency
> + * @prepare: Callback function which is called before calling
> + *		play_idle_precise()
> + * @complete: Callback function which is called after calling
> + *		play_idle_precise()
>    * @cpumask: mask of CPUs affected by idle injection
> + *
> + * This structure is used to define per instance idle inject device data. Each
> + * instance has an idle duration, a run duration and mask of CPUs to inject
> + * idle.
> + * Actual idle is injected by calling kernel scheduler interface
> + * play_idle_precise(). There are two optional callbacks which the caller can
> + * register by calling idle_inject_register_full():
> + * prepare() - This callback is called just before calling play_idle_precise()
> + *		If this callback returns non zero value then
> + *		play_idle_precise() is not called. This means skip injecting
> + *		idle during this period.
> + * complete() - This callback is called after calling play_idle_precise().
>    */
>   struct idle_inject_device {
>   	struct hrtimer timer;
>   	unsigned int idle_duration_us;
>   	unsigned int run_duration_us;
>   	unsigned int latency_us;
> +	int (*prepare)(unsigned int cpu);
> +	void (*complete)(unsigned int cpu);
>   	unsigned long cpumask[];
>   };
>   
> @@ -132,6 +150,7 @@ static void idle_inject_fn(unsigned int cpu)
>   {
>   	struct idle_inject_device *ii_dev;
>   	struct idle_inject_thread *iit;
> +	int ret;
>   
>   	ii_dev = per_cpu(idle_inject_device, cpu);
>   	iit = per_cpu_ptr(&idle_inject_thread, cpu);
> @@ -141,8 +160,18 @@ static void idle_inject_fn(unsigned int cpu)
>   	 */
>   	iit->should_run = 0;
>   
> +	if (ii_dev->prepare) {
> +		ret = ii_dev->prepare(cpu);
> +		if (ret)
> +			goto skip;
> +	}
> +
>   	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
>   			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
> +
> +skip:
> +	if (ii_dev->complete)
> +		ii_dev->complete(cpu);
>   }
>   
>   /**
> @@ -295,17 +324,23 @@ static int idle_inject_should_run(unsigned int cpu)
>   }
>   
>   /**
> - * idle_inject_register - initialize idle injection on a set of CPUs
> + * idle_inject_register_full - initialize idle injection on a set of CPUs
>    * @cpumask: CPUs to be affected by idle injection
> + * @prepare: callback called before calling play_idle_precise()
> + * @complete: callback called after calling play_idle_precise()
>    *
>    * This function creates an idle injection control device structure for the
> - * given set of CPUs and initializes the timer associated with it.  It does not
> - * start any injection cycles.
> + * given set of CPUs and initializes the timer associated with it. This
> + * function also allows to register prepare() and complete() callbacks.
> + * It does not start any injection cycles.
>    *
>    * Return: NULL if memory allocation fails, idle injection control device
>    * pointer on success.
>    */
> -struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +
> +struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
> +						     int (*prepare)(unsigned int cpu),
> +						     void (*complete)(unsigned int cpu))
>   {
>   	struct idle_inject_device *ii_dev;
>   	int cpu, cpu_rb;
> @@ -318,6 +353,8 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>   	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>   	ii_dev->timer.function = idle_inject_timer_fn;
>   	ii_dev->latency_us = UINT_MAX;
> +	ii_dev->prepare = prepare;
> +	ii_dev->complete = complete;
>   
>   	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>   
> @@ -342,6 +379,23 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>   
>   	return NULL;
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_register_full, IDLE_INJECT);
> +
> +/**
> + * idle_inject_register - initialize idle injection on a set of CPUs
> + * @cpumask: CPUs to be affected by idle injection
> + *
> + * This function creates an idle injection control device structure for the
> + * given set of CPUs and initializes the timer associated with it.  It does not
> + * start any injection cycles.
> + *
> + * Return: NULL if memory allocation fails, idle injection control device
> + * pointer on success.
> + */
> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +{
> +	return idle_inject_register_full(cpumask, NULL, NULL);
> +}
>   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
>   
>   /**
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index fb88e23a99d3..e18d89793490 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -13,6 +13,10 @@ struct idle_inject_device;
>   
>   struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
>   
> +struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
> +						     int (*prepare)(unsigned int cpu),
> +						     void (*complete)(unsigned int cpu));
> +
>   void idle_inject_unregister(struct idle_inject_device *ii_dev);
>   
>   int idle_inject_start(struct idle_inject_device *ii_dev);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

