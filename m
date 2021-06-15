Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D63A73E7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 04:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFOC21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 22:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOC21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 22:28:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCD5C061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 19:26:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u30so40530512qke.7
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 19:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lHQGUeZhFDoTh7Hq3zo7y7j2Hu4SG3rIYVL9gIYJNLw=;
        b=P/m0k5sIXF3hUFi9CU9gedE0eSuKde5rJ/cAtjEH9QhIMyMOgGXVy2P8APxEwdN/2/
         XQpNik2U8u5BNpMjfqCQ7UBAg9x22TcogdFYZ1nGx+AKkrTHh1S7mK2xiUMppuN9tR7c
         Eg+hQyJw12c4HN8X0iCmXG0aSxRj8Yc+Bhta5QQviCbSwdEMY2VnkPxxzD6zql+kmtJo
         kuMiL1sXCCbsTFJzQkJFC0Ewb37nGxZQddWTJ4AvAHTEN9boVwO61vOIkoqMiFGbOQ4y
         RFA3Bb8+SNKMwUfzdsRGwkhOu0Guc5uSUGPLuYLTxT8b1YzWU30f9kFL2rUJstSTK5of
         EQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lHQGUeZhFDoTh7Hq3zo7y7j2Hu4SG3rIYVL9gIYJNLw=;
        b=pypR58K8j5m3HvHgsg6deoaihxF9efamdiLmYZ4ABU3V4p8NtYjGOU0Pfk0NE3+5ti
         /8+4BZvq8jiC836dA/c+8N/66xdrK8nyuo/8jCKTLlHZjm38hcEzqhRgpCVFRj48xNs7
         sVpVa5OOT1wfzrYfNhsUCCQxs8BQP2Ti1QO96jlO8Z1jDZmUe6SoRVMkCafmvaQ+34mx
         d6F5JgG8cb/+trtknCIfE4udy/87Z+y7SLiEjzCWLFP0zdAPa3VpfGMoGzSXg4EnmNTq
         1VO+A+Gd7vO13vHQULnBA0rWYG+O4YAW5+hiaoBlKrGIZveUZ35+zK7bFN7RGIXK2XH3
         q3FQ==
X-Gm-Message-State: AOAM533dFHN7tVuHA8Pttw4UsCKD3+rcp8fiOhYTHA5lRqS/S22xgdHl
        pNcDhTXmbsJ5QX8gXk2b0q0kKEhGN8kdbQ==
X-Google-Smtp-Source: ABdhPJy9SFQfnpdgUuDXAzItK0wkCG5DOQgInCuSQ9aDPxteKWf0mLxjqJaQEDxWSKlxkSvO6YV0xA==
X-Received: by 2002:a05:620a:4547:: with SMTP id u7mr2061128qkp.439.1623722341355;
        Mon, 14 Jun 2021 18:59:01 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v5sm11263588qkh.39.2021.06.14.18.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 18:59:00 -0700 (PDT)
Subject: Re: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-4-thara.gopinath@linaro.org>
 <20210614103141.nnrd4sn756os52wh@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5a8f1622-4964-a8e1-f8a1-1dbd38948d45@linaro.org>
