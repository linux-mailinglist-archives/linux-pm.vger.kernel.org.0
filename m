Return-Path: <linux-pm+bounces-35922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0EBCD997
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B02D4E507A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCE2F60D8;
	Fri, 10 Oct 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MasSTGUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2313BC0C;
	Fri, 10 Oct 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107522; cv=none; b=cDuOmr8xp/dGnHmtr0zst+lk4n69OKBwHVGDO9W+9fvfJUwTMBA8SplB1kg2pbGu9KZ/Bcbd74hvoyybC4cttZFQM7JusxXgCWV5LolziDamq5xUhgM6PcFQZlkAwPOAi3h7r3fR/PEfU8uPAkZD5XeU2V9ZEQg8oG7RR5y/q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107522; c=relaxed/simple;
	bh=9+oSY/IZtMS97w/FzZPMB/lEGaydDpXxMEPE+D8KrRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG3ljEzP0ZzI1VyyNXZxlFkcZyy5m248s9TaJoB73QAa0MWz3Oe86WVCfomD36egynH8TJK8As9ZZBHPQ3I4VryqtYg+WkXgxCvCtXjBTXQ3Ni4F0jPReYQJOeR4rwSaXiTuedrZ33iW2ZL+DQn4ZxHhG+SJHnvaihtMQWICU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MasSTGUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A3C4CEF1;
	Fri, 10 Oct 2025 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107521;
	bh=9+oSY/IZtMS97w/FzZPMB/lEGaydDpXxMEPE+D8KrRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MasSTGUxtdJ0kcf9pdDVZ1iYZ+kaTlR9cw4p4YYeuTi9Oeuadmj8g4UPjjFxrmQtK
	 SKPfVf0lkBuTQDsNyj87s9EidgaRKqdVR8Q09GQWEAqMhvRtEkK4gkVVU0C0IhGgqW
	 lBTY9xgHWg1kZFdOx0zeqNp9lYWfBN83x7tneTDBACZ/05+aakSlWqLKqUy7LiPnXq
	 VDUvo3qGNObPubLd+37GUu8O1WYU1fNEgcLn69ny4t9A0uubroLl4BuJbvC70OYiqo
	 4Hq0Ss+sXQtEJprY1YckkLeLlg9BvjcHxOYIVqjJJd6IQXvZMFryrtmIykMxMu7Yyj
	 XDBSs+2wck6WA==
Date: Fri, 10 Oct 2025 15:45:15 +0100
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
Message-ID: <20251010144515.GI2988639@google.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
 <20251009161847.GE2890766@google.com>
 <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>

On Fri, 10 Oct 2025, Matti Vaittinen wrote:

> Hi deee Ho Lee,
> 
> And Thanks for the review!
> 
> On 09/10/2025 19:18, Lee Jones wrote:
> > On Tue, 07 Oct 2025, Matti Vaittinen wrote:
> > 
> > > The ROHM BD72720 is a power management IC which continues the BD71828
> > > family of PMICs. Similarly to the BD71815 and BD71828, the BD72720
> > > integrates regulators, charger, RTC, clock gate and GPIOs.
> > > 
> > > The main difference to the earlier PMICs is that the BD72720 has two
> > > different I2C slave addresses. In addition to the registers behind the
> > > 'main I2C address', most of the charger (and to some extent LED) control
> > > is done via registers behind a 'secondary I2C slave address', 0x4c.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > 
> > > ---
> > > Note: This patch depends on the series: "power: supply: add charger for
> > > BD71828" by Andreas:
> > > https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemnade.info/
> > > 
> > > There are some new variants being planned. Most notably, the BD73900
> > > should be almost identical to the BD72720 - for everything else except
> > > the charger block.
> > > ---
> 
> // snip
> 
> > > +
> > > +static struct regmap *bd72720_secondary_regmap;
> > 
> > Dynamically allocate this and add it to .platform_data once it's
> > populated.
> > 
> 
> This can be done but I suppose it's unnecessary churn. This driver does not
> (at the moment) support more than one instance of the PMIC anyways. (The
> button data is not alloacted).
> 
> This is not really a problem as typically there is only 1 of these PMICs to
> be controlled.

