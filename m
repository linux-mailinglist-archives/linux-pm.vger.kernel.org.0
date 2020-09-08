Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40355261C84
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgIHTUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgIHQCR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 12:02:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CEC08C5E9
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 08:31:32 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x69so13867140oia.8
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=65LnmdieavTEhJfi0SrLAQhPeq9YZ5FbUcSHRfimrcA=;
        b=XshfxkSROZwaCAEzapUJ3fJyZee8kn6NO3Ov+5ZejUj1RvIrCkhs0swvXex7NLQCvm
         CSq6RxGewovkv7PVnlmLxeifCrYL644iuyzrHTsszZOoAlTN/C9b+yV8UvzSKhZADTYW
         KtzRUJ2wkH7aTmVZ8A+l8bda1vN08GN/Klbqqv+9uv7H7Fs2/UwAE+9/COUGfwFV8MAj
         69wn0lAj88nQ+lX5MFlk0t6YJrhWz/cMzkP9v09XhAzou1pPi+MOysrUZAoRq1L7Y8v+
         NFyOidO4rSiN7wgGMGI49Es4Gt4ni6bYicRMfLHEpnEzAhsOvovvYbIK8HgIaGgE1hyc
         77Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65LnmdieavTEhJfi0SrLAQhPeq9YZ5FbUcSHRfimrcA=;
        b=cyo+SbZn2HWsDucb4ryNoOmAbixBnxkumA+IKJ+BZuHGPKLQBIx7MvmgH2sOQL+DCh
         R+jYEZURgv/DeezI8SGY8/BkwgE+h+vGMGuvEmRqQhycpHLKjjCcBy7upE8N1LhBe1cU
         /EeeR51zYZYZUOo8/4AMPJw15Q8DtgN/zPXY/Q+KgsVi9PoeSkquDSLde+TbY7zTfo58
         WWsXdUzK9ew2XNfcU8YtuwoXxLDavBJVSbcVp/4juqpPkjSFDiYWAHYeT55tPZT3HpvX
         u8RrWOxeD+6DNojxl2XUwZmoCrnHN76JUtQHQA1cTOCKqIG0rj1i7A2IqyccPx6YMBM3
         Qn9A==
X-Gm-Message-State: AOAM5335xCY197oM0wvrrELVXbdHSNZCVtuzw+FHulznMZKB+dvT1fmQ
        XFzOHnBZ8ZLpuv4cHgqkXMrPKA==
X-Google-Smtp-Source: ABdhPJzPXzWJHImzCAl3VOO0YadgCIjXj+2EESenWHV3cK0TOoZmWKWSJFJ0fin5T0H3XKlA11vGRg==
X-Received: by 2002:aca:31ca:: with SMTP id x193mr3093875oix.16.1599579091302;
        Tue, 08 Sep 2020 08:31:31 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id j66sm3476095otc.74.2020.09.08.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:31:30 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:31:28 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 4/7] cpufreq: qcom-hw: Make use of of_match data for
 offsets and row size
Message-ID: <20200908153128.GP3715@yoga>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-5-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 08 Sep 02:57 CDT 2020, Manivannan Sadhasivam wrote:

