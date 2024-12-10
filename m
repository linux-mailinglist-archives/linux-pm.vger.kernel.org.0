Return-Path: <linux-pm+bounces-18921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E59EB3E9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798DC2837B6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C931B85C5;
	Tue, 10 Dec 2024 14:50:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628671B3940
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842200; cv=none; b=sBS2ccIrITzICfXvCKE9jd7dU2viM3nNgeofOnOqdd03z9tNQ+P3sbU9GamVnVYBZk+uIbuOHUhoFiLTH30OmnGTia/RSc0gEbDqaNkEQ9XUj/zGogFF2CGlj5M1eb3koKRp5yAWD/bc1h2JypOIbnNRqKq1u4Fs38RbHCMMGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842200; c=relaxed/simple;
	bh=egbRlbmlhjY1fckZ53UEb1P9iVDOvrQeu9+7WhhX9Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG2nkGEdRiez/gB02REpWlqmm2AvSS1pf9ZAGZMyjwWFNxJoKxL0CEDYSIIpwyn6Sb7cLvrHVFUvxffIzL8VrYKYzSlQsXA34pbB0ULd9TN6+0tEf/kfHny+PSLsALMEsCJpBxNh8IICI9YDMboV/coJzBI/8qkCVXp7q3Fo6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tL1YR-0005u5-Pz; Tue, 10 Dec 2024 15:49:39 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tL1YQ-002hu8-0r;
	Tue, 10 Dec 2024 15:49:39 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tL1YQ-008Y8G-2u;
	Tue, 10 Dec 2024 15:49:38 +0100
Date: Tue, 10 Dec 2024 15:49:38 +0100
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
	Pengfei Li <pengfei.li_1@nxp.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <20241210144938.zf3dkiubqhcxguqv@pengutronix.de>
References: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
 <20241209-imx91tmu-v1-2-7859c5387f31@nxp.com>
 <20241210103646.7gblp7mzxbna5gas@pengutronix.de>
 <Z1hLlm75iGMogltc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1hLlm75iGMogltc@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 24-12-10, Frank Li wrote:
> On Tue, Dec 10, 2024 at 11:36:46AM +0100, Marco Felsch wrote:
> > Hi,
> >
> > On 24-12-09, Frank Li wrote:

...

> > > +	/* disable the monitor during initialization */
> > > +	imx91_tmu_enable(tmu, false);
> > > +	imx91_tmu_start(tmu, false);
> >
> > Make use of pm_runtime?
> 
> thermal is always on after probe. continue measure tempature. So pm_runtime
> is not suitable for this case.

There are at least 3 drivers which use pm-runtime including the i.MX6/7
imx_thermal.c driver.

> > > +	ret = imx91_init_from_nvmem_cells(tmu);
> > > +	if (ret) {
> > > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> > > +	}
> > > +
> > > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > > +	rate = clk_get_rate(tmu->clk);
> > > +	div = (rate / 4000000) - 1;
> >
> > Would be nice to validate the div value before passing to the HW and if
> > the target rate of 4MHz can't be reached by the div you you should
> > return -EINVAL.
> >
> > > +
> > > +	/* Set divider value and enable divider */
> > > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > > +
> > > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
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
> > > +
> > > +	/*
> > > +	 * Set measure mode
> > > +	 * 00b - Single oneshot measurement
> > > +	 * 01b - Continuous measurement
> > > +	 * 10b - Periodic oneshot measurement
> > > +	 */
> >
> > For the resolution it's fine to have the values directly coded without a
> > define, but here we can definitly use a define and drop the comment.
> >
> > > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x3), tmu->base + CTRL1_CLR);
> > > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x1), tmu->base + CTRL1_SET);
> >
> > Why do we set it to periodic mode instead of the single-shot? At the
> > moment the device doesn't have IRQ support, and so there is no need to
> > run the measurements in background.
> 
> It is "continous measurement".  first clean MODE_MASK, then then 01.

Still, why? You return the temp value upon a request (get_temp). There
is no async notification from this driver to others. So it can be left
to single-shot and do the measurement on request (get_temp).

> _CLR means clean bits according to mask
> _SET means set bits according to mask.

I know.

Regards,
  Marco

> 
> Frank
> 
> >
> > > +
> > > +	/*
> > > +	 * Set Periodic Measurement Frequency to 25Hz:
> > > +	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]. ->
> > > +	 * PERIOD_CTRL(MEAS_FREQ) = (1000 / 25) / (1000 / 4000000);
> > > +	 * Where tMEAS_FREQ = Measurement period and tCONV_CLK = 1/fCONV_CLK.
> > > +	 * This field should have value greater than count corresponds
> > > +	 * to time greater than summation of conversion time, power up
> > > +	 * delay, and six times of conversion clock time.
> > > +	 * tMEAS_FREQ > (tCONV + tPUD + 6 * tCONV_CLK).
> > > +	 * tCONV is conversion time determined by CTRL1[RESOLUTION].
> > > +	 */
> > > +	writel_relaxed(FIELD_PREP(MEAS_FREQ_MASK, 0x27100), tmu->base + PERIOD_CTRL);
> >
> > With the single-shot measurements we could remove this part and..
> >
> > > +
> > > +	/* enable the monitor */
> > > +	imx91_tmu_enable(tmu, true);
> > > +	imx91_tmu_start(tmu, true);
> >
> > this part as well.
> >
> > Regards,
> >   Marco
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
> > > +	imx91_tmu_enable(tmu, false);
> > > +}
> > > +
> > > +static int __maybe_unused imx91_tmu_suspend(struct device *dev)
> > > +{
> > > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > > +
> > > +	/* disable tmu */
> > > +	imx91_tmu_start(tmu, false);
> > > +	imx91_tmu_enable(tmu, false);
> > > +
> > > +	clk_disable_unprepare(tmu->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused imx91_tmu_resume(struct device *dev)
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
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(imx91_tmu_pm_ops,
> > > +			 imx91_tmu_suspend, imx91_tmu_resume);
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
> > >
> 

