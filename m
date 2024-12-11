Return-Path: <linux-pm+bounces-19060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0E9ED625
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C13816AEA8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA8A242EFA;
	Wed, 11 Dec 2024 18:57:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2C242EEC
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943452; cv=none; b=kB9Ott+AjdLutvsLCr9F9FfHfL74M7RdC3cnzGoe0l8BUzfnOkAinglxVGXrt80DHINclUkdGKJ833i2F1UfgIStKwpWQypM6paxMMv0aBWpf1WCRAMW38r+ce8LQhVNrQ9Cbi05eM8ZG7y+bq3mD14imlmWeX8/XtezTJiMe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943452; c=relaxed/simple;
	bh=gzLaOdE//ITNtAZIxkl55EsI846FM5MiEbUHNlwkhoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRqNcnz57ccdC8GkQtv8SUPSJLjCMsenvgdJf58LCqLbgeTBNVg7hfvWvdbH/ZTqmXlb/klu39U9vellp5zWDy5gIUgZTxLp9WD3i/KpVzFN8OXFW6PLVY2I1Kt/HMoIQeh7lwnD2YYJWoG3mDPAwE6ggW5OxyuQOWun4E4qVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLRtS-0005ua-OL; Wed, 11 Dec 2024 19:57:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLRtQ-002uPB-2r;
	Wed, 11 Dec 2024 19:57:05 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLRtR-00AYei-1k;
	Wed, 11 Dec 2024 19:57:05 +0100
Date: Wed, 11 Dec 2024 19:57:05 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v2 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <20241211185705.7b5uw26loobibzln@pengutronix.de>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
 <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
 <20241211154622.f2jwwrqansk6il3o@pengutronix.de>
 <Z1m+O1UV4HD+7Rr2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1m+O1UV4HD+7Rr2@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 24-12-11, Frank Li wrote:
