Return-Path: <linux-pm+bounces-35525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD4BA760C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 20:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C12177C8A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69924397A;
	Sun, 28 Sep 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="txCqod+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D2635;
	Sun, 28 Sep 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759082478; cv=none; b=c2/94UM1yoVlYr9pYHemYxNOefcv8OkyUxSpYV8YMF6CkXFcLjWcQyy0S9kNOdu9LKyVOhIDhdWdzwwCktcFCiMTlJc2/qJ0NMLt0Q7v91T0K7CvZgW7C6LrCm4HrouhoVcsLoX+xr0TpPSrx+S0vyyrwhTfRCHZwUWGlbDcICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759082478; c=relaxed/simple;
	bh=ETGlfgCHn7iTomo7gbPyeKU7/4yXFLWwgSsvm/N4bJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdWQo8Ys/xjCiL2vU8kruSSMT63QPySkG5e+PhN7QYkoAkSp+aqy9smGuTk5FcBQU0a1ZVVaCKv8Z9fccGi0vBXK4RffT3xz/y7L3TuJqjeoZNo9mnP6lSMn5ZVSPGan4WJ4BoqF/foZJpJ3YI2teiVYyq2sDvwkrRVY6gfQ0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=txCqod+7; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=p3zwPG2lHdfGT54vRdWzMiWo1GIY+4oyV83lYkTPCSg=; b=txCqod+7lxWDuX9hd4gJshx+rB
	jLCDSApN3cGlTlr2qpYvhamL3LoECi5F4cqyj44c0gAV+ltxFnBfm0iBvhqi5/cdl5uJ0m9sc995z
	GwWM8UZJRcGEQjAKV9dRXFf+ZHJWRIx9utw47og7Y0P1a5ZjlasCEtL1/RXjkOUPRaElOwzNSTKVJ
	XBs6/TeBl3YOETm0A/qiP94hRqi3vLR+NcWeMBdzddiGk5T8/e1cSJrshXG8eoiv/sjFGHtaK6VR8
	mLE8Ki8VcsL+syGhf3f2lX7mikw5EsBY1OS3NdMTLpbf2Cp02CQL8iSYRsOeGmlv4h4gv5ZEClUOI
	YINvYD3Q==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2vhm-001XtX-0B;
	Sun, 28 Sep 2025 20:01:02 +0200
Date: Sun, 28 Sep 2025 20:01:01 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aNl33eHpr7gd8HJz@aurel32.net>
Mail-Followup-To: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
 <20250927220824.1267318-2-aurelien@aurel32.net>
 <20250928000255-GYA1342640@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928000255-GYA1342640@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Yixun,

On 2025-09-28 08:02, Yixun Lan wrote:
> Hi Aurelien, 
> 
> On 00:07 Sun 28 Sep     , Aurelien Jarno wrote:
> > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > chip, which is commonly paired with the SpacemiT K1 SoC.
> > 
> > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > done directly through the regmap interface. Reboot or poweroff is
> > triggered by setting a specific bit in a control register, which is
> > automatically cleared by the hardware afterwards.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  drivers/power/reset/Kconfig              |  9 +++
> >  drivers/power/reset/Makefile             |  1 +
> >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+)
> >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > 
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 77ea3129c7080..5afef049760d6 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> [snip]..
> > +
> > +static int spacemit_p1_reboot_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	regmap = dev_get_regmap(dev->parent, NULL);
> > +	if (!regmap)
> > +		return -ENODEV;
> > +
> > +	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler, regmap);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register power off handler: %d\n", ret);
> > +		return ret;
> suggest to simplify with dev_err_probe(), which will save few lines
> > +	}
> > +
> > +	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler, regmap);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register restart handler: %d\n", ret);
> > +		return ret;
> ditto

Thanks for the hint, that'll be in the next version.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

