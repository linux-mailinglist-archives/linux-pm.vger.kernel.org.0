Return-Path: <linux-pm+bounces-18900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA139EAE1C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62E3283755
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432B199E9D;
	Tue, 10 Dec 2024 10:37:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C602197A7F
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827036; cv=none; b=IntynAvua71E00ek9g6QWeXUJ6b7akPFYELdR5K2E3m4FJcRTm1a9JioWTwBk2W5c60UC8Z+MYWY1W/mNRp8Tulmt31xicgpvmn6G1BhzQfm7JySg0b+y8bp2fYfyt48idGN2nqIXwC28mzoYbPueJfepWH6L+Qt4oB2IMR3ZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827036; c=relaxed/simple;
	bh=suPiFHdwUXxu5Dm1/7yFbyIMoADlOtHrkoTWTSmgaiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auoi+eMCsV7ptYJBg6alPegikemKC3Qi8Jlf3OQLmZe09htHBh77HMnE1MH74GuCLaEz1v3MmckvY3r5rw1n0JykM2YWG2+e+UpYyf9lUKHrTt0JQSt6cTivsGj9neyGVGrMGKQZ3rjnTcdIKn3+dmdmIdLHnGfWOxOvvPEKQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tKxbk-0000PX-Hu; Tue, 10 Dec 2024 11:36:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tKxbi-002frZ-0N;
	Tue, 10 Dec 2024 11:36:46 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tKxbi-008Te3-2U;
	Tue, 10 Dec 2024 11:36:46 +0100
Date: Tue, 10 Dec 2024 11:36:46 +0100
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
	Pengfei Li <pengfei.li_1@nxp.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <20241210103646.7gblp7mzxbna5gas@pengutronix.de>
References: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
 <20241209-imx91tmu-v1-2-7859c5387f31@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-imx91tmu-v1-2-7859c5387f31@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi,

On 24-12-09, Frank Li wrote:
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
>  drivers/thermal/Kconfig         |  10 ++
>  drivers/thermal/Makefile        |   1 +
>  drivers/thermal/imx91_thermal.c | 281 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
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
> index 0000000000000..19c4dafe9c7a9
> --- /dev/null
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -0,0 +1,281 @@
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
> +#include <linux/thermal.h>
> +
> +#define CTRL0			0x0
> +
> +#define STAT0			0x10
> +#define STAT0_DRDY0_IF_MASK	BIT(16)
> +
> +#define DATA0			0x20
> +#define DATA_INT_MASK		GENMASK(14, 7)
> +#define DATA_FRAC_MASK		GENMASK(6, 0)
> +
> +#define THR_CTRL01		0x30
> +#define THR_CTRL23		0x40
> +
> +#define CTRL1			0x200
> +#define CTRL1_SET		0x204
> +#define CTRL1_CLR		0x208
> +#define CTRL1_EN		BIT(31)
> +#define CTRL1_START		BIT(30)
> +#define CTRL1_STOP		BIT(29)
> +#define CTRL1_RES_MASK		GENMASK(19, 18)
> +#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
> +
> +#define PERIOD_CTRL		0x270
> +#define MEAS_FREQ_MASK		GENMASK(23, 0)
> +
> +#define REF_DIV			0x280
> +#define DIV_EN			BIT(31)
> +#define DIV_MASK		GENMASK(23, 16)
> +
> +#define PUD_ST_CTRL		0x2B0
> +#define PUDL_MASK		GENMASK(23, 16)
> +
> +#define TRIM1			0x2E0
> +#define TRIM2			0x2F0
> +
> +#define TMU_TEMP_LOW_LIMIT	-40000
> +#define TMU_TEMP_HIGH_LIMIT	125000
> +
> +#define DEFAULT_TRIM1_CONFIG 0xB561BC2DU
> +#define DEFAULT_TRIM2_CONFIG 0x65D4U

please align the defines and use lower-case for the hex values.

> +struct tmu_sensor {
> +	struct imx91_tmu *priv;
> +	struct thermal_zone_device *tzd;
> +};

This can be part of imx91_tmu right?

> +struct imx91_tmu {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct tmu_sensor sensors;
> +};
> +
> +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> +{
> +	if (start)
> +		writel_relaxed(CTRL1_START, tmu->base + CTRL1_SET);
> +	else
> +		writel_relaxed(CTRL1_STOP, tmu->base + CTRL1_SET);

Nit:
	unsigned int val = start ? CTRL1_START : CTRL1_STOP;

	writel_relaxed(val, tmu->base + CTRL1_SET);

Aside the nit, why do you use *_relaxed() accessors in you whole code?
Is the order not strictly required?

> +}
> +
> +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> +{
> +	if (enable)
> +		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_SET);
> +	else
> +		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_CLR);

Same here:

	unsigned int reg = enable ? CTRL1_SET : CTRL1_CLR;

	writel_relaxed(CTRL1_EN, tmu->base + reg);
> +}
> +
> +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
> +	struct imx91_tmu *tmu = sensor->priv;

With tmu_sensor merged into imx91_tmu you don't need this reverse
pointer logic.

> +	int val;
> +	int ret;
> +
> +	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
> +					 val & STAT0_DRDY0_IF_MASK, 1000,
> +					 40000);
> +	if (ret)
> +		return -EAGAIN;
> +
> +	val = readl_relaxed(tmu->base + DATA0) & 0xffffU;
						   ^
				Please use a MASK define for it, also no
				need to use the U suffix.