> On Wed, Dec 11, 2024 at 04:46:22PM +0100, Marco Felsch wrote:
> > On 24-12-10, Frank Li wrote:
> > > From: Pengfei Li <pengfei.li_1@nxp.com>
> > >
> > > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > > single sensor for the CPU. The register layout differs from other chips,
> > > necessitating the creation of a dedicated file for this.
> > >
> > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v1 to v2
> > > - use low case for hexvalue
> > > - combine struct imx91_tmu and tmu_sensor
> > > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > > - use s16 for imx91_tmu_get_temp(), which may negative value
> > > - use reverse christmas tree style
> > > - use run time pm
> > > - use oneshot to sample temp
> > > - register thermal zone after hardware init
> > > ---
> > >  drivers/thermal/Kconfig         |  10 ++
> > >  drivers/thermal/Makefile        |   1 +
> > >  drivers/thermal/imx91_thermal.c | 265 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 276 insertions(+)
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index d3f9686e26e71..da403ed86aeb1 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> > >  	  cpufreq is used as the cooling device to throttle CPUs when the passive
> > >  	  trip is crossed.
> > >
> > > +config IMX91_THERMAL
> > > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > > +	depends on ARCH_MXC || COMPILE_TEST
> > > +	depends on OF
> > > +	help
> > > +	  Support for Temperature sensor found on NXP i.MX91 SoC.
> > > +	  It supports one critical trip point and one passive trip point. The
> > > +	  cpufreq is used as the cooling device to throttle CPUs when the passive
> > > +	  trip is crossed.
> > > +
> > >  config K3_THERMAL
> > >  	tristate "Texas Instruments K3 thermal support"
> > >  	depends on ARCH_K3 || COMPILE_TEST
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 9abf43a74f2bb..08da241e6a598 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> > >  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> > >  obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> > >  obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> > >  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> > >  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> > >  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > > new file mode 100644
> > > index 0000000000000..ebb59eda92951
> > > --- /dev/null
> > > +++ b/drivers/thermal/imx91_thermal.c
> > > @@ -0,0 +1,265 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2024 NXP.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/nvmem-consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/thermal.h>
> > > +
> > > +#define CTRL0			0x0
> >
> > Unused
> >
> > > +
> > > +#define STAT0			0x10
> > > +#define STAT0_DRDY0_IF_MASK	BIT(16)
> > > +
> > > +#define DATA0			0x20
> > > +
> > > +#define THR_CTRL01		0x30
> > > +#define THR_CTRL23		0x40
> >
> > Both are unused too
> >
> > > +#define CTRL1			0x200
> >
> > Unused
> >
> > > +#define CTRL1_SET		0x204
> > > +#define CTRL1_CLR		0x208
> > > +#define CTRL1_EN		BIT(31)
> > > +#define CTRL1_START		BIT(30)
> > > +#define CTRL1_STOP		BIT(29)
> > > +#define CTRL1_RES_MASK		GENMASK(19, 18)
> > > +#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
> > > +#define   CTRL1_MEAS_MODE_SINGLE	0
> > > +#define   CTRL1_MEAS_MODE_CONTINUES	1
> > > +#define   CTRL1_MEAS_MODE_PERIODIC	2
> > > +
> > > +#define REF_DIV			0x280
> > > +#define DIV_EN			BIT(31)
> > > +#define DIV_MASK		GENMASK(23, 16)
> > > +
> > > +#define PUD_ST_CTRL		0x2B0
> > > +#define PUDL_MASK		GENMASK(23, 16)
> > > +
> > > +#define TRIM1			0x2E0
> > > +#define TRIM2			0x2F0
> > 					^
> > 				still upper-case
> >
> > > +#define TMU_TEMP_LOW_LIMIT	-40000
> > > +#define TMU_TEMP_HIGH_LIMIT	125000
> > > +
> > > +#define DEFAULT_TRIM1_CONFIG 0xb561bc2d
> > > +#define DEFAULT_TRIM2_CONFIG 0x65d4
> > > +
> > > +struct imx91_tmu {
> > > +	void __iomem *base;
> > > +	struct clk *clk;
> > > +	struct device *dev;
> > > +	struct thermal_zone_device *tzd;
> > > +};
> > > +
> > > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > > +{
> > > +	u32 val = start ? CTRL1_START : CTRL1_STOP;
> > > +
> > > +	writel_relaxed(val, tmu->base + CTRL1_SET);
> > > +}
> > > +
> > > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > > +{
> > > +	u32 reg = enable ? CTRL1_SET : CTRL1_CLR;
> > > +
> > > +	writel_relaxed(CTRL1_EN, tmu->base + reg);
> > > +}
> > > +
> > > +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > > +{
> > > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > > +	s16 data;
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
> > > +					 val & STAT0_DRDY0_IF_MASK, 1000,
> > > +					 40000);
> > > +	if (ret)
> > > +		return -EAGAIN;
> > 		 ^
> > Missing pm_runtime_put(). Instead goto out;
> >
> > > +
> > > +	/* DATA0 is 16bit signed number */
> > > +	data = readw_relaxed(tmu->base + DATA0);
> > > +	*temp = data * 1000 / 64;
> > > +	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
> > > +		return -EAGAIN;
> > 			^
> > 		ret = -EAGAIN;
> > 		goto out;
> >
> > out:
> > > +
> > > +	pm_runtime_put(tmu->dev);
> > > +
> > > +	return 0;
> >
> > 	return ret;
> > > +}
> > > +
> > > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > > +	.get_temp = imx91_tmu_get_temp,
> > > +};
> > > +
> > > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > > +{
> > > +	struct device *dev = tmu->dev;
> > > +	u32 trim1, trim2;
> > > +	int ret;
> > > +
> > > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (trim1 == 0 || trim2 == 0)
> > > +		return -EINVAL;
> > > +
> > > +	writel_relaxed(trim1, tmu->base + TRIM1);
> > > +	writel_relaxed(trim2, tmu->base + TRIM2);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx91_tmu_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> >
> > Since you already have the dev pointer, you can make use of it...
> >
> > > +	struct imx91_tmu *tmu;
> > > +	unsigned long rate;
> > > +	u32 div;
> > > +	int ret;
> > > +
> > > +	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> > 				^
> > 				here
> > > +	if (!tmu)
> > > +		return -ENOMEM;
> > > +
> > > +	tmu->dev = &pdev->dev;
> >
> > 	and here
> >
> > > +
> > > +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(tmu->base))
> > > +		return PTR_ERR(tmu->base);
> > 			^
> > 		dev_err_probe();
> >
> > > +
> > > +	tmu->clk = devm_clk_get_enabled(dev, NULL);
> > > +	if (IS_ERR(tmu->clk))
> > > +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> > > +
> > > +	platform_set_drvdata(pdev, tmu);
> > > +
> > > +	/* disable the monitor during initialization */
> > > +	imx91_tmu_enable(tmu, false);
> > > +	imx91_tmu_start(tmu, false);
> >
> > No need to disable it here since both bits (ENABLE and START) are 0
> > after a reset.
> 
> Maybe uboot enable it. We can't depend on reset value without really set
> hardware reset bit.

So the module can't be rested e.g. by disabling module power? Having a
dedicated reset mechanism would be much simpler instead of writing each
reg-field to the default value.

