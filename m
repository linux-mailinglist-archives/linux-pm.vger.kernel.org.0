Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282C261216
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIHNhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgIHLLw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:11:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC79C061573
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 04:11:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so4352335pgl.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2U5XwFuEgr/SIRuK7Y7khcG750/bPseN6yZ8Fee6LI=;
        b=AiXbSnLY7gHFWrKM457Y+K5j7df7eoaX90LVLDj4gtMTJTSBd34uNcLxpg7fsM00KI
         uq2ktYqsFlQEDyYCIbir5GHn88IlcE+9jzF78TDPKLUBCSSi4lBlmyOCYBkBvFP+uy4G
         vzMcjG9jfqL0JvndUsDzrBBTROO5uWWlD+/xgWJhSgWoZFPrAxS3FIDcqCqBv3r44av/
         gAh2Hqnl4Kv3U/HG7zdV3GP4VfmHWHzK3J05NMp5CyfMkwj1Gi8RlST8XYmpxyc+vswx
         Nvwv4bRWMi2aZYntYUkkU/QK5hr4jY87gPJSkxXSfkGEJSDiZfMHPp4tniOPtCDE0b4Z
         ftlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2U5XwFuEgr/SIRuK7Y7khcG750/bPseN6yZ8Fee6LI=;
        b=p24GagJnx/qRjHFwWDntTurXQs4xNWE0Rk7qXU+B1M64oUIaiHiLAlHBJGOYcmt/id
         ogW5hazKyH44UkQyVfSLSwYH7fy1HuHjuKThgiEbg/lUwKkTqusKLJoM59JjUCJ7rizP
         cTJCe3nkThUKB4v3eGpmXvOCiV5LxGmnFacCrYqCu1iUDrKCordC+9XbGf83erumP3Qe
         dfbwBaFTY0NjFF5eZcFRCUTWCWUE0vJZrGtEmdp52N5p/lq0gOCLEZsB3th8xRsNp4a8
         2bdNySRTYrw3vbsg9wGsiFgQev7BPwIrjQAQUMI0d+04w6U4n6yRmAA6hxHZwc9qlubR
         fraw==
X-Gm-Message-State: AOAM533Oi5tN41pX6FGyC46MXm4519zXnMQh+ibW7WP56y7Hh465nMmX
        7jNf09Ba2ffmuhPxWhdNHahg
X-Google-Smtp-Source: ABdhPJzpYM3oK34m9Wx8KPE3Q87aKldvytDDqdsa7m2Ow4Hb+OIg+aki/VcWINQYcGZudVi+/wlB5Q==
X-Received: by 2002:a63:f1d:: with SMTP id e29mr6178403pgl.358.1599563510557;
        Tue, 08 Sep 2020 04:11:50 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id md10sm15724081pjb.45.2020.09.08.04.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 04:11:49 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:41:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware
 registers
Message-ID: <20200908111141.GB23095@mani>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
 <20200908103444.5e526uawa45om6lt@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908103444.5e526uawa45om6lt@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 0908, Viresh Kumar wrote:
> On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> > Use regmap for accessing cpufreq registers in hardware.
> 
> Why ? Please mention why a change is required in the log.
> 

Only because it is recommended to use regmap for abstracting the hw access.
Moreover it handles the proper locking for us in the core (spinlock vs mutex).
I've seen many subsystem maintainers prefer regmap over plain readl/writel
calls. I'll add the reason in commit log.

