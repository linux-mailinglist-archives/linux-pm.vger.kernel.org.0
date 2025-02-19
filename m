Return-Path: <linux-pm+bounces-22424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E546A3BF5F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467CA17B669
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BE1E8855;
	Wed, 19 Feb 2025 12:59:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD1E0489
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969977; cv=none; b=CFczQYmi/FwEO14EesNGePwLZCG7msAQm1AD7hxCo7GDSvsOEj4p2i5XAXPyKB9KSdTkdARUUaTxmZe0hovoTvK6tmDdni677k0q/ZWrSBeC1QEf03jI8J0rviKMDBF+ATETRyegt5LawhyB3g4HOlKPQcPdrsoUR701C+yWy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969977; c=relaxed/simple;
	bh=RmbWzA+KsqBr0DKw1mDnaYjvmbbD4CiWxTQtiP52xZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgrwC7qv82LCRV2Aaq9sgJi8eQQnLtSjHX54Q0PfmkBqb2drQe8q67gLCjRwJ+ZQly5awUS32nMuaOEldFW+FZbHHr4BOlqzmOJAyOdbWN2DwOwJlw5ip8kkw8PKl4PfyHKYSV6f9iidOAzS+7hkby5T1/cebNbsV7H4yABl19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tkjfW-0006ej-KO; Wed, 19 Feb 2025 13:59:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tkjfW-001lmx-0E;
	Wed, 19 Feb 2025 13:59:14 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tkjfV-006GAO-33;
	Wed, 19 Feb 2025 13:59:13 +0100
Date: Wed, 19 Feb 2025 13:59:13 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <20250219125913.2st3qnawwvf74dfi@pengutronix.de>
References: <20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com>
 <20250218-imx91tmu-v5-2-76c0b27673e6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-imx91tmu-v5-2-76c0b27673e6@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 25-02-18, Frank Li wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
> 
> Introduce support for the i.MX91 thermal monitoring unit, which features a
> single sensor for the CPU. The register layout differs from other chips,
> necessitating the creation of a dedicated file for this.
> 
> This sensor provides a resolution of 1/64�C (6-bit fraction). For actual
> accuracy, refer to the datasheet, as it varies depending on the chip grade.
> Provide an interrupt for end of measurement and threshold violation and
> Contain temperature threshold comparators, in normal and secure address
> space, with direction and threshold programmability.
> 
> Datasheet Link: https://www.nxp.com/docs/en/data-sheet/IMX91CEC.pdf
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v4 to v5
> - add irq support
> - use period mode
> - Marco, if need drop review tag, let me know

Please drop me since I'm a bit out of glue what you changed and don't
want to review it again. Also it's not very reviewer friendly to add a
major feature albeit the latest version seemed to be in pretty good
shape apart the missing IRQ support.

Regards,
  Marco


