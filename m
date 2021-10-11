Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F934298B8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhJKVRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhJKVRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 17:17:30 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2363C06161C
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 14:15:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cv2so11736193qvb.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oRt/0xfqDMIYdNSP0wJTSosZJDZg5crujf+a2Cp5VBg=;
        b=d8JKBIR773ZV5J6VHjN/DvFgPB/9YH+LOLMlYjwZHMmuX8YlvGMnQEkhu/Vv/ke8/I
         bzcuN5qu1+GupZnOmsediccE3KHQSokxAabM6XQ3wcb9dtLg58rAqw0lxQNVvl2AU1Kw
         qbRZl+QhBoNOlo3OITApqaMuoZrweRYOOaaEEVBKWQBq0aSIZ/FArDXhOjbyV7cX7vSB
         l64RlfakfwcljB0kVjaENqtl6pVYMD1gORO7Bj6egsCZcpEBOZfgrSpYFvbm796tieUC
         zKCVhG5EyBR/5osbu0HxJZi21jR2H0fq73iF5IhPUkuxjlBHNrvIPIXSDmCwNAiP88qE
         NESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRt/0xfqDMIYdNSP0wJTSosZJDZg5crujf+a2Cp5VBg=;
        b=xhsxBmecBkMojd8HM2RvWtlZz8DQqBvM0gIgHQu1OPmCCfEC8k2xtIh0GNCCOJrvx9
         GullY4b9pBpWrRAlM1L6pT1ldQiL5YwzXaR74rfWZtSJr6C68o2xDbiFo9dV/PM1PCnE
         F+6aND6vtSqI3JfbIL2R9A1U9cVQYKx8ljm6hsNdDDdADDqm56KBzPHZrFSOLbUxlHw4
         jvlw2uMxyesgbD8hGpZ0FaGS+SqOQ+MBNC4ojc1HnzdzebeYyrw+FRe2RtwcISp5TN15
         UOFn1GrTjWJyRTO6PAOLvPvquW7d4fVEkYIwtpqiHrt7vQOUD/owS3hboE4PIMFq7EXd
         rsNw==
X-Gm-Message-State: AOAM5334H7vWdjqE2fMbLF0+TVlR5mypQpTPWz5LUJRtCtsAfjOGEhFh
        kFuyvMXws2iNLGJOdoNd++fYCA==
X-Google-Smtp-Source: ABdhPJw7/3h6SJV4zGg+1+ClRXbq+u/Qyuelpsok1iZhMwQTwP/q7Zlg+VNpaTfBX2QLKoyPgTzbPA==
X-Received: by 2002:ad4:5748:: with SMTP id q8mr15947224qvx.52.1633986928957;
        Mon, 11 Oct 2021 14:15:28 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id s203sm4746181qke.21.2021.10.11.14.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 14:15:28 -0700 (PDT)
Subject: Re: [PATCH 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211007080729.8262-1-lukasz.luba@arm.com>
 <20211007080729.8262-2-lukasz.luba@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <0ee4bc3b-0ad8-598d-417f-b8fe0a8fb8b1@linaro.org>
Date:   Mon, 11 Oct 2021 17:15:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007080729.8262-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/7/21 4:07 AM, Lukasz Luba wrote:
> The thermal pressure is a mechanism which is used for providing
> information about reduced CPU performance to the scheduler. Usually code
> has to convert the value from frequency units into capacity units,
> which are understandable by the scheduler. Create a common conversion code
> which can be just used via a handy API.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   arch/arm/include/asm/topology.h   |  1 +
>   arch/arm64/include/asm/topology.h |  1 +
>   drivers/base/arch_topology.c      | 36 ++++++++++++++++++++++++++++++-
>   include/linux/arch_topology.h     |  3 +++
>   include/linux/sched/topology.h    |  7 ++++++
>   5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 470299ee2fba..aee6c456c085 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,7 @@
>   /* Replace task scheduler's default thermal pressure API */
>   #define arch_scale_thermal_pressure topology_get_thermal_pressure
>   #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_thermal_pressure_update	topology_thermal_pressure_update
>   
>   #else
>   
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index ec2db3419c41..c997015402bc 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -33,6 +33,7 @@ void update_freq_counters_refs(void);
>   /* Replace task scheduler's default thermal pressure API */
>   #define arch_scale_thermal_pressure topology_get_thermal_pressure
>   #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_thermal_pressure_update	topology_thermal_pressure_update
>   
>   #include <asm-generic/topology.h>
>   
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 43407665918f..ad31513d0104 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -25,6 +25,7 @@
>   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>   static struct cpumask scale_freq_counters_mask;
>   static bool scale_freq_invariant;
> +static DEFINE_PER_CPU(u32, freq_factor) = 1;
>   
>   static bool supports_scale_freq_counters(const struct cpumask *cpus)
>   {
> @@ -168,6 +169,40 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
>   }
>   EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
>   
> +/**
> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
> + * @cpus	: The related CPUs which capacity has been reduced

The related CPUs "for" which

> + * @capped_freq	: The maximum allowed frequency that CPUs can run at
> + *
> + * Update the value of thermal pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq must be less or equal to the max possible frequency and
> + * reflects the currently allowed max CPUs frequency due to thermal capping.
> + * The @capped_freq must be provided in kHz.
> + */
> +void topology_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity;
> +	int cpu;
> +
> +	if (!cpus)
> +		return;
> +
> +	cpu = cpumask_first(cpus);
> +	max_capacity = arch_scale_cpu_capacity(cpu);
> +
> +	/* Convert to MHz scale which is used in 'freq_factor' */
> +	capped_freq /= 1000;
> +
> +	capacity = capped_freq * max_capacity;
> +	capacity /= per_cpu(freq_factor, cpu);

use mult_frac as used in other implementations ?

-- 
Warm Regards
Thara (She/Her/Hers)

> +
> +	arch_set_thermal_pressure(cpus, max_capacity - capacity);
> +}
> +EXPORT_SYMBOL_GPL(topology_thermal_pressure_update);
> +
>   static ssize_t cpu_capacity_show(struct device *dev,
>   				 struct device_attribute *attr,
>   				 char *buf)
> @@ -220,7 +255,6 @@ static void update_topology_flags_workfn(struct work_struct *work)
>   	update_topology = 0;
>   }
>   
> -static DEFINE_PER_CPU(u32, freq_factor) = 1;
>   static u32 *raw_capacity;
>   
>   static int free_raw_capacity(void)
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index f180240dc95f..9e183621a59b 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -59,6 +59,9 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
>   void topology_set_thermal_pressure(const struct cpumask *cpus,
>   				   unsigned long th_pressure);
>   
> +void topology_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_freq);
> +
>   struct cpu_topology {
>   	int thread_id;
>   	int core_id;
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 8f0f778b7c91..990d14814427 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -266,6 +266,13 @@ void arch_set_thermal_pressure(const struct cpumask *cpus,
>   { }
>   #endif
>   
> +#ifndef arch_thermal_pressure_update
> +static __always_inline
> +void arch_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_frequency)
> +{ }
> +#endif
> +
>   static inline int task_node(const struct task_struct *p)
>   {
>   	return cpu_to_node(task_cpu(p));
> 