Thanks,
Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 55 ++++++++++++++++++++++++++-----
> >  1 file changed, 47 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 41853db7c9b8..de816bcafd33 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pm_opp.h>
> > +#include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  
> >  #define LUT_MAX_ENTRIES			40U
> > @@ -32,6 +33,7 @@ struct qcom_cpufreq_soc_data {
> >  
> >  struct qcom_cpufreq_data {
> >  	void __iomem *base;
> > +	struct regmap *regmap;
> >  	const struct qcom_cpufreq_soc_data *soc_data;
> >  };
> >  
> > @@ -85,8 +87,11 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> >  	struct qcom_cpufreq_data *data = policy->driver_data;
> >  	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> >  	unsigned long freq = policy->freq_table[index].frequency;
> > +	int ret;
> >  
> > -	writel_relaxed(index, data->base + soc_data->reg_perf_state);
> > +	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (icc_scaling_enabled)
> >  		qcom_cpufreq_set_bw(policy, freq);
> > @@ -102,6 +107,7 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> >  	const struct qcom_cpufreq_soc_data *soc_data;
> >  	struct cpufreq_policy *policy;
> >  	unsigned int index;
> > +	int ret;
> >  
> >  	policy = cpufreq_cpu_get_raw(cpu);
> >  	if (!policy)
> > @@ -110,7 +116,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> >  	data = policy->driver_data;
> >  	soc_data = data->soc_data;
> >  
> > -	index = readl_relaxed(data->base + soc_data->reg_perf_state);
> > +	ret = regmap_read(data->regmap, soc_data->reg_perf_state, &index);
> > +	if (ret)
> > +		return 0;
> > +
> >  	index = min(index, LUT_MAX_ENTRIES - 1);
> >  
> >  	return policy->freq_table[index].frequency;
> > @@ -123,9 +132,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> >  	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
> >  	unsigned int index;
> >  	unsigned long freq;
> > +	int ret;
> >  
> >  	index = policy->cached_resolved_idx;
> > -	writel_relaxed(index, data->base + soc_data->reg_perf_state);
> > +	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
> > +	if (ret)
> > +		return 0;
> >  
> >  	freq = policy->freq_table[index].frequency;
> >  	arch_set_freq_scale(policy->related_cpus, freq,
> > @@ -171,14 +183,24 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
> >  	}
> >  
> >  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > -		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
> > -				      i * soc_data->lut_row_size);
> > +		ret = regmap_read(drv_data->regmap, soc_data->reg_freq_lut +
> > +				  i * soc_data->lut_row_size, &data);
> > +		if (ret) {
> > +			kfree(table);
> > +			return ret;
> > +		}
> > +
> >  		src = FIELD_GET(LUT_SRC, data);
> >  		lval = FIELD_GET(LUT_L_VAL, data);
> >  		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> >  
> > -		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
> > -				      i * soc_data->lut_row_size);
> > +		ret = regmap_read(drv_data->regmap, soc_data->reg_volt_lut +
> > +				  i * soc_data->lut_row_size, &data);
> > +		if (ret) {
> > +			kfree(table);
> > +			return ret;
> > +		}
> > +
> >  		volt = FIELD_GET(LUT_VOLT, data) * 1000;
> >  
> >  		if (src)
> > @@ -248,6 +270,13 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
> >  	}
> >  }
> >  
> > +static struct regmap_config qcom_cpufreq_regmap = {
> > +	.reg_bits = 32,
> > +	.reg_stride = 4,
> > +	.val_bits = 32,
> > +	.fast_io = true,
> > +};
> > +
> >  static const struct qcom_cpufreq_soc_data qcom_soc_data = {
> >  	.reg_enable = 0x0,
> >  	.reg_freq_lut = 0x110,
> > @@ -274,6 +303,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  	struct qcom_cpufreq_data *data;
> >  	const struct of_device_id *match;
> >  	int ret, index;
> > +	u32 val;
> >  
> >  	cpu_dev = get_cpu_device(policy->cpu);
> >  	if (!cpu_dev) {
> > @@ -316,9 +346,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  
> >  	data->soc_data = match->data;
> >  	data->base = base;
> > +	data->regmap = devm_regmap_init_mmio(dev, base, &qcom_cpufreq_regmap);
> > +	if (IS_ERR(data->regmap)) {
> > +		ret = PTR_ERR(data->regmap);
> > +		goto error;
> > +	}
> >  
> >  	/* HW should be in enabled state to proceed */
> > -	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> > +	ret = regmap_read(data->regmap, data->soc_data->reg_enable, &val);
> > +	if (ret)
> > +		goto error;
> > +
> > +	if (!(val & 0x1)) {
> >  		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> >  		ret = -ENODEV;
> >  		goto error;
> > -- 
> > 2.17.1
> 
> -- 
> viresh
