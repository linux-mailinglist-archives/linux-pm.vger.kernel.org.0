Return-Path: <linux-pm+bounces-38795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC0C8E110
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622484E59F9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9B32B9B1;
	Thu, 27 Nov 2025 11:38:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFD32AAC4;
	Thu, 27 Nov 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243494; cv=none; b=hNZbHq10h+c4Q++K/jNz5/QeJTqUZrf18Q/JuvQpwWNqo1L4KoqH72RT6WaPdVKYtBkDroXdYPBMcClDJLguKQoMagZP8lSyAxnfru7qFytqYSe2PU3T4hx25liArU9B2x5vz6nwvzbipnO0jfrQKTZHEmASTnJ+kw1D2QvnizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243494; c=relaxed/simple;
	bh=baktSXSGzehKpc845xZ9D5zy9Pp0XDza9T9sHnWZzJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7UwkYCeds6LhZJihJ6Xp46gy3bk9ER1OhMSO124b9BCNU2bl51czDy2w/njAejInhHr0VX/o+fcvPfsN5yafWUBSrE6gexChSGdqrX2/ikdxLSprD2Jf6WKeMKGY4Rp6rcOeeKucFrl0Gfh/SoPA2ORI2PPkMN59d5POpY8m8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C3216341FD3;
	Thu, 27 Nov 2025 11:38:11 +0000 (UTC)
Date: Thu, 27 Nov 2025 19:38:00 +0800
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
Message-ID: <20251127113800-GYA1795104@gentoo.org>
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

Hi Shuwei,

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
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a09c188b9ad11377afe232d89c60504eb7000417..76095d2888980718b39470c09731092a21f7159b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -495,6 +495,20 @@ config SPRD_THERMAL
>  	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
>  	  framework.
>  
> +config K1_THERMAL
please name it as SPACEMIT_K1_THERMAL, having K1 only is too short

> +	tristate "SpacemiT K1 thermal sensor driver"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	help
> +	  This driver provides support for the thermal sensor unit (TSU)
> +	  integrated in the SpacemiT K1 SoC.
> +
> +	  The TSU monitors temperatures for five thermal zones: soc, package,
> +	  gpu, cluster0, and cluster1. It supports reporting temperature
> +	  values and handling high/low threshold interrupts.
> +
> +	  Say Y here if you want to enable thermal monitoring on SpacemiT K1.
> +	  If compiled as a module, it will be called k1_thermal.
> +
>  config KHADAS_MCU_FAN_THERMAL
>  	tristate "Khadas MCU controller FAN cooling support"
>  	depends on OF
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d7718978db245faffba98ff95a07c7bcbc776fd2..bf28ffe7a39f916acd608ea6d592c82049b0be17 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> +obj-$(CONFIG_K1_THERMAL)	+= k1_thermal.o
same reason to adjust filename
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>  obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
>  obj-$(CONFIG_THERMAL_CORE_TESTING)	+= testing/
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
> +
> +#include "thermal_hwmon.h"
> +
> +#define MAX_SENSOR_NUMBER		5
> +#define TEMPERATURE_OFFSET		278
this seems a magic number? could you improve the name a bit,
or better put a comment to have a explanation

> +
> +#define K1_TSU_INT_EN			0x14
> +#define K1_TSU_INT_CLR			0x10
> +#define K1_TSU_INT_STA			0x18
> +
> +#define K1_TSU_INT_EN_MASK		BIT(0)
> +#define K1_TSU_INT_MASK(x)		(GENMASK(2, 1) << ((x) * 2))
> +
> +#define K1_TSU_EN			0x8
> +#define K1_TSU_EN_MASK(x)		BIT(x)
> +
> +#define K1_TSU_DATA_BASE		0x20
..
> +#define K1_TSU_DATA(x)			(K1_TSU_DATA_BASE + ((x) / 2) * 4)
so this is a register after taking a look at the code..
can you add a 'REG' explicitly? same reason for others

> +#define K1_TSU_DATA_MASK(x)		(((x) % 2) ? GENMASK(31, 16) : GENMASK(15, 0))
> +#define K1_TSU_DATA_SHIFT(x)		(((x) % 2) ? 16 : 0)
There is only one call, can you just fold it there? instead of using this magic

