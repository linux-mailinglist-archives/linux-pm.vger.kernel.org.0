Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1652F3328
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbhALOpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 09:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhALOpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 09:45:18 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E4C061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 06:44:37 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d203so2579473oia.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZ6H+36o3j6qUM3JrVIORPFXFSr49vf4C5tKrsAYiiM=;
        b=FeBHS8B6BOxj68A691cxsLmz37r8DC4we2hHRftBP1QB9qZEhSLVY2U/hDCY6/Pfzn
         9PiWKf1AV6EWtYb5HNjMFoWxr5+2URqRFC1E/qURLmL166XIBfuAx+WVbUumdwSO3g0i
         DynyCxz/02wJIy8ZLoduO3711/lgVJSumTAqji//gAkigj3fbq41cKG4Q+oNBATPEYtl
         2sGOOPyGJGrqEvNo156RCxH/5re/kYnk79C6h8irtJ7LUUx9NK8MQgQQPPuHyjrUXfdZ
         df9J3fTmgudCkm5Ct27du4leah5ahUidExO+8u+hRc65W2ujO5SFHNPgfRR5meyCZLDI
         nKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZ6H+36o3j6qUM3JrVIORPFXFSr49vf4C5tKrsAYiiM=;
        b=HQEwDMjIEq/F22fQrwK/wqoeXTAp4BFmz2nDiptk5pVcmbeoYBel5BfmtruiwDR/78
         M0LHEzFUZK8q3M06ttx7QF1oZUOSD2r9XJ4FJmpcF4912LxLxOixonQlmphFXS5T4742
         dsx2l9IycNb0nfLnELq8J1/PN1c4o0TAVYIcY10Bh2C+9kskgC3ti+6kbkO15FdEreFo
         Up7qmVhh9/0CVykwMAsWFVnXKIlGVQFr6CSBBb8h5hXI22HkwDlVyTaWiEPBGNH21irt
         eR1u9mC/a/k825lAL/LG9zzu1cU78QTfO94QIN3uemyD28ombpB7UL9zUkPdmZ19LQBB
         83pQ==
X-Gm-Message-State: AOAM531xztT4FGp07UK4opF0Gx0EBuhO9QqW9Wxn8pRAY6MK4ucn+v3P
        /COdZe6MGUufHIqw6AkbNnyPyA==
X-Google-Smtp-Source: ABdhPJyvHdAobTbF2pWi0eBIKcmPfeIXmG1pEhK8BsDtzUwLLRMGldUEPBmguIk/fpyHj6yFY2OKuw==
X-Received: by 2002:aca:909:: with SMTP id 9mr2451714oij.69.1610462676808;
        Tue, 12 Jan 2021 06:44:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w4sm659828otj.3.2021.01.12.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:44:36 -0800 (PST)
Date:   Tue, 12 Jan 2021 08:44:34 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <X/210llTiuNt3haG@builder.lan>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112095236.20515-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 12 Jan 03:52 CST 2021, Shawn Guo wrote:

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
> 
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

Intuitively I feel that resources allocated in cpufreq_driver->init()
should be explicitly freed in cpufreq_driver->exit() and should thereby
not use devm to track the allocations.

Further more, the fact that one needs to explicitly perform the
release_mem_region explicitly is a good sign that one shouldn't manually
unmap things that was mapped by devm_ioremap_resource().



But afaict when qcom_cpufreq_hw_driver_remove() calls
cpufreq_unregister_driver() to end up in cpufreq_remove_dev() it will
only call cpufreq_driver->exit() iff cpufreq_driver->offline() is
implemented - which it isn't in our case. So without using devm to track
this we would leak the memory - which also implies that we're leaking
the "freq_table" when this happens.

But isn't that simply a typo in cpufreq_remove_dev()? And can't we just
use ioremap()/iounmap() here instead?

Regards,
Bjorn

>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
