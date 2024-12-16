Return-Path: <linux-pm+bounces-19296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F59F2DC2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070E41882C2A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AD202F95;
	Mon, 16 Dec 2024 10:05:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDE202C58
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343555; cv=none; b=fr0mfaBYBvI70nLCamkGEmm6BwiINvFTzG5cvfQxmLW3eWIYFvFc+tMIJh1cOJ4wWEgBYOmYq/+iuHJ3cVQRHbqlSti8yJju6I9UxA6a5TnHxd00Ci3stwVn0D4BM55LIEPC0LUykV2vIzSYtuO+HilR/IMaUk1bkTwAfHnIMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343555; c=relaxed/simple;
	bh=8BW2YHPLwFuvNY/tJbXJRQ7mmOLx1MJ46ZCx+AiBHAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGV+SprUJ6SsWYgeXb7jfag4ejSd7dMYkTaKs2Sz8tnDwCVTlZ1az+wTeseBOyFDr1EeeAr1+LPnBKlEh/hnjIpFgTqx5+Rgqo5ul1zd3s8bVk4ivBPXtPrfYjFVhNxfpMh5ol4rjpoCn2YsZYhivXCmZ+RWUGjC+YhyW5vByoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tN7yd-0001fi-VT; Mon, 16 Dec 2024 11:05:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tN7yc-003g34-1F;
	Mon, 16 Dec 2024 11:05:23 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tN7yd-002Ytv-08;
	Mon, 16 Dec 2024 11:05:23 +0100
Date: Mon, 16 Dec 2024 11:05:23 +0100
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
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <20241216100523.p5ay544cvhx3lyvu@pengutronix.de>
References: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
 <20241212-imx91tmu-v3-2-85e756b29437@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-imx91tmu-v3-2-85e756b29437@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi,

On 24-12-12, Frank Li wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
> 
> Introduce support for the i.MX91 thermal monitoring unit, which features a
> single sensor for the CPU. The register layout differs from other chips,
> necessitating the creation of a dedicated file for this.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
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
>  drivers/thermal/Kconfig         |  10 ++
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/imx91_thermal.c | 263 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d3f9686e26e71..da403ed86aeb1 100644
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
> +	  Support for Temperature sensor found on NXP i.MX91 SoC.
> +	  It supports one critical trip point and one passive trip point. The
> +	  cpufreq is used as the cooling device to throttle CPUs when the passive
> +	  trip is crossed.
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
> index 0000000000000..62b579365fd03
> --- /dev/null
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024 NXP.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/thermal.h>
> +
> +#define IMX91_TMU_STAT0				0x10
> +#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> +
> +#define IMX91_TMU_DATA0				0x20
> +
> +#define IMX91_TMU_CTRL1_SET			0x204
> +#define IMX91_TMU_CTRL1_CLR			0x208
> +#define IMX91_TMU_CTRL1_EN			BIT(31)
> +#define IMX91_TMU_CTRL1_START			BIT(30)
> +#define IMX91_TMU_CTRL1_STOP			BIT(29)
> +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
> +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
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
> +struct imx91_tmu {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct thermal_zone_device *tzd;
> +};
> +
> +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> +{
> +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
> +
> +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1_SET);
> +}
> +
> +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> +{
> +	u32 reg = enable ? IMX91_TMU_CTRL1_SET : IMX91_TMU_CTRL1_CLR;
> +
> +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
> +}
> +
> +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> +	s16 data;
> +	int ret;
> +	u32 val;
> +
> +	ret = pm_runtime_resume_and_get(tmu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	imx91_tmu_start(tmu, true);
> +
> +	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
> +					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000, 40000);
> +	if (ret) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	/* DATA0 is 16bit signed number */
> +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
> +	*temp = data * 1000 / 64;
> +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
> +		ret = -EAGAIN;
> +
> +out:
> +	pm_runtime_put(tmu->dev);
> +
> +	return ret;
> +}
> +
> +static struct thermal_zone_device_ops tmu_tz_ops = {
> +	.get_temp = imx91_tmu_get_temp,
> +};
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
> +static int imx91_tmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx91_tmu *tmu;
> +	unsigned long rate;
> +	u32 div;
> +	int ret;
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
> +	div = (rate / 4000000) - 1;
> +	if (div > IMX91_TMU_DIV_MAX)
> +		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limiation");
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
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3), tmu->base + IMX91_TMU_CTRL1_CLR);
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1), tmu->base + IMX91_TMU_CTRL1_SET);
> +
> +	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1_CLR);
> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK, IMX91_TMU_CTRL1_MEAS_MODE_SINGLE),
> +		       tmu->base + IMX91_TMU_CTRL1_SET);
> +
> +	imx91_tmu_enable(tmu, true);

Nit: I don't think that this is necessary, albeit it's not wrong.

> +	pm_runtime_set_active(dev);
> +	devm_pm_runtime_enable(dev);
> +
> +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> +	if (IS_ERR(tmu->tzd))
> +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> +				     "failed to register thermal zone sensor\n");

This return will leave the pm_runtime in the wrong state now. I'm Not
sure if the thermal_of_zone_register() requires the device to be
operational. If not, we can move

> +	pm_runtime_put(dev);

above the devm_thermal_of_zone_register() call.

> +
> +	return 0;
> +}
> +
> +static void imx91_tmu_remove(struct platform_device *pdev)
> +{
> +	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
> +
> +	/* disable tmu */
> +	imx91_tmu_start(tmu, false);

Nit: Still not needed to disable the start, as the start bit is
self-clearing, since we're running in one-shot mode.

> +	imx91_tmu_enable(tmu, false);
> +}

If we put the imx91_tmu_enable() into a devm_add_action() hook, we can
drop the .remove callback completely.

With the above addressed, feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regards,
  Marco

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
> +	.remove = imx91_tmu_remove,
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