Also according the TRM 58.3.4 this doesn't seem right. According the TRM
this is a s16 (two's-complement) value. You won't get negative values if
store it within a int.

> +	*temp = val * 1000L / 64L;
			  ^     ^
You don't need to specify the type here explicit since all params would
be converted to int and no overflow happens.

> +	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops tmu_tz_ops = {
> +	.get_temp = imx91_tmu_get_temp,
> +};
> +
> +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> +{
> +	struct device *dev = tmu->dev;
> +	int ret;
> +	u32 trim1, trim2;

Please use the reverse christmas tree style.

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
> +	writel_relaxed(trim1, tmu->base + TRIM1);
> +	writel_relaxed(trim2, tmu->base + TRIM2);
> +
> +	return 0;
> +}
> +
> +static int imx91_tmu_probe(struct platform_device *pdev)
> +{
> +	struct imx91_tmu *tmu;
> +	unsigned long rate;
> +	u32 div;
> +	int ret;
> +	int i = 0;

Same here.

> +	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> +	if (!tmu)
> +		return -ENOMEM;
> +
> +	tmu->dev = &pdev->dev;
> +
> +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tmu->base))
> +		return PTR_ERR(tmu->base);
> +
> +	tmu->clk = devm_clk_get_prepared(&pdev->dev, NULL);
> +	if (IS_ERR(tmu->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> +
> +	tmu->sensors.priv = tmu;

As said, no need for the sensors container.

> +	tmu->sensors.tzd = devm_thermal_of_zone_register(&pdev->dev, i, &tmu->sensors, &tmu_tz_ops);
> +	if (IS_ERR(tmu->sensors.tzd))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->sensors.tzd),
> +				     "failed to register thermal zone sensor\n");
> +
> +	platform_set_drvdata(pdev, tmu);
> +
> +	/* disable the monitor during initialization */
> +	imx91_tmu_enable(tmu, false);
> +	imx91_tmu_start(tmu, false);

Make use of pm_runtime?

> +	ret = imx91_init_from_nvmem_cells(tmu);
> +	if (ret) {
> +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> +	}
> +
> +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> +	rate = clk_get_rate(tmu->clk);
> +	div = (rate / 4000000) - 1;

Would be nice to validate the div value before passing to the HW and if
the target rate of 4MHz can't be reached by the div you you should
return -EINVAL.

> +
> +	/* Set divider value and enable divider */
> +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> +
> +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> +
> +	/*
> +	 * Set resolution mode
> +	 * 00b - Conversion time = 0.59325 ms
> +	 * 01b - Conversion time = 1.10525 ms
> +	 * 10b - Conversion time = 2.12925 ms
> +	 * 11b - Conversion time = 4.17725 ms
> +	 */
> +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
> +
> +	/*
> +	 * Set measure mode
> +	 * 00b - Single oneshot measurement
> +	 * 01b - Continuous measurement
> +	 * 10b - Periodic oneshot measurement
> +	 */

For the resolution it's fine to have the values directly coded without a
define, but here we can definitly use a define and drop the comment.

> +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x3), tmu->base + CTRL1_CLR);
> +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x1), tmu->base + CTRL1_SET);

Why do we set it to periodic mode instead of the single-shot? At the
moment the device doesn't have IRQ support, and so there is no need to
run the measurements in background.

> +
> +	/*
> +	 * Set Periodic Measurement Frequency to 25Hz:
> +	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]. ->
> +	 * PERIOD_CTRL(MEAS_FREQ) = (1000 / 25) / (1000 / 4000000);
> +	 * Where tMEAS_FREQ = Measurement period and tCONV_CLK = 1/fCONV_CLK.
> +	 * This field should have value greater than count corresponds
> +	 * to time greater than summation of conversion time, power up
> +	 * delay, and six times of conversion clock time.
> +	 * tMEAS_FREQ > (tCONV + tPUD + 6 * tCONV_CLK).
> +	 * tCONV is conversion time determined by CTRL1[RESOLUTION].
> +	 */
> +	writel_relaxed(FIELD_PREP(MEAS_FREQ_MASK, 0x27100), tmu->base + PERIOD_CTRL);

With the single-shot measurements we could remove this part and..

> +
> +	/* enable the monitor */
> +	imx91_tmu_enable(tmu, true);
> +	imx91_tmu_start(tmu, true);

this part as well.

Regards,
  Marco

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
> +	imx91_tmu_enable(tmu, false);
> +}
> +
> +static int __maybe_unused imx91_tmu_suspend(struct device *dev)
> +{
> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> +
> +	/* disable tmu */
> +	imx91_tmu_start(tmu, false);
> +	imx91_tmu_enable(tmu, false);
> +
> +	clk_disable_unprepare(tmu->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx91_tmu_resume(struct device *dev)
> +{
> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(tmu->clk);
> +	if (ret)
> +		return ret;
> +
> +	imx91_tmu_enable(tmu, true);
> +	imx91_tmu_start(tmu, true);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx91_tmu_pm_ops,
> +			 imx91_tmu_suspend, imx91_tmu_resume);
> +
> +static const struct of_device_id imx91_tmu_table[] = {
> +	{ .compatible = "fsl,imx91-tmu", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> +
> +static struct platform_driver imx91_tmu = {
> +	.driver = {
> +		.name	= "i.MX91_thermal",
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
> 