> For preparing the driver to handle further SoC revisions, let's use the
> of_match data for getting the device specific offsets and row size instead
> of defining them globally.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 96 +++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index ccea34f61152..41853db7c9b8 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -19,15 +19,21 @@
>  #define LUT_L_VAL			GENMASK(7, 0)
>  #define LUT_CORE_COUNT			GENMASK(18, 16)
>  #define LUT_VOLT			GENMASK(11, 0)
> -#define LUT_ROW_SIZE			32
>  #define CLK_HW_DIV			2
>  #define LUT_TURBO_IND			1
>  
> -/* Register offsets */
> -#define REG_ENABLE			0x0
> -#define REG_FREQ_LUT			0x110
> -#define REG_VOLT_LUT			0x114
> -#define REG_PERF_STATE			0x920
> +struct qcom_cpufreq_soc_data {
> +	u32 reg_enable;
> +	u32 reg_freq_lut;
> +	u32 reg_volt_lut;
> +	u32 reg_perf_state;
> +	u8 lut_row_size;
> +};
> +
> +struct qcom_cpufreq_data {
> +	void __iomem *base;
> +	const struct qcom_cpufreq_soc_data *soc_data;
> +};
>  
>  static unsigned long cpu_hw_rate, xo_rate;
>  static bool icc_scaling_enabled;
> @@ -76,10 +82,11 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
>  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  					unsigned int index)
>  {
> -	void __iomem *perf_state_reg = policy->driver_data;
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
>  	unsigned long freq = policy->freq_table[index].frequency;
>  
> -	writel_relaxed(index, perf_state_reg);
> +	writel_relaxed(index, data->base + soc_data->reg_perf_state);
>  
>  	if (icc_scaling_enabled)
>  		qcom_cpufreq_set_bw(policy, freq);
> @@ -91,7 +98,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  
>  static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  {
> -	void __iomem *perf_state_reg;
> +	struct qcom_cpufreq_data *data;
> +	const struct qcom_cpufreq_soc_data *soc_data;
>  	struct cpufreq_policy *policy;
>  	unsigned int index;
>  
> @@ -99,9 +107,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  	if (!policy)
>  		return 0;
>  
> -	perf_state_reg = policy->driver_data;
> +	data = policy->driver_data;
> +	soc_data = data->soc_data;
>  
> -	index = readl_relaxed(perf_state_reg);
> +	index = readl_relaxed(data->base + soc_data->reg_perf_state);
>  	index = min(index, LUT_MAX_ENTRIES - 1);
>  
>  	return policy->freq_table[index].frequency;
> @@ -110,12 +119,13 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>  static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  						unsigned int target_freq)
>  {
> -	void __iomem *perf_state_reg = policy->driver_data;
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
>  	unsigned int index;
>  	unsigned long freq;
>  
>  	index = policy->cached_resolved_idx;
> -	writel_relaxed(index, perf_state_reg);
> +	writel_relaxed(index, data->base + soc_data->reg_perf_state);
>  
>  	freq = policy->freq_table[index].frequency;
>  	arch_set_freq_scale(policy->related_cpus, freq,
> @@ -125,8 +135,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  }
>  
>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> -				    struct cpufreq_policy *policy,
> -				    void __iomem *base)
> +				    struct cpufreq_policy *policy)
>  {
>  	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>  	u32 volt;
> @@ -134,6 +143,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
>  	int ret;
> +	struct qcom_cpufreq_data *drv_data = policy->driver_data;
> +	const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
>  
>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
> @@ -160,14 +171,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	}
>  
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> -		data = readl_relaxed(base + REG_FREQ_LUT +
> -				      i * LUT_ROW_SIZE);
> +		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
> +				      i * soc_data->lut_row_size);
>  		src = FIELD_GET(LUT_SRC, data);
>  		lval = FIELD_GET(LUT_L_VAL, data);
>  		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>  
> -		data = readl_relaxed(base + REG_VOLT_LUT +
> -				      i * LUT_ROW_SIZE);
> +		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
> +				      i * soc_data->lut_row_size);
>  		volt = FIELD_GET(LUT_VOLT, data) * 1000;
>  
>  		if (src)
> @@ -237,6 +248,20 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  	}
>  }
>  
> +static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> +	.reg_enable = 0x0,
> +	.reg_freq_lut = 0x110,
> +	.reg_volt_lut = 0x114,
> +	.reg_perf_state = 0x920,
> +	.lut_row_size = 32,
> +};
> +
> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> +	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> +
>  static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -246,6 +271,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct device *cpu_dev;
>  	struct resource *res;
>  	void __iomem *base;
> +	struct qcom_cpufreq_data *data;
> +	const struct of_device_id *match;
>  	int ret, index;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
> @@ -275,8 +302,23 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	if (!base)
>  		return -ENOMEM;
>  
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	match = of_match_device(qcom_cpufreq_hw_match, &pdev->dev);

Rather than having to move the qcom_cpufreq_hw_match table and reference
it here, use the more succinct:

	data->soc-data = of_device_get_match_data(&pdev->dev);

Apart from this, I think the patch looks good.

> +	if (!match) {
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +
> +	data->soc_data = match->data;
> +	data->base = base;
> +
>  	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> +	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
>  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>  		ret = -ENODEV;
>  		goto error;
> @@ -289,9 +331,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> -	policy->driver_data = base + REG_PERF_STATE;
> +	policy->driver_data = data;
>  
> -	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
> +	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>  	if (ret) {
>  		dev_err(dev, "Domain-%d failed to read LUT\n", index);
>  		goto error;
> @@ -315,13 +357,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev = get_cpu_device(policy->cpu);
> -	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +	struct qcom_cpufreq_data *data = policy->driver_data;
>  	struct platform_device *pdev = cpufreq_get_driver_data();
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>  	kfree(policy->freq_table);
> -	devm_iounmap(&pdev->dev, base);
> +	devm_iounmap(&pdev->dev, data->base);

PS. Unrelated to your series, I don't like the fact that we use devres
in code paths that's only indirectly tied to the device's life cycle.

Regards,
Bjorn

>  
>  	return 0;
>  }
> @@ -391,12 +433,6 @@ static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
>  	return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
>  }
>  
> -static const struct of_device_id qcom_cpufreq_hw_match[] = {
> -	{ .compatible = "qcom,cpufreq-hw" },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> -
>  static struct platform_driver qcom_cpufreq_hw_driver = {
>  	.probe = qcom_cpufreq_hw_driver_probe,
>  	.remove = qcom_cpufreq_hw_driver_remove,
> -- 
> 2.17.1
> 
