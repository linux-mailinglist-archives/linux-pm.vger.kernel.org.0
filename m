Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18D13B7B7D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 04:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhF3C1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhF3C1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 22:27:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4BC061766
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 19:25:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j14so328508qvu.6
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/he0D2loD88b1uHUtFHjQmeUSldqVtd/Mp90qGy3EA=;
        b=RImqw0cKz7BmgX+9mMv6XaNVNbPZx7DRNvr9PTn6Eb3NzLxmdk8t5yodds2pOd/kDR
         6uMiE7xLgXKWT4eJiegqQTUKTKxaPEnrZ7XNYV76cc18DqKEKk/CEFyS8laD5nf7/gLw
         f/FV/ROdstuT+g+ibEaHrPyuz4BS3W+SUnTLm6eSvYKmXcpvVfiHYZclKMRhXgvg4lSP
         QS3iVZTlV42v3bQsXl00zlPcanoNzE36toD7U0baH58CC4EmH7u7T3/2kWU6FFjA/RPb
         sbEDidgiJ8/z6VfPkAnDV7wBocMD98/p1iNuunSvoxx3KeNiLyaUUUQ2y9Q3l9Y4iboH
         TyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/he0D2loD88b1uHUtFHjQmeUSldqVtd/Mp90qGy3EA=;
        b=Y3YV6TMrLjlxozBr5HC8J6V53zNvLF2a3z4hEGTocdt1upMbSQAWvd5h3kAx/by3AT
         BvLwO9SDOuhP/BnO86Tq3h7HPdE/1Fj6f8EHEhh2jEtacsjM6IxWUVnr+HDXjam5KMT6
         FMGQD+06rCx5brHLceb8gH+rkYWkKPcutHNShD3Y/UsNInKT9NdpEvIfjYiVdACUWSjB
         7g1kS2kK1hOidRMMHwjf0yAmpwmepYIfwxnckObMExe8E6TzGUvXk5TCXDvZ0ApsCe1E
         oDbBDnwqBWpxLdpU5OfHkSDVV5I3PO7LJfscwh9r+e00Sh/Dw13usD4aAT7zVafuIah6
         e7ow==
X-Gm-Message-State: AOAM5328/QFqQpD39WkrOyfHPeXqj+EPNKta4FFRf1MW2sqKAQ8Qjkpl
        GFHzMrTHKjaAUBZ+6laY73utSQ==
X-Google-Smtp-Source: ABdhPJwQrRY8wFTGdC9bM760IH5q68es5ECl1z6SPztmY4LvhVh5u5FunECPUpQepqoPHzHjk0DAiw==
X-Received: by 2002:a0c:ffa2:: with SMTP id d2mr34967988qvv.50.1625019912758;
        Tue, 29 Jun 2021 19:25:12 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id x28sm10838945qtm.71.2021.06.29.19.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 19:25:12 -0700 (PDT)
Subject: Re: [Patch v2 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-4-thara.gopinath@linaro.org>
 <20210629023556.v3u4hdye5ojolubq@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5d194c91-e557-e5f5-60d6-ad2b1ca2def4@linaro.org>
Date:   Tue, 29 Jun 2021 22:25:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210629023556.v3u4hdye5ojolubq@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/28/21 10:35 PM, Viresh Kumar wrote:
> On 24-06-21, 07:58, Thara Gopinath wrote:
>> Add interrupt support to notify the kernel of h/w initiated frequency
>> throttling by LMh. Convey this to scheduler via thermal presssure
>> interface.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
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
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 103 ++++++++++++++++++++++++++++++
>>   1 file changed, 103 insertions(+)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859bf76f1..241f6f2b441f 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/slab.h>
>> +#include <linux/interrupt.h>
> 
> Please don't break the alphabetical order here.
> 
>>   #define LUT_MAX_ENTRIES			40U
>>   #define LUT_SRC				GENMASK(31, 30)
>> @@ -22,10 +23,13 @@
>>   #define CLK_HW_DIV			2
>>   #define LUT_TURBO_IND			1
>>   
>> +#define HZ_PER_KHZ			1000
>>
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
>>   	const struct qcom_cpufreq_soc_data *soc_data;
>> +	struct cpufreq_policy *policy;
>> +	int lmh_dcvs_irq;
>>   };
>>   
>>   static unsigned long cpu_hw_rate, xo_rate;
>> @@ -251,10 +258,79 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
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
>> +	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
>> +	capacity = throttled_freq * max_capacity;
>> +	capacity /= policy->cpuinfo.max_freq;
>> +	/* Don't pass boost capacity to scheduler */
>> +	if (capacity > max_capacity)
>> +		capacity = max_capacity;
> 
> I wonder why this check isn't present for cpufreq_cooling.c .

Hi Viresh,

I don't think cpufreq_cooling recognizes boost frequencies. The max 
state there is the max of nominal frequencies , right? If not, it might 
be a good idea to add this check there as well.

I will fix rest of your comments in v3.

-- 
Warm Regards
Thara (She/Her/Hers)

> 
>> +	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
>> +	/*
> 
> Whenever you mix code and comments, please separate them with a blank
> line, else it becomes a bit messy and harder to read.
> 
>> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
>> +	 * polling and switch back to interrupt mechanism
>> +	 */
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
>> @@ -274,6 +350,23 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>>   
>> +static void qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy)
>> +{
>> +	struct qcom_cpufreq_data *data = policy->driver_data;
>> +	struct platform_device *pdev = cpufreq_get_driver_data();
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
>> +			       0, "dcvsh-irq", data);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
>> +		return;
>> +	}
>> +	data->policy = policy;
>> +	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
>> +}
>> +
>>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   {
>>   	struct platform_device *pdev = cpufreq_get_driver_data();
>> @@ -370,6 +463,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>>   	}
>>   
>> +	/* Look for LMh interrupt. If no interrupt line is specified /
>> +	 * if there is an error, allow cpufreq to be enabled as usual.
>> +	 */
> 
> Proper comment style please..
> 
>> +	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
>> +	if (data->lmh_dcvs_irq > 0) {
>> +		qcom_cpufreq_hw_lmh_init(policy);
>> +	} else if (data->lmh_dcvs_irq != -ENXIO) {
>> +		ret = data->lmh_dcvs_irq;
>> +		goto error;
>> +	}
> 
> Move all of this to qcom_cpufreq_hw_lmh_init().
> 
> And I don't see any cleanup for this stuff. There is no guarantee that
> the irq won't fire and queue up a work right after cpufreq driver is
> unregistered and before the devm_ stuff gets released.
> 
>>   	return 0;
>>   error:
>>   	kfree(data);
>> -- 
>> 2.25.1
> 


