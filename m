Return-Path: <linux-pm+bounces-36278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E2BE438B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1D345DCB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A235346A00;
	Thu, 16 Oct 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZczjY8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C7212542;
	Thu, 16 Oct 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628474; cv=none; b=WMFcOw4dELV676ymq1Y8iu0SdZAwyzY/J7IFoD+EhtQVzvDziYRiPfoNw5DqZ3kSsJg2iGFUL0chPRJx/3gC0NLCK7ZPdRzGDKZ1UAEjW5SJrNqiXPRP2c/N3+yCLO2UAe6+kHI6YKEByc48rgHit0ivFKo6hxFJOoY6SfyE6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628474; c=relaxed/simple;
	bh=Q/HWaD+Cm1k2FvqHSaHj4us9kKwWTCjTyyYVe2cQN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCcqglCwftdcicI/wG/9b4HgNXGI3rv5eF3dESF2p/QVMzQkZ/0F8Ju65jHo54N+ZY+/CsCyRZsmBmQn41AfOiN13+9670yBWVdzP9MsprYDQMvO1jPcTbXZUqej4+dJ8kyJgHYKr6Ej/drEMFVj9lU4rsfaSUbjLfewAfZNlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZczjY8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EF8C4CEFB;
	Thu, 16 Oct 2025 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628474;
	bh=Q/HWaD+Cm1k2FvqHSaHj4us9kKwWTCjTyyYVe2cQN/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZczjY8PAPUR65NODg0Xv5A+weHeZu0CXQADdIL3St/Ncjy4MenkFAGAoeyZPgHbt
	 +nzUcDcfaPa/kZk57EXSlo3HPRTx13NeijCuSiqSuLvEIh+arNEpSFheX7joGESlS9
	 lijYBN5NbYz9rfpGF1q38V/U9tz5Muvky7fP/aUvF8o1WhXjWq5nk9lGXkHAydqTYe
	 b4PJ79E0KswuKRsutuC/FpomCeKN36MmRrF9w1Dg5OuTDolxKv5ObbRqkqEzhPnzFK
	 2uWvjiVtfJH6HwPm3e5SgfEJgdmc7mCtmOJnD2/KSlpyDr0YAlAGnl+p7PtvCmvtav
	 r1OowkX02LnpA==
Date: Thu, 16 Oct 2025 16:27:49 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC PATCH 06/13] mfd: bd71828: Support ROHM BD72720
Message-ID: <20251016152749.GA9735@google.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
 <20251009161847.GE2890766@google.com>
 <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
 <20251010144515.GI2988639@google.com>
 <CANhJrGMEN0QRLoBzntVnaYgfFDyre=Yfw-dNdmi226p6pnpgHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhJrGMEN0QRLoBzntVnaYgfFDyre=Yfw-dNdmi226p6pnpgHw@mail.gmail.com>

On Mon, 13 Oct 2025, Matti Vaittinen wrote:

> pe 10.10.2025 klo 17.45 Lee Jones (lee@kernel.org) kirjoitti:
> >
> > On Fri, 10 Oct 2025, Matti Vaittinen wrote:
> >
> > > Hi deee Ho Lee,
> > >
> > > And Thanks for the review!
> > >
> > > On 09/10/2025 19:18, Lee Jones wrote:
> > > > On Tue, 07 Oct 2025, Matti Vaittinen wrote:
> > > >
> > > > > The ROHM BD72720 is a power management IC which continues the BD71828
> > > > > family of PMICs. Similarly to the BD71815 and BD71828, the BD72720
> > > > > integrates regulators, charger, RTC, clock gate and GPIOs.
> > > > >
> > > > > The main difference to the earlier PMICs is that the BD72720 has two
> > > > > different I2C slave addresses. In addition to the registers behind the
> > > > > 'main I2C address', most of the charger (and to some extent LED) control
> > > > > is done via registers behind a 'secondary I2C slave address', 0x4c.
> > > > >
> > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> // snip
> 
> > > > > +
> > > > > +static struct regmap *bd72720_secondary_regmap;
> > > >
> > > > Dynamically allocate this and add it to .platform_data once it's
> > > > populated.
> > > >
> > >
> > > This can be done but I suppose it's unnecessary churn. This driver does not
> > > (at the moment) support more than one instance of the PMIC anyways. (The
> > > button data is not alloacted).
> > >
> > > This is not really a problem as typically there is only 1 of these PMICs to
> > > be controlled.
> >
> > I'd take a few lines of extra code over a globally defined variable any
> > day of the week.
> 
> Even though that'll require us to drop the const from the
> bd72720_mfd_cells MFD cell array? Which, in turn, will probably
> require us to drop the const from the MFD cell pointer in probe as
> well. Additionally, this will require us to skim through the MFD cell
> array in probe, so we locate the power cell, adding one more spot for
> errors. I think this is quite a cost just a princible of dropping a
> global, which is accessed from one function only. I'd definitely agree
> if it was driver data which gets used in a variety of functions, but
> here we really just need a memory location for a pointer so MFD can
> copy it when kicking the 'sub drivers'. Do you think you can still
> reconsider?

