Return-Path: <linux-pm+bounces-38727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D6C8AE62
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974133A766D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436933BBB6;
	Wed, 26 Nov 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="a+adtWVJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F933B6DA;
	Wed, 26 Nov 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173664; cv=none; b=AWJ5sTRilwx7QL+ox2+UmQZyjOMJG0a/UAmUD/HQCg3j6Xu22hiyyWCl9RGYykcVR2/Y0LZDJRSVOjrf9l+EkQgcOTVOgpEZYDQtP9Rkvl+eulDJY1nc1a+ggDOltHTR2mCrLPtc47RT/Ix091U4jEadGDdVI+Jt0Sy0av/OsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173664; c=relaxed/simple;
	bh=x0kK1Zt9GMug1E5KSufQyhfENjqsQBZR+UYh60o3iuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW6AA1Dpb7Vu7ObFOWRZWnpg14hSxil2lneBA9JUsPYyWzfzHON/sMlgRLEUqY0U3oZFCNM41hrN5RPI5op3UdPunfQl6HpcsZKBdK8cAl6T9Xw3Jep3bh9oeKKwySN3JiFrF8kL+4jyyyKEJP9dNIWKrQvs8sP9Ux4CtPgm9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=a+adtWVJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2CCC620E95;
	Wed, 26 Nov 2025 17:14:20 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plvOBBVR04nM; Wed, 26 Nov 2025 17:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764173659; bh=x0kK1Zt9GMug1E5KSufQyhfENjqsQBZR+UYh60o3iuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+adtWVJRPL5kbbUY2jOqIkmrmPlTEZpk3zUcm9uIYtnZHEa7GPIOeT6siRgbKfny
	 UHZVKelDJF5J7A2zoLHoVxsgsdJAAvmgYr2NUFscOuCvcu25NGG8lzRdkBsHG72FCU
	 mnT6wIYwmQTcnmzZQvoYW2HcbSEa+6YLNMUssyyb80RovbqPnb1BuoyYsbW95keBUV
	 M0yy1fo6EIlUCvnTKtdQmDygJiAB04HmseDBEDXcgtAfUN+wEhMstJ8+ZLjp3RMBk5
	 SSOih19lEyPDE63aSxJIKyzuSfwee4knPASEzbCg85Z8aC3dp6lebLpFC9dbMUmAls
	 k5o5hRuPXwwCg==
Date: Wed, 26 Nov 2025 16:13:54 +0000
From: Yao Zi <ziyao@disroot.org>
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
Subject: Re: [PATCH 2/3] thermal: K1: Add driver for K1 SoC thermal sensor
Message-ID: <aScnQgLuV3kMLBJg@pie>
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
 <20251127-b4-k1-thermal-v1-2-f32ce47b1aba@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-b4-k1-thermal-v1-2-f32ce47b1aba@163.com>

On Thu, Nov 27, 2025 at 02:44:08AM +0800, Shuwei Wu wrote:
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

...

> diff --git a/drivers/thermal/k1_thermal.c b/drivers/thermal/k1_thermal.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a0e9585cbc5a4e0f7c3a47debb3cfa8e82082d88
> --- /dev/null
> +++ b/drivers/thermal/k1_thermal.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thermal sensor driver for SpacemiT K1 SoC
> + *
> + * Copyright (C) 2025 Shuwei Wu <shuweiwoo@163.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>

devm_kzalloc() is used in the file, but include for linux/slab.h is
missing.

> +#include "thermal_hwmon.h"
> +
> +#define MAX_SENSOR_NUMBER		5
> +#define TEMPERATURE_OFFSET		278
> +
> +#define K1_TSU_INT_EN			0x14
> +#define K1_TSU_INT_CLR			0x10
> +#define K1_TSU_INT_STA			0x18

...

> +#define K1_TSU_EN			0x8

...

> +#define K1_TSU_DATA_BASE		0x20

...

> +#define K1_TSU_THRSH_BASE		0x40

...

> +#define K1_TSU_TIME			0x0C

...

> +#define K1_TSU_PCTRL			0x00

...

> +#define K1_TSU_PCTRL2			0x04

Why not sort these register offsets?

> +struct k1_thermal_sensor {
> +	struct k1_thermal_priv *priv;
> +	struct thermal_zone_device *tzd;
> +	int id;
> +};

> +struct k1_thermal_priv {
> +	void __iomem *base;
> +	struct device *dev;

This variable is set but used nowhere, so I think this could be dropped.

> +	struct clk *clk;
> +	struct clk *bus_clk;
> +	struct reset_control *reset;

With devres-managed API, these three variables are only used in the
probe function, thus could be dropped, too.

> +	struct k1_thermal_sensor sensors[MAX_SENSOR_NUMBER];
> +};
> +
> +static int k1_init_sensors(struct platform_device *pdev)

Suggest passing k1_thermal_priv directly into the function, since
struct platform_device isn't really necessary for it. Also it could
return void, since there's no error to happen.