Date:   Mon, 14 Jun 2021 21:58:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614103141.nnrd4sn756os52wh@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/14/21 6:31 AM, Viresh Kumar wrote:
> On 08-06-21, 18:29, Thara Gopinath wrote:
>> Add interrupt support to notify the kernel of h/w initiated frequency
>> throttling by LMh. Convey this to scheduler via thermal presssure
>> interface.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 100 ++++++++++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859bf76f1..95e17330aa9d 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/slab.h>
>> +#include <linux/interrupt.h>
>>   
>>   #define LUT_MAX_ENTRIES			40U
>>   #define LUT_SRC				GENMASK(31, 30)
>> @@ -22,10 +23,13 @@
>>   #define CLK_HW_DIV			2
>>   #define LUT_TURBO_IND			1
>>   
>> +#define HZ_PER_KHZ			1000
>> +
>>   struct qcom_cpufreq_soc_data {
>>   	u32 reg_enable;
>>   	u32 reg_freq_lut;
>>   	u32 reg_volt_lut;
>> +	u32 reg_current_vote;
>>   	u32 reg_perf_state;
>>   	u8 lut_row_size;
>>   };
>> @@ -33,7 +37,11 @@ struct qcom_cpufreq_soc_data {
>>   struct qcom_cpufreq_data {
>>   	void __iomem *base;
>>   	struct resource *res;
>> +	struct delayed_work lmh_dcvs_poll_work;
>>   	const struct qcom_cpufreq_soc_data *soc_data;
>> +	cpumask_var_t cpus;
>> +	unsigned long throttled_freq;
>> +	int lmh_dcvs_irq;
>>   };
>>   
>>   static unsigned long cpu_hw_rate, xo_rate;
>> @@ -251,10 +259,79 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>>   	}
>>   }
>>   
>> +static inline unsigned long qcom_lmh_vote_to_freq(u32 val)
>> +{
>> +	return (val & 0x3FF) * 19200;
>> +}
>> +
>> +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>> +{
>> +	struct cpufreq_policy policy;
>> +	struct dev_pm_opp *opp;
>> +	struct device *dev;
>> +	unsigned long max_capacity, capacity, freq_hz;
>> +	unsigned int val, freq;
>> +
>> +	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
>> +	freq = qcom_lmh_vote_to_freq(val);
>> +	freq_hz = freq * HZ_PER_KHZ;
>> +
>> +	/* Do I need to calculate ceil and floor ? */
> 
> You don't know ?

stray comment! Will remove it.

> 
>> +	dev = get_cpu_device(cpumask_first(data->cpus));
>> +	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
>> +	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
>> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
>> +
>> +	data->throttled_freq = freq_hz / HZ_PER_KHZ;
>> +
> 
> What exactly are we trying to do here ? A comment would be good as
> well.

You want me to put a comment saying converting frequency in hz to khz ?

> 
>> +	cpufreq_get_policy(&policy, cpumask_first(data->cpus));
>> +
>> +	/* Update thermal pressure */
>> +	max_capacity = arch_scale_cpu_capacity(cpumask_first(data->cpus));
> 
> Set capacity of a single CPU from a policy ?

Get maximum capacity of a cpu.

> 
>> +	capacity = data->throttled_freq * max_capacity;
>> +	capacity /= policy.cpuinfo.max_freq;
>> +	/* Don't pass boost capacity to scheduler */
>> +	if (capacity > max_capacity)
>> +		capacity = max_capacity;
>> +	arch_set_thermal_pressure(data->cpus, max_capacity - capacity);
> 
> You should really be using policy->cpus instead of allocating
> data->cpus..

Yes I should be. But I still need data->cpus to get the policy.

> 
>> +}
>> +
>> +static void qcom_lmh_dcvs_poll(struct work_struct *work)
>> +{
>> +	struct qcom_cpufreq_data *data;
>> +
>> +	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
>> +
>> +	qcom_lmh_dcvs_notify(data);
> 
> You should really move the below stuff the disable_irq_nosync(), it
> will make your life easier.

I don't understand your comment here. I want to disable irq. call 
notify. Start polling. And in polling I want to call notify and if the 
thermal event has passed stop polling else continue polling.
> 
>> +	/**
>> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
>> +	 * polling and switch back to interrupt mechanism
>> +	 */
>> +	if (data->throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(data->cpus)))
>> +		/* Clear the existing interrupts and enable it back */
>> +		enable_irq(data->lmh_dcvs_irq);
>> +	else
>> +		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
>> +				 msecs_to_jiffies(10));
>> +}
>> +
>> +static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>> +{
>> +	struct qcom_cpufreq_data *c_data = data;
>> +
>> +	/* Disable interrupt and enable polling */
>> +	disable_irq_nosync(c_data->lmh_dcvs_irq);
>> +	qcom_lmh_dcvs_notify(c_data);
>> +	mod_delayed_work(system_highpri_wq, &c_data->lmh_dcvs_poll_work, msecs_to_jiffies(10));
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>>   	.reg_enable = 0x0,
>>   	.reg_freq_lut = 0x110,
>>   	.reg_volt_lut = 0x114,
>> +	.reg_current_vote = 0x704,
> 
> Should this be a different patch ?

Why ? This is the register to read the throttled frequency.

> 
>>   	.reg_perf_state = 0x920,
>>   	.lut_row_size = 32,
>>   };
>> @@ -285,6 +362,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   	void __iomem *base;
>>   	struct qcom_cpufreq_data *data;
>>   	int ret, index;
>> +	bool lmh_mitigation_enabled = false;
> 
> You just overwrite it below, no need to initialize it.

Sure.

> 
>>   
>>   	cpu_dev = get_cpu_device(policy->cpu);
>>   	if (!cpu_dev) {
>> @@ -305,6 +383,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	index = args.args[0];
>>   
>> +	lmh_mitigation_enabled = of_property_read_bool(pdev->dev.of_node, "qcom,support-lmh");
>> +
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>>   	if (!res) {
>>   		dev_err(dev, "failed to get mem resource %d\n", index);
>> @@ -329,6 +409,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto unmap_base;
>>   	}
>>   
>> +	if (!alloc_cpumask_var(&data->cpus, GFP_KERNEL)) {
>> +		ret = -ENOMEM;
>> +		goto unmap_base;
>> +	}
>> +
>>   	data->soc_data = of_device_get_match_data(&pdev->dev);
>>   	data->base = base;
>>   	data->res = res;
>> @@ -347,6 +432,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto error;
>>   	}
>>   
>> +	cpumask_copy(data->cpus, policy->cpus);
>>   	policy->driver_data = data;
>>   
>>   	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>> @@ -370,6 +456,20 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>>   	}
>>   
>> +	if (lmh_mitigation_enabled) {
> 
> Shouldn't you move the allocation and setting of data->cpus here ? I
> suggest creating a separate routine for all initialization around this
> stuff.

I should considering nothing else is using data->cpus. Yes I will create 
a separate init function.

> 
>> +		data->lmh_dcvs_irq = platform_get_irq(pdev, index);
>> +		if (data->lmh_dcvs_irq < 0) {
>> +			ret = data->lmh_dcvs_irq;
>> +			goto error;
>> +		}
>> +		ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
>> +				       0, "dcvsh-irq", data);
> 
> I would rather pass policy as data here.

So policy for a cpu can change runtime, right ?

> 
>> +		if (ret) {
>> +			dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
>> +			goto error;
>> +		}
>> +		INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
>> +	}
>>   	return 0;
>>   error:
>>   	kfree(data);
> 

-- 
Warm Regards
Thara (She/Her/Hers)
