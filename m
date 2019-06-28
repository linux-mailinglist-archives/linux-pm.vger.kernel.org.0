Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5881759607
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF1I0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:26:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1I0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 04:26:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A085560ACA; Fri, 28 Jun 2019 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561710358;
        bh=K0puubr6KjSd/U2wC8/D1AvaBvSGxwauajMJtt24LxU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I9HndQ+/CmYCm+NMCV44KlTBpKX3EYSenyqWHB/avflg/VFHeRooX41CHzGF5gpUh
         nLoe0Z4V6QIzJ8klXSykG6wwz8m5S0jB6JkO7Eakn9dMXYoTAXHz2HtI3bNu6rND8v
         p8vUPRl6c1ae7Ha3NMdjdfKaqeIyrihawbA6xOqY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [106.51.23.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 792FA607C3;
        Fri, 28 Jun 2019 08:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561710357;
        bh=K0puubr6KjSd/U2wC8/D1AvaBvSGxwauajMJtt24LxU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JGxRWFCQWdjd7mVig7t1+xz/bVfp0sgKWQjqqacTY5+NdQUXPjSF/rJ5mzqPISWD1
         VZA47Vrmok12DfKLHvQ2xhfWD748/0+cf0lhkU2Ka5dluyFHwrMGI1gv99c02pT9QN
         M79gfAczgIityx3ErojTBjgZ9Dc9yhp5cyLORhZc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 792FA607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH RFC 3/4] cpufreq: qcom: Update the bandwidth levels on
 frequency change
To:     Sibi Sankar <sibis@codeaurora.org>, viresh.kumar@linaro.org,
        nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com
References: <20190627133424.4980-1-sibis@codeaurora.org>
 <20190627133424.4980-4-sibis@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <aaf49cd8-bc0c-672f-2a20-67382e06461c@codeaurora.org>
Date:   Fri, 28 Jun 2019 13:55:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627133424.4980-4-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/27/2019 7:04 PM, Sibi Sankar wrote:
> Add support to parse and update optional OPP tables attached to the
> cpu nodes when the OPP bandwidth values are populated to enable
> scaling of DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
[]...

>   
> @@ -79,13 +108,29 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>   {
>   	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
>   	u32 volt;
> +	u64 rate;
>   	unsigned int max_cores = cpumask_weight(policy->cpus);
>   	struct cpufreq_frequency_table	*table;
> +	struct device_node *opp_table_np, *np;
> +	int ret;
>   
>   	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>   	if (!table)
>   		return -ENOMEM;
>   
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (!ret) {
> +		/* Disable all opps and cross-validate against LUT */
> +		opp_table_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +		for_each_available_child_of_node(opp_table_np, np) {
> +			ret = of_property_read_u64(np, "opp-hz", &rate);
> +			dev_pm_opp_disable(cpu_dev, rate);
> +		}
> +		of_node_put(opp_table_np);
> +	} else {
> +		dev_err(cpu_dev, "Couldn't add OPP table from dt\n");

The changelog seems to suggest specifying OPP tables in DT is optional,
but here we seem to error out if the tables are missing.

> +	}
> +
>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>   		data = readl_relaxed(base + REG_FREQ_LUT +
>   				      i * LUT_ROW_SIZE);
> @@ -104,7 +149,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>   
>   		if (freq != prev_freq && core_count == max_cores) {
>   			table[i].frequency = freq;
> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
>   			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>   				freq, core_count);
>   		} else {
> @@ -125,7 +170,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>   			if (prev_cc != max_cores) {
>   				prev->frequency = prev_freq;
>   				prev->flags = CPUFREQ_BOOST_FREQ;
> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
> +				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
> +							volt);
>   			}
>   
>   			break;
> @@ -168,6 +214,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct device *dev = &global_pdev->dev;
> +	struct opp_table *opp_table = NULL;
>   	struct of_phandle_args args;
>   	struct device_node *cpu_np;
>   	struct device *cpu_dev;
> @@ -202,6 +249,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	if (!base)
>   		return -ENOMEM;
>   
> +	opp_table = dev_pm_opp_set_paths(cpu_dev);
> +
>   	/* HW should be in enabled state to proceed */
>   	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
>   		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> @@ -237,6 +286,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   
>   	return 0;
>   error:
> +	if (opp_table)
> +		dev_pm_opp_put_paths(opp_table);
>   	devm_iounmap(dev, base);
>   	return ret;
>   }
> @@ -275,6 +326,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>   
>   static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   {
> +	struct opp_table *opp_table = NULL;
> +	struct device *cpu_dev;
>   	struct clk *clk;
>   	int ret;
>   
> @@ -294,6 +347,26 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   
>   	global_pdev = pdev;
>   
> +	/* Check for optional interconnect paths on CPU0 */
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		dev_err(&pdev->dev, "failed to get cpu0 device\n");
> +		return -ENODEV;
> +	}
> +
> +	opp_table = dev_pm_opp_set_paths(cpu_dev);
> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		if (ret == -EPROBE_DEFER) {
> +			dev_dbg(&pdev->dev, "defer icc set paths: %d\n", ret);
> +			return ret;
> +		}
> +		dev_err(&pdev->dev, "set paths failed ddr/l3 scaling off: %d\n",
> +			ret);

Here again, the interconnect paths don't seem to be optional as the comment
above suggests.

> +	} else {
> +		dev_pm_opp_put_paths(opp_table);
> +	}
> +
>   	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>   	if (ret)
>   		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