> +{

...

> +	/*
> +	 * Enable all sensors' auto mode, enable dither control,
> +	 * consecutive mode, and power up sensor.
> +	 */
> +	temp = readl(priv->base + K1_TSU_PCTRL);
> +	temp |= K1_TSU_PCTRL_RAW_SEL |
> +		K1_TSU_PCTRL_TEMP_MODE |
> +		K1_TSU_PCTRL_HW_AUTO_MODE |
> +		K1_TSU_PCTRL_ENABLE;
> +	temp &= ~K1_TSU_PCTRL_SW_CTRL;
> +	temp &= ~K1_TSU_PCTRL_CTUNE;
> +	writel(temp, priv->base + K1_TSU_PCTRL);

It's a nitpick, but I think it'll be better if you follow the same
pattern as in other readl-modification-writel blocks, to clear the bits
then set the desired ones later,

> +	/* Select 24M clk for high speed mode */

This looks a little confusing, in dt-bindings you only listed a core
clock and a bus clock, but neither core nor bus clock runs at 24MHz. So
I suspect there's another clock source supplying the "24MHz clk",
possibly the 24MHz oscillator, and it should be described in
dt-bindings, too.

> +	temp = readl(priv->base + K1_TSU_PCTRL2);
> +	temp &= ~K1_TSU_PCTRL2_CLK_SEL_MASK;
> +	temp |= K1_TSU_PCTRL2_CLK_SEL_24M;
> +	writel(temp, priv->base + K1_TSU_PCTRL2);

...

> +	/* Enable each sensor */
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		temp = readl(priv->base + K1_TSU_EN);
> +		temp &= ~K1_TSU_EN_MASK(i);
> +		temp |= K1_TSU_EN_MASK(i);

What's the point of clearing a bit and setting it again?

Furthermore, this is the only place K1_TSU_EN_MASK is used. If you fold
the modified bits into a macro, let's say, K1_TSU_EN_ALL, to be
GENMASK(MAX_SENSOR_NUNBER - 1, 0), this loop could be replaced with
readl-or-writel operation, which seems much simpler to me.

> +		writel(temp, priv->base + K1_TSU_EN);
> +	}
> +
> +	return 0;
> +}

...

> +/*
> + * The conversion formula used is:
> + * T(m°C) = (((raw_value & mask) >> shift) - TEMPERATURE_OFFSET) * 1000
> + */
> +static int k1_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct k1_thermal_sensor *sensor = thermal_zone_device_priv(tz);
> +	struct k1_thermal_priv *priv = sensor->priv;
> +
> +	*temp = readl(priv->base + K1_TSU_DATA(sensor->id));
> +	*temp &= K1_TSU_DATA_MASK(sensor->id);
> +	*temp >>= K1_TSU_DATA_SHIFT(sensor->id);

FIELD_GET() would help here.

> +
> +	*temp -= TEMPERATURE_OFFSET;
> +
> +	*temp *= 1000;
> +
> +	return 0;
> +}
> +
> +/*
> + * For each sensor, the hardware threshold register is 32 bits:
> + * - Lower 16 bits [15:0] configure the low threshold temperature.
> + * - Upper 16 bits [31:16] configure the high threshold temperature.
> + */
> +static int k1_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{

...

> +	high_code = high_code / 1000 + TEMPERATURE_OFFSET;
> +	temp = readl(priv->base + K1_TSU_THRSH(sensor->id));
> +	temp &= ~K1_TSU_THRSH_HIGH_MASK;
> +	temp |= (high_code << K1_TSU_THRSH_HIGH_SHIFT);
> +	writel(temp, priv->base + K1_TSU_THRSH(sensor->id));
> +
> +	low_code = low_code / 1000 + TEMPERATURE_OFFSET;
> +	temp = readl(priv->base + K1_TSU_THRSH(sensor->id));
> +	temp &= ~K1_TSU_THRSH_LOW_MASK;
> +	temp |= (low_code << K1_TSU_THRSH_LOW_SHIFT);
> +	writel(temp, priv->base + K1_TSU_THRSH(sensor->id));

Similarly, FIELD_PUT() could simplify these threshold setting code.

> +
> +	return 0;
> +}

...

> +static irqreturn_t k1_thermal_irq_thread(int irq, void *data)
> +{
> +	struct k1_thermal_priv *priv = (struct k1_thermal_priv *)data;
> +	int msk, status, i;
> +
> +	status = readl(priv->base + K1_TSU_INT_STA);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; i++) {
> +		if (status & K1_TSU_INT_MASK(i)) {
> +			msk = readl(priv->base + K1_TSU_INT_CLR);
> +			msk |= K1_TSU_INT_MASK(i);
> +			writel(msk, priv->base + K1_TSU_INT_CLR);
> +			/* Notify thermal framework to update trips */

Purpose of the code looks obvious, do you think the comment should be
dropped?

> +			thermal_zone_device_update(priv->sensors[i].tzd, THERMAL_EVENT_UNSPECIFIED);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int k1_thermal_probe(struct platform_device *pdev)
> +{

...

> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);

Why not using dev_err_probe() here?

...

> +	ret = k1_init_sensors(pdev);

k1_init_sensors would never fail, suggest changing it to return void,
and get rid of assignment to ret here.

Best regards,
Yao Zi

