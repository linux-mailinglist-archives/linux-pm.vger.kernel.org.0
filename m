Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF003DE70E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhHCHNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhHCHNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 03:13:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A15C061764
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 00:13:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so2602970pjr.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJnO/q9aMYt2BAZNZXSA0urhOrU1UN7gjNrdhJYojBM=;
        b=Gs2yCCo/Uz2BlS91VnZxNnyU6UvZsn45TY0xHAshUYpyez8nIZA7AvqD6ey1YBgiZg
         +V3UFUtxP8FyOCVTF9OGu0klWjSB5tjyI8kTipqWT8ACjyOtygnwojFc9R64WKGkBytG
         Ojh5tQkU4RzJLY2xQw4VkML2dsDaQ4nqTGKEzfuBeECnVv5nlubAnT5G1AuTI33mBCo/
         HR5jDVCfDZlYa9pfr5k+/npz/BTfM+gzag9u7kdHHNDVnic8aq91BsiknUaAB+Dd95hs
         DwBBFIz5L3YK9/PghFhJb+l3mh5iejxx1lOKeKFFkL+cv1Bpy8kF3tHopng7ZDzuigUZ
         ODwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJnO/q9aMYt2BAZNZXSA0urhOrU1UN7gjNrdhJYojBM=;
        b=aEhQLpSdbWgrEnEtd+sDumZMYHrQV8LAGUPwjEby43uu7CNrOdxmgo+bSpTr7HFplM
         8pRZjCvq5aT5jlJGQaoca5okqmgocEZFl6LF8iGUKCBK/yRDarXUaBRn8j0GEZ4hm8Is
         d+ZepPnPyi1REnpICLO4w9yP2CYdCrrG0YkYE10eiEYFsN++O9jcdsvoyTmb4E4DxFDS
         bkawBL5dBUvWWn6uil9Jd+SbvaQyGa6IOPW7rIznn2Mlf3NhYFkFFpVuPXoDwjtrORSs
         /X+BddRHpCqSM6PTXuIIC97T5XUh+6hwh2yHx/nLp7uC1QXxsNIhmjTEmBqi2aQABxHD
         wX+Q==
X-Gm-Message-State: AOAM530pnx9FkreMoWSnHxXiGNnFHH5QEhx31LGhlfWRFx5PAPM0+BTK
        NqQnN2CQtoJMACXdHNIuWEGnp+gOMbD5gg==
X-Google-Smtp-Source: ABdhPJwbuIeGfRdVfbCDpH/YKMFhjYkxEYzlq7BvsicneEXmLBZnQmK/h7FJc+7i1q3LpRy10WtzIg==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr20820209pfl.57.1627974784741;
        Tue, 03 Aug 2021 00:13:04 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c24sm16694621pgj.11.2021.08.03.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 00:13:04 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:43:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v13 2/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210803071302.b4ttoqgqdq4dfmwe@vireshk-i7>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
 <1627574891-26514-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627574891-26514-3-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-21, 00:08, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add cpufreq HW support

Please write a proper commit log, what you are adding and which SoCs
it will apply to. Also add a full stop (.) at the end.

> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |   12 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  357 +++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h               |   39 ++++

The changes to cpufreq.h should be done in a separate patch.

> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> new file mode 100644
> index 0000000..ca50a3a
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/energy_model.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			32U
> +#define LUT_FREQ			GENMASK(11, 0)
> +#define LUT_ROW_SIZE			0x4
> +#define CPUFREQ_HW_STATUS		BIT(0)
> +#define SVS_HW_STATUS			BIT(1)
> +#define POLL_USEC			1000
> +#define TIMEOUT_USEC			300000
> +
> +enum {
> +	REG_FREQ_LUT_TABLE,
> +	REG_FREQ_ENABLE,
> +	REG_FREQ_PERF_STATE,
> +	REG_FREQ_HW_STATE,
> +	REG_EM_POWER_TBL,
> +	REG_FREQ_LATENCY,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_mtk {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	int nr_opp;
> +	cpumask_t related_cpus;
> +};
> +
> +static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
> +	[REG_FREQ_LUT_TABLE]	= 0x0,
> +	[REG_FREQ_ENABLE]	= 0x84,
> +	[REG_FREQ_PERF_STATE]	= 0x88,
> +	[REG_FREQ_HW_STATE]	= 0x8c,
> +	[REG_EM_POWER_TBL]	= 0x90,
> +	[REG_FREQ_LATENCY]	= 0x110,
> +};
> +
> +static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
> +
> +static int __maybe_unused
> +mtk_cpufreq_get_cpu_power(unsigned long *mW,
> +			  unsigned long *KHz, struct device *cpu_dev)
> +{
> +	struct cpufreq_mtk *c;
> +	struct cpufreq_policy *policy;
> +	int i;
> +
> +	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	if (!policy)
> +		return 0;
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +
> +	for (i = 0; i < c->nr_opp; i++) {
> +		if (c->table[i].frequency < *KHz)
> +			break;
> +	}
> +	i--;
> +
> +	*KHz = c->table[i].frequency;
> +	*mW = readl_relaxed(c->reg_bases[REG_EM_POWER_TBL] +
> +			    i * LUT_ROW_SIZE) / 1000;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
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
> +	c = mtk_freq_domain_map[policy->cpu];
> +
> +	index = readl_relaxed(c->reg_bases[REG_FREQ_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return c->table[index].frequency;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +					       unsigned int target_freq)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +	unsigned int index;
> +
> +	index = cpufreq_table_find_index_dl(policy, target_freq);
> +
> +	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
> +
> +	return policy->freq_table[index].frequency;
> +}
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
> +	base_table = c->reg_bases[REG_FREQ_LUT_TABLE];
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

Won't this fit in a single line ?

> +
> +		prev_freq = freq;
> +	}
> +
> +	c->table[i].frequency = CPUFREQ_TABLE_END;
> +	c->nr_opp = i;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  unsigned int cpu, int index,
> +				  const u16 *offsets)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *dev = &pdev->dev;
> +	int ret, i;
> +	void __iomem *base;
> +
> +	if (mtk_freq_domain_map[cpu])

This should not happen anymore, isn't it ?

> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	ret = of_perf_domain_get_sharing_cpumask(index, "performance-domains",

Instead of parsing parsing "performance-domains" twice, I would rather
pass a CPU number here instead of index.

> +						 "#performance-domain-cells",
> +						 &c->related_cpus);

You could have directly passed policy->cpus here instead.

> +	if (ret) {
> +		dev_info(dev, "Domain-%d failed to get related CPUs\n", index);
> +		return ret;
> +	}
> +
> +	ret = mtk_cpu_create_freq_table(pdev, c);
> +	if (ret) {
> +		dev_info(dev, "Domain-%d failed to create freq table\n", index);
> +		return ret;
> +	}
> +
> +	mtk_freq_domain_map[cpu] = c;

I will rather use policy->driver_data to store this now.

> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct cpufreq_mtk *c;
> +	struct device *cpu_dev;
> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
> +	struct pm_qos_request *qos_request;
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	const u16 *offsets;
> +	unsigned int latency;
> +	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
> +	int ret;

It looks much more organized when the variable definitions are in
decreasing order of their length, instead of the random order as it is
right now.

> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	cpu_np = of_cpu_device_node_get(policy->cpu);
> +	if (!cpu_np) {
> +		dev_info(&pdev->dev, "Failed to get cpu %d device\n",
> +			 policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
> +					 "#performance-domain-cells", 0,
> +					 &args);
> +	if (ret < 0)

What about dropping cpu_np and same later in the code as well ?

> +		return ret;
> +
> +	/* Get the bases of cpufreq for domains */
> +	ret = mtk_cpu_resources_init(pdev, policy->cpu, args.args[0], offsets);
> +	if (ret) {
> +		dev_info(&pdev->dev, "CPUFreq resource init failed\n");
> +		return ret;
> +	}
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", policy->cpu);
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

Oh you already do this, you can remove mtk_freq_domain_map array now.

> +
> +	latency = readl_relaxed(c->reg_bases[REG_FREQ_LATENCY]);
> +	if (!latency)
> +		latency = CPUFREQ_ETERNAL;
> +
> +	/* us convert to ns */
> +	policy->cpuinfo.transition_latency = latency * 1000;

You want to multiple CPUFREQ_ETERNAL too ?

> +
> +	policy->fast_switch_possible = true;
> +
> +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);

This is a small structure, why not allocate it on stack instead ?

> +	if (!qos_request)
> +		return -ENOMEM;
> +
> +	/* Let CPUs leave idle-off state for SVS CPU initializing */
> +	cpu_latency_qos_add_request(qos_request, 0);
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
> +
> +	if (readl_poll_timeout(c->reg_bases[REG_FREQ_HW_STATE], sig,
> +			       (sig & pwr_hw) == pwr_hw, POLL_USEC,
> +			       TIMEOUT_USEC)) {
> +		if (!(sig & CPUFREQ_HW_STATUS)) {
> +			pr_info("cpufreq hardware of CPU%d is not enabled\n",
> +				policy->cpu);
> +			return -ENODEV;
> +		}
> +
> +		pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
> +	}
> +
> +	cpu_latency_qos_remove_request(qos_request);
> +
> +	em_dev_register_perf_domain(cpu_dev, c->nr_opp, &em_cb, policy->cpus, true);
> +
> +	kfree(qos_request);

Why free after registering for em ? And also move the entire qos thing
into a separate routine instead of adding it to ->init().

> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +
> +	/* HW should be in paused state now */
> +	writel_relaxed(0x0, c->reg_bases[REG_FREQ_ENABLE]);

Please make sure each and every resource is freed here and in probe on
failures.

> +
> +	return 0;
> +}
> +
> +static struct cpufreq_driver cpufreq_mtk_hw_driver = {
> +	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_IS_COOLING_DEV,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= mtk_cpufreq_hw_target_index,
> +	.get		= mtk_cpufreq_hw_get,
> +	.init		= mtk_cpufreq_hw_cpu_init,
> +	.exit		= mtk_cpufreq_hw_cpu_exit,
> +	.fast_switch	= mtk_cpufreq_hw_fast_switch,
> +	.name		= "mtk-cpufreq-hw",
> +	.attr		= cpufreq_generic_attr,
> +};
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	cpufreq_mtk_hw_driver.driver_data = pdev;
> +
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +		return ret;
> +	}
> +
> +	return 0;

You can do return ret here and drop the earlier return and its {}.

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
> +module_platform_driver(mtk_cpufreq_hw_driver);
> +
> +MODULE_DESCRIPTION("Mediatek cpufreq-hw driver");
> +MODULE_LICENSE("GPL v2");

You can add Module-author as well here if you want.

> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd7194..4916d70 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -13,6 +13,8 @@
>  #include <linux/completion.h>
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> @@ -1036,6 +1038,43 @@ void arch_set_freq_scale(const struct cpumask *cpus,
>  }
>  #endif
>  
> +#ifdef CONFIG_CPU_FREQ

There is another CONFIG_CPU_FREQ a few lines above, please use the
same block for this routine as well.

> +static inline int of_perf_domain_get_sharing_cpumask(int index, const char *list_name,
> +						     const char *cell_name,
> +						     struct cpumask *cpumask)
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
> +		ret = of_parse_phandle_with_args(cpu_np, list_name,
> +						 cell_name, 0,
> +						 &args);
> +
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int of_perf_domain_get_sharing_cpumask(int index, const char *list_name,
> +						     const char *cell_name,
> +						     struct cpumask *cpumask)
> +{
> +	return 0;

	return -EOPNOTSUPP;

> +}
> +#endif

-- 
viresh
