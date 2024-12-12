Return-Path: <linux-pm+bounces-19118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A59EE516
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A241887275
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5D211714;
	Thu, 12 Dec 2024 11:32:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B711F239A
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003146; cv=none; b=kKwZahvf/TzNMdgXgqsLNq+lVLEDfiXktS6Q6hfkLhUjOe323jt0Gd0crbzM9ZKQ+AUGqL2XZyFKNgWNML5qGwZd4u2DCH69vk0mTChLyKSR/0alB5agMJvltDJsxQG4BKbgGhEUcgqVf5ydI3Aumyiq+Ot1tMOiTnGoQ8WIlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003146; c=relaxed/simple;
	bh=ZVAihSvgfQuty8ITI57swW//l7DPkKP5Slf6S0lJ0pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slr8uyeLVwmjlMix7h+bb1TZSeIeXjBn2hAx8pwaBjzUZ0j36jkxRl9jrXsgZH30BOY9Sdj1cSooIR/yx5xEMBSguNZu+O8UmWrl9gdzDs98C7NqiTxDpCPtawQOaWrXE481jz/S0KGs3XczgUycu58+pCYzFdQEvtL/05ObDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLhQC-0005QD-1I; Thu, 12 Dec 2024 12:31:56 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLhQA-0031XP-1e;
	Thu, 12 Dec 2024 12:31:55 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tLhQB-00COyC-0X;
	Thu, 12 Dec 2024 12:31:55 +0100
Date: Thu, 12 Dec 2024 12:31:55 +0100
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
Message-ID: <20241212113155.wfbbmxcrtcefzuha@pengutronix.de>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
 <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
 <20241211154622.f2jwwrqansk6il3o@pengutronix.de>
 <Z1m+O1UV4HD+7Rr2@lizhi-Precision-Tower-5810>
 <20241211185705.7b5uw26loobibzln@pengutronix.de>
 <Z1n4h/AxzthB0V9l@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1n4h/AxzthB0V9l@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 24-12-11, Frank Li wrote:
> On Wed, Dec 11, 2024 at 07:57:05PM +0100, Marco Felsch wrote:
> > On 24-12-11, Frank Li wrote:
> > > On Wed, Dec 11, 2024 at 04:46:22PM +0100, Marco Felsch wrote:
> > > > On 24-12-10, Frank Li wrote:
> > > > > From: Pengfei Li <pengfei.li_1@nxp.com>
> > > > >
> > > > > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > > > > single sensor for the CPU. The register layout differs from other chips,
> > > > > necessitating the creation of a dedicated file for this.
> > > > >
> > > > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > change from v1 to v2
> > > > > - use low case for hexvalue
> > > > > - combine struct imx91_tmu and tmu_sensor
> > > > > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > > > > - use s16 for imx91_tmu_get_temp(), which may negative value
> > > > > - use reverse christmas tree style
> > > > > - use run time pm
> > > > > - use oneshot to sample temp
> > > > > - register thermal zone after hardware init
> > > > > ---
> > > > >  drivers/thermal/Kconfig         |  10 ++
> > > > >  drivers/thermal/Makefile        |   1 +
> > > > >  drivers/thermal/imx91_thermal.c | 265 ++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 276 insertions(+)
> > > > >
> 
> [...]
> 
> > > > > +	platform_set_drvdata(pdev, tmu);
> > > > > +
> > > > > +	/* disable the monitor during initialization */
> > > > > +	imx91_tmu_enable(tmu, false);
> > > > > +	imx91_tmu_start(tmu, false);
> > > >
> > > > No need to disable it here since both bits (ENABLE and START) are 0
> > > > after a reset.
> > >
> > > Maybe uboot enable it. We can't depend on reset value without really set
> > > hardware reset bit.
> >
> > So the module can't be rested e.g. by disabling module power? Having a
> > dedicated reset mechanism would be much simpler instead of writing each
> > reg-field to the default value.
> 
> Not all module can be power off individual. Normally, it should have sw
> reset bit in controller. but I have not find it in this module.
> 
> >
> > > > > +	ret = imx91_init_from_nvmem_cells(tmu);
> > > > > +	if (ret) {
> > > > > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > > > > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> > > > 			^
> > > > Can you please anwer if _relaxed API is sufficient? I don't know why you
> > > > making use of the _relaxed API here anyway. We have only a few MMIO
> > > > accesses here, so why can't we use the writel() instead? This applies to
> > > > the whole driver.
> > >
> > > There are not big difference writel_relaxed() or writel() for this driver.
> > > Just original owner pick one.
> >
> > NACK, the difference is that _relaxed() APIs don't guarantee the order
> > the register access is done.
> 
> It is totally wrong. *_relexed() API can guarantee the register access
> order. Only can't guarantee order with other memory. such as
> 
> 1 writel_related(A, 0)
> 2. x = 3
> 3 writel_related(B, 1)
> 
> Hardware/memory model, require B=1 must be after A=0, but not necessary
> after x=3, that's means (2) x=3 may happen after 3.
> 
> if use writel(), guarantee 1, 2, 3 as order.  Here have not DMA involved.
> So not any impact if (2) after (3).
> 
> Typically, only below case have to use writel().
> 2 (update DMA descritpor), 3 start DMA,
> 
> Additional, writel() also can't guarantee register access is done!!!!
> 
> writel() just means you send a write command to bus. Not guarantee to reach
> target module. typical case is
> 
> writel(A, 0);
> udelay(1);
> writel(A, 1);
> 
> The interval between A=1 and A=0 may less than 1us if timer have not use
> MMIO register. (arm system counter).
> 
> In this driver, the only valuable benefit by using writel() instead of
> writel_relexed() is "short function name".

You're right, I had to check the documentation once again. The _relaxed
API is fine by me, thank you also for the clarification.

> > > > > +	}
> > > > > +
> > > > > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > > > > +	rate = clk_get_rate(tmu->clk);
> > > > > +	div = (rate / 4000000) - 1;
> > > > > +	if (div > FIELD_GET(DIV_MASK, DIV_MASK))
> > > > 			^
> > > > This misuse the FIELD_GET() API. Instead please add a define e.g. DIV_MAX.
> > >
> > > I don't think so, It avoid define another macro DIV_MAX, which may miss
> > > defined, the related marco should come from one source.
> > >
> > > For example:
> > >
> > > DIV_MASK is GENMASK(23, 16),  DIV_MAX is 256. But if hardware upgrade,
> > > DIV_MASK to GENMASK(24, 16), DIV_MAX is quite easy to forget update it and
> > > hard to find such mis-match when div value < 256.
> >
> > We not talking about "possible" other HW. For now it's just this one and
> > using FIELD_GET() this way is seems odd, at least to me.
> 
> If you look implement of FIELD_GET()
> (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));, it will be
> reasonable.