If the data isn't ready, it shouldn't be in static / const structures.

You're attempting to statically declare dynamic data *shudder*, using
global variables *double-shudder*!

> >
> > > // snip
> > >
> > > > > +/*
> > > > > + * The BD72720 is an odd beast in that it contains two separate sets of
> > > > > + * registers, both starting from address 0x0. The twist is that these "pages"
> > > > > + * are behind different I2C slave addresses. Most of the registers are behind
> > > > > + * a slave address 0x4b, which will be used as the "main" address for this
> > > > > + * device.
> > > > > + * Most of the charger related registers are located behind slave address 0x4c.
> > > > > + * It is tempting to push the dealing with the charger registers and the extra
> > > > > + * 0x4c device in power-supply driver - but perhaps it's better for the sake of
> > > > > + * the cleaner re-use to deal with setting up all of the regmaps here.
> > > > > + * Furthermore, the LED stuff may need access to both of these devices.
> > > > > + */
> > > > > +#define BD72720_SECONDARY_I2C_SLAVE 0x4c
> > > > > +static const struct regmap_range bd72720_volatile_ranges_4b[] = {
> > > > > + {
> > > > > +         /* RESETSRC1 and 2 are write '1' to clear */
> > > > > +         .range_min = BD72720_REG_RESETSRC_1,
> > > > > +         .range_max = BD72720_REG_RESETSRC_2,
> > > >
> > > > regmap_reg_range()?
> > >
> > > Ah, thanks. Out of the curiosity - do you know why this macro is written on
> > > lowercase?
> >
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> >
> > =:-)
> 
> Yeah. I just thought that maybe you knew :)
> 
> >
> > > // snip
> > > > > +static int bd72720_set_type_config(unsigned int **buf, unsigned int type,
> > > > > +                            const struct regmap_irq *irq_data,
> > > > > +                            int idx, void *irq_drv_data)
> > > > > +{
> > > > > + const struct regmap_irq_type *t = &irq_data->type;
> > > > > +
> > > > > + /*
> > > > > +  * The regmap IRQ ecpects IRQ_TYPE_EDGE_BOTH to be written to register
> > > > > +  * as logical OR of the type_falling_val and type_rising_val. This is
> > > > > +  * not how the BD72720 implements this configuration, hence we need
> > > > > +  * to handle this specific case separately.
> > > > > +  */
> > > > > + if (type == IRQ_TYPE_EDGE_BOTH) {
> > > > > +         buf[0][idx] &= ~t->type_reg_mask;
> > > > > +         buf[0][idx] |= BD72720_GPIO_IRQ_TYPE_BOTH;
> > > > > +
> > > > > +         return 0;
> > > > > + }
> > > > > +
> > > > > + return regmap_irq_set_type_config_simple(buf, type, irq_data, idx,
> > > > > +                                          irq_drv_data);
> > > >
> > > > Use 100-chars to avoid these pointless wraps please.
> > >
> > > gnarl. I think we have discussed this before :)
> > > I would love to keep the lines short - closer to 80 chars - because that way
> > > I can fit 3 terminals on my screen. All the years spent staring at the
> > > monitor are taking their toll, and my vision isn't as good as it used to be.
> > > Frightening thing being that it seems I will only need to increase the font
> > > in the future :/
> > >
> > > Well, sure the lines can be split if you feel strongly about it - but I have
> > > a real reason (other than the usual - "they have always been like that") to
> > > try keep them short...
> >
> > Welcome to the year 2000 when 32" monitors are super affordable.
> 
> I know. But work rooms where I can fit larger table aren't. Not even
> in Finland which should have plenty of space. And my table is really
> packed.

*facepalm*  =:-)

I wouldn't swap out my 32" monitor now if you paid me!

-- 
Lee Jones [李琼斯]