> +
> +#define K1_TSU_THRSH_BASE		0x40
> +#define K1_TSU_THRSH(x)			(K1_TSU_THRSH_BASE + ((x) * 4))
> +#define K1_TSU_THRSH_HIGH_MASK		GENMASK(31, 16)
> +#define K1_TSU_THRSH_LOW_MASK		GENMASK(15, 0)
> +#define K1_TSU_THRSH_HIGH_SHIFT		16
> +#define K1_TSU_THRSH_LOW_SHIFT		0
> +
> +#define K1_TSU_TIME			0x0C
> +#define K1_TSU_TIME_MASK		GENMASK(23, 0)
> +#define K1_TSU_TIME_FILTER_PERIOD	GENMASK(21, 20)
> +#define K1_TSU_TIME_ADC_CNT_RST		GENMASK(7, 4)
> +#define K1_TSU_TIME_WAIT_REF_CNT	GENMASK(3, 0)
> +
> +#define K1_TSU_PCTRL			0x00
> +#define K1_TSU_PCTRL_RAW_SEL		BIT(7)
> +#define K1_TSU_PCTRL_TEMP_MODE		BIT(3)
> +#define K1_TSU_PCTRL_ENABLE		BIT(0)
> +
> +#define K1_TSU_PCTRL_SW_CTRL		GENMASK(21, 18)
> +#define K1_TSU_PCTRL_CTUNE		GENMASK(11, 8)
> +#define K1_TSU_PCTRL_HW_AUTO_MODE	BIT(23)
> +
> +#define K1_TSU_PCTRL2			0x04
> +#define K1_TSU_PCTRL2_CLK_SEL_MASK	GENMASK(15, 14)
> +#define K1_TSU_PCTRL2_CLK_SEL_24M	(0 << 14)
> +
> +struct k1_thermal_sensor {
> +	struct k1_thermal_priv *priv;
> +	struct thermal_zone_device *tzd;
> +	int id;
> +};
> +
> +struct k1_thermal_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct clk *clk;
> +	struct clk *bus_clk;
> +	struct reset_control *reset;
> +	struct k1_thermal_sensor sensors[MAX_SENSOR_NUMBER];
> +};
> +
> +static int k1_init_sensors(struct platform_device *pdev)
> +{
> +	struct k1_thermal_priv *priv = platform_get_drvdata(pdev);
> +	unsigned int temp;
so is 'temp' short for temperature? if not, for intermediate register value,
please simply use 'val' for less confusion, sometimes people prefer 'tmp',
but I'd avoid here

> +	int i;
> +
> +	/* Disable all the interrupts */
> +	writel(0xffffffff, priv->base + K1_TSU_INT_EN);
> +
> +	/* Configure ADC sampling time and filter period */
> +	temp = readl(priv->base + K1_TSU_TIME);
> +	temp &= ~K1_TSU_TIME_MASK;
> +	temp |= K1_TSU_TIME_FILTER_PERIOD |
> +		K1_TSU_TIME_ADC_CNT_RST |
> +		K1_TSU_TIME_WAIT_REF_CNT;
> +	writel(temp, priv->base + K1_TSU_TIME);
> +
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
> +
> +	/* Select 24M clk for high speed mode */
> +	temp = readl(priv->base + K1_TSU_PCTRL2);
> +	temp &= ~K1_TSU_PCTRL2_CLK_SEL_MASK;
> +	temp |= K1_TSU_PCTRL2_CLK_SEL_24M;
> +	writel(temp, priv->base + K1_TSU_PCTRL2);
> +
> +	/* Enable thermal interrupt */
> +	temp = readl(priv->base + K1_TSU_INT_EN);
> +	temp |= K1_TSU_INT_EN_MASK;
> +	writel(temp, priv->base + K1_TSU_INT_EN);
> +
> +	/* Enable each sensor */
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		temp = readl(priv->base + K1_TSU_EN);
> +		temp &= ~K1_TSU_EN_MASK(i);
> +		temp |= K1_TSU_EN_MASK(i);
> +		writel(temp, priv->base + K1_TSU_EN);
> +	}
> +
> +	return 0;
> +}
> +
> +static void k1_enable_sensor_irq(struct k1_thermal_sensor *sensor)
> +{
> +	struct k1_thermal_priv *priv = sensor->priv;
> +	unsigned int temp;
> +
> +	temp = readl(priv->base + K1_TSU_INT_CLR);
> +	temp |= K1_TSU_INT_MASK(sensor->id);
> +	writel(temp, priv->base + K1_TSU_INT_CLR);
> +
> +	temp = readl(priv->base + K1_TSU_INT_EN);
> +	temp &= ~K1_TSU_INT_MASK(sensor->id);
> +	writel(temp, priv->base + K1_TSU_INT_EN);
> +}
> +
> +/*
> + * The conversion formula used is:
> + * T(m°C) = (((raw_value & mask) >> shift) - TEMPERATURE_OFFSET) * 1000
> + */
> +static int k1_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct k1_thermal_sensor *sensor = thermal_zone_device_priv(tz);
> +	struct k1_thermal_priv *priv = sensor->priv;
> +
ditto, suggest to introduce intermediate variable 'val', then assign at last step
> +	*temp = readl(priv->base + K1_TSU_DATA(sensor->id));
> +	*temp &= K1_TSU_DATA_MASK(sensor->id);
> +	*temp >>= K1_TSU_DATA_SHIFT(sensor->id);
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
> +	struct k1_thermal_sensor *sensor = thermal_zone_device_priv(tz);
> +	struct k1_thermal_priv *priv = sensor->priv;
> +	int high_code = high;
> +	int low_code = low;
> +	unsigned int temp;
> +
> +	if (low >= high)
> +		return -EINVAL;
> +
> +	if (low < 0)
> +		low_code = 0;
> +
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
> +
any reason why not to combine above two readl/writel() into one?
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops k1_thermal_ops = {
> +	.get_temp = k1_thermal_get_temp,
> +	.set_trips = k1_thermal_set_trips,
> +};
> +
> +static irqreturn_t k1_thermal_irq_thread(int irq, void *data)
> +{
> +	struct k1_thermal_priv *priv = (struct k1_thermal_priv *)data;
> +	int msk, status, i;
s/msk/mask/, for better consistency
> +
> +	status = readl(priv->base + K1_TSU_INT_STA);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; i++) {
> +		if (status & K1_TSU_INT_MASK(i)) {
> +			msk = readl(priv->base + K1_TSU_INT_CLR);
> +			msk |= K1_TSU_INT_MASK(i);
> +			writel(msk, priv->base + K1_TSU_INT_CLR);
> +			/* Notify thermal framework to update trips */
> +			thermal_zone_device_update(priv->sensors[i].tzd, THERMAL_EVENT_UNSPECIFIED);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
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
..
> +	priv->dev = dev;
> +	platform_set_drvdata(pdev, priv);
I'd suggest moving above behind to resource acquisition
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Failed to get/deassert reset control\n");
> +
> +	priv->clk = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Failed to get core clock\n");
> +
> +	priv->bus_clk = devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(priv->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->bus_clk),
> +				     "Failed to get bus clock\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = k1_init_sensors(pdev);
> +
> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		priv->sensors[i].id = i;
> +		priv->sensors[i].priv = priv;
> +		priv->sensors[i].tzd = devm_thermal_of_zone_register(dev,
> +									i, priv->sensors + i,
> +									&k1_thermal_ops);
> +		if (IS_ERR(priv->sensors[i].tzd))
> +			return dev_err_probe(dev, PTR_ERR(priv->sensors[i].tzd),
> +						"Failed to register thermal zone: %d\n", i);
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
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id k1_thermal_dt_ids[] = {
> +	{ .compatible = "spacemit,k1-thermal" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, k1_thermal_dt_ids);
> +
> +static struct platform_driver k1_thermal_driver = {
> +	.driver = {
> +		.name		= "k1_thermal",
> +		.of_match_table = k1_thermal_dt_ids,
> +	},
> +	.probe	= k1_thermal_probe,
> +};
> +module_platform_driver(k1_thermal_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT K1 Thermal Sensor Driver");
> +MODULE_AUTHOR("Shuwei Wu <shuweiwoo@163.com>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)

