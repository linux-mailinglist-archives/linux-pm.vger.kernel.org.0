Return-Path: <linux-pm+bounces-23909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A96A5D9E0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA901897B6E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E2C23BFA9;
	Wed, 12 Mar 2025 09:50:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF1236A73;
	Wed, 12 Mar 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773057; cv=none; b=Wg5hM4uWuPro45He14guu/pgVinJckcfeBu56QVYPw6L/MLQRvCbtwuJCwOBA08LJS/JQkWgkdcur7qRxjK+6C8DDz0jcUei+FN8U+KdPowdgfweggKoLyJF1AiezgqFhMccfca59yg7sS4DJ0ZUbSnqGlO5dtZK0XpA6vtKFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773057; c=relaxed/simple;
	bh=cPaifqjn+79emxa4flNc0qkuWrozQrP5tn9MQpqTWl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+WspqazwcgIkYF7MAs0H79MNl4UgowNFWxUWG2JhPkoGYf3AjA6HXQzmn4cuCbQp2qPRxXEWjFNnAuRbi/Ei/AoPpi1N8OgTqZxuXZ1dQGBKfCHoMt6rSe0aY4wh/WfLKqKovzH4F5b0WmFrkGwKG0OHeLsgBRIpqeOMBJABco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C97152B;
	Wed, 12 Mar 2025 02:51:05 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E443F5A1;
	Wed, 12 Mar 2025 02:50:51 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:50:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
	<tiny.windzz@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<imx@lists.linux.dev>
Subject: Re: [PATCH v2] cpufreq: Init cpufreq only for present CPUs
Message-ID: <Z9FY-Uu-7R9eWEQ7@bogus>
References: <20250312092127.357316-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312092127.357316-1-ping.bai@nxp.com>

On Wed, Mar 12, 2025 at 05:21:27PM +0800, Jacky Bai wrote:
> for_each_possible_cpu() is currently used to initialize cpufreq
> in below cpufreq drivers:
>   drivers/cpufreq/cpufreq-dt.c
>   drivers/cpufreq/mediatek-cpufreq-hw.c
>   drivers/cpufreq/mediatek-cpufreq.c
>   drivers/cpufreq/qcom-cpufreq-nvmem.c
>   drivers/cpufreq/sun50i-cpufreq-nvmem.c
>

Just drop this list, totally redundant as diffstat must give that anyways.
You have already made it stale as it doesn't match the diffstat.

With that fixed:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
> 
> With nosmp or maxcpus=0, only the boot CPU is present, lead
> to the cpufreq probe failure or defer probe due to no cpu device
> available for not present CPUs.
> 
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> above cpufreq drivers to ensure it only registers cpufreq for
> CPUs that are actually present.
> 
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v2 changes:
>   - Add changes for armada-8k-cpufreq, mvebu-cpfureq, qcome-cpufreq-hw,
>     scmi-cpufreq, scpi-cpufreq, virtual-cpufreq.
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c    | 2 +-
>  drivers/cpufreq/cpufreq-dt.c           | 2 +-
>  drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
>  drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
>  drivers/cpufreq/mvebu-cpufreq.c        | 2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
>  drivers/cpufreq/scmi-cpufreq.c         | 2 +-
>  drivers/cpufreq/scpi-cpufreq.c         | 2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
>  drivers/cpufreq/virtual-cpufreq.c      | 2 +-
>  11 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> index 7a979db81f09..5a3545bd0d8d 100644
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -47,7 +47,7 @@ static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
>  {
>  	int cpu;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		struct device *cpu_dev;
>  		struct clk *clk;
>  
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 778916f89a51..e80dd982a3e2 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -283,7 +283,7 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>  	int ret, cpu;
>  
>  	/* Request resources early so we can return in case of -EPROBE_DEFER */
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
>  		if (ret)
>  			goto err;
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index aa209f5527dc..74f1b4c796e4 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -303,7 +303,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  	struct regulator *cpu_reg;
>  
>  	/* Make sure that all CPU supplies are available before proceeding. */
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
>  		if (!cpu_dev)
>  			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 2656b88db378..f3f02c4b6888 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -631,7 +631,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, -ENODEV,
>  				     "failed to get mtk cpufreq platform data\n");
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		info = mtk_cpu_dvfs_info_lookup(cpu);
>  		if (info)
>  			continue;
> diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
> index 7f3cfe668f30..2aad4c04673c 100644
> --- a/drivers/cpufreq/mvebu-cpufreq.c
> +++ b/drivers/cpufreq/mvebu-cpufreq.c
> @@ -56,7 +56,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  	 * it), and registers the clock notifier that will take care
>  	 * of doing the PMSU part of a frequency transition.
>  	 */
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		struct device *cpu_dev;
>  		struct clk *clk;
>  		int ret;
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b3b3dbc7d38..8422704a3b10 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -306,7 +306,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  	struct of_phandle_args args;
>  	int cpu, ret;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		cpu_np = of_cpu_device_node_get(cpu);
>  		if (!cpu_np)
>  			continue;
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 3a8ed723a23e..54f8117103c8 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  		nvmem_cell_put(speedbin_nvmem);
>  	}
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		struct dev_pm_opp_config config = {
>  			.supported_hw = NULL,
>  		};
> @@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	dev_err(cpu_dev, "Failed to register platform device\n");
>  
>  free_opp:
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
>  		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
>  	}
> @@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(cpufreq_dt_pdev);
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
>  		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
>  	}
> @@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
>  	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
>  	unsigned int cpu;
>  
> -	for_each_possible_cpu(cpu)
> +	for_each_present_cpu(cpu)
>  		qcom_cpufreq_suspend_pd_devs(drv, cpu);
>  
>  	return 0;
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ff2897789797..c310aeebc8f3 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -104,7 +104,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
>  	int cpu, tdomain;
>  	struct device *tcpu_dev;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		if (cpu == cpu_dev->id)
>  			continue;
>  
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 048dc43a9997..17cda84f00df 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -65,7 +65,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  	if (domain < 0)
>  		return domain;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		if (cpu == cpu_dev->id)
>  			continue;
>  
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 17d6a149f580..47d6840b3489 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  	snprintf(name, sizeof(name), "speed%d", speed);
>  	config.prop_name = name;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		struct device *cpu_dev = get_cpu_device(cpu);
>  
>  		if (!cpu_dev) {
> @@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  	pr_err("Failed to register platform device\n");
>  
>  free_opp:
> -	for_each_possible_cpu(cpu)
> +	for_each_present_cpu(cpu)
>  		dev_pm_opp_clear_config(opp_tokens[cpu]);
>  	kfree(opp_tokens);
>  
> @@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(cpufreq_dt_pdev);
>  
> -	for_each_possible_cpu(cpu)
> +	for_each_present_cpu(cpu)
>  		dev_pm_opp_clear_config(opp_tokens[cpu]);
>  
>  	kfree(opp_tokens);
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> index 45becb92aa4a..7dd1b0c263c7 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -138,7 +138,7 @@ static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
>  	cur_perf_domain = readl_relaxed(base + policy->cpu *
>  					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
>  		if (!cpu_dev)
>  			continue;
> -- 
> 2.34.1
> 

-- 
Regards,
Sudeep

