Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06E26A8AD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgIOPW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIOPVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 11:21:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EBC06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 08:21:50 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b13so1905058qvl.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqHQRkFUPiUi6Qqzo8XJhwi1LLKHPy0kZzVG2It1rlM=;
        b=iCpr6NwOUhxXVZDiQO7yus/7TtSaidBDaZnKqFxxIzZsb6ugEeW1ErGWupMk1zt8cL
         RWPcA3ewXoXXdMBIVpUkFZ0/Ad/76QrtHy7LYkPFJClSSLXrW9imNXKWB2y3lCr/ixWu
         r+IbHLwod2ASBaq+jzkIZwWEMXcz4nhBvZNLYc10LdjGWqOndTEkgAuyUHJgpztP/qFS
         HhREylsuJecilEq+NokRJbd8Arq6xSnfdvfQAycJ4cbQzl2ji+i+Df9LBDKGPYLgoLNf
         AaF9Jaxc6vwPOlLcGh8PvkTaCqx/qZrOFyi4AXoCkB32r7WGPc3zjRozLeAqJ/Mn7W5N
         BTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqHQRkFUPiUi6Qqzo8XJhwi1LLKHPy0kZzVG2It1rlM=;
        b=OeMPw5RXwvB9gbCyBMKKfGJ0FDAdquUgMqSLzMAO6s5FkAUx+zWTMtSK1+ir3IK9mu
         yYW+MLjXX1BInJFZroZWfu6+Gsll9scZm/JzLy+Uu9nAB3RW1NxBV0nEClJfcXG43Fey
         LOrc7q0iTEwLgWe3A17UgpDASScaOcElLb3n7o1BaxiLFQjA2vgENj4d6+bUbH9Vcy3v
         jVzzlchyK6CLINg3LX6riAcaHhQMtfbyGQoYHT4bVrc25QhYpjTQpK6bZLzuEfDS++IA
         JlpqGPe5HHQYLik6n5Uo0ahfOhBTV0dk8mEz3kwaJy083zfjLlohXuWblRSyIxg3QdmS
         16GQ==
X-Gm-Message-State: AOAM532JnBn5eag2Wuh8oMa+jkMVdOgbbfr2fbj1c1/v5+y94A2LevlF
        OckjKe7R9Xaal/ZijtH80PTrOQ==
X-Google-Smtp-Source: ABdhPJzz+8qJ9FibGHl7rFQTkOs0RcPVHXW/6EsBzJZ3vd9LnnyZTOpW+dwM15ATVf2WXb+TNHThKw==
X-Received: by 2002:a0c:b44d:: with SMTP id e13mr2933695qvf.19.1600183309416;
        Tue, 15 Sep 2020 08:21:49 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id c70sm4095263qkg.4.2020.09.15.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:21:48 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:21:47 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org
Subject: Re: [PATCH v2 4/5] cpufreq: qcom-hw: Use of_device_get_match_data
 for offsets and row size
Message-ID: <20200915152147.GD478@uller>
References: <20200915072423.18437-1-manivannan.sadhasivam@linaro.org>
 <20200915072423.18437-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915072423.18437-5-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 15 Sep 07:24 UTC 2020, Manivannan Sadhasivam wrote:

> For preparing the driver to handle further SoC revisions, let's use the
> of_device_get_match_data() API for getting the device specific offsets
> and row size instead of defining them globally.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 89 ++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 8a303783927f..e3c46984a037 100644
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
> @@ -245,6 +270,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct device_node *cpu_np;
>  	struct device *cpu_dev;
>  	void __iomem *base;
> +	struct qcom_cpufreq_data *data;
>  	int ret, index;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
> @@ -270,8 +296,17 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	data->soc_data = of_device_get_match_data(&pdev->dev);
> +	data->base = base;
> +
>  	/* HW should be in enabled state to proceed */
> -	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> +	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
>  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>  		ret = -ENODEV;
>  		goto error;
> @@ -284,9 +319,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
> @@ -310,13 +345,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
>  
>  	return 0;
>  }
> @@ -386,12 +421,6 @@ static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
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
