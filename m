Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD636056D9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJTFj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 01:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJTFj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 01:39:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275E4B0D7
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 22:39:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j23so24853137lji.8
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G24uPHmZ+Dl0ZLfPWxD9bWyNC0GECvAY5oRSra0CmSY=;
        b=G3/D9RsssoQoipDkXpqrkKUNrGzNUYJs6fEyRnghJwLFH87vglzXUNmwmtXuZSrqei
         OG1CKTZIMjCUfJYXKMRZAFdib0r7KI3phl87Mb4hd8Bd14tJDAB8jkcgSpwxGqrsoTyA
         LonExDF04QEEn5jhUPcf+mHS+ichwcZqv28VtxoriT2doVU6uTl3Wh/npiSRmueIrsqg
         3gohruz17TtMGWR7kPmkSG53GFS51iDb1OYqfGGgy0RhLg4J6rQQlAubVHMlGjZVQPQy
         68nNuGRiY0F6a1r9opoa40tW1l7lu9CsEpuHUAkIj/sIbBybj5+Crm+Hxc/XgztqbY7n
         TyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G24uPHmZ+Dl0ZLfPWxD9bWyNC0GECvAY5oRSra0CmSY=;
        b=tMKGbZUIopXvhauMV5c0zWplOYk7vcWBhEUfaODyIkMeNYQQ/3w7xv+bNBzYHUgZFG
         fgYxZoKea6DkfbEN2jIop1OnpqCD3Q5nArjSimJUqr334P4OSzdpGJY/7A5Z9pyo01DQ
         A5hLQdE4QLbpQu+OwueGFsCmh07GlUzr291TJfYTPGUjzRXFb5hXk5EHs7CWelE0zD+y
         Cp7y2Y6e0a55LZGSZIwkzgS1ovHSGe6YLbc7d1jIKUrv3D4AUhk29aaKkSYoe677KW7o
         io+zJk0Sc6mvPcN84o9aHuF8QyXt+vQdg6v/n/uwapqozHm35sDkvNmUq/kSZjNeXKuh
         +AZw==
X-Gm-Message-State: ACrzQf1v8I5xrURLPr7JStqb5Ukc0ARyoAaRbQrRBsbjvqoweaDv68LD
        Vy6NlDNdHtrCbivDa1T41Bhizg==
X-Google-Smtp-Source: AMsMyM6+WOvv+VytnUlnFfvLP9GA8ZHN5z5J4bJ1K3d/v5WWM7JkmRZR851VRPgN47h2ARI04juAWg==
X-Received: by 2002:a05:651c:1989:b0:26f:d491:e486 with SMTP id bx9-20020a05651c198900b0026fd491e486mr3848329ljb.147.1666244392182;
        Wed, 19 Oct 2022 22:39:52 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0049f53b65790sm2568405lfu.228.2022.10.19.22.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 22:39:51 -0700 (PDT)
Message-ID: <b88de305-cb1f-7251-ccb8-4ea3b62bc322@linaro.org>
Date:   Thu, 20 Oct 2022 08:39:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/4] cpufreq: qcom-hw: Add CPU clock provider support
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
 <20221019135925.366162-4-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019135925.366162-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/10/2022 16:59, Manivannan Sadhasivam wrote:
> Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> cores. But this relationship is not represented with the clk framework
> so far.
> 
> So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> clock producer/consumer relationship cleaner and is also useful for CPU
> related frameworks like OPP to know the frequency at which the CPUs are
> running.
> 
> The clock frequency provided by the driver is for each CPU policy. We
> cannot get the frequency of each CPU core because, not all platforms
> support per-core DCVS feature.
> 
> Also the frequency supplied by the driver is the actual frequency that
> comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> not same as what the CPUFreq framework has set but it is the one that gets
> supplied to the CPUs after throttling by LMh.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 67 +++++++++++++++++++++++++++++--
>   1 file changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a5b3b8d0e164..4dd710f9fb69 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
>   #include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/interconnect.h>
> @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
>   	bool cancel_throttle;
>   	struct delayed_work throttle_work;
>   	struct cpufreq_policy *policy;
> +	struct clk_hw cpu_clk;
>   
>   	bool per_core_dcvs;
>   };
> @@ -482,6 +484,54 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>   	free_irq(data->throttle_irq, data);
>   }
>   
> +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> +
> +	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> +}
> +
> +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> +};
> +
> +static int qcom_cpufreq_hw_clk_add(struct qcom_cpufreq_data *data, u32 index)
> +{
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct device *dev = &pdev->dev;
> +	char *clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", index);
> +	static struct clk_init_data init = {};
> +	int ret;
> +
> +	init.name = clk_name;
> +	init.flags = CLK_GET_RATE_NOCACHE;
> +	init.ops = &qcom_cpufreq_hw_clk_ops;
> +	data->cpu_clk.init = &init;
> +
> +	ret = clk_hw_register(dev, &data->cpu_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> +		return ret;
> +	}
> +
> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, &data->cpu_clk);

This doesn't look corresponding to the DT bindings you are adding. 
of_clk_hw_simple_get() would return a single clock per dt node, 
whichever arguments were passed, while you are adding clocks 
correspoding to CPU clusters.

 From what I see according to the bindings, you should register a single 
provider using the of_clk_hw_onecell_get() function.

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
> +		clk_hw_unregister(&data->cpu_clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static void qcom_cpufreq_hw_clk_remove(struct qcom_cpufreq_data *data)
> +{
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct device *dev = &pdev->dev;
> +
> +	of_clk_del_provider(dev->of_node);
> +	clk_hw_unregister(&data->cpu_clk);
> +}
> +
>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -556,19 +606,24 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	policy->driver_data = data;
>   	policy->dvfs_possible_from_any_cpu = true;
>   
> +	ret = qcom_cpufreq_hw_clk_add(data, index);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to add CPU clock\n", index);
> +		goto error;
> +	}
> +
>   	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>   	if (ret) {
>   		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> -		goto error;
> +		goto clk_remove;
>   	}
>   
>   	ret = dev_pm_opp_get_opp_count(cpu_dev);
>   	if (ret <= 0) {
>   		dev_err(cpu_dev, "Failed to add OPPs\n");
>   		ret = -ENODEV;
> -		goto error;
> +		goto clk_remove;
>   	}
> -
>   	if (policy_has_boost_freq(policy)) {
>   		ret = cpufreq_enable_boost_support();
>   		if (ret)
> @@ -577,9 +632,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   
>   	ret = qcom_cpufreq_hw_lmh_init(policy, index);
>   	if (ret)
> -		goto error;
> +		goto clk_remove;
>   
>   	return 0;
> +
> +clk_remove:
> +	qcom_cpufreq_hw_clk_remove(data);
>   error:
>   	kfree(data);
>   unmap_base:
> @@ -599,6 +657,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>   	dev_pm_opp_remove_all_dynamic(cpu_dev);
>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>   	qcom_cpufreq_hw_lmh_exit(data);
> +	qcom_cpufreq_hw_clk_remove(data);
>   	kfree(policy->freq_table);
>   	kfree(data);
>   	iounmap(base);

-- 
With best wishes
Dmitry