I know the implementation and still IMHO it's not the correct usage at
least to me. What's wrong is that a mask doesn't define the possible
values for a reg-field, e.g. GENMASK(1, 0) could allow all values from 0
to 3 but the HW may allow only 0 and 1.

> Hardware IP may update in future, bitwidth of field may expand.

Please see above.

> > > > > +		return -EINVAL;
> > > > 			^
> > > > 		dev_err_probe()
> > > > > +
> > > > > +	/* Set divider value and enable divider */
> > > > > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > > > > +
> > > > > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > > > > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> > > > 		^
> > > > You dont need to repeat the default value, so this line can be dropped.
> > > >
> > > > > +
> > > > > +	/*
> > > > > +	 * Set resolution mode
> > > > > +	 * 00b - Conversion time = 0.59325 ms
> > > > > +	 * 01b - Conversion time = 1.10525 ms
> > > > > +	 * 10b - Conversion time = 2.12925 ms
> > > > > +	 * 11b - Conversion time = 4.17725 ms
> > > > > +	 */
> > > > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> > > > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
> > > >
> > > > Same here, you repeat the module default after reset, so please drop it.
> > > >
> > > > > +	writel_relaxed(CTRL1_MEAS_MODE_MASK, tmu->base + CTRL1_CLR);
> > > > > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, CTRL1_MEAS_MODE_SINGLE),
> > > > > +		       tmu->base + CTRL1_SET);
> > > > > +
> > > > > +	clk_disable_unprepare(tmu->clk);
> > > >
> > > > Drop this, and
> > > >
> > > > > +	pm_runtime_set_suspended(dev);
> > > >
> > > > replace this with: pm_runtime_set_active();
> > >
> > > No big difference, if set_active, we need add Enable TMU here. I can
> > > change to set_active.
> >
> > You don't need to manually disable the clock, it would be done by the
> > runtime-pm.
> 
> Yes, runtime-pm can disable clock, but it need align harware and run time
> state before enable runtime pm.
> 
> There are two options
> 1 disable all hardware resources and pm_runtime_set_suspended()
> 2. enable all hardware resources and set_active()

I know.

> After algned, use runtime pm API to controller it.
> 
> I choose option1, you prefer option 2.

I know this too and I'm fine with it albeit I would like option 2 more
because:
 - based on pm-runtime API only
 - easier to enable autosuspend feature

Regards,
  Marco

> Frank
> >
> > Regards,
> >   Marco
> >
> >
> [...]
> > > > > +
> > > > > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > > > > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > > > > +MODULE_LICENSE("GPL");
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > >
> 

