Return-Path: <linux-pm+bounces-23783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FECA5A394
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9423A9FD0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFA230BF5;
	Mon, 10 Mar 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hybiMAQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9DF1624C0;
	Mon, 10 Mar 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633452; cv=none; b=UohPUh631a5XpJhM3AM3nr7TGnzPMNlOf4UvMEO43sxtoePBSEfFtLrMD5tpdFkNcWx4D9zhCNhHNmxTENzrJUCIRmhY0+GJQcMvsTh5GCy1HJx00GKs0T4zOcoptCX2X/8o3ti2NmZFQyQ/60/55BCJhMh/ZABBIliN1XQuzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633452; c=relaxed/simple;
	bh=RzhTiFdvucIVDCROkX2WzXWGv0bsSTcofGbLyDngjWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL5MQWjvm++N8fSr/YLU+K3wcEsBZAmn1qyJjF8AWynJrENuQmfaDjGRXm/zSUT0hiZFh0xO8h1G1Ap4L6sJrLMSR8z2mJT5LHVnCqHcXx+KFangFSmQfcgPnbXqDUCzP7n0/0RN3LYQ2tliGCQcTfCi5d3MCpni8MlZv6ph18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hybiMAQh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=RWF6GDJzM/hy2cQecsSjoebubSbxEAFf7JYu72sTbbs=; b=hybiMAQheTWRVQOf
	Brb1iHlg5QiLKtB7AknF+HJBfWeQvN4Y5AujGAm0+xJzWS2LC+HbzEtkeszjwPt/Ynqel5ezOniyi
	JVPVfwyTYgXdPbchxvUW1zKY0X2a/DvukCEJ2iQK6Dighh1LsCh527e0SfRZPZAupAEMXI2w8vflT
	MBT1v0HfVG0RsfJimHZkg4o0mmaIuubASyQPW3WrlWeWmYv5/WjwH/kqcJAfxFwQj82D4cLSXnbDV
	+4ploGfQhaa6pX5vxeJ5UD44NSoL24+R6qyjsLcPg84ECs6waUSGbN7sYwvsmXVthQJETEsd8q5vU
	SQ5q2K0mvNIRt7QgTw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1triPt-003ykV-16;
	Mon, 10 Mar 2025 19:03:57 +0000
Date: Mon, 10 Mar 2025 19:03:57 +0000
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
Message-ID: <Z883nYWpaOF2OZbs@gallifrey>
References: <20250309193612.251929-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250309193612.251929-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:02:58 up 306 days,  6:17,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> I've split this up based on the subcomponents to make the size
> of each patch sensible.
> 

Both Alexandre and Mark would prefer the mfd changes to be
more separate from the subsystem changes, so I'll cook a v2
shortly.

Dave

> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 
> Dr. David Alan Gilbert (9):
>   mfd: pcf50633-adc:  Remove
>   backlight: pcf50633-backlight: Remove
>   rtc: pcf50633: Remove
>   mfd: pcF50633-gpio: Remove
>   Input: pcf50633-input - Remove
>   regulator: pcf50633-regulator: Remove
>   power: supply: pcf50633: Remove charger
>   mfd: pcf50633: Remove irq code
>   mfd: pcf50633: Remove remains
> 
>  arch/mips/configs/ip27_defconfig             |   3 -
>  drivers/input/misc/Kconfig                   |   7 -
>  drivers/input/misc/Makefile                  |   1 -
>  drivers/input/misc/pcf50633-input.c          | 113 -----
>  drivers/mfd/Kconfig                          |  24 -
>  drivers/mfd/Makefile                         |   4 -
>  drivers/mfd/pcf50633-adc.c                   | 255 ----------
>  drivers/mfd/pcf50633-core.c                  | 304 ------------
>  drivers/mfd/pcf50633-gpio.c                  |  92 ----
>  drivers/mfd/pcf50633-irq.c                   | 312 -------------
>  drivers/power/supply/Kconfig                 |   6 -
>  drivers/power/supply/Makefile                |   1 -
>  drivers/power/supply/pcf50633-charger.c      | 466 -------------------
>  drivers/regulator/Kconfig                    |   7 -
>  drivers/regulator/Makefile                   |   1 -
>  drivers/regulator/pcf50633-regulator.c       | 124 -----
>  drivers/rtc/Kconfig                          |   7 -
>  drivers/rtc/Makefile                         |   1 -
>  drivers/rtc/rtc-pcf50633.c                   | 284 -----------
>  drivers/video/backlight/Kconfig              |   7 -
>  drivers/video/backlight/Makefile             |   1 -
>  drivers/video/backlight/pcf50633-backlight.c | 154 ------
>  include/linux/mfd/pcf50633/adc.h             |  69 ---
>  include/linux/mfd/pcf50633/backlight.h       |  42 --
>  include/linux/mfd/pcf50633/core.h            | 232 ---------
>  include/linux/mfd/pcf50633/gpio.h            |  48 --
>  include/linux/mfd/pcf50633/mbc.h             | 130 ------
>  include/linux/mfd/pcf50633/pmic.h            |  68 ---
>  28 files changed, 2763 deletions(-)
>  delete mode 100644 drivers/input/misc/pcf50633-input.c
>  delete mode 100644 drivers/mfd/pcf50633-adc.c
>  delete mode 100644 drivers/mfd/pcf50633-core.c
>  delete mode 100644 drivers/mfd/pcf50633-gpio.c
>  delete mode 100644 drivers/mfd/pcf50633-irq.c
>  delete mode 100644 drivers/power/supply/pcf50633-charger.c
>  delete mode 100644 drivers/regulator/pcf50633-regulator.c
>  delete mode 100644 drivers/rtc/rtc-pcf50633.c
>  delete mode 100644 drivers/video/backlight/pcf50633-backlight.c
>  delete mode 100644 include/linux/mfd/pcf50633/adc.h
>  delete mode 100644 include/linux/mfd/pcf50633/backlight.h
>  delete mode 100644 include/linux/mfd/pcf50633/core.h
>  delete mode 100644 include/linux/mfd/pcf50633/gpio.h
>  delete mode 100644 include/linux/mfd/pcf50633/mbc.h
>  delete mode 100644 include/linux/mfd/pcf50633/pmic.h
> 
> -- 
> 2.48.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

