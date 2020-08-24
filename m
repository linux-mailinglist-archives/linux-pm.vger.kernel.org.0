Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACF224FB06
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHXKG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHXKGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:06:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2CC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:06:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d188so4566009pfd.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iiK0Gp73r4bwySQTPwmRW8jyiiv/39g4d9wctzmxVp0=;
        b=CbGexZIjU1nx24i0mN9pImZ9EPpEzpynC1O7b202UvVYqaAsndHIWM6dALQ/WkDrz7
         FypNDBnZyqFIz+F6JayBUcdp7euhiNqmzlqZniCIxHDJxEbrd6k8xSR2fWUn2TzH6jwa
         niibtG6t1eMNAjxE3BDejWFLPygoDhocSnoxXCrP187ClBxI6Yo7PVYsEzFaNF62TvnS
         8xfYwrW7DQum/S9/HjigoUqU0+ZwinlGRy5gnHSNe1uws86kBIU2VJ0Q/ntItpj68jzZ
         4tT5yt/tTr5Uk81/Xtn35amn/hCmVed37MNp8CjZ7x+/QY6iIE4k1pkGQAUIqGHiz2iU
         zmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiK0Gp73r4bwySQTPwmRW8jyiiv/39g4d9wctzmxVp0=;
        b=lw/fDqhcR9tVleGaZLneaJz95u/6LRCn362dXgDGezcuID0hftZ76cc2b9fZTSVT2b
         LTmXzejtrr9g1SbH7Tfe0JWU1DKMCJfYLyifA+V7/ZsHaQYI4CB/a6k2HVSvpmICaHan
         vtoEd/e0Kg0hgefE5WwM3toMwXqhKBIAZUNWafGxYjO6fGIJ7+9vg/RcD6UolWYTJPKK
         Whaay84g0Z+/WYk7FYKTe9mnb+ZCuKHO6jl3zvGpH2QZY9VNt9cUCza7ivjzeDNCxMLX
         8r2Gq5htB+dWJQh06TWwwfMEi8V8SaL1uIF8S5rZ+HRo1niMAhFPwbqrsPtdPv95Iq73
         ee7w==
X-Gm-Message-State: AOAM532YY2CEGpR7J4kf9qKusWNTRfuW9OZdi29le5JUYNtZXj/dRbOB
        FT1BkoH09uju+6cJME2c1qFKdQ==
X-Google-Smtp-Source: ABdhPJyBPIvACBNUIHl2f3fGWVhGG1KiIK6pUom04oP8uinr8F7GG+FbgpEiI9q4aaTxfzxrOLafmg==
X-Received: by 2002:a63:1457:: with SMTP id 23mr3067243pgu.80.1598263582267;
        Mon, 24 Aug 2020 03:06:22 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id c5sm3355656pgj.0.2020.08.24.03.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:06:21 -0700 (PDT)
Date:   Mon, 24 Aug 2020 15:36:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200824100619.o6uwnlsaxdgc3l7r@vireshk-i7>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
 <1597302475-15484-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597302475-15484-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-08-20, 15:07, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add MT6779 cpufreq HW support.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  arch/arm64/configs/defconfig          |    1 +
>  drivers/cpufreq/Kconfig.arm           |   11 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  255 +++++++++++++++++++++++++++++++++
>  4 files changed, 268 insertions(+)
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 883e8ba..866a1bf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -86,6 +86,7 @@ CONFIG_CPUFREQ_DT=y
>  CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
> +CONFIG_ARM_MEDIATEK_CPUFREQ_HW=m

What about a 'default m' in Kconfig itself ?

>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_IMX_CPUFREQ_DT=m
>  CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c6cbfc8..81f1cc1 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -121,6 +121,17 @@ config ARM_MEDIATEK_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for MediaTek SoCs.
>  
> +config ARM_MEDIATEK_CPUFREQ_HW
> +	tristate "MediaTek CPUFreq HW driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Support for the CPUFreq HW driver.
> +	  Some MediaTek chipsets have a HW engine to offload the steps
> +	  necessary for changing the frequency of the CPUs. Firmware loaded
> +	  in this engine exposes a programming interface to the OS.
> +	  The driver implements the cpufreq interface for this HW engine.
> +	  Say Y if you want to support CPUFreq HW.
> +
>  config ARM_OMAP2PLUS_CPUFREQ
>  	bool "TI OMAP2+"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index f6670c4..dc1f371 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
>  obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
> +obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ_HW)	+= mediatek-cpufreq-hw.o
>  obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> new file mode 100644
> index 0000000..6752db9
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			32U
> +#define LUT_FREQ			GENMASK(11, 0)
> +#define LUT_VOLT			GENMASK(28, 12)
> +#define LUT_ROW_SIZE			0x4
> +
> +/* Register offsets */
> +#define REG_ENABLE			0x84
> +#define REG_PERF_STATE		0x88
> +
> +static struct platform_device *global_pdev;

Use cpufreq_driver->driver_data for this, it is already used in other
drivers for similar use.

> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	void __iomem *perf_state_reg = policy->driver_data;
> +	unsigned long freq = policy->freq_table[index].frequency;
> +
> +	writel_relaxed(index, perf_state_reg);
> +	arch_set_freq_scale(policy->related_cpus, freq,
> +			    policy->cpuinfo.max_freq);
> +	return 0;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	void __iomem *perf_state_reg;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	perf_state_reg = policy->driver_data;
> +
> +	index = readl_relaxed(perf_state_reg);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int mtk_cpufreq_hw_read_lut(struct device *cpu_dev,

This routine needs to be named better, it is creating the cpufreq
table after all.

> +				   struct cpufreq_policy *policy,
> +				   void __iomem *base)

Please make sure checkpatch --strict doesn't give any errors.

> +{
> +	u32 data;
> +	u32 freq, volt, prev_freq = 0;

Merge these two..

> +	int i = 0;
> +	struct cpufreq_frequency_table	*table;
> +
> +	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> +	if (!table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base + (i * LUT_ROW_SIZE));
> +		freq = FIELD_GET(LUT_FREQ, data) * 1000;
> +		volt = FIELD_GET(LUT_VOLT, data);
> +		if (freq != prev_freq) {
> +			table[i].frequency = freq;
> +			dev_pm_opp_add(cpu_dev, freq * 1000, volt);

Why are you adding OPPs here and rather why using OPP specific stuff
at all in the driver ?

> +			dev_dbg(cpu_dev, "index=%d freq=%d, volt=%d\n", i,
> +				freq, volt);
> +		} else {
> +			break;
> +		}
> +		prev_freq = freq;
> +	}
> +	table[i].frequency = CPUFREQ_TABLE_END;
> +	policy->freq_table = table;
> +	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> +
> +	return 0;
> +}
> +
> +static void mtk_get_related_cpus(int index, struct cpumask *m)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	int cpu, ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "mtk,freq-domain",

Where are bindings of this node and how does this look ?

> +						 "#freq-domain-cells", 0,
> +						 &args);
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, m);
> +	}
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct device *dev = &global_pdev->dev;
> +	struct of_phandle_args args;
> +	struct device_node *cpu_np;
> +	struct device *cpu_dev;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret, index;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("%s: failed to get cpu%d device\n", __func__,
> +		       policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	cpu_np = of_cpu_device_node_get(policy->cpu);
> +	if (!cpu_np)
> +		return -EINVAL;
> +
> +	ret = of_parse_phandle_with_args(cpu_np, "mtk,freq-domain",
> +					 "#freq-domain-cells", 0, &args);
> +	of_node_put(cpu_np);
> +	if (ret)
> +		return ret;
> +
> +	index = args.args[0];
> +	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
> +	if (!res)
> +		return -ENODEV;
> +	base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
> +
> +	mtk_get_related_cpus(index, policy->cpus);
> +	if (!cpumask_weight(policy->cpus)) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		ret = -ENOENT;
> +		goto error;
> +	}
> +
> +	policy->driver_data = base + REG_PERF_STATE;
> +	ret = mtk_cpufreq_hw_read_lut(cpu_dev, policy, base);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> +		goto error;
> +	}
> +
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "Failed to add OPPs\n");
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, (base + REG_ENABLE));
> +	return 0;
> +error:
> +	devm_iounmap(dev, base);
> +	return ret;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +
> +	dev_pm_opp_remove_all_dynamic(cpu_dev);
> +	kfree(policy->freq_table);
> +	devm_iounmap(&global_pdev->dev, base);
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *mtk_cpufreq_hw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_mtk_hw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= mtk_cpufreq_hw_target_index,
> +	.get		= mtk_cpufreq_hw_get,
> +	.init		= mtk_cpufreq_hw_cpu_init,
> +	.exit		= mtk_cpufreq_hw_cpu_exit,
> +	.name		= "mtk-cpufreq-hw",
> +	.attr		= mtk_cpufreq_hw_attr,
> +};
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	global_pdev = pdev;
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret)
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +	else
> +		dev_dbg(&pdev->dev, "mtk CPUFreq HW driver initialized\n");
> +
> +	return ret;
> +}
> +
> +static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +	return cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
> +}
> +
> +static const struct of_device_id mtk_cpufreq_hw_match[] = {
> +	{ .compatible = "mediatek,cpufreq-hw" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
> +
> +static struct platform_driver mtk_cpufreq_hw_driver = {
> +	.probe = mtk_cpufreq_hw_driver_probe,
> +	.remove = mtk_cpufreq_hw_driver_remove,
> +	.driver = {
> +		.name = "mtk-cpufreq-hw",
> +		.of_match_table = mtk_cpufreq_hw_match,
> +	},
> +};
> +
> +static int __init mtk_cpufreq_hw_init(void)
> +{
> +	return platform_driver_register(&mtk_cpufreq_hw_driver);
> +}
> +postcore_initcall(mtk_cpufreq_hw_init);
> +
> +static void __exit mtk_cpufreq_hw_exit(void)
> +{
> +	platform_driver_unregister(&mtk_cpufreq_hw_driver);
> +}
> +module_exit(mtk_cpufreq_hw_exit);
> +
> +MODULE_DESCRIPTION("mtk CPUFREQ HW Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
