Return-Path: <linux-pm+bounces-30804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70AB041C8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AE13AF866
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF462571D4;
	Mon, 14 Jul 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n6WEjRAo"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEC23F26A;
	Mon, 14 Jul 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503682; cv=none; b=U0D+dTbMbh3wbsU67IWamS6q8eW5D6xvjwtt+Hm7PMiw7n6GsYxGxco+dJGDCVkT5x8WJsnkge0awvWpdyjGvFHyoHkBTfTESoNkm5srZnoHkYfdIAcq7RQ8PQYtT07gCmJSt0QtEMk/8dNuu8oHgLNRLvo9Ix3/0y5nPIXIy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503682; c=relaxed/simple;
	bh=C64EfHnHMIz677ZQtmfMRi9lhk3psI5/NikDBBeYj6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8VxPXrcjU1/VMQY3coCKmx7+NI/rJ4xTktcdO3ulNqU0scf6o4RZi78V3bwAkStsnqA0s4vuORrQ0AAzAx0/2evQ8wrqfOcOQl6sd1bDQRLZyNBJ5qWTNBmRZw4VxXqMMTFFpJ5qY27bcsc7D5y/Y+HXywVq84r/9IJlEtVxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n6WEjRAo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752503677;
	bh=C64EfHnHMIz677ZQtmfMRi9lhk3psI5/NikDBBeYj6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n6WEjRAoEnnDPHCxUVvgPzx8NXlEGXt6yao4e/J+01gPReIyc9rJzJNtD/0BKny1F
	 g5JZjL2yrCiQTGbFb1JLya5qvGW/f2o7fEgvJkvFRGzDSHElhkiMHFfS7x27ZLrOXT
	 Zomdi/9I2wLMGq7TcWwGxqikXapKeBltunIu93OFdWsN1fzBOtA+FWYg/I2pYtIgBG
	 Cn6h5SOzYwyKMwF24XNCnKdt395tYkPQ0xIiTCsauMzCvFkzX3AujuOpOLzusP3qVY
	 C5JdHLUU4VouD93vtVNkygpP+rlWBszkqbTA+mdkuili2MSibDCFvmW8b5kvBnsIkj
	 OA16Yt9ZvXILw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F2C817E05F0;
	Mon, 14 Jul 2025 16:34:36 +0200 (CEST)
Message-ID: <0c5e1177-c8f0-494f-94f1-de5e01b3715a@collabora.com>
Date: Mon, 14 Jul 2025 16:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpufreq: mediatek-hw: Add support for MT8196
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
 <20250714-mt8196-cpufreq-v2-4-cc85e78855c7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250714-mt8196-cpufreq-v2-4-cc85e78855c7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/25 16:08, Nicolas Frattaroli ha scritto:
