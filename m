Return-Path: <linux-pm+bounces-33811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7DB43554
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B20B565A56
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08C2857EF;
	Thu,  4 Sep 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzS0OIkJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B62BDC13;
	Thu,  4 Sep 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973828; cv=none; b=Gl/OvRPsK8pTWlXVfbjyKvwbPYsR0W4WHJdi03TjkAqaB6WffcPKmx37MVN3Fd1QYfWsqgBP7MPzH4US/4Aot9Tu1H8PFdpokrS9SdXrXMfegXipY+7L0NYJ2Scq9WTwmsI3gZcvZ3eOE0Yz+U3PF6Jk9crWESxl0EITPhfW5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973828; c=relaxed/simple;
	bh=F7eR2YP5D7/sCGzQjeS8yBp1r9PNrYYMLqBfkaCETAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LitUqYhGeQkhkuhBNRBIMVvUnMfoNF8GiYzzg7vlW+7Za3qg5OBVlTSZ/1q45NiV03WHyAuJStSiKIZYnW/GmkFVx4NM1K3FvY6w846UyNLLSK6w48prNhKX7ybmQMhmtlnwn80eExJGayyQsccIR+N/ApeoWVDuDeRyQVYcU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzS0OIkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06D2C4CEF1;
	Thu,  4 Sep 2025 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973827;
	bh=F7eR2YP5D7/sCGzQjeS8yBp1r9PNrYYMLqBfkaCETAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzS0OIkJTmcFGrcza21OtHx+duiy+CKHaqJu+I260FftI8oSlXL6CMO437QmpttCo
	 5Qk6KMPKW+ZPCY8otukVcPoUeum0yvnfH3BYh6N220PWc+q/qEXcgeINpPd2WlctBO
	 ziOUX4eZCTk9j9H+VZSpMuoNQJJssC8rJd1ooEBmbNJDCrSc8QUss/hUVAcTgOqGym
	 AKh6XHLWHHq77CNMl07VfErDNjrFze5mB7arRJlIC5htfYjoElHEr6wtQ3YmA6flkL
	 E2U3qWYtswhoYulaoz0ILQ2HdbvS4MzdleOT9PYu+wgsFiZ5omKXc1kebNPVIrLWv2
	 /+CssXk4kFPBw==
Date: Thu, 4 Sep 2025 10:17:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/8] memory: tegra210: Support interconnect framework
Message-ID: <20250904-aloof-cow-of-speed-ad5fe5@kuoka>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-5-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903-t210-actmon-v2-5-e0d534d4f8ea@gmail.com>

On Wed, Sep 03, 2025 at 02:50:11PM -0500, Aaron Kling wrote:
> This makes mc and emc interconnect providers and allows for dynamic
> memory clock scaling.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig             |   1 +
>  drivers/memory/tegra/tegra210-emc-core.c | 274 ++++++++++++++++++++++++++++++-
>  drivers/memory/tegra/tegra210-emc.h      |  23 +++
>  drivers/memory/tegra/tegra210.c          |  81 +++++++++
>  4 files changed, 377 insertions(+), 2 deletions(-)

Patch #3 was memory, patch #4 was soc, patch #5 is memory, so that
mixup pattern continues.

Please address the earlier feedback.

> 
> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
> index fc5a277918267ee8240f9fb9efeb80275db4790b..2d0be29afe2b9ebf9a0630ef7fb6fb43ff359499 100644
> --- a/drivers/memory/tegra/Kconfig
> +++ b/drivers/memory/tegra/Kconfig
> @@ -55,6 +55,7 @@ config TEGRA210_EMC
>  	tristate "NVIDIA Tegra210 External Memory Controller driver"
>  	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
>  	select TEGRA210_EMC_TABLE
> +	select PM_OPP
>  	help
>  	  This driver is for the External Memory Controller (EMC) found on
>  	  Tegra210 chips. The EMC controls the external DRAM on the board.
> diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
> index e96ca4157d48182574310f8caf72687bed7cc16a..f12e60b47fa87d629505cde57310d2bb68fc87f3 100644
> --- a/drivers/memory/tegra/tegra210-emc-core.c
> +++ b/drivers/memory/tegra/tegra210-emc-core.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  #include <soc/tegra/fuse.h>
> @@ -1569,6 +1570,79 @@ static int tegra210_emc_set_rate(struct device *dev,
>  	return 0;
>  }
>  

...

