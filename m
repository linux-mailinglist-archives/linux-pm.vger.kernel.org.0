Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47F03C67D8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhGMBMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 21:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhGMBMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 21:12:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3FC0613E9
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 18:09:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g8so3515927qtj.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGhtXyqYPY8qEbMpvsH+XdOKq/D+/cjHALZLO2xNjI8=;
        b=ivVus2MiA3C2aSry4cjIIJXXhWNGXEhoEkCrWazStuuSGEpcF3Wkjcs49Z3XFKu96b
         zNfjYrmJ+BZ02lApi8Z32Yock2AEg4+9n2IZJcLanoCRtaU4xvd7XSov28FfEIgXXwE4
         rROG2IiasfVHuHrwVvvNWZM57AQNKQ+QxeGSdbJgmjSEZ6nH7uHqU60swEUJbJ1bkjyv
         8cz30/lrPc+dRBwh3xnaihSdR0AgP8N4MTFy2WF7DGP+akVzXgslUALcGihAUbM5r7Bi
         c2lqT5Pr89TcqTw9Gjqp5J12UYuAmyxUUlqyjXL4EfsPH8k2jYOdopkevazP4BC8eF+Y
         5EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGhtXyqYPY8qEbMpvsH+XdOKq/D+/cjHALZLO2xNjI8=;
        b=dz4pOIDfWZTOy+GmzciivCTYCXgL9VfKnlo3Xz8fwDYbuRTMB4mvX55nyuzQPB9eWM
         KqtTbBI4h8GdYCyKtkYZh7Dy4L8bSOsfSVBvgD+xVSC5/jzIO2qOVvTb28OTpS5CmJiL
         y3xpSH63+FA2NIxTPwdH1LWKH0Xksp5kMUmTJFReb6pdqXgVXrSf+Wjhk8P06AddzbCO
         u/QAOW2z0FUU9qRHVgMAQjaKGvgzhg4BvDuVBCPd/xdarj6i5+iBi70cpvpej0QIYVTG
         /H3u+pDUU/N1Aj/6soXx9dT61ej7QS/dEj8seAHzYL8N2GxItOCyfQRcoTsry7490qXh
         RqCg==
X-Gm-Message-State: AOAM530oZIO7aq3kHVuScGdRSieIVRPElSgSSjOw+jBUGRhbZjxw178u
        oZqvHopU9gVh+BForpIbSLRi8w==
X-Google-Smtp-Source: ABdhPJyQtNRnUVjjomXJx2sNRorRWjBFMSc25Fe+T9Un54f5wDetoTSyGVPXu2NvNB+F8Ntj6Mqorg==
X-Received: by 2002:a05:622a:11cf:: with SMTP id n15mr1653434qtk.256.1626138568907;
        Mon, 12 Jul 2021 18:09:28 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id e10sm7479954qkg.18.2021.07.12.18.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 18:09:28 -0700 (PDT)
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org> <YOkonX2F+xP5fcuT@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <fce5e26c-6fd6-d0df-f3d5-4e38dd666600@linaro.org>
Date:   Mon, 12 Jul 2021 21:09:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOkonX2F+xP5fcuT@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/10/21 12:57 AM, Bjorn Andersson wrote:
> On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:
> 
>> Add interrupt support to notify the kernel of h/w initiated frequency
>> throttling by LMh. Convey this to scheduler via thermal presssure
>> interface.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v2->v3:
>> 	- Cosmetic fixes from review comments on the list.
>> 	- Moved all LMh initializations to qcom_cpufreq_hw_lmh_init.
>> 	- Added freeing of LMh interrupt and cancelling the polling worker to
>> 	  qcom_cpufreq_hw_cpu_exit as per Viresh's suggestion.
>> 	- LMh interrupts are now tied to cpu dev and not cpufreq dev. This will be
>> 	  useful for further generation of SoCs where the same interrupt signals
>> 	  multiple cpu clusters.
>>
>> v1->v2:
>> 	- Introduced qcom_cpufreq_hw_lmh_init to consolidate LMh related initializations
>> 	  as per Viresh's review comment.
>> 	- Moved the piece of code restarting polling/re-enabling LMh interrupt to
>> 	  qcom_lmh_dcvs_notify therby simplifying isr and timer callback as per Viresh's
>> 	  suggestion.
>> 	- Droped cpus from qcom_cpufreq_data and instead using cpus from cpufreq_policy in
>> 	  qcom_lmh_dcvs_notify as per Viresh's review comment.
>> 	- Dropped dt property qcom,support-lmh as per Bjorn's suggestion.
>> 	- Other minor/cosmetic fixes
>>
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859bf76f1..bb5fc700d913 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/cpufreq.h>
>>   #include <linux/init.h>
>>   #include <linux/interconnect.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
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
>> @@ -33,7 +37,10 @@ struct qcom_cpufreq_soc_data {
>>   struct qcom_cpufreq_data {
>>   	void __iomem *base;
>>   	struct resource *res;
>> +	struct delayed_work lmh_dcvs_poll_work;
> 
> How about dropping "lmh" from this variable name?
> 
> Perhaps "throttle_work" or something like that?
> 
>>   	const struct qcom_cpufreq_soc_data *soc_data;
>> +	struct cpufreq_policy *policy;
>> +	int lmh_dcvs_irq;
> 
> throttle_irq ?

sounds good!

> 
>>   };
>>   
>>   static unsigned long cpu_hw_rate, xo_rate;
>> @@ -251,10 +258,84 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
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
>> +	struct cpufreq_policy *policy = data->policy;
>> +	struct dev_pm_opp *opp;
>> +	struct device *dev;
>> +	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
>> +	unsigned int val, freq;
>> +
>> +	/*
>> +	 * Get the h/w throttled frequency, normalize it using the
>> +	 * registered opp table and use it to calculate thermal pressure.
>> +	 */
>> +	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
> 
> I would find it cleaner to move the readl() into the helper function, as
> you don't care about the register value, only the resulting frequency.

Ok..

> 
>> +	freq = qcom_lmh_vote_to_freq(val);
>> +	freq_hz = freq * HZ_PER_KHZ;
>> +
>> +	dev = get_cpu_device(cpumask_first(policy->cpus));
>> +	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
>> +	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
>> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
>> +
>> +	throttled_freq = freq_hz / HZ_PER_KHZ;
>> +
>> +	/* Update thermal pressure */
>> +
>> +	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
>> +	capacity = throttled_freq * max_capacity;
>> +	capacity /= policy->cpuinfo.max_freq;
> 
> Perhaps, to avoid overflows if this is ever used on a 32-bit platform
> use:
> 
> 	mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq)

