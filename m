Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA672F2C6A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbhALKPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 05:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404514AbhALKPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 05:15:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC9C061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 02:14:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id r4so1138392pls.11
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5iSTFwNPbYkUnV4St2XcKkbysvK454B2BvcX9uDXsfw=;
        b=oouQoSvU8qtTR+cxxuakvs/nYUTQCUegBjPTuGBI1i69HXiPnBf3DeUaSHboNZcmun
         2dQHrp3eDdhBmvvUzkgjJw/cswyBeEOmLSSDe3oa5cQ0nMLRyfmThyFKLqpjfaAQrUhY
         tRTD3aLx1tcTE+nSJkBR7lFlkDl0Q7hiuAWlOOJZG3GsXlBAIQ0ylGqpjTlphHQ3W11W
         GReV35vi4xD8cwpLvHq2oQHiu8lHculO0ZPbL1bp4okEpjs0QzCqbfyOHtXULXtJ1LV1
         rV7ZJV+7rR2NLQMD/IHGISk/SEJYT4Pw8/1I/cBBhc/iJDHnvgDFcvXKJPpCuH+Ndpr4
         DgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5iSTFwNPbYkUnV4St2XcKkbysvK454B2BvcX9uDXsfw=;
        b=EzbURiIiCmwI9o7MYnQjBcviTZm8GXYZbA1enehKIwnBit4SQi+YorgQgB55uah/Ns
         WGWKUHxo1vf0+u1ugK9hTxJax18f7uzQYeOVFFRu8uSYdwtyt0Swh/ZA+uSZWGHCDNbg
         h9xpSyV8kN6+o/JjKnHfU1C+/gSDI61iDoa5HvbzbJ++Y1ZAJR1G/X/xr1/+phRTXBLE
         Db1QYET2+99yRjW6g10nkuwr72sVDc9HQE3Q961EiMeQ9ojf1vW+GiYlRLIGSVHgbNFz
         ijUFUUeN2iqOPBwU+DyatT/wcni8D7ZDyHOXU3U7w3kKVLGQ3DZwH9qtfUsg9qQdf2H3
         5tJQ==
X-Gm-Message-State: AOAM5308RDPuAQvx1osneqSmSdhGqmdZQOyohfoQHoGukRWo6CVW7C+J
        Lj5twbnD8MBhzkanhRjjzvF9tRCnqTgzlw==
X-Google-Smtp-Source: ABdhPJz45mPmZrjIh58BTQhk3Ojtq9FJXPW1JRAhOrIAQDCiSXj1NtJW8hUbl7YAsIre6FiY4Wt10A==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr2374505pjo.209.1610446492151;
        Tue, 12 Jan 2021 02:14:52 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id e65sm2655129pfh.175.2021.01.12.02.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 02:14:51 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:44:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210112101449.cmkjaegukxut3tym@vireshk-i7>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112095236.20515-1-shawn.guo@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-01-21, 17:52, Shawn Guo wrote:
> On SDM845/850, running the following commands to put all cores in
> freq-domain1 offline and then get one core back online, there will be
> a request region error seen from qcom-hw driver.
> 
> $ echo 0 > /sys/devices/system/cpu/cpu4/online
> $ echo 0 > /sys/devices/system/cpu/cpu5/online
> $ echo 0 > /sys/devices/system/cpu/cpu6/online
> $ echo 0 > /sys/devices/system/cpu/cpu7/online
> $ echo 1 > /sys/devices/system/cpu/cpu4/online
> 
> [ 3395.915416] CPU4: shutdown
> [ 3395.938185] psci: CPU4 killed (polled 0 ms)
> [ 3399.071424] CPU5: shutdown
> [ 3399.094316] psci: CPU5 killed (polled 0 ms)
> [ 3402.139358] CPU6: shutdown
> [ 3402.161705] psci: CPU6 killed (polled 0 ms)
> [ 3404.742939] CPU7: shutdown
> [ 3404.765592] psci: CPU7 killed (polled 0 ms)
> [ 3411.492274] Detected VIPT I-cache on CPU4
> [ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> [ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> [ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]
> 
> The cause is that the memory region requested in .init hook doesn't get
> released in .exit hook, and the subsequent call to .init will always fail
> on this error.  Let's break down the devm_platform_ioremap_resource()
> call a bit, so that we can have the resource pointer to release memory
> region from .exit hook.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

FWIW, Ionela also sent a fix though I like this one better for the
obvious reasons.

https://lore.kernel.org/lkml/20210108151406.23595-1-ionela.voinescu@arm.com/

> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 9ed5341dc515..315ee987d2d3 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -32,6 +32,7 @@ struct qcom_cpufreq_soc_data {
>  
>  struct qcom_cpufreq_data {
>  	void __iomem *base;
> +	struct resource *res;
>  	const struct qcom_cpufreq_soc_data *soc_data;
>  };
>  
> @@ -280,6 +281,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct of_phandle_args args;
>  	struct device_node *cpu_np;
>  	struct device *cpu_dev;
> +	struct resource *res;
>  	void __iomem *base;
>  	struct qcom_cpufreq_data *data;
>  	int ret, index;
> @@ -303,7 +305,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	index = args.args[0];
>  
> -	base = devm_platform_ioremap_resource(pdev, index);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> @@ -315,6 +318,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	data->soc_data = of_device_get_match_data(&pdev->dev);
>  	data->base = base;
> +	data->res = res;
>  
>  	/* HW should be in enabled state to proceed */
>  	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> @@ -358,11 +362,13 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  	struct device *cpu_dev = get_cpu_device(policy->cpu);
>  	struct qcom_cpufreq_data *data = policy->driver_data;
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct resource *res = data->res;
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>  	kfree(policy->freq_table);
>  	devm_iounmap(&pdev->dev, data->base);
> +	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
>  
>  	return 0;
>  }
> -- 
> 2.17.1

-- 
viresh
