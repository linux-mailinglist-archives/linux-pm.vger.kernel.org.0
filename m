Return-Path: <linux-pm+bounces-34344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F60B512C8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD51188D3DB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF185314A64;
	Wed, 10 Sep 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hut0o4aI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82D3148D4;
	Wed, 10 Sep 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497187; cv=none; b=k6I6ewiPPLDTSTvE2cq6tmNo8xTH5MoFqx6Fop+BxounRFkOFMbmjffvQoi5E8jxuTrsZQKvXRJVilVJGaUxbvVYynZ9v+9sPfglvKMgnVb9B/r29LYWRhN73BE0sPz/GQkJD0hJy/n5HGlIEz2q90WuNn4IgxW5B5IMzPHHYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497187; c=relaxed/simple;
	bh=DG29mR2Uzj3dMeySz9wzg/RJdg+PsDMyEmYkbWnfp5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F58shjjSqjYggIDzGfjFiTGAxTQLwqezK2BhrOFYlPrNFLmag3V7f9QMoFj0ihsM+nCDIOnExqx+w3VFZ/bisPOfIYIA79uNaLC7MrujhD4IbD/NhPL75RLGd8WHs1JC+4m3uVDLw5Qy4dWuc1GgALuSPf6DaUx7KlgT8sLBWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hut0o4aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE81C4CEF0;
	Wed, 10 Sep 2025 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757497187;
	bh=DG29mR2Uzj3dMeySz9wzg/RJdg+PsDMyEmYkbWnfp5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hut0o4aITN8IhWBbeVDXtd+SC34BUn+ftJ03ciGhpANktF6MmaO/7irdZ34XbsDJL
	 a3z0gpB00y4B59dsrzELzNGorBJixpfImFpJ9cpZ+eK5/eJy3fXhJD78PXEDkFM4jI
	 aENpbOsuBKE+7/Pcy7fFQtW5q/4oqeZi5iQZkrUup9HTGXC2IRRlvgJCpRC8kv9X3n
	 rYOotru4HKyn+pzESjCRF4gssRxPPUZq4H/GTyqJ+SvCo5gGI7xOB7xeszw5CrCMst
	 cgqsDU9rbjxjupI9MHqy/Bn0GxeEqNylOoT9lNY9avjmEHhDB1wvhsD7IHweDtPaV3
	 iWsUppX5llJkQ==
Message-ID: <29ec10fa-1ca4-43eb-a865-7219d39c7140@kernel.org>
Date: Wed, 10 Sep 2025 11:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] memory: tegra210: Support interconnect framework
To: webgeek1234@gmail.com, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-5-1403365d571e@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250906-t210-actmon-v3-5-1403365d571e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2025 22:16, Aaron Kling via B4 Relay wrote:
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

return dev_err_probe

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

Write descriptive error messages or skip it. It's printing errors also
on ENOMEM.

I will send a patch to fix existing code.

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

return dev_err_probe

> +	}
> +	opp_token = err;
> +
> +	err = dev_pm_opp_of_add_table(emc->dev);
> +	if (err) {
> +		if (err == -ENODEV)
> +			dev_warn(emc->dev, "OPP table not found, please update your device tree\n");
> +		else
> +			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
> +
> +		goto put_hw_table;
> +	}
> +
> +	max_opps = dev_pm_opp_get_opp_count(emc->dev);
> +	if (max_opps <= 0) {
> +		dev_err(emc->dev, "Failed to add OPPs\n");
> +		goto remove_table;
> +	}
> +
> +	if (emc->num_timings != max_opps) {
> +		dev_err(emc->dev, "OPP table does not match emc table\n");
> +		goto remove_table;
> +	}
> +
> +	for (i = 0; i < emc->num_timings; i++) {
> +		rate = emc->timings[i].rate * 1000;
> +		opp = dev_pm_opp_find_freq_exact(emc->dev, rate, true);
> +		if (IS_ERR(opp)) {
> +			dev_err(emc->dev, "Rate %lu not found in OPP table\n", rate);
> +			goto remove_table;
> +		}
> +
> +		dev_pm_opp_put(opp);
> +	}
> +
> +	dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
> +		      hw_version, clk_get_rate(emc->clk) / 1000000);
> +
> +	return 0;
> +
> +remove_table:
> +	dev_pm_opp_of_remove_table(emc->dev);
> +put_hw_table:
> +	dev_pm_opp_put_supported_hw(opp_token);
> +
> +	return err;
> +}
> +

...

> diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
> index cfa61dd885577a8fbd79c396a1316101197ca1f2..20828a07d2d0cafa739b534c20c12f065b276669 100644
> --- a/drivers/memory/tegra/tegra210.c
> +++ b/drivers/memory/tegra/tegra210.c
> @@ -3,6 +3,9 @@
>   * Copyright (C) 2015 NVIDIA CORPORATION.  All rights reserved.
>   */
>  
> +#include <linux/of.h>
> +#include <linux/device.h>
> +
>  #include <dt-bindings/memory/tegra210-mc.h>
>  
>  #include "mc.h"
> @@ -1273,6 +1276,83 @@ static const struct tegra_mc_reset tegra210_mc_resets[] = {
>  	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
>  };
>  
> +static int tegra210_mc_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	/* TODO: program PTSA */
> +	return 0;
> +}
> +
> +static int tegra210_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	/*
> +	 * ISO clients need to reserve extra bandwidth up-front because
> +	 * there could be high bandwidth pressure during initial filling
> +	 * of the client's FIFO buffers.  Secondly, we need to take into
> +	 * account impurities of the memory subsystem.
> +	 */
> +	if (tag & TEGRA_MC_ICC_TAG_ISO)
> +		peak_bw = tegra_mc_scale_percents(peak_bw, 400);
> +
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static struct icc_node_data *
> +tegra210_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
> +{
> +	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
> +	const struct tegra_mc_client *client;
> +	unsigned int i, idx = spec->args[0];
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	list_for_each_entry(node, &mc->provider.nodes, node_list) {
> +		if (node->id != idx)
> +			continue;
> +
> +		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +		if (!ndata)
> +			return ERR_PTR(-ENOMEM);
> +
> +		client = &mc->soc->clients[idx];
> +		ndata->node = node;
> +
> +		switch (client->swgroup) {
> +		case TEGRA_SWGROUP_DC:
> +		case TEGRA_SWGROUP_DCB:
> +		case TEGRA_SWGROUP_PTC:
> +		case TEGRA_SWGROUP_VI:
> +			/* these clients are isochronous by default */
> +			ndata->tag = TEGRA_MC_ICC_TAG_ISO;
> +			break;
> +
> +		default:
> +			ndata->tag = TEGRA_MC_ICC_TAG_DEFAULT;
> +			break;
> +		}
> +
> +		return ndata;
> +	}
> +
> +	for (i = 0; i < mc->soc->num_clients; i++) {
> +		if (mc->soc->clients[i].id == idx)
> +			return ERR_PTR(-EPROBE_DEFER);

This feels like more reasonable use of deferred probe, but I wonder how
is this condition possible.

This xlate is called at earliest after MC ICC is registered. At this
tage all nodes are created, so previous list_for_each_entry() should
succeed and return. If previous list_for_each_entry() did not return,
how can you find a matching client for which the node will be added
later, thus deferred probe?

This is again existing code, of course :)



Best regards,
Krzysztof

