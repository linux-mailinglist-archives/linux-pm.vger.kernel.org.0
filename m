Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3B261E5E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 21:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgIHTvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgIHPuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 11:50:35 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F9C061368
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:39:15 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h9so4020099ooo.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vBukYCVJ0dPzfynBSfYWtIL6LfPb6kYIege12EwUKjA=;
        b=T63IxB0puDzrheBenrRjLNYbacMf7qUkmO6Wfuaj8oGyxkHKI2Ye9T3wzxtikbG/jv
         bYhDh5/q9/kOp2VwZTF/Fa+HzHT7Hya0h+bcAL5ImpauE2zGkAojSCjj21OJTR//7Q/0
         j1PWQHX8n8/94B8wnCuCCyvhZ61MLKOU2o37GoeFmaAiH05bqEVTVId5tffG7X1PdkeO
         YalM3Vy47YGexvYGu2gW0OnbauxBLxm5oIqibh7TeGfsEHtNiO28E3CkvjSARq97Bl8L
         eOMfiEIa5ndBEAKQoPzqSoCuvvH8Ytm8xjgBVw/2PVE9cwepw3+xua9f4ehIGz5Sj7lq
         0ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBukYCVJ0dPzfynBSfYWtIL6LfPb6kYIege12EwUKjA=;
        b=Z8ufrYRLL4qx4rTT79/iYNedEveIo9knmKiSJ0k2j+C1SHcUnBC3WYD56O9rMdbJGe
         TXADxHJ1aKjCKxtWXKDGwSIKiypYsfDva07HQlRbePZwchLwd9mvH71oGFW8svGfGvQu
         4/OkhDGAmUv+M/npq6kIDAQ+ou0osGJQuHFYxtXgimSpmfuMSclpZl2OkdGZsv080NFY
         w/H0sq4WG4wXgRyDNrsH5B3qUzFgtg0bT8A9LlHL47LXcW54odOGTRQ9J4NqaZmZ3PD3
         sJZjJ1I92ietq7WsheDOEDjRAwxamzmR1zBtxM/i6xm0D2/w1mP8dfXZfzJ6707z48F2
         twSQ==
X-Gm-Message-State: AOAM532CuwXrAMHdEOugHRjkUYtJ/WUYWpIYj9apVPRE/Lhd/5E0Z+VS
        bbIiO2tAF8xQMKQyfPKmoQdSug==
X-Google-Smtp-Source: ABdhPJyBfKsVbBZmtm2xq52k9JBNoPkKHfWeqCb/fyPZs+uEZF3BunlkPpOYAXIIG71UjOJYDRIimA==
X-Received: by 2002:a4a:d8ce:: with SMTP id c14mr18642612oov.90.1599579554861;
        Tue, 08 Sep 2020 08:39:14 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id 34sm1219242otg.23.2020.09.08.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:39:14 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:39:11 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908153911.GR3715@yoga>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:

> Use regmap for accessing cpufreq registers in hardware.
> 

The content of the patch looks good, but in itself I don't see the
reason for migrating to regmap.

If you have subsequent patches, that would benefit from describing the
hardware differences using reg_fields then it might be a good idea, but
I would suggest that you postpone this patch until there's an actual
beneficiary.

Regards,
Bjorn

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
> 
