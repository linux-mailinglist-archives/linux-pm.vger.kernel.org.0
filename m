Return-Path: <linux-pm+bounces-39630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB94CC1F73
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 11:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DB033005018
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC2337B9F;
	Tue, 16 Dec 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="Xx8Us6Go"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail6.out.flockmail.com (mail6.out.flockmail.com [18.204.122.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8E33AD8B
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.204.122.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880986; cv=none; b=RhQ2YRxJVql+z0ZPFOgbY5ITGq0oArRq+Nj5gOnDd6mXN+/QxOxohAH7VwiRi1KsoV7IWvO9daGqy5+gjgiSe/gJaKBM1EZW0Dwq5uHWWUZdCOtq/afnvao6Tx2bG56oQXxV0r+irGBzayfjsExGhfo80qDcTlOdeeW9wp8b1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880986; c=relaxed/simple;
	bh=k2H2H60gXQXYrQI4akqnPX4Uiys9VATbOnhr/LIGLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7VC89aCIIPUfXfrlL+BLKSMiaxU984wSuyY6E7Ul0vYkZrb3pEQdIPkTb4PWTxPSkkTH3zOeSYBji/9sBENNipN7f7LbpwfWB+qT/N5JUypWZRUwBL3q9OagiTmTtAaD5T+Pr6/KZumDSCIfQeHVgF07HpF07bsXJJBwifjnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=Xx8Us6Go; arc=none smtp.client-ip=18.204.122.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVtTY6slyz2xBN;
	Tue, 16 Dec 2025 10:29:37 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Nqv+uCahWfvzScOVWccp0oO5/3kRbR83LIZ1y9zYAsA=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=date:from:to:message-id:references:mime-version:in-reply-to:cc:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765880977; v=1;
	b=Xx8Us6God1Rh84FQ679hDWdCa4KG+/mABWS6NOPSdrgbXSI66eCk5cBaAV+rC6H6lMd++v/Q
	M2WRUTzQCtbqKQevsa1cFH08z6HKrg6//aBDVGUY/b4S/gD73Ed31LMdnkQ8ynu0isqrnn+9WeS
	psRn+HD+Gh8MMCP4gf2Eu9tI=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVtTR0rLtz2xCY;
	Tue, 16 Dec 2025 10:29:30 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:29:27 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Shuwei Wu <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: spacemit: k1: Add thermal sensor support
Message-ID: <aUE0h5ORAjfuglqr@pie>
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
 <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765880977805920150.27573.5656934272644109717@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69413491
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=Byx-y9mGAAAA:8
	a=-5OSf9QB08thGc-nJjkA:9 a=CjuIK1q_8ugA:10 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Tue, Dec 16, 2025 at 10:00:36AM +0800, Shuwei Wu wrote:
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
> 
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
> Changes in v2:
> - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
> - Move driver to drivers/thermal/spacemit/
> - Add Kconfig/Makefile for spacemit and update top-level build files
> - Refactor names, style, code alignment, and comments
> - Simplify probe and error handling
> ---
>  drivers/thermal/Kconfig               |   2 +
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/spacemit/Kconfig      |  19 +++
>  drivers/thermal/spacemit/Makefile     |   3 +
>  drivers/thermal/spacemit/k1_tsensor.c | 283 ++++++++++++++++++++++++++++++++++
>  5 files changed, 308 insertions(+)

...

> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f164754e807ddd311c8cf98bcc074fd580514aa2
> --- /dev/null
> +++ b/drivers/thermal/spacemit/k1_tsensor.c
> @@ -0,0 +1,283 @@

...

> +/*
> + * For each sensor, the hardware threshold register is 32 bits:
> + * - Lower 16 bits [15:0] configure the low threshold temperature.
> + * - Upper 16 bits [31:16] configure the high threshold temperature.
> + */
> +static int k1_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
> +	struct k1_tsensor *ts = ch->ts;
> +	int high_code = high;
> +	int low_code = low;

Since high_code and low_code are used to bit operations, please define
them as unsigned types. u32 would be pretty fine here.

Also, you could avoid the initialization of high_code and low_code
here...

> +	u32 val;
> +
> +	if (low >= high)
> +		return -EINVAL;
> +
> +	if (low < 0)
> +		low_code = 0;

... if you change this if to

	if (low < 0)
		low = 0;

...

> +	high_code = high_code / 1000 + TEMPERATURE_OFFSET;
> +	low_code = low_code / 1000 + TEMPERATURE_OFFSET;

... and re-write the right side of the assignments to use high/low
instead.

> +	val = readl(ts->base + K1_TSENSOR_THRSH_REG(ch->id));
> +	val &= ~K1_TSENSOR_THRSH_HIGH_MASK;
> +	val |= FIELD_PREP(K1_TSENSOR_THRSH_HIGH_MASK, high_code);
> +
> +	val &= ~K1_TSENSOR_THRSH_LOW_MASK;
> +	val |= FIELD_PREP(K1_TSENSOR_THRSH_LOW_MASK, low_code);
> +	writel(val, ts->base + K1_TSENSOR_THRSH_REG(ch->id));
> +
> +	return 0;
> +}

...

> +static int k1_tsensor_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k1_tsensor *ts;
> +	struct reset_control *reset;
> +	struct clk *clk, *bus_clk;

You could drop bus_clk here, and re-use clk to retrieve the return value
of devm_clk_get_enabled(dev, "bus"), which also saves you some
characters.

...

> +	clk = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get core clock\n");

clk isn't used anywhere later, so overriding its value is fine.

> +	bus_clk = devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(bus_clk), "Failed to get bus clock\n");
> +
> +			return PTR_ERR(ts->ch[i].tzd);

Regards,
Yao Zi