> The MT8196 SoC uses DVFS to set a desired target frequency for each CPU
> core. It also uses slightly different register offsets.
> 
> Add support for it, which necessitates reworking how the mmio regs are
> acquired, as mt8196 has the fdvfs config register and the fdvfs
> registers as two reg items before the performance domains.
> 
> I've verified with both `sysbench cpu run` and `head -c 10G \
> /dev/urandom | pigz -p 8 -c - | pv -ba > /dev/null` that we don't just
> get a higher reported clock frequency, but that the observed performance
> also increases, by a factor of 2.64 in an 8 thread sysbench test.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 75 +++++++++++++++++++++++++++++++++--
>   1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 53611077d0d9a2d9865cf771568ab71abc0e6fbd..de6b2b8f6600f23148a7a24cafeae339903ba119 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -24,6 +24,8 @@
>   #define POLL_USEC			1000
>   #define TIMEOUT_USEC			300000
>   
> +#define MT8196_FDVFS_MAGIC		0xABCD0001UL
> +
>   enum {
>   	REG_FREQ_LUT_TABLE,
>   	REG_FREQ_ENABLE,
> @@ -36,7 +38,10 @@ enum {
>   };
>   
>   struct mtk_cpufreq_priv {
> +	struct device *dev;
>   	const struct mtk_cpufreq_variant *variant;
> +	void __iomem *fdvfs_config;
> +	void __iomem *fdvfs;
>   };
>   
>   struct mtk_cpufreq_domain {
> @@ -49,7 +54,10 @@ struct mtk_cpufreq_domain {
>   };
>   
>   struct mtk_cpufreq_variant {
> +	int (*init)(struct mtk_cpufreq_priv *priv);
>   	const u16 reg_offsets[REG_ARRAY_SIZE];
> +	const unsigned int fdvfs_fdiv;
> +	const unsigned int domain_offset;

I don't think you need a domain_offset here, but just a boolean saying that this
"has_fdvfs" or "is_dvfs_hybrid" or something else...

Besides, what about having just a

#define FDVFS_FDIV_HZ (26 * 1000) ?

This is the only platform that uses FDVFS and needs a FDIV, and I don't think that
other FDVFS MCUs will have a different divider.

If so, we can always add that param later to the variant structure, I think?

That'd reduce the change to

struct mtk_cpufreq_pdata {
	int (*hw_init)(struct mtk_cpufreq_priv *priv);
	const u16 reg_offsets[REG_ARRAY_SIZE];
	const bool is_hybrid_dvfs;
};

(don't mind about the naming, I'm just giving you alternatives if you didn't think
about those, I'm not complaining)

>   };
>   
>   static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
> @@ -63,6 +71,37 @@ static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
>   	},
>   };
>   
> +static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
> +{
> +	priv->fdvfs_config = devm_of_iomap(priv->dev, priv->dev->of_node, 0, NULL);
> +	if (IS_ERR_OR_NULL(priv->fdvfs_config))
> +		return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs_config),
> +				     "failed to get fdvfs-config iomem\n");
> +
> +	if (readl_relaxed(priv->fdvfs_config) == MT8196_FDVFS_MAGIC) {

...but then, wait a minute, is the FDVFS_CONFIG used only to check if FDVFS_MAGIC
is present?

If that's all for which it is used for, we might as well just assume that MT8196
always has FDVFS, because, well, it's true - MT8196 and MT6991 always have that
because it's initialized by the firmware before booting the kernel.

If there will be any need at all to initialize the FDVFS in Linux, we can use that
MMIO in a driver that does only that, perhaps...

> +		priv->fdvfs = devm_of_iomap(priv->dev, priv->dev->of_node, 1, NULL);
> +		if (IS_ERR_OR_NULL(priv->fdvfs))
> +			return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),
> +					     "failed to get fdvfs iomem\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtk_cpufreq_variant cpufreq_mtk_mt8196_variant = {
> +	.init = mtk_cpufreq_hw_mt8196_init,
> +	.reg_offsets = {
> +		[REG_FREQ_LUT_TABLE]	= 0x0,
> +		[REG_FREQ_ENABLE]	= 0x84,
> +		[REG_FREQ_PERF_STATE]	= 0x88,
> +		[REG_FREQ_HW_STATE]	= 0x8c,
> +		[REG_EM_POWER_TBL]	= 0x90,
> +		[REG_FREQ_LATENCY]	= 0x114,
> +	},
> +	.fdvfs_fdiv = 26000,
> +	.domain_offset = 2,
> +};
> +
>   static int __maybe_unused
>   mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
>   			  unsigned long *KHz)
> @@ -91,12 +130,31 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
>   	return 0;
>   }
>   
> +static void mtk_cpufreq_hw_fdvfs_switch(unsigned int target_freq,
> +				       struct cpufreq_policy *policy)
> +{
> +	struct mtk_cpufreq_domain *data = policy->driver_data;
> +	struct mtk_cpufreq_priv *priv = data->parent;
> +	unsigned int cpu;
> +
> +	target_freq = DIV_ROUND_UP(target_freq, priv->variant->fdvfs_fdiv);
> +	for_each_cpu(cpu, policy->real_cpus) {
> +		writel_relaxed(target_freq, priv->fdvfs + cpu * 4);
> +	}
> +}
> +
>   static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>   				       unsigned int index)
>   {
>   	struct mtk_cpufreq_domain *data = policy->driver_data;
> +	unsigned int target_freq;
>   
> -	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
> +	if (data->parent->fdvfs) {
> +		target_freq = policy->freq_table[index].frequency;
> +		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
> +	} else {
> +		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
> +	}
>   
>   	return 0;
>   }
> @@ -127,7 +185,10 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>   
>   	index = cpufreq_table_find_index_dl(policy, target_freq, false);
>   
> -	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
> +	if (data->parent->fdvfs)
> +		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
> +	else
> +		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
>   
>   	return policy->freq_table[index].frequency;
>   }
> @@ -188,7 +249,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
>   	if (ret < 0)
>   		return ret;
>   
> -	index = args.args[0];

	index = args.args[0];

	/*
	 * If this is cpufreq with hybrid dvfs, the first declared register range
	 * is FDVFS and each of the frequency domain MMIOs follow that.
	 */
	if (priv->variant->cpufreq_is_hybrid_dvfs)
		index++

Do you like that? Any concern with such a solution? :-)

Cheers,
Angelo

> +	index = args.args[0] + priv->variant->domain_offset;
>   	of_node_put(args.np);
>   
>   	data->parent = priv;
> @@ -339,6 +400,13 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	priv->variant = data;
> +	priv->dev = &pdev->dev;
> +
> +	if (priv->variant->init) {
> +		ret = priv->variant->init(priv);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	platform_set_drvdata(pdev, priv);
>   	cpufreq_mtk_hw_driver.driver_data = pdev;
> @@ -357,6 +425,7 @@ static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
>   
>   static const struct of_device_id mtk_cpufreq_hw_match[] = {
>   	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_base_variant },
> +	{ .compatible = "mediatek,mt8196-cpufreq-hw", .data = &cpufreq_mtk_mt8196_variant },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
> 