> @@ -1758,6 +1832,193 @@ static void tegra210_emc_debugfs_init(struct tegra210_emc *emc)
>  			    &tegra210_emc_debug_temperature_fops);
>  }
>  
> +static inline struct tegra210_emc *
> +to_tegra210_emc_provider(struct icc_provider *provider)
> +{
> +	return container_of(provider, struct tegra210_emc, icc_provider);
> +}
> +
> +static struct icc_node_data *
> +emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_provider *provider = data;
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	/* External Memory is the only possible ICC route */
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		if (node->id != TEGRA_ICC_EMEM)
> +			continue;
> +
> +		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +		if (!ndata)
> +			return ERR_PTR(-ENOMEM);
> +
> +		/*
> +		 * SRC and DST nodes should have matching TAG in order to have
> +		 * it set by default for a requested path.
> +		 */
> +		ndata->tag = TEGRA_MC_ICC_TAG_ISO;
> +		ndata->node = node;
> +
> +		return ndata;
> +	}
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct tegra210_emc *emc = to_tegra210_emc_provider(dst->provider);
> +	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
> +	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
> +	unsigned long long rate = max(avg_bw, peak_bw);
> +	const unsigned int ddr = 2;

Just use defines in top part for this.

> +	int err;
> +
> +	/*
> +	 * Tegra210 memory layout can be 1 channel at 64-bit or 2 channels
> +	 * at 32-bit each. Either way, the total bus width will always be
> +	 * 64-bit.
> +	 */
> +	const unsigned int dram_data_bus_width_bytes = 64 / 8;

Same here.

> +
> +	/*
> +	 * Tegra210 EMC runs on a clock rate of SDRAM bus. This means that
> +	 * EMC clock rate is twice smaller than the peak data rate because
> +	 * data is sampled on both EMC clock edges.
> +	 */
> +	do_div(rate, ddr * dram_data_bus_width_bytes);
> +	rate = min_t(u64, rate, U32_MAX);
> +
> +	err = emc_set_min_rate(emc, rate, EMC_RATE_ICC);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_interconnect_init(struct tegra210_emc *emc)
> +{
> +	const struct tegra_mc_soc *soc = emc->mc->soc;
> +	struct icc_node *node;
> +	int err;
> +
> +	emc->icc_provider.dev = emc->dev;
> +	emc->icc_provider.set = emc_icc_set;
> +	emc->icc_provider.data = &emc->icc_provider;
> +	emc->icc_provider.aggregate = soc->icc_ops->aggregate;
> +	emc->icc_provider.xlate_extended = emc_of_icc_xlate_extended;
> +	emc->icc_provider.get_bw = tegra_emc_icc_get_init_bw;
> +
> +	icc_provider_init(&emc->icc_provider);
> +
> +	/* create External Memory Controller node */
> +	node = icc_node_create(TEGRA_ICC_EMC);
> +	if (IS_ERR(node)) {
> +		err = PTR_ERR(node);
> +		goto err_msg;
> +	}
> +
> +	node->name = "External Memory Controller";
> +	icc_node_add(node, &emc->icc_provider);
> +
> +	/* link External Memory Controller to External Memory (DRAM) */
> +	err = icc_link_create(node, TEGRA_ICC_EMEM);
> +	if (err)
> +		goto remove_nodes;
> +
> +	/* create External Memory node */
> +	node = icc_node_create(TEGRA_ICC_EMEM);
> +	if (IS_ERR(node)) {
> +		err = PTR_ERR(node);
> +		goto remove_nodes;
> +	}
> +
> +	node->name = "External Memory (DRAM)";
> +	icc_node_add(node, &emc->icc_provider);
> +
> +	err = icc_provider_register(&emc->icc_provider);
> +	if (err)
> +		goto remove_nodes;
> +
> +	return 0;
> +
> +remove_nodes:
> +	icc_nodes_remove(&emc->icc_provider);
> +err_msg:
> +	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> +
> +	return err;
> +}
> +
> +static int tegra_emc_opp_table_init(struct tegra210_emc *emc)
> +{
> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int opp_token, err, max_opps, i;
> +
> +	err = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
> +	if (err < 0) {
> +		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
> +		return err;
> +	}
> +	opp_token = err;
> +
> +	err = dev_pm_opp_of_add_table(emc->dev);
> +	if (err) {
> +		if (err == -ENODEV)
> +			dev_err(emc->dev, "OPP table not found, please update your device tree\n");

So this looks like the actual ABI break.

Best regards,
Krzysztof