yep. sounds good.

> 
>> +
>> +	/* Don't pass boost capacity to scheduler */
>> +	if (capacity > max_capacity)
>> +		capacity = max_capacity;
>> +
>> +	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
>> +
>> +	/*
>> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
>> +	 * polling and switch back to interrupt mechanism
>> +	 */
>> +
>> +	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
>> +		/* Clear the existing interrupts and enable it back */
>> +		enable_irq(data->lmh_dcvs_irq);
>> +	else
>> +		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
>> +				 msecs_to_jiffies(10));
>> +}
>> +
>> +static void qcom_lmh_dcvs_poll(struct work_struct *work)
>> +{
>> +	struct qcom_cpufreq_data *data;
>> +
>> +	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
>> +
>> +	qcom_lmh_dcvs_notify(data);
>> +}
>> +
>> +static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>> +{
>> +	struct qcom_cpufreq_data *c_data = data;
>> +
>> +	/* Disable interrupt and enable polling */
>> +	disable_irq_nosync(c_data->lmh_dcvs_irq);
>> +	qcom_lmh_dcvs_notify(c_data);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>>   	.reg_enable = 0x0,
>>   	.reg_freq_lut = 0x110,
>>   	.reg_volt_lut = 0x114,
>> +	.reg_current_vote = 0x704,
>>   	.reg_perf_state = 0x920,
>>   	.lut_row_size = 32,
>>   };
>> @@ -274,6 +355,35 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>>   
>> +static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>> +{
>> +	struct qcom_cpufreq_data *data = policy->driver_data;
>> +	struct platform_device *pdev = cpufreq_get_driver_data();
>> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
>> +	char irq_name[15];
>> +	int ret;
>> +
>> +	/*
>> +	 * Look for LMh interrupt. If no interrupt line is specified /
>> +	 * if there is an error, allow cpufreq to be enabled as usual.
>> +	 */
>> +	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
>> +	if (data->lmh_dcvs_irq <= 0)
>> +		return data->lmh_dcvs_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
>> +
>> +	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
>> +	ret = devm_request_irq(cpu_dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
>> +			       0, irq_name, data);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
> 
> The irq number here won't have any meaning, and %x wouldn't be suitable.
> 
> How about ..."Error registering %s: %d\n", irq_name, ret); ?

ok.

> 
>> +		return 0;
> 
> This sounds like a problem, wouldn't it be suitable to treat it as a
> problem?

I thought a lot about this. My point is even if LMh does not get enabled 
due to some reason, cpufreq should be enabled. If I return an error back 
from here, cpufreq will be disabled.


> 
>> +	}
>> +	data->policy = policy;
> 
> Afaict, no one is going to access data->policy unless devm_request_irq()
> succeeds and if it does and the interrupt fires immediately it would be
> too late to set it here. So better move it earlier.
> 
>> +	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
> 
> What if the interrupt fires before you initialize the work? Better move
> this higher up.

I will move this and the data->policy = policy above before requesting 
the interrupt.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   {
>>   	struct platform_device *pdev = cpufreq_get_driver_data();
>> @@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>>   	}
>>   
>> +	ret = qcom_cpufreq_hw_lmh_init(policy, index);
>> +	if (ret)
>> +		goto error;
>> +
>>   	return 0;
>>   error:
>>   	kfree(data);
>> @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>   
>>   	dev_pm_opp_remove_all_dynamic(cpu_dev);
>>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>> +	if (data->lmh_dcvs_irq > 0) {
>> +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);
> 
> As init/exit are called multiple times you should avoid the devm
> variants.

Yes. I think Viresh was also mentioning this. I will move to non devm 
version.

> 
> Regards,
> Bjorn
> 
>> +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
>> +	}
>>   	kfree(policy->freq_table);
>>   	kfree(data);
>>   	iounmap(base);
>> -- 
>> 2.25.1
>>

-- 
Warm Regards
Thara (She/Her/Hers)
