Return-Path: <linux-pm+bounces-23814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564ECA5B64F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 02:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0828B1894D23
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66331E3DFA;
	Tue, 11 Mar 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IC9ctY59"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5141C63;
	Tue, 11 Mar 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657913; cv=none; b=NpBb7OI9Qnpi97K0WzF9vDC5RRvc+pvcL4V7MuPcc/9eRFEYdEhz9acekFkri1Jzl4F1PJU/oahfUNtkZKsCXoUwODtwlv4C69zoVE9T7388n+ZMMXAth7GdP0vIQ8mc6CT65lWaXDe41IGISSL3/6Zr/Z4AOIxmKx5ahieYiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657913; c=relaxed/simple;
	bh=SAWgCmReWDwFueE8sGcj3Dn15fV1Xg6gOw21ijuZnDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4BuS+vweaGBxtUcvJchUy+2OAbAkw5DCc1H8zbKfvtIKVgDgbAlD1TXpOId/KX+WmfP64Ke82oPKC3ItwwPmGf2T4jkfgFo3urL+9ri6eHy7XzwrvgmqnXF6OdsuSJyZLHFyk2u3qOJnQnLWzxcVSEtaRj/4iLlxIIZUP99X6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IC9ctY59; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=NEqOnfxZNcmn2LgGL93widqC+Pfk+3b4HnWZx6HPkdc=; b=IC9ctY59MNwsJGB1
	KDkOokDnCYzLkR3h5NpmzxozIj5BKDBTqM96Wer4SeAhbatSczejsYG6i+1vGetPFwa8xjBzF+4Bt
	62L6X2IVb8slnv+G+A/7qHfT4N4tc80LTlX3wUKUL3FFuml8KB7T5hcKyFtM4IqFhAlopufIvKKqo
	q66HvHxhpFlTmjXafP4Lrp/8ZR7HZxxZb5sEcMmBkTMByOPx+kfBHkOwRsrxI1gpU3kjnNrn0jvqK
	4a2BqUUTED9Zci3ymteJ6+qwwoDhwkWZByQcDIVN08SGGbZqrCC5L9iu0zjpUScPgHrAEprAbpr1k
	5FeKwFYf/hI/vUl98w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tromY-0042vt-0p;
	Tue, 11 Mar 2025 01:51:46 +0000
Date: Tue, 11 Mar 2025 01:51:46 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	alexandre.belloni@bootlin.com, danielt@kernel.org,
	jingoohan1@gmail.com, deller@gmx.de, linus.walleij@linaro.org,
	brgl@bgdev.pl, tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Remove pcf50633
Message-ID: <Z8-XMr3fVKpol6c0@gallifrey>
References: <20250309193612.251929-1-linux@treblig.org>
 <Z883nYWpaOF2OZbs@gallifrey>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z883nYWpaOF2OZbs@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:51:14 up 306 days, 13:05,  1 user,  load average: 0.05, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > The pcf50633 was used as part of the OpenMoko devices but
> > the support for its main chip was recently removed in:
> > commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> > 
> > See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> > 
> > Remove it.
> > 
> > I've split this up based on the subcomponents to make the size
> > of each patch sensible.
> > 
> 
> Both Alexandre and Mark would prefer the mfd changes to be
> more separate from the subsystem changes, so I'll cook a v2
> shortly.

v2 thread starting with message
  20250311014959.743322-1-linux@treblig.org
just posted.

Thanks!

Dave

> Dave
> 
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > 
> > Dr. David Alan Gilbert (9):
> >   mfd: pcf50633-adc:  Remove
> >   backlight: pcf50633-backlight: Remove
> >   rtc: pcf50633: Remove
> >   mfd: pcF50633-gpio: Remove
> >   Input: pcf50633-input - Remove
> >   regulator: pcf50633-regulator: Remove
> >   power: supply: pcf50633: Remove charger
> >   mfd: pcf50633: Remove irq code
> >   mfd: pcf50633: Remove remains
> > 
> >  arch/mips/configs/ip27_defconfig             |   3 -
> >  drivers/input/misc/Kconfig                   |   7 -
> >  drivers/input/misc/Makefile                  |   1 -
> >  drivers/input/misc/pcf50633-input.c          | 113 -----
> >  drivers/mfd/Kconfig                          |  24 -
> >  drivers/mfd/Makefile                         |   4 -
> >  drivers/mfd/pcf50633-adc.c                   | 255 ----------
> >  drivers/mfd/pcf50633-core.c                  | 304 ------------
> >  drivers/mfd/pcf50633-gpio.c                  |  92 ----
> >  drivers/mfd/pcf50633-irq.c                   | 312 -------------
> >  drivers/power/supply/Kconfig                 |   6 -
> >  drivers/power/supply/Makefile                |   1 -
> >  drivers/power/supply/pcf50633-charger.c      | 466 -------------------
> >  drivers/regulator/Kconfig                    |   7 -
> >  drivers/regulator/Makefile                   |   1 -
> >  drivers/regulator/pcf50633-regulator.c       | 124 -----
> >  drivers/rtc/Kconfig                          |   7 -
> >  drivers/rtc/Makefile                         |   1 -
> >  drivers/rtc/rtc-pcf50633.c                   | 284 -----------
> >  drivers/video/backlight/Kconfig              |   7 -
> >  drivers/video/backlight/Makefile             |   1 -
> >  drivers/video/backlight/pcf50633-backlight.c | 154 ------
> >  include/linux/mfd/pcf50633/adc.h             |  69 ---
> >  include/linux/mfd/pcf50633/backlight.h       |  42 --
> >  include/linux/mfd/pcf50633/core.h            | 232 ---------
> >  include/linux/mfd/pcf50633/gpio.h            |  48 --
> >  include/linux/mfd/pcf50633/mbc.h             | 130 ------
> >  include/linux/mfd/pcf50633/pmic.h            |  68 ---
> >  28 files changed, 2763 deletions(-)
> >  delete mode 100644 drivers/input/misc/pcf50633-input.c
> >  delete mode 100644 drivers/mfd/pcf50633-adc.c
> >  delete mode 100644 drivers/mfd/pcf50633-core.c
> >  delete mode 100644 drivers/mfd/pcf50633-gpio.c
> >  delete mode 100644 drivers/mfd/pcf50633-irq.c
> >  delete mode 100644 drivers/power/supply/pcf50633-charger.c
> >  delete mode 100644 drivers/regulator/pcf50633-regulator.c
> >  delete mode 100644 drivers/rtc/rtc-pcf50633.c
> >  delete mode 100644 drivers/video/backlight/pcf50633-backlight.c
> >  delete mode 100644 include/linux/mfd/pcf50633/adc.h
> >  delete mode 100644 include/linux/mfd/pcf50633/backlight.h
> >  delete mode 100644 include/linux/mfd/pcf50633/core.h
> >  delete mode 100644 include/linux/mfd/pcf50633/gpio.h
> >  delete mode 100644 include/linux/mfd/pcf50633/mbc.h
> >  delete mode 100644 include/linux/mfd/pcf50633/pmic.h
> > 
> > -- 
> > 2.48.1
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

