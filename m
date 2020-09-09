Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52926305C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIPQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgIILaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 07:30:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1479C061797
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 04:29:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so1877800pfn.8
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kc6Yomps2D2n8nZdrOeRPm5cJ+KzoM2wVkMkwmBNIZc=;
        b=YEr4mGSp0d7n00uEasiyiXXQg5aJ33rd927jmHwi6ibR7bcAPfJ/9frElok0rlQczZ
         pV/gqKpu8+8xUSf55EC3SmEIb92/EnagqOkfjfF/zGth50KNTLzIg6KEQOtOrh63pU0V
         q/arWVkKCZuxL3yCL0OhMa+ze981HPP8Ooh7ne8lKRuNv7XpAoyK5ii6J5JNAiDRGUw6
         gLF1EttEz5f4N3yZzWgBSkxb++cthtwxiyhbrZljaowSO0Qk6s4XMc68eWxotx7ilBYl
         otJhYH+7P71/jqToYjAtzoT/jidvLmdhRzkOggn//MsWKywSTAXATm0CgpQaKqcu2jqB
         5SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kc6Yomps2D2n8nZdrOeRPm5cJ+KzoM2wVkMkwmBNIZc=;
        b=XcD2VfkEYRm8U/8HgE+c5WB3k6RDDBQwjQXFcELuM9JHC22wB3f7t70fNirXromUpk
         G+/SXcoJPLjd2HkVc5XFYHUz9Jm/qnyI0rznSp5t5OVlbSAfmReJtVu8sfz8hH/chd0R
         SW9mjC8PO68nmTyR4a+XszyYE6fZD9Xb+pWnNKJrrfic11PAW6M0Vtk/jbKk2Z4TFjXx
         aIcgN4Xaz0JjzqUUM/tKwJfOMs2QTVVruxKvcu9/7mSn0B0QpkghEdPTaieXmFRhhohC
         JNPAak78bQO2/oXuJi4pvdjacyyBFmiAb1+rgIPsR2+C3tf0umOpHqgUDCynvCY3tq+T
         5cQA==
X-Gm-Message-State: AOAM5318l9zPCBHeNQ4xykRWXl5TkLFiXa6o8r6rADx801ATnUQJXBYq
        18JwP5cu5oaiiCPE8LugHC3SEQ==
X-Google-Smtp-Source: ABdhPJxCkG1isPqbkrb8m8ZW120W/qZ6CKiKqF5kfPrTwlG3sPQXzqZ4DQ4/F9ndk/QetxRooSTgeg==
X-Received: by 2002:a05:6a00:2b1:: with SMTP id q17mr446412pfs.74.1599650999144;
        Wed, 09 Sep 2020 04:29:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 187sm2390284pfx.174.2020.09.09.04.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:29:58 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:59:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v5 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200909112955.5fm3mv2btr6wrcc7@vireshk-i7>
References: <1599645086-10169-1-git-send-email-hector.yuan@mediatek.com>
 <1599645086-10169-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599645086-10169-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-09-20, 17:51, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add MT6779 cpufreq HW support.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |   12 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  289 +++++++++++++++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c6cbfc8..8e58c12 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -121,6 +121,18 @@ config ARM_MEDIATEK_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for MediaTek SoCs.
>  
> +config ARM_MEDIATEK_CPUFREQ_HW
> +	tristate "MediaTek CPUFreq HW driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	default m
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
> index 0000000..ae4b38b
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,289 @@
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
> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			32U
> +#define LUT_FREQ			GENMASK(11, 0)
> +#define LUT_ROW_SIZE			0x4
> +
> +enum {
> +	REG_LUT_TABLE,
> +	REG_ENABLE,
> +	REG_PERF_STATE,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_mtk {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	cpumask_t related_cpus;
> +};
> +
> +static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
> +	[REG_LUT_TABLE]		= 0x0,
> +	[REG_ENABLE]		= 0x84,
> +	[REG_PERF_STATE]	= 0x88,
> +};
> +
> +static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
> +
> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +	arch_set_freq_scale(policy->related_cpus,
> +			    policy->freq_table[index].frequency,
> +			    policy->cpuinfo.max_freq);

