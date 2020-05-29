Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601791E79FD
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2KAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2KAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 06:00:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A8C03E969
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 03:00:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so939765plr.2
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gSuXGOWGraV02Ow0L0i7sd8hsTVt5hmju0us+gXA8o=;
        b=kyNtSCAtRrsMRC/o10vYfWqp9g05/2+aA61AGbTPKFKMwsBAFXK4iKKDfeXoQzF8hi
         kbWUjy6oWOTPlmvIobL6xMcZnx1SmBlz/xaR5VQ0GR4e/kNB7slw6ZQi8dat0HwJ/To5
         xWkqsuXMvdNRBOz4p/whXCxvz/jwKoTC7GMoKE5HZQDkGF4CJjWBRnrNOqM4uDPKWz9t
         ofSb8YZcQzgUM0S+Y4fLqNIvnVD3EsKVyueAIwPt4kQ+QOaabZy/EbarjIb+SQ8aH+Bl
         gpOCnh7vo3+YE/QZtQ5lmZyCYIkTCrPAhP1je9U0D71Qs52lM9ML6PZyP+4kx8k4OaCU
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gSuXGOWGraV02Ow0L0i7sd8hsTVt5hmju0us+gXA8o=;
        b=XXbIp9sNAlMHIDuWpqKpAkcPjpr2BW6VtE/DCBkuLA58RgTldFqPPWJkOJ7kFU4Ea3
         V8IF+p7GQofwCO7SR4U9Wlqi9yT5aUr0uK2FmG/boVRh4y+R3RqMPyXDMYCZpu1k6aVi
         uiws2pZ5N/PpHUKLOWVYjxyvxLt3HY5lEWy+DSfmVD6CAxTV2l3N9XT/d6uYOLhX8bZF
         Ye8vMuYKv+dDVxcquJlxmP+2Y7OzHAdUc02e/yvkMGq6uhnDhENV+uoItih3a06UBMEe
         a2V8DFhMkoqgaYoS5hcCJ0remxjhKjklr8K3e7mO6nQWTSVweqnTFn02CeGuEh5QUGBO
         lsuw==
X-Gm-Message-State: AOAM532KeA/aIz9eaqU6XCZHBFvZMddBLAsv74jRM9DYuZqZRuRrFqq4
        X0Mgxlnu7M+J/UfwPg41sTDs4w==
X-Google-Smtp-Source: ABdhPJyrzJMEG4Ks4VvFP/4SNrgVTccSb1hrZ9W7XjPAPMwxSUZP7Lv+DJkHwFxglN70sluDC20+3w==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr8548358pjb.131.1590746431426;
        Fri, 29 May 2020 03:00:31 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id d21sm6909350pfd.109.2020.05.29.03.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 03:00:30 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v5 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200529100028.2wz2iqi5vqji2heb@vireshk-i7>
References: <20200527202153.11659-1-sibis@codeaurora.org>
 <20200527202153.11659-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527202153.11659-5-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-05-20, 01:51, Sibi Sankar wrote:
> Add support to parse optional OPP table attached to the cpu node when
> the OPP bandwidth values are populated. This allows for scaling of
> DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V5:
>  * Use dev_pm_opp_adjust_voltage instead [Viresh]
>  * Misc cleanup
> 
> v4:
>  * Split fast switch disable into another patch [Lukasz]
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 77 ++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fc92a8842e252..fbd73d106a3ae 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/cpufreq.h>
>  #include <linux/init.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -31,6 +32,52 @@
>  static unsigned long cpu_hw_rate, xo_rate;
>  static struct platform_device *global_pdev;
>  
> +static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
> +			       unsigned long freq_khz)
> +{
> +	unsigned long freq_hz = freq_khz * 1000;
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	ret = dev_pm_opp_set_bw(dev, opp);
> +	dev_pm_opp_put(opp);
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_update_opp(struct device *cpu_dev,
> +				   unsigned long freq_khz,
> +				   unsigned long volt)
> +{
> +	unsigned long freq_hz = freq_khz * 1000;
> +
> +	if (dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt))
> +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);

What's going on here ? Why add OPP here ?

> +
> +	/* Enable the opp after voltage update */
> +	return dev_pm_opp_enable(cpu_dev, freq_hz);
> +}
> +
> +/* Check for optional interconnect paths on CPU0 */
> +static int qcom_cpufreq_find_icc_paths(struct device *dev)
> +{
> +	struct device *cpu_dev;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev)
> +		return -EPROBE_DEFER;
> +
> +	return dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
> +}
> +

open code this into the probe routine.

>  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  					unsigned int index)
>  {
> @@ -39,6 +86,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  
>  	writel_relaxed(index, perf_state_reg);
>  
> +	qcom_cpufreq_set_bw(policy, freq);
> +
>  	arch_set_freq_scale(policy->related_cpus, freq,
>  			    policy->cpuinfo.max_freq);
>  	return 0;
> @@ -88,12 +137,30 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  {
>  	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>  	u32 volt;
> +	u64 rate;
>  	struct cpufreq_frequency_table	*table;
> +	struct device_node *opp_table_np, *np;
> +	int ret;
>  
>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (!ret) {
> +		/* Disable all opps and cross-validate against LUT */
> +		opp_table_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +		for_each_available_child_of_node(opp_table_np, np) {
> +			ret = of_property_read_u64(np, "opp-hz", &rate);

No way, please use dev_pm_opp_find_freq_*() here instead to grab OPPs
one by one.

> +			if (!ret)
> +				dev_pm_opp_disable(cpu_dev, rate);
> +		}
> +		of_node_put(opp_table_np);
> +	} else if (ret != -ENODEV) {
> +		dev_err(cpu_dev, "Invalid OPP table in Device tree\n");
> +		return ret;
> +	}

Rather put this in the if (ret) block and so the else part doesn't
need extra indentation.

> +
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>  		data = readl_relaxed(base + REG_FREQ_LUT +
>  				      i * LUT_ROW_SIZE);
> @@ -112,7 +179,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  
>  		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>  			table[i].frequency = freq;
> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		} else if (core_count == LUT_TURBO_IND) {
> @@ -133,7 +200,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
> +				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
> +							volt);
>  			}
>  
>  			break;

-- 
viresh
