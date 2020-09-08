Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE144261001
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIHKfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgIHKer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:34:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88EC061757
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 03:34:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so9749510pgl.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nCi8zy7QuQkZMR6IxuyCp5GD0A3R6OZW47abt1o2sE=;
        b=JR7BTrwJhzX7Mfr1dyfJa8McktGcJbt+Q/yWlCstYdZe6ZP+AbvN60k9wgL+5/Pk3P
         1Ha3q+LLnrT4pfCJ92nARvsTbKg/JiTQmqCqhZIIZR25oymECHGZb7MgrLHsdFuQVzdN
         ngYcf0iR33Bd27uwKMpzwWP+dw4i2XLgtky8KXsRKt28cgWlM2oox8/EPjvn/T7H2pA4
         gNTG+hIaTDVzhVFkXyekNim/O+eVUgQIgedGcF5qT7oBqHihA0sWw9ly4YBqGE45M9HL
         tl5iqkEOAkbz4NtfqESltSy64RcY+X72jFGfknInIeeYPpgliCklRG5wZeZ9LGLGMGco
         rALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nCi8zy7QuQkZMR6IxuyCp5GD0A3R6OZW47abt1o2sE=;
        b=D2AnMii0kcMza2exF4sd7vFsOzNWfr6N/D92zZDqvWelNN6Fh2NsPZ9kVNJG2XcQb6
         bVvdj78WW7lU6M1XR2DvTTNxKz/ICvGstXSasJTI7C41o4nH2WQcMcu/GqUQCbn4W0TE
         rg3gk11BMF6qZUNrP6c3YL4NOFv9kT+kVIu/a3J/XLHi6cMGhDBF4uSXTaMKFOxUD4jk
         RfnbjMPjTmO8q9o8E3Ry9/3rxHPPxQdd+ygG9+NXnPXKDioZei2RCwZ3ZcV3PLtwxuTd
         BDZ3YnH8ZM42h2uO9/bEDTCqsP2NILmgdnlHeS3TdB0FcTUKJMnXYl6RfFTenfm4M3N4
         96fQ==
X-Gm-Message-State: AOAM530GkPIR9qJEwfjAepAFtmC2s5dOhz6LWEnHmTlz4s8810k20g5w
        3BHg3MG72WJporY0B4Q9wmu6LtlK6y6nNQ==
X-Google-Smtp-Source: ABdhPJxYAK1Zi7MXGpBWBuIGleqFscf/lAKVmLVtd3LYQAY3bDRZjWZ/jyNlrvWNehd/7EMXc8I+mA==
X-Received: by 2002:a63:485c:: with SMTP id x28mr169704pgk.289.1599561286562;
        Tue, 08 Sep 2020 03:34:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a15sm9887130pfi.119.2020.09.08.03.34.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:34:45 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:04:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908103444.5e526uawa45om6lt@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> Use regmap for accessing cpufreq registers in hardware.

Why ? Please mention why a change is required in the log.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 55 ++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 41853db7c9b8..de816bcafd33 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_opp.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
>  #define LUT_MAX_ENTRIES			40U
> @@ -32,6 +33,7 @@ struct qcom_cpufreq_soc_data {
>  
>  struct qcom_cpufreq_data {
>  	void __iomem *base;
> +	struct regmap *regmap;
>  	const struct qcom_cpufreq_soc_data *soc_data;
>  };
>  
> @@ -85,8 +87,11 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  	struct qcom_cpufreq_data *data = policy->driver_data;
>  	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
>  	unsigned long freq = policy->freq_table[index].frequency;
> +	int ret;
>  
> -	writel_relaxed(index, data->base + soc_data->reg_perf_state);
> +	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
> +	if (ret)
> +		return ret;
>  
>  	if (icc_scaling_enabled)
>  		qcom_cpufreq_set_bw(policy, freq);
> @@ -102,6 +107,7 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
>  	unsigned int index;
> +	int ret;
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (!policy)
> @@ -110,7 +116,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  	data = policy->driver_data;
>  	soc_data = data->soc_data;
>  
> -	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> +	ret = regmap_read(data->regmap, soc_data->reg_perf_state, &index);
> +	if (ret)
> +		return 0;
> +
>  	index = min(index, LUT_MAX_ENTRIES - 1);
>  
>  	return policy->freq_table[index].frequency;
> @@ -123,9 +132,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
>  	unsigned int index;
>  	unsigned long freq;
> +	int ret;
>  
>  	index = policy->cached_resolved_idx;
> -	writel_relaxed(index, data->base + soc_data->reg_perf_state);
> +	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
> +	if (ret)
> +		return 0;
>  
>  	freq = policy->freq_table[index].frequency;
>  	arch_set_freq_scale(policy->related_cpus, freq,
> @@ -171,14 +183,24 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	}
>  
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> -		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
> -				      i * soc_data->lut_row_size);
> +		ret = regmap_read(drv_data->regmap, soc_data->reg_freq_lut +
> +				  i * soc_data->lut_row_size, &data);
> +		if (ret) {
> +			kfree(table);
> +			return ret;
> +		}
> +
>  		src = FIELD_GET(LUT_SRC, data);
>  		lval = FIELD_GET(LUT_L_VAL, data);
>  		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>  
> -		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
> -				      i * soc_data->lut_row_size);
> +		ret = regmap_read(drv_data->regmap, soc_data->reg_volt_lut +
> +				  i * soc_data->lut_row_size, &data);
> +		if (ret) {
> +			kfree(table);
> +			return ret;
> +		}
> +
>  		volt = FIELD_GET(LUT_VOLT, data) * 1000;
>  
>  		if (src)
> @@ -248,6 +270,13 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  	}
>  }
>  
> +static struct regmap_config qcom_cpufreq_regmap = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>  	.reg_enable = 0x0,
>  	.reg_freq_lut = 0x110,
> @@ -274,6 +303,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct qcom_cpufreq_data *data;
>  	const struct of_device_id *match;
>  	int ret, index;
> +	u32 val;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -316,9 +346,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	data->soc_data = match->data;
>  	data->base = base;
> +	data->regmap = devm_regmap_init_mmio(dev, base, &qcom_cpufreq_regmap);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);
> +		goto error;
> +	}
>  
>  	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> +	ret = regmap_read(data->regmap, data->soc_data->reg_enable, &val);
> +	if (ret)
> +		goto error;
> +
> +	if (!(val & 0x1)) {
>  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>  		ret = -ENODEV;
>  		goto error;
> -- 
> 2.17.1

-- 
viresh
