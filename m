Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163C2FA4F2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 16:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbhARPjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 10:39:15 -0500
Received: from foss.arm.com ([217.140.110.172]:38158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393416AbhARPjM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 10:39:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA6A01FB;
        Mon, 18 Jan 2021 07:38:25 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8E43F68F;
        Mon, 18 Jan 2021 07:38:25 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:38:23 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: drop devm_xxx() calls from init/exit
 hooks
Message-ID: <20210118153823.GA3310@arm.com>
References: <20210118130603.16176-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118130603.16176-1-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday 18 Jan 2021 at 21:06:03 (+0800), Shawn Guo wrote:
> Commit f17b3e44320b ("cpufreq: qcom-hw: Use
> devm_platform_ioremap_resource() to simplify code") introduces
> a regression on platforms using the driver, by failing to initialise
> a policy, when one is created post hotplug.
> 
> When all the CPUs of a policy are hoptplugged out, the call to .exit()
> and later to devm_iounmap() does not release the memory region that was
> requested during devm_platform_ioremap_resource().  Therefore,
> a subsequent call to .init() will result in the following error, which
> will prevent a new policy to be initialised:
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
> With that being said, the original code was tricky and skipping memory
> region request intentionally to hide this issue.  The true cause is that
> those devm_xxx() device managed functions shouldn't be used for cpufreq
> init/exit hooks, because &pdev->dev is alive across the hooks and will
> not trigger auto resource free-up.  Let's drop the use of device managed
> functions and manually allocate/free resources, so that the issue can be
> fixed properly.
> 
> Fixes: f17b3e44320b ("cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code")
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> 
> I took some of the commit log from Ionela.
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 43 ++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 9ed5341dc515..b529b49649e0 100644
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
> @@ -303,18 +305,33 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	index = args.args[0];
>  
> -	base = devm_platform_ioremap_resource(pdev, index);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>  

Nit: you could move this allocation after all resource reservation and
mapping below, possibly to avoid doing it unless the base address and
the memory resource is actually valid. Or you can keep it here and
remove the use of the local variables, especially the "base" variable.

> -	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		ret = -ENOMEM;
> -		goto error;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	if (!res) {
> +		dev_err(dev, "failed to get mem resource %d\n", index);
> +		ret = -ENODEV;
> +		goto free_data;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), res->name)) {
> +		dev_err(dev, "failed to request resource %pR\n", res);
> +		ret = -EBUSY;
> +		goto free_data;
> +	}
> +
> +	base = ioremap(res->start, resource_size(res));
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "failed to map resource %pR\n", res);
> +		ret = PTR_ERR(base);
> +		goto release_region;
>  	}
>  
>  	data->soc_data = of_device_get_match_data(&pdev->dev);
>  	data->base = base;
> +	data->res = res;
>  
>  	/* HW should be in enabled state to proceed */
>  	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
> @@ -349,7 +366,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  
>  	return 0;
>  error:
> -	devm_iounmap(dev, base);
> +	iounmap(data->base);
> +release_region:
> +	release_mem_region(res->start, resource_size(res));
> +free_data:
> +	kfree(data);
>  	return ret;
>  }
>  
> @@ -357,12 +378,14 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev = get_cpu_device(policy->cpu);
>  	struct qcom_cpufreq_data *data = policy->driver_data;
> -	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct resource *res = data->res;
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>  	kfree(policy->freq_table);
> -	devm_iounmap(&pdev->dev, data->base);
> +	iounmap(data->base);
> +	release_mem_region(res->start, resource_size(res));
> +	kfree(data);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 


I only mentioned a small nit above. Otherwise it looks good to me and it
works nicely on DB845c.

Many thanks,
Ionela.
