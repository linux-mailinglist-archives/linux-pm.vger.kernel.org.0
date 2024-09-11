Return-Path: <linux-pm+bounces-14008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C8974EEF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177991C215C8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459117BED4;
	Wed, 11 Sep 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0V366jw6"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680A45C18;
	Wed, 11 Sep 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047895; cv=none; b=TLAeSle55dCtqwO7RfSnDbEtV6xgA1MuVuom2OjSE6MZMlwhS+5yOqeeRADhf5iKeMYzGuaH4qe8RZBZ9GqLRkT82Zg21ABB7lrBJP5u/VDE0DCJ4G/b9l67MEvSbkG4Uka3UegV/h9Z88v56r8Zd1JdC+cVdvfTXkMVllIjAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047895; c=relaxed/simple;
	bh=qhj7KM8Of8EZEkH4d38oeP6Xh2Sr8VhoFo22LcaMxGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edm6mjs/5C1z8KzFLYpjC3gM5v9C/mYGOafmqt1VFescI1KqTSxaDQ6z0GEICJLplx0A+Y3BgKorUa5/au32h5DUGdT/qTXC75SRN7Jwh33gt+1eqPwXkpM28pb8eppf68DoIKV8naKrv84LnV6JkYLhEI96UiqaT60grT5k3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0V366jw6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNb8FNqNc1pyiluz5XbOkdKPgdGwdFZnKD4YbayYcKs=; b=0V366jw6uETJ6sjPeanMRDucm+
	KrBb5CGgRh9DKb3D32v1lzPu7ijmHE0reQ/aCu7F7N7qHMySUIWoGnKl2ATRnBNcI5lHIa9uZICYR
	7fsDvCepVe12TFIMtdmvoZxlOAq4toPvNzNjainKXSAQf8B01wtHuNL214MmPrjN+yL261N13HXkn
	kj7bmqygquwI+rKjI/jzEinxLorz7gbatnySNjIzbz97p1hDS7CUrHRONpJ9IPLg8y8/ntYgbJlfN
	/mHdB9GKw3yBBqEq8GU5kbAFWSJgJh/harGnIdSFfz2DJM/41t5/qApYNveETrxf65zZltPzvTW/l
	eB0ODdKg==;
Received: from i53875a03.versanet.de ([83.135.90.3] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1soJtk-0007oi-Kw; Wed, 11 Sep 2024 11:44:28 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v1 5/6] pmdomain: rockchip: add regulator support
Date: Wed, 11 Sep 2024 11:46:58 +0200
Message-ID: <2224005.vXnMlVU4IS@diego>
In-Reply-To: <20240910180530.47194-6-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-6-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:14 CEST schrieb Sebastian Reichel:
> Some power domains require extra voltages to be applied. For example
> trying to enable the GPU domain on RK3588 fails when the SoC does not
> have VDD GPU enabled.
> 
> The solution to temporarily change the device's device tree node has
> been taken over from the Mediatek power domain driver.
> 
> The regulator is not acquired at probe time, since that creates circular
> dependencies. The power domain driver must be probed early, since SoC
> peripherals need it. Regulators on the other hand depend on SoC
> peripherals like SPI, I2C or GPIO.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

It does look like Chen-Yu Tsai is working on a similar problem [0].

I.e. this really is a hack, so I started looking around the regulator API
and found of_regulator_bulk_get existing but unused that already
operates on a of-node.

Googling further I stumbled upon the linked patch from some days
ago ;-) . So maybe that could be a cleaner way forward?


[0] https://patchwork.kernel.org/project/linux-mediatek/patch/20240904090016.2841572-6-wenst@chromium.org/

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 57 +++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 663d390faaeb..ae6990897928 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <soc/rockchip/pm_domains.h>
>  #include <dt-bindings/power/px30-power.h>
> @@ -89,6 +90,8 @@ struct rockchip_pm_domain {
>  	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
>  	int num_clks;
>  	struct clk_bulk_data *clks;
> +	struct device_node *node;
> +	struct regulator *supply;
>  };
>  
>  struct rockchip_pmu {
> @@ -571,18 +574,67 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  	return 0;
>  }
>  
> +static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
> +{
> +	return pd->supply ? regulator_disable(pd->supply) : 0;
> +}
> +
> +
> +static int rockchip_pd_regulator_enable(struct rockchip_pm_domain *pd)
> +{
> +	struct rockchip_pmu *pmu = pd->pmu;
> +	struct device_node *main_node;
> +
> +	if (!pd->supply) {
> +		/*
> +		 * Find regulator in current power domain node.
> +		 * devm_regulator_get() finds regulator in a node and its child
> +		 * node, so set of_node to current power domain node then change
> +		 * back to original node after regulator is found for current
> +		 * power domain node.
> +		 */
> +		main_node = pmu->dev->of_node;
> +		pmu->dev->of_node = pd->node;
> +		pd->supply = devm_regulator_get(pmu->dev, "domain");
> +		pmu->dev->of_node = main_node;
> +		if (IS_ERR(pd->supply)) {
> +			pd->supply = NULL;
> +			return 0;
> +		}
> +	}
> +
> +	return regulator_enable(pd->supply);
> +}
> +
>  static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>  {
>  	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
> +	int ret;
> +
> +	ret = rockchip_pd_regulator_enable(pd);
> +	if (ret) {
> +		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> +		return ret;
> +	}
>  
> -	return rockchip_pd_power(pd, true);
> +	ret = rockchip_pd_power(pd, true);
> +	if (ret)
> +		rockchip_pd_regulator_disable(pd);
> +
> +	return ret;
>  }
>  
>  static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>  {
>  	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
> +	int ret;
>  
> -	return rockchip_pd_power(pd, false);
> +	ret = rockchip_pd_power(pd, false);
> +	if (ret)
> +		return ret;
> +
> +	rockchip_pd_regulator_disable(pd);
> +	return ret;
>  }
>  
>  static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
> @@ -663,6 +715,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>  
>  	pd->info = pd_info;
>  	pd->pmu = pmu;
> +	pd->node = node;
>  
>  	pd->num_clks = of_clk_get_parent_count(node);
>  	if (pd->num_clks > 0) {
> 





