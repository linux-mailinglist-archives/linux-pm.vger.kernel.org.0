Return-Path: <linux-pm+bounces-32807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64724B2F759
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E274D188E823
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94D2DFA40;
	Thu, 21 Aug 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bZTxGDmt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98C1E991B;
	Thu, 21 Aug 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777551; cv=none; b=rqC2bHqGFsHIi0eAf5WZYdTYoPN6GG1JyMfecxVPNqZkt21z1Sx3cDkfrUnwLH+GudvO1n5JNemmIeRuey+vlqTgiHnKkzCci1yxtHqf+668p3DGAvEJotXFtfZcUQtJoK7EEwRGr7iWEtSIx7UI+mIQRpHsmH5cW2Whow00j/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777551; c=relaxed/simple;
	bh=ON+fT5/VOLmiFW4HKd5bWQUm+E3Gnwxg6Ny15LQhxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCosUQ6mGQ7a9/fgH7GJyS3pJLSj0l66qtBNB5XFUWzbWcwB9Cc1zKp78g84qgiwi7A1y0NLruzYoAHupl4y7vvAOAqHLZ/UWW3XGzRkTAR6GsX1gF921JGbcDcc04tK0gXUVLvyNfR1JQ75koRIpFBcEYqQMGxievIRzgrdBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=bZTxGDmt; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qfOo+6egoxzaqQXrgCGLp4eqYlzOglIg1+6kt0rT8Us=; b=bZTxGDmtnkRP64ggrQ21P1G3rz
	pXd/033e9jyWdtySKds7pUwaCbYbrf88MWCPLb/yr9Wd/DgTSUXmDHf0jpfm/OBst8iPv7UeMMyAv
	5HPZYfZBUC8kqgA77cFGTJVC7hiYrDUVS47/klgavavKdda8H/XBpmgIUSllmU2+HXWRQqOnOEO6P
	bJonbhCq8kT0jC++s+PxwPWGyNpSyL8Z5KLSH2Th0hjEA0Y4TnlONUtn1m3qGA8Na09LccjkHBOsX
	R7He5IyK9Kk45jT5sufriyFuXiAwRgT+hcSlqGvIEp06Ca0PPJvuLb+J71Zc9UwXbIxx7Wd8DGmvi
	87ijeTZA==;
Date: Thu, 21 Aug 2025 13:59:05 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>
Subject: Re: [PATCH v2 2/2] power: supply: Add bd718(15/28/78) charger
 driver
Message-ID: <20250821135905.233dcf2c@akair>
In-Reply-To: <d0471494-3f95-44f3-a301-142eb745ae2f@gmail.com>
References: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
	<20250820-bd71828-charger-v2-2-32fc96027e92@kemnade.info>
	<d0471494-3f95-44f3-a301-142eb745ae2f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 21 Aug 2025 09:38:12 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> On 20/08/2025 23:21, Andreas Kemnade wrote:
> > Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> > It is a stripped down version of the driver here:
> > https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
> > 
> > For the ease of review and to do a step-by-step approach remove all the
> > coloumb counter related stuff and do not sneak in BD71827 support. That
> > also avoids non-trivial rebasing of the above series.
> > 
> > Changes besides that:
> > Replace the custom property by a standard one and do not use megaohms
> > for the current sense resistor.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Thanks for doing this Andreas :) Just a question about maintenance and 
> one comment. After those are handled:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> I also added couple of styling 'nits', which you can address if you agree.
> 
> > ---
> >   drivers/power/supply/Kconfig         |    9 +
> >   drivers/power/supply/Makefile        |    1 +
> >   drivers/power/supply/bd71828-power.c | 1135 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 1145 insertions(+)
> > 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..16dddb2355d9b89ccf0ad453fb77c189cf36f00f 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -974,6 +974,15 @@ config CHARGER_UCS1002
> >   	  Say Y to enable support for Microchip UCS1002 Programmable
> >   	  USB Port Power Controller with Charger Emulation.
> >   
> > +config CHARGER_BD71828
> > +	tristate "Power-supply driver for ROHM BD71828 and BD71815 PMIC"
> > +	depends on MFD_ROHM_BD71828
> > +	help
> > +	  Say Y here to enable support for charger and battery
> > +	  in ROHM BD71815, BD71817, ROHM BD71828 power management
> > +	  ICs. This driver gets various bits of information about battery
> > +	  and charger states.
> > +
> >   config CHARGER_BD99954
> >   	tristate "ROHM bd99954 charger driver"
> >   	depends on I2C
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index f943c9150b326d41ff241f82610f70298635eb08..c6520a11f021c872f01250ae54eb4c63018cd428 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -113,6 +113,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
> >   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> >   obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
> >   obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
> > +obj-$(CONFIG_CHARGER_BD71828)	+= bd71828-power.o
> >   obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
> >   obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
> >   obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
> > diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
> > new file mode 100644  
> 
> Do you think you could agree to maintain this? I would like to also be 
> listed either as M: or R:
> 
> So please, add one more patch bringing in the maintainer info.
> 
ok, I will do.

> > index 0000000000000000000000000000000000000000..f074d7159de1cb832bc0fb5ab494cddeb96a8968
> > --- /dev/null
> > +++ b/drivers/power/supply/bd71828-power.c
> > @@ -0,0 +1,1135 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * bd71828-power.c
> > + * @file ROHM BD71815, BD71828 and BD71878 Charger driver
> > + *
> > + * Copyright 2021.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/rohm-bd71815.h>
> > +#include <linux/mfd/rohm-bd71828.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +
> > +/* common defines */
> > +#define BD7182x_MASK_VBAT_U			0x1f
> > +#define BD7182x_MASK_VDCIN_U			0x0f
> > +#define BD7182x_MASK_IBAT_U			0x3f
> > +#define BD7182x_MASK_CURDIR_DISCHG		0x80
> > +#define BD7182x_MASK_CC_CCNTD_HI		0x0FFF
> > +#define BD7182x_MASK_CC_CCNTD			0x0FFFFFFF  
> 
> nit: I would still drop the unused defines. They make this look more 
> complex than it is and make also reviewing harder. (Same as with the 
> unused struct members - I think the defines should be introduced in the 
> patch which also uses them. (Well, register address definitions are an 
> exception - I'm not against defining all register addresses in initial 
> commit. Especially so when we have an MFD device, where register 
> addresses tend to live in different subsystem (MFD) tree.
> 
ok, I will take the brush. Time for a power-nap on the 'd' key...

Regards,
Andreas

