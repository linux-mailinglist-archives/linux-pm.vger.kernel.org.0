Return-Path: <linux-pm+bounces-38845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D020AC9050C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 23:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 481F434CD09
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7844325709;
	Thu, 27 Nov 2025 22:58:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2730E0C8;
	Thu, 27 Nov 2025 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284335; cv=none; b=k6NlcOiaehdLufh/IBKNIuBAB764hFci1kDjzrKOSP3rbS/O/T83MV5tPdUMbDPDhTn6GVZ0kOGdZM+y0OG+lIjMZmeDjmutkOxpiQKItZhWTR5wgLiZsOPgpFRXQJ1sWqcaX76GL7XSeIoFN5n3BI7/fhVveY6S7CrFLnCEfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284335; c=relaxed/simple;
	bh=RVBTJiUR7zh4n+gWYRke44xVtV9Onf4/4V8rM+noByw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ6kRF4NBgMq/a/kb6jNN98vLxWUNZFH5vosUaL6Jyo7wziLDbLcnJWkMYnk3aVsTD9UvOnGlgR2E15YwZEHmwhoxgOWc0Tc/WNNsfjY5I95Eq7VEaVYjMiH4ApGzrPLrfAhRkgD1Xgh+rVMOzH6DgfYJt5nAsfJZhyEx5pTIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0560C341F8A;
	Thu, 27 Nov 2025 22:58:52 +0000 (UTC)
Date: Fri, 28 Nov 2025 06:58:48 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Shuwei Wu <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: K1: Add driver for K1 SoC thermal sensor
Message-ID: <20251127225848-GYA1797866@gentoo.org>
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
 <20251127-b4-k1-thermal-v1-2-f32ce47b1aba@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-b4-k1-thermal-v1-2-f32ce47b1aba@163.com>

Hi Shuwei, 

for the title, you could simplify it by adding short prefix/annotation with
my previous comments

thermal: K1: Add driver for K1 SoC thermal sensor
-> thermal: spacemit: k1: Add thermal sensor support


On 02:44 Thu 27 Nov     , Shuwei Wu wrote:
> The thermal sensor unit (TSU) on K1 supports monitoring five temperature
> zones. The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
> 
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
>  drivers/thermal/Kconfig      |  14 ++
>  drivers/thermal/Makefile     |   1 +
>  drivers/thermal/k1_thermal.c | 307 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 322 insertions(+)
> 
> +}
[snip]..
> +
> +static int k1_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k1_thermal_priv *priv;
> +	int i, irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Failed to get/deassert reset control\n");
no need to break the line, it's ok to have 100 column per line
https://elixir.bootlin.com/linux/v6.18-rc7/source/Documentation/dev-tools/checkpatch.rst#L688

P.S: this isn't hard rule and may still up to maintainer..
> +
> +	priv->clk = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Failed to get core clock\n");
ditto
> +
> +	priv->bus_clk = devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(priv->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->bus_clk),
> +				     "Failed to get bus clock\n");
ditto
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
I suggest to group this with dev_request_threaded_irq(), since both of them
are taking care of IRQ related operation
> +
> +	ret = k1_init_sensors(pdev);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		priv->sensors[i].id = i;
> +		priv->sensors[i].priv = priv;
> +		priv->sensors[i].tzd = devm_thermal_of_zone_register(dev,
> +									i, priv->sensors + i,
> +									&k1_thermal_ops);
                                                                  ~~~~~~~~
here is wrong, alignment should match open parentheses, didn't checkpatch.pl warn about this?

> +		if (IS_ERR(priv->sensors[i].tzd))
> +			return dev_err_probe(dev, PTR_ERR(priv->sensors[i].tzd),
> +						"Failed to register thermal zone: %d\n", i);
I'd say, no need to do the verbose print, almost every error path has
print message already
> +
> +		/* Attach sysfs hwmon attributes for userspace monitoring */
> +		ret = devm_thermal_add_hwmon_sysfs(dev, priv->sensors[i].tzd);
> +		if (ret)
> +			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> +
> +		k1_enable_sensor_irq(priv->sensors + i);
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					k1_thermal_irq_thread,
> +					IRQF_ONESHOT, "k1_thermal", priv);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
no need to print extra error message, please refer to:
 https://lore.kernel.org/all/20250805092922.135500-2-panchuang@vivo.com
 https://github.com/torvalds/linux/commit/55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10

-- 
Yixun Lan (dlan)