> Change from v3 to v4
> - Add Macro's review tag
> - Use devm_add_action()
> - Move pm_runtim_put before thermal_of_zone_register()
> 
> change from v2 to v3
> - add IMX91_TMU_ prefix for register define
> - remove unused register define
> - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
> - use dev variable in probe function
> - use pm_runtime_set_active() in probe
> - move START to imx91_tmu_get_temp()
> - use DEFINE_RUNTIME_DEV_PM_OPS()
> - keep set reset value because there are not sw "reset" bit in controller,
> uboot may change and enable tmu.
> 
> change from v1 to v2
> - use low case for hexvalue
> - combine struct imx91_tmu and tmu_sensor
> - simplify imx91_tmu_start() and imx91_tmu_enable()
> - use s16 for imx91_tmu_get_temp(), which may negative value
> - use reverse christmas tree style
> - use run time pm
> - use oneshot to sample temp
> - register thermal zone after hardware init
> ---
>  drivers/thermal/Kconfig         |  10 +
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/imx91_thermal.c | 422 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d3f9686e26e71..78a05d1030882 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the passive
>  	  trip is crossed.
>  
> +config IMX91_THERMAL
> +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Include one sensor and six comparators. Each of them compares the
> +	  temperature value (from the sensor) against the programmable
> +	  threshold values. The direction of the comparison is configurable
> +	  (greater / lesser than).
> +
>  config K3_THERMAL
>  	tristate "Texas Instruments K3 thermal support"
>  	depends on ARCH_K3 || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9abf43a74f2bb..08da241e6a598 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>  obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> new file mode 100644
> index 0000000000000..da2e01aa6f281
> --- /dev/null
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/thermal.h>
> +#include <linux/units.h>
> +
> +#define REG_SET					0x4
> +#define REG_CLR					0x8
> +#define REG_TOG					0xc
> +
> +#define IMX91_TMU_CTRL0				0x0
> +#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
> +#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
> +#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
> +
> +#define IMX91_TMU_THR_MODE_LE			0
> +#define IMX91_TMU_THR_MODE_GE			1
> +
> +#define IMX91_TMU_STAT0				0x10
> +#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
> +#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
> +#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> +
> +#define IMX91_TMU_DATA0				0x20
> +
> +#define IMX91_TMU_CTRL1				0x200
> +#define IMX91_TMU_CTRL1_EN			BIT(31)
> +#define IMX91_TMU_CTRL1_START			BIT(30)
> +#define IMX91_TMU_CTRL1_STOP			BIT(29)
> +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
> +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
> +
> +#define IMX91_TMU_THR_CTRL01			0x30
> +#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
> +
> +#define IMX91_TMU_REF_DIV			0x280
> +#define IMX91_TMU_DIV_EN			BIT(31)
> +#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
> +#define IMX91_TMU_DIV_MAX			255
> +
> +#define IMX91_TMU_PUD_ST_CTRL			0x2b0
> +#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
> +
> +#define IMX91_TMU_TRIM1				0x2e0
> +#define IMX91_TMU_TRIM2				0x2f0
> +
> +#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
> +#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
> +
> +#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
> +#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
> +
> +#define IMX91_TMU_PERIOD_CTRL			0x270
> +#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
> +
> +#define IMX91_TMP_FRAC				64
> +
> +struct imx91_tmu {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct thermal_zone_device *tzd;
> +	struct mutex lock; /* sync with irq thread */
> +	int trip;
> +	int hysteresis;
> +	bool enable;
> +};
> +
> +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> +{
> +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
> +
> +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> +}
> +
> +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> +{
> +	u32 reg = IMX91_TMU_CTRL1;
> +
> +	reg += enable ? REG_SET : REG_CLR;
> +
> +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
> +}
> +
> +static int imx91_tmu_to_mcelsius(int x)
> +{
> +	return x * MILLIDEGREE_PER_DEGREE / IMX91_TMP_FRAC;
> +}
> +
> +static int imx91_tmu_from_mcelsius(int x)
> +{
> +	return x * IMX91_TMP_FRAC / MILLIDEGREE_PER_DEGREE;
> +}
> +
> +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> +	s16 data;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(tmu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&tmu->lock);
> +
> +	/* DATA0 is 16bit signed number */
> +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
> +	*temp = imx91_tmu_to_mcelsius(data);
> +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
> +		ret = -EAGAIN;
> +
> +	if (*temp <= tmu->trip - tmu->hysteresis && tmu->enable) {
> +		writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> +	}
> +
> +	pm_runtime_put(tmu->dev);
> +
> +	return ret;
> +}
> +
> +static int imx91_tmu_set_trip_temp(struct thermal_zone_device *tz, const struct thermal_trip *trip,
> +				   int temp)
> +{
> +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> +	int val;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(tmu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (temp < 0)
> +		return -EINVAL;
> +
> +	guard(mutex)(&tmu->lock);
> +
> +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> +
> +	/* Comparator1 for temperature threshold */
> +	writel_relaxed(IMX91_TMU_THR_CTRL01_THR1_MASK, tmu->base + IMX91_TMU_THR_CTRL01 + REG_CLR);
> +	val = FIELD_PREP(IMX91_TMU_THR_CTRL01_THR1_MASK, imx91_tmu_from_mcelsius(temp));
> +	writel_relaxed(val, tmu->base + IMX91_TMU_THR_CTRL01 + REG_SET);
> +
> +	writel_relaxed(IMX91_TMU_STAT0_THR1_IF, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> +
> +	tmu->trip = temp;
> +	tmu->hysteresis = trip->hysteresis;
> +
> +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> +	pm_runtime_put(tmu->dev);
> +
> +	return 0;
> +}
> +
> +static int imx91_tmu_trip_walk_cb(struct thermal_trip *trip, void *arg)
> +{
> +	struct imx91_tmu *tmu = arg;
> +
> +	return imx91_tmu_set_trip_temp(tmu->tzd, trip, trip->temperature);
> +}
> +
> +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> +{
> +	struct device *dev = tmu->dev;
> +	u32 trim1, trim2;
> +	int ret;
> +
> +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> +	if (ret)
> +		return ret;
> +
> +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> +	if (ret)
> +		return ret;
> +
> +	if (trim1 == 0 || trim2 == 0)
> +		return -EINVAL;
> +
> +	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
> +	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
> +
> +	return 0;
> +}
> +
> +static void imx91_tmu_action_remove(void *data)
> +{
> +	struct imx91_tmu *tmu = data;
> +
> +	/* disable tmu */
> +	imx91_tmu_enable(tmu, false);
> +}
> +
> +static irqreturn_t imx91_tmu_alarm_irq_thread(int irq, void *dev)
> +{
> +	struct imx91_tmu *tmu = dev;
> +	int val;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(tmu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	thermal_zone_device_update(tmu->tzd, THERMAL_EVENT_UNSPECIFIED);
> +
> +	scoped_guard(mutex, &tmu->lock) {
> +		val = readl_relaxed(tmu->base + IMX91_TMU_STAT0);
> +		/* Have to use CLR register to clean up w1c bits */
> +		writel_relaxed(val, tmu->base + IMX91_TMU_STAT0 + REG_CLR);
> +
> +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> +	}
> +
> +	pm_runtime_put(tmu->dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_device_mode mode)
> +{
> +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> +	int ret;
> +
> +	if (mode == THERMAL_DEVICE_ENABLED) {
> +		ret = pm_runtime_get(tmu->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		guard(mutex)(&tmu->lock);
> +		imx91_tmu_start(tmu, true);
> +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> +		tmu->enable = true;
> +	} else {
> +		guard(mutex)(&tmu->lock);
> +
> +		writel_relaxed(IMX91_TMU_CTRL0_THR1_IE, tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> +		imx91_tmu_start(tmu, false);
> +		pm_runtime_put(tmu->dev);
> +		tmu->enable = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops tmu_tz_ops = {
> +	.get_temp = imx91_tmu_get_temp,
> +	.change_mode = imx91_tmu_change_mode,
> +	.set_trip_temp = imx91_tmu_set_trip_temp,
> +};
> +
> +static int imx91_tmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx91_tmu *tmu;
> +	unsigned long rate;
> +	int irq, ret;
> +	u32 div;
> +
> +	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> +	if (!tmu)
> +		return -ENOMEM;
> +
> +	tmu->dev = dev;
> +
> +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tmu->base))
> +		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
> +
> +	tmu->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(tmu->clk))
> +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> +
> +	platform_set_drvdata(pdev, tmu);
> +
> +	devm_mutex_init(dev, &tmu->lock);
> +
> +	/* disable the monitor during initialization */
> +	imx91_tmu_enable(tmu, false);
> +	imx91_tmu_start(tmu, false);
> +
> +	ret = imx91_init_from_nvmem_cells(tmu);
> +	if (ret) {
> +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
> +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
> +	}
> +
> +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> +	rate = clk_get_rate(tmu->clk);
> +	div = (rate / (4 * HZ_PER_MHZ)) - 1;
> +	if (div > IMX91_TMU_DIV_MAX)
> +		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
> +
> +	/* Set divider value and enable divider */
> +	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
> +		       tmu->base + IMX91_TMU_REF_DIV);
> +
> +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
> +
> +	/*
> +	 * Set resolution mode
> +	 * 00b - Conversion time = 0.59325 ms
> +	 * 01b - Conversion time = 1.10525 ms
> +	 * 10b - Conversion time = 2.12925 ms
> +	 * 11b - Conversion time = 4.17725 ms
> +	 */
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3),
> +		       tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1),
> +		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> +
> +	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1 + REG_CLR);
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK,
> +				  IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC),
> +		       tmu->base + IMX91_TMU_CTRL1 + REG_SET);
> +
> +	/*
> +	 * Set Periodic Measurement Frequency to 25Hz:
> +	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]
> +	 */
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_PERIOD_CTRL_MEAS_MASK, 4 * HZ_PER_MHZ / 25),
> +		       tmu->base + IMX91_TMU_PERIOD_CTRL);
> +
> +	writel_relaxed(IMX91_TMU_CTRL0_THR1_IE | IMX91_TMU_CTRL0_THR1_MASK,
> +		       tmu->base + IMX91_TMU_CTRL0 + REG_CLR);
> +
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL0_THR1_MASK, IMX91_TMU_THR_MODE_GE),
> +		       tmu->base + IMX91_TMU_CTRL0 + REG_SET);
> +
> +	pm_runtime_set_active(dev);
> +	devm_pm_runtime_enable(dev);
> +	pm_runtime_suspend(dev);
> +
> +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> +	if (IS_ERR(tmu->tzd))
> +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> +				     "failed to register thermal zone sensor\n");
> +
> +	thermal_zone_for_each_trip(tmu->tzd, imx91_tmu_trip_walk_cb, tmu);
> +
> +	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, imx91_tmu_alarm_irq_thread,
> +					IRQF_ONESHOT, "imx91_thermal", tmu);
> +
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
> +
> +	return 0;
> +}
> +
> +static int imx91_tmu_runtime_suspend(struct device *dev)
> +{
> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> +
> +	/* disable tmu */
> +	imx91_tmu_enable(tmu, false);
> +
> +	clk_disable_unprepare(tmu->clk);
> +
> +	return 0;
> +}
> +
> +static int imx91_tmu_runtime_resume(struct device *dev)
> +{
> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(tmu->clk);
> +	if (ret)
> +		return ret;
> +
> +	imx91_tmu_enable(tmu, true);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
> +				 imx91_tmu_runtime_resume, NULL);
> +
> +static const struct of_device_id imx91_tmu_table[] = {
> +	{ .compatible = "fsl,imx91-tmu", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> +
> +static struct platform_driver imx91_tmu = {
> +	.driver = {
> +		.name	= "imx91_thermal",
> +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> +		.of_match_table = imx91_tmu_table,
> +	},
> +	.probe = imx91_tmu_probe,
> +};
> +module_platform_driver(imx91_tmu);
> +
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 
> 