> > > +	ret = imx91_init_from_nvmem_cells(tmu);
> > > +	if (ret) {
> > > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> > 			^
> > Can you please anwer if _relaxed API is sufficient? I don't know why you
> > making use of the _relaxed API here anyway. We have only a few MMIO
> > accesses here, so why can't we use the writel() instead? This applies to
> > the whole driver.
> 
> There are not big difference writel_relaxed() or writel() for this driver.
> Just original owner pick one.

NACK, the difference is that _relaxed() APIs don't guarantee the order
the register access is done.

> > > +	}
> > > +
> > > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > > +	rate = clk_get_rate(tmu->clk);
> > > +	div = (rate / 4000000) - 1;
> > > +	if (div > FIELD_GET(DIV_MASK, DIV_MASK))
> > 			^
> > This misuse the FIELD_GET() API. Instead please add a define e.g. DIV_MAX.
> 
> I don't think so, It avoid define another macro DIV_MAX, which may miss
> defined, the related marco should come from one source.
> 
> For example:
> 
> DIV_MASK is GENMASK(23, 16),  DIV_MAX is 256. But if hardware upgrade,
> DIV_MASK to GENMASK(24, 16), DIV_MAX is quite easy to forget update it and
> hard to find such mis-match when div value < 256.

We not talking about "possible" other HW. For now it's just this one and
using FIELD_GET() this way is seems odd, at least to me.

> > > +		return -EINVAL;
> > 			^
> > 		dev_err_probe()
> > > +
> > > +	/* Set divider value and enable divider */
> > > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > > +
> > > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> > 		^
> > You dont need to repeat the default value, so this line can be dropped.
> >
> > > +
> > > +	/*
> > > +	 * Set resolution mode
> > > +	 * 00b - Conversion time = 0.59325 ms
> > > +	 * 01b - Conversion time = 1.10525 ms
> > > +	 * 10b - Conversion time = 2.12925 ms
> > > +	 * 11b - Conversion time = 4.17725 ms
> > > +	 */
> > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
> >
> > Same here, you repeat the module default after reset, so please drop it.
> >
> > > +	writel_relaxed(CTRL1_MEAS_MODE_MASK, tmu->base + CTRL1_CLR);
> > > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, CTRL1_MEAS_MODE_SINGLE),
> > > +		       tmu->base + CTRL1_SET);
> > > +
> > > +	clk_disable_unprepare(tmu->clk);
> >
> > Drop this, and
> >
> > > +	pm_runtime_set_suspended(dev);
> >
> > replace this with: pm_runtime_set_active();
> 
> No big difference, if set_active, we need add Enable TMU here. I can
> change to set_active.

You don't need to manually disable the clock, it would be done by the
runtime-pm.

Regards,
  Marco


> Frank
> 
> >
> > > +	pm_runtime_enable(dev);
> > 		^
> > devm_pm_runtime_enable()
> >
> > > +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> > > +	if (IS_ERR(tmu->tzd))
> > > +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> > > +				     "failed to register thermal zone sensor\n");
> >
> >
> > pm_runtime_put()
> >
> >
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void imx91_tmu_remove(struct platform_device *pdev)
> > > +{
> > > +	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
> > > +
> > > +	/* disable tmu */
> > > +	imx91_tmu_start(tmu, false);
> >
> > No need to clear the START bit since we are running in
> > single-shot-measurements now.
> >
> > > +	imx91_tmu_enable(tmu, false);
> > > +}
> > > +
> > > +static int imx91_tmu_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > > +
> > > +	/* disable tmu */
> > > +	imx91_tmu_start(tmu, false);
> >
> > Can be dropped.
> >
> > > +	imx91_tmu_enable(tmu, false);
> > > +
> > > +	clk_disable_unprepare(tmu->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx91_tmu_runtime_resume(struct device *dev)
> > > +{
> > > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(tmu->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	imx91_tmu_enable(tmu, true);
> > > +	imx91_tmu_start(tmu, true);
> >
> > Drop imx91_tmu_start() from the resume since this isn't related to the
> > runtime-pm. Instead the function needs to be called within
> > imx91_tmu_get_temp().
> >
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops imx91_tmu_pm_ops = {
> > > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> > > +	RUNTIME_PM_OPS(imx91_tmu_runtime_suspend, imx91_tmu_runtime_resume, NULL)
> > > +};
> >
> > DEFINE_RUNTIME_DEV_PM_OPS()
> >
> > > +
> > > +static const struct of_device_id imx91_tmu_table[] = {
> > > +	{ .compatible = "fsl,imx91-tmu", },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> > > +
> > > +static struct platform_driver imx91_tmu = {
> > > +	.driver = {
> > > +		.name	= "i.MX91_thermal",
> > 				^
> > Please don't use such names, instead use imx91_thermal.
> >
> > Regards,
> >   Marco
> >
> > > +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> > > +		.of_match_table = imx91_tmu_table,
> > > +	},
> > > +	.probe = imx91_tmu_probe,
> > > +	.remove = imx91_tmu_remove,
> > > +};
> > > +module_platform_driver(imx91_tmu);
> > > +
> > > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > > +MODULE_LICENSE("GPL");
> > >
> > > --
> > > 2.34.1
> > >
> > >
> 