I'd take a few lines of extra code over a globally defined variable any
day of the week.

> // snip
> 
> > > +/*
> > > + * The BD72720 is an odd beast in that it contains two separate sets of
> > > + * registers, both starting from address 0x0. The twist is that these "pages"
> > > + * are behind different I2C slave addresses. Most of the registers are behind
> > > + * a slave address 0x4b, which will be used as the "main" address for this
> > > + * device.
> > > + * Most of the charger related registers are located behind slave address 0x4c.
> > > + * It is tempting to push the dealing with the charger registers and the extra
> > > + * 0x4c device in power-supply driver - but perhaps it's better for the sake of
> > > + * the cleaner re-use to deal with setting up all of the regmaps here.
> > > + * Furthermore, the LED stuff may need access to both of these devices.
> > > + */
> > > +#define BD72720_SECONDARY_I2C_SLAVE 0x4c
> > > +static const struct regmap_range bd72720_volatile_ranges_4b[] = {
> > > +	{
> > > +		/* RESETSRC1 and 2 are write '1' to clear */
> > > +		.range_min = BD72720_REG_RESETSRC_1,
> > > +		.range_max = BD72720_REG_RESETSRC_2,
> > 
> > regmap_reg_range()?
> 
> Ah, thanks. Out of the curiosity - do you know why this macro is written on
> lowercase?

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Mark Brown <broonie@linaro.org>

=:-)

> // snip
> > > +static int bd72720_set_type_config(unsigned int **buf, unsigned int type,
> > > +				   const struct regmap_irq *irq_data,
> > > +				   int idx, void *irq_drv_data)
> > > +{
> > > +	const struct regmap_irq_type *t = &irq_data->type;
> > > +
> > > +	/*
> > > +	 * The regmap IRQ ecpects IRQ_TYPE_EDGE_BOTH to be written to register
> > > +	 * as logical OR of the type_falling_val and type_rising_val. This is
> > > +	 * not how the BD72720 implements this configuration, hence we need
> > > +	 * to handle this specific case separately.
> > > +	 */
> > > +	if (type == IRQ_TYPE_EDGE_BOTH) {
> > > +		buf[0][idx] &= ~t->type_reg_mask;
> > > +		buf[0][idx] |= BD72720_GPIO_IRQ_TYPE_BOTH;
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	return regmap_irq_set_type_config_simple(buf, type, irq_data, idx,
> > > +						 irq_drv_data);
> > 
> > Use 100-chars to avoid these pointless wraps please.
> 
> gnarl. I think we have discussed this before :)
> I would love to keep the lines short - closer to 80 chars - because that way
> I can fit 3 terminals on my screen. All the years spent staring at the
> monitor are taking their toll, and my vision isn't as good as it used to be.
> Frightening thing being that it seems I will only need to increase the font
> in the future :/
> 
> Well, sure the lines can be split if you feel strongly about it - but I have
> a real reason (other than the usual - "they have always been like that") to
> try keep them short...

Welcome to the year 2000 when 32" monitors are super affordable.

> > > +}
> > > +
> > >   static const struct regmap_irq_chip bd71828_irq_chip = {
> > >   	.name = "bd71828_irq",
> > >   	.main_status = BD71828_REG_INT_MAIN,
> > > @@ -465,6 +814,28 @@ static const struct regmap_irq_chip bd71815_irq_chip = {
> > >   	.irq_reg_stride = 1,
> > >   };
> > > +static const unsigned int bd72720_irq_type_base = BD72720_REG_GPIO1_CTRL;
> > 
> > This makes it look like a global variable, which I am allergic to.
> > 
> > Perhaps make it clear that this is a single element static array instead.
> 
> Ok. Just a comment will do?

Nope. :)

> > > +static const struct regmap_irq_chip bd72720_irq_chip = {
> > > +	.name = "bd72720_irq",
> > > +	.main_status = BD72720_REG_INT_LVL1_STAT,
> > > +	.irqs = &bd72720_irqs[0],
> > > +	.num_irqs = ARRAY_SIZE(bd72720_irqs),
> > > +	.status_base = BD72720_REG_INT_PS1_STAT,
> > > +	.unmask_base = BD72720_REG_INT_PS1_EN,
> > > +	.config_base = &bd72720_irq_type_base,
> > > +	.num_config_bases = 1,
> > > +	.num_config_regs = 2,
> > > +	.set_type_config = bd72720_set_type_config,
> > > +	.ack_base = BD72720_REG_INT_PS1_STAT,
> > > +	.init_ack_masked = true,
> > > +	.num_regs = 12,
> > > +	.num_main_regs = 1,
> > > +	.sub_reg_offsets = &bd72720_sub_irq_offsets[0],
> > > +	.num_main_status_bits = 8,
> > > +	.irq_reg_stride = 1,
> > > +};
> > > +
> > >   static int set_clk_mode(struct device *dev, struct regmap *regmap,
> > >   			int clkmode_reg)
> > >   {
> > > @@ -511,6 +882,25 @@ static void bd71828_remove_poweroff(void *data)
> > >   	pm_power_off = NULL;
> > >   }
> > > +static int bd72720_get_secondary_regmap(struct i2c_client *i2c,
> > 
> > Does this 'secondary' have a specific purpose or a better name?
> 
> I am not entirely sure. When I asked this from the designers they just told
> me that they needed more than 255 registers so they added another slave
> address... (I'm not sure what would have been wrong with using a page
> register). So, I assume they just placed stuff that didn't fit in first 255
> register there. But yeah, it looks like most of the registers there are
> related to the charger. So, perhaps it isn't completely misleading to use
> "charger regmap"? The data-sheet seems to be just using "Register map 1" and
> "Register map 2" in the tables listing these registers. I kind of like using
> something which maps easily to the data-sheet, but I really have no strong
> opinion on this.
> 
> > > +					const struct mfd_cell *mfd, int cells)
> > > +{
> 
> // snip
> 
> > > diff --git a/include/linux/mfd/rohm-bd72720.h b/include/linux/mfd/rohm-bd72720.h
> > > new file mode 100644
> > > index 000000000000..856a6962b1b2
> > > --- /dev/null
> > > +++ b/include/linux/mfd/rohm-bd72720.h
> > > @@ -0,0 +1,632 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * Copyright 2024 ROHM Semiconductors.
> > 
> > Seems odd to introduce a new file with an old date.
> 
> I originally wrote this last year :) I can it update though. Thanks.
> 
> > 
> > > + *
> > > + * Author: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > + */
> > > +
> > > +#ifndef _MFD_BD72720_H
> > > +#define _MFD_BD72720_H
> > > +
> > > +#include <linux/regmap.h>
> > > +
> > > +enum {
> > > +	BD72720_BUCK1,
> > > +	BD72720_BUCK2,
> > > +	BD72720_BUCK3,
> > > +	BD72720_BUCK4,
> > > +	BD72720_BUCK5,
> > > +	BD72720_BUCK6,
> > > +	BD72720_BUCK7,
> > > +	BD72720_BUCK8,
> > > +	BD72720_BUCK9,
> > > +	BD72720_BUCK10,
> > > +	BD72720_BUCK11,
> > > +	BD72720_LDO1,
> > > +	BD72720_LDO2,
> > > +	BD72720_LDO3,
> > > +	BD72720_LDO4,
> > > +	BD72720_LDO5,
> > > +	BD72720_LDO6,
> > > +	BD72720_LDO7,
> > > +	BD72720_LDO8,
> > > +	BD72720_LDO9,
> > > +	BD72720_LDO10,
> > > +	BD72720_LDO11,
> > > +	BD72720_REGULATOR_AMOUNT,
> > > +};
> > > +
> > > +/* BD72720 interrupts */
> > > +#define BD72720_INT_LONGPUSH_MASK BIT(0)
> > 
> > Tab out the values please.
> 
> Ok, sure.
> 
> Ps.
> I do really appreciate you going through RFCs :) Kudos!

NP

-- 
Lee Jones [李琼斯]

