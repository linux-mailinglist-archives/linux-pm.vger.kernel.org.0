Return-Path: <linux-pm+bounces-14584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521E97EF47
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06FAB21583
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EBA19F10F;
	Mon, 23 Sep 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gsi6BcX+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B16197A97;
	Mon, 23 Sep 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108998; cv=none; b=BMOaGX/sb3UHe+2PcsUDAtwo6co9vO1/5mE0Rn1MFkFahmDS7F3c7NFj+vbTzY4RhfSbfoDe0mjCA4zT+T2askg5hdkF246ARUFg/A6kvXozAIin0finxcaMVp7TBi6toF9p+4KsAY7KsbamFoEvVzEvthBoScuWLdxFYVNZpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108998; c=relaxed/simple;
	bh=Txy4umxwzXeEDZRELo1lzkAdTGPrrnMyXfHjONuFz5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrrrROmvZ5IiXkXXboQ6d997zE/SheB0RGvvNroDbVKKbt0+uPaiap6N5fWaQc+uT0zfKvEuTH8J090y2/2aTT0z6DG4WhIl/5hQcMhMte9nxcnlJeEPXEIMqkp02bczM9ac8PB4Rr51z61l7PChMDx6lSLl/03xCg+bPsNa5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gsi6BcX+; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/AmOiAHeLFGH+2TLf+NtkplfI90prKE8BJKRX3gixao=; b=gsi6BcX+zG9nEqxAcxGMxx/fgN
	2jgqpr6PExcCYdzFQCihd0v4Zi7g74au7D+dN9q9LtadEJL3AcMv17el/g6ZUE8TnLEpIktJ/Sp6a
	7XeTSjqIvmvtcn4hrty8sb8OG+9iQicgUSvxzmQj5JN9BYgbRsNb96u/Ob4cz0k65IWGzCs48NaKL
	Bi5vlbpojSHzlUQIWjH8xS/F+eozz1pJVhHPNVoXi1zjLAw+j77xwj19RsKG+rxgDfrOxLbDyoNGo
	zIuntuBrSkGRYY8nnv9RN1VtNZcokp7pPm1oDo3fl9f7J4BJnsWINIemRb7pKpq0LjRvFsYgr4Ju0
	9y0JHXlg==;
Date: Mon, 23 Sep 2024 18:29:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tony@atomide.com, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: initial support for TWL6030/32
Message-ID: <20240923182948.571eaa59@akair>
In-Reply-To: <89a7e86b-8866-4148-9f9e-13ca84c1aede@kernel.org>
References: <20240918084132.928295-1-andreas@kemnade.info>
	<20240918084132.928295-4-andreas@kemnade.info>
	<89a7e86b-8866-4148-9f9e-13ca84c1aede@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 18 Sep 2024 12:43:01 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

> On 18/09/2024 10:41, Andreas Kemnade wrote:
> > Add a driver for the charger in the TWL6030/32. For now it does not
> > report much in sysfs but parameters are set up for USB, charging is
> > enabled with the specified parameters. It stops charging when full
> > and also restarts charging.
> > This prevents ending up in a system setup where you run out of
> > battery although a charger is plugged in after precharge completed.
> > 
> > Battery voltage behavior was checked via the GPADC.
> >   
> 
> Few stylistic comments below.
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/power/supply/Kconfig           |  10 +
> >  drivers/power/supply/Makefile          |   1 +
> >  drivers/power/supply/twl6030_charger.c | 566
> > +++++++++++++++++++++++++ 3 files changed, 577 insertions(+)
> >  create mode 100644 drivers/power/supply/twl6030_charger.c
> > 
> > diff --git a/drivers/power/supply/Kconfig
> > b/drivers/power/supply/Kconfig index bcfa63fb9f1e2..9f2eef6787f7a
> > 100644 --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -493,6 +493,16 @@ config CHARGER_TWL4030
> >  	help
> >  	  Say Y here to enable support for TWL4030 Battery Charge
> > Interface. 
> > +config CHARGER_TWL6030
> > +	tristate "OMAP TWL6030 BCI charger driver"
> > +	depends on IIO && TWL4030_CORE  
> 
> || COMPILE_TEST, at least for TWL part
> (but please test first)
> 
ERROR: modpost: "twl_i2c_write"
[drivers/power/supply/twl6030_charger.ko] undefined! ERROR: modpost:
"twl_i2c_read" [drivers/power/supply/twl6030_charger.ko] undefined!

>
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, twl_charger_of_match);
> > +
> > +static struct platform_driver twl6030_charger_driver = {
> > +	.probe = twl6030_charger_probe,
> > +	.driver	= {
> > +		.name	= "twl6030_charger",
> > +		.of_match_table =
> > of_match_ptr(twl_charger_of_match),  
> 
> I propose to drop of_match_ptr and maybe_unused, so this won't be
> restricted only to OF
>
so that more things get compile-tested without OF? But I see no reason
why .probe would be optimized away (and with it a lot more things) by
the compiler.

Regards,
Andreas

