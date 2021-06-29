Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2289B3B6CA6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhF2Cwx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 22:52:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30499 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhF2Cwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 22:52:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624935026; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Efi5O9a9zama6IARAOsMmnTjTuKRRY3Zblari0Envps=; b=AoEKJVG7fhSirj1HzviRXXnsECKZuhs1RQZ1i6T4lBa2bBeTYQnGbFXA+bmnQrGFh+dLab7+
 Gcpjs8yNGesQEiqgioS1cyRm+x/juyehcp393fleTBN01wAz0V/xwVS5j5jQOHq3TQO/gStb
 wy26ssm5QseJ+iaE0lvHWcyYPzQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60da8a6ead0600eede84cf07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 02:50:22
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89D5EC433F1; Tue, 29 Jun 2021 02:50:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.103] (unknown [49.204.182.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0D4EC433F1;
        Tue, 29 Jun 2021 02:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0D4EC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [Patch v2 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-4-thara.gopinath@linaro.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <34542481-09b0-ae3b-25f1-77565bf47755@codeaurora.org>
Date:   Tue, 29 Jun 2021 08:20:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624115813.3613290-4-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/2021 5:28 PM, Thara Gopinath wrote:
> Add interrupt support to notify the kernel of h/w initiated frequency
> throttling by LMh. Convey this to scheduler via thermal presssure
> interface.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Introduced qcom_cpufreq_hw_lmh_init to consolidate LMh related initializations
> 	  as per Viresh's review comment.
> 	- Moved the piece of code restarting polling/re-enabling LMh interrupt to
> 	  qcom_lmh_dcvs_notify therby simplifying isr and timer callback as per Viresh's
> 	  suggestion.
> 	- Droped cpus from qcom_cpufreq_data and instead using cpus from cpufreq_policy in
> 	  qcom_lmh_dcvs_notify as per Viresh's review comment.
> 	- Dropped dt property qcom,support-lmh as per Bjorn's suggestion.
> 	- Other minor/cosmetic fixes
> 
>   drivers/cpufreq/qcom-cpufreq-hw.c | 103 ++++++++++++++++++++++++++++++
>   1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859bf76f1..241f6f2b441f 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -13,6 +13,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/pm_opp.h>
>   #include <linux/slab.h>
> +#include <linux/interrupt.h>
>   
>   #define LUT_MAX_ENTRIES			40U
>   #define LUT_SRC				GENMASK(31, 30)
> @@ -22,10 +23,13 @@
>   #define CLK_HW_DIV			2
>   #define LUT_TURBO_IND			1
>   
> +#define HZ_PER_KHZ			1000
> +
>   struct qcom_cpufreq_soc_data {
>   	u32 reg_enable;
>   	u32 reg_freq_lut;
>   	u32 reg_volt_lut;
> +	u32 reg_current_vote;
>   	u32 reg_perf_state;
>   	u8 lut_row_size;
>   };
> @@ -33,7 +37,10 @@ struct qcom_cpufreq_soc_data {
>   struct qcom_cpufreq_data {
>   	void __iomem *base;
>   	struct resource *res;
> +	struct delayed_work lmh_dcvs_poll_work;
>   	const struct qcom_cpufreq_soc_data *soc_data;
> +	struct cpufreq_policy *policy;
> +	int lmh_dcvs_irq;
>   };
>   
>   static unsigned long cpu_hw_rate, xo_rate;
> @@ -251,10 +258,79 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>   	}
>   }
>   
> +static inline unsigned long qcom_lmh_vote_to_freq(u32 val)
> +{
> +	return (val & 0x3FF) * 19200;
> +}
> +
> +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> +{
> +	struct cpufreq_policy *policy = data->policy;
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
> +	unsigned int val, freq;
> +
> +	/*
> +	 * Get the h/w throttled frequency, normalize it using the
> +	 * registered opp table and use it to calculate thermal pressure.
> +	 */
> +	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
> +	freq = qcom_lmh_vote_to_freq(val);
> +	freq_hz = freq * HZ_PER_KHZ;
> +
> +	dev = get_cpu_device(cpumask_first(policy->cpus));
> +	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
> +	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
> +
> +	throttled_freq = freq_hz / HZ_PER_KHZ;
> +
> +	/* Update thermal pressure */
> +	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
> +	capacity = throttled_freq * max_capacity;
> +	capacity /= policy->cpuinfo.max_freq;
> +	/* Don't pass boost capacity to scheduler */
> +	if (capacity > max_capacity)
> +		capacity = max_capacity;
> +	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
> +	/*
> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
> +	 * polling and switch back to interrupt mechanism
> +	 */
> +	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
> +		/* Clear the existing interrupts and enable it back */
> +		enable_irq(data->lmh_dcvs_irq);
> +	else
> +		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
> +				 msecs_to_jiffies(10));
> +}
> +
> +static void qcom_lmh_dcvs_poll(struct work_struct *work)
> +{
> +	struct qcom_cpufreq_data *data;
> +
> +	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
> +
> +	qcom_lmh_dcvs_notify(data);
> +}
> +
> +static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
> +{
> +	struct qcom_cpufreq_data *c_data = data;
> +
> +	/* Disable interrupt and enable polling */
> +	disable_irq_nosync(c_data->lmh_dcvs_irq);
> +	qcom_lmh_dcvs_notify(c_data);
> +
> +	return 0;
> +}
> +
>   static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>   	.reg_enable = 0x0,
>   	.reg_freq_lut = 0x110,
>   	.reg_volt_lut = 0x114,
> +	.reg_current_vote = 0x704,
>   	.reg_perf_state = 0x920,
>   	.lut_row_size = 32,
>   };
> @@ -274,6 +350,23 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>   
> +static void qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy)
> +{
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
> +			       0, "dcvsh-irq", data);


It is better if you tag the CPU id while registering the IRQ.
"dcvsh-irq-x" (0/4/7)

> +	if (ret) {
> +		dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
> +		return;
> +	}
> +	data->policy = policy;
> +	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
> +}
> +
>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -370,6 +463,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>   	}
>   
> +	/* Look for LMh interrupt. If no interrupt line is specified /
> +	 * if there is an error, allow cpufreq to be enabled as usual.
> +	 */
> +	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
> +	if (data->lmh_dcvs_irq > 0) {
> +		qcom_cpufreq_hw_lmh_init(policy);
> +	} else if (data->lmh_dcvs_irq != -ENXIO) {
> +		ret = data->lmh_dcvs_irq;
> +		goto error;
> +	}
>   	return 0;
>   error:
>   	kfree(data);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