Please drop the arch_set_freq_scale() stuff. This is getting moved to
cpufreq core in another series and will be done by core code for
everyone. Sorry I forgot to mention that earlier.

> +
> +	return 0;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_mtk *c;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	c = policy->driver_data;

What about doing this instead ?

        c = mtk_freq_domain_map[cpu];

You won't require to get policy here, right ?

> +
> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *cpu_dev;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {

Why do you need this here ? You don't use it.

> +		pr_err("%s: failed to get cpu%d device\n", __func__,
> +		       policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +	if (!c) {
> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, c->reg_bases[REG_ENABLE]);

Don't you need to do the opposite of this as well ?
cpufreq_driver->exit ?

> +
> +	return 0;
> +}
> +
> +static struct cpufreq_driver cpufreq_mtk_hw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= mtk_cpufreq_hw_target_index,
> +	.get		= mtk_cpufreq_hw_get,
> +	.init		= mtk_cpufreq_hw_cpu_init,
> +	.name		= "mtk-cpufreq-hw",
> +	.attr		= cpufreq_generic_attr,
> +};
> +
> +static int mtk_cpu_create_freq_table(struct platform_device *pdev,
> +				     struct cpufreq_mtk *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base_table;
> +	u32 data, i, freq, prev_freq = 0;
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	base_table = c->reg_bases[REG_LUT_TABLE];
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base_table + (i * LUT_ROW_SIZE));
> +		freq = FIELD_GET(LUT_FREQ, data) * 1000;
> +
> +		if (freq == prev_freq)
> +			break;
> +
> +		c->table[i].frequency = freq;
> +
> +		dev_dbg(dev, "index=%d freq=%d\n",
> +			i, c->table[i].frequency);
> +
> +		prev_freq = freq;
> +	}
> +
> +	c->table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	return 0;
> +}
> +
> +static int mtk_get_related_cpus(int index, struct cpumask *m)
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
> +		ret = of_parse_phandle_with_args(cpu_np, "mtk-freq-domain",
> +						 "#freq-domain-cells", 0,
> +						 &args);
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, m);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  unsigned int cpu, int index,
> +				  const u16 *offsets)
> +{
> +	struct cpufreq_mtk *c;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret, i, cpu_r;
> +	void __iomem *base;
> +
> +	if (mtk_freq_domain_map[cpu])
> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

Can you use devm_platform_ioremap_resource() here ?

> +
> +	for (i = REG_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	ret = mtk_get_related_cpus(index, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		return ret;
> +	}
> +
> +	ret = mtk_cpu_create_freq_table(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to create OPP\n", index);

Still the wrong error. You didn't fail to create OPP here :)

Just search for OPP in the driver and see if you need to fix that.

> +		return ret;
> +	}
> +
> +	for_each_cpu(cpu_r, &c->related_cpus)
> +		mtk_freq_domain_map[cpu_r] = c;

What about doing this from mtk_get_related_cpus() instead? We already
run the loop there.

> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	const u16 *offsets;
> +	unsigned int cpu;
> +	int ret;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);

This deserves dev_err and maybe you should error out completely ?
Currently if of_cpu_device_node_get() fails for all CPUs, you will
still try to register the cpufreq driver.

> +			continue;
> +		}
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "mtk-freq-domain",
> +						 "#freq-domain-cells", 0,
> +						 &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Get the bases of cpufreq for domains */
> +		ret = mtk_cpu_resources_init(pdev, cpu, args.args[0], offsets);
> +		if (ret) {
> +			dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +	return cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
> +}
> +
> +static const struct of_device_id mtk_cpufreq_hw_match[] = {
> +	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
> +	{}
> +};
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
> +module_init(mtk_cpufreq_hw_init);
> +
> +static void __exit mtk_cpufreq_hw_exit(void)
> +{
> +	platform_driver_unregister(&mtk_cpufreq_hw_driver);
> +}
> +module_exit(mtk_cpufreq_hw_exit);

You can use this instead.

module_platform_driver(mtk_cpufreq_hw_driver);

> +
> +MODULE_DESCRIPTION("mtk CPUFREQ HW Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
