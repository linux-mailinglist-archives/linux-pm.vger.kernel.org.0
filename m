Return-Path: <linux-pm+bounces-23804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F0A5B600
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 02:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBEA1892838
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C71E0DEB;
	Tue, 11 Mar 2025 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dovkdPDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DB17BD3;
	Tue, 11 Mar 2025 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657815; cv=none; b=F00qGRbqgtOq4S/3ftHojIhc+DpBJQAbS7pSxZlWsyZTVG3rySel16LhhhgNYqM8Fqac9kclFVHv4IcNDX9Nk9WRuArR5/wFHPBckSQ+uauv+J2OtwDGwy0p2tmQNbX1YfthgCmLpXBcumnqpzkI9FLrSf8jGLcnc6AdPsi1DDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657815; c=relaxed/simple;
	bh=Qt3iMTJDzWJ71sWLMYejSXqVZvIiblbQaVTkfqcmWZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cx+NbRnabAJk6/AP9Q18854I+5S7DivSFiHNsFgyzMBtFWXexY6bNOclIdBmyaNeN6XImQFCldL/F3VLnbST7IunRK8pGseRsoUN//Dm7PyNPluQg3ZDjtFCobCrQKs3DkGbRLAQZrL/0icniEBNsJ19RMUgmfK4XwT4h+5kGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dovkdPDU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jXYs1u+pjL0qr1vHTKm0DQerWnFqgvy1EC6wUyQXJiA=; b=dovkdPDUdcFfcNgj
	HMFaZotBxaTqsUneRHr978c+UFzi4ix5UUa6CM3TCDbuH81bY1G+jrGZGcGFb0fQcNKeI5AjrC/xF
	nM5dPVofxgGcOJ3mqPJZUpsnff+teQLatal19+d8k2sbNJP8IVkDMjmlYqoACZ0V6ciTk2XADymeC
	yKaUY0/KkpmDUiDFFcktY4e5952URL5LxT7H5vGPpHTc/89Mo7GnCGULaBGsorMIf3gEt22OyOQJZ
	8qMA61y5zV5alFGPG1aPkReIJyGQ4MlfjeK+l4uxq3tSHtFLlk9f8yg5i/KK7xBBX+cNSlT3lwzwv
	CMA9/hZxhUQ1SIlu6A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1trokq-0042n5-1X;
	Tue, 11 Mar 2025 01:50:00 +0000
From: linux@treblig.org
To: arnd@arndb.de,
	lee@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 0/9] Remove pcf50633
Date: Tue, 11 Mar 2025 01:49:50 +0000
Message-ID: <20250311014959.743322-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The pcf50633 was used as part of the OpenMoko devices but
the support for its main chip was recently removed in:
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")

See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/

Remove it.

I've split this up based on the subcomponents to make the size
of each patch sensible.

v2
  Moved most of the mfd updates out of the subsystem patches.
  Swung the backlight nearer the end, since we can't avoid fixing
  up the core.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dr. David Alan Gilbert (9):
  mfd: pcf50633-adc:  Remove
  rtc: pcf50633: Remove
  mfd: pcF50633-gpio: Remove
  Input: pcf50633-input - Remove
  regulator: pcf50633-regulator: Remove
  power: supply: pcf50633: Remove charger
  backlight: pcf50633-backlight: Remove
  mfd: pcf50633: Remove irq code
  mfd: pcf50633: Remove remains

 arch/mips/configs/ip27_defconfig             |   3 -
 drivers/input/misc/Kconfig                   |   7 -
 drivers/input/misc/Makefile                  |   1 -
 drivers/input/misc/pcf50633-input.c          | 113 -----
 drivers/mfd/Kconfig                          |  24 -
 drivers/mfd/Makefile                         |   4 -
 drivers/mfd/pcf50633-adc.c                   | 255 ----------
 drivers/mfd/pcf50633-core.c                  | 304 ------------
 drivers/mfd/pcf50633-gpio.c                  |  92 ----
 drivers/mfd/pcf50633-irq.c                   | 312 -------------
 drivers/power/supply/Kconfig                 |   6 -
 drivers/power/supply/Makefile                |   1 -
 drivers/power/supply/pcf50633-charger.c      | 466 -------------------
 drivers/regulator/Kconfig                    |   7 -
 drivers/regulator/Makefile                   |   1 -
 drivers/regulator/pcf50633-regulator.c       | 124 -----
 drivers/rtc/Kconfig                          |   7 -
 drivers/rtc/Makefile                         |   1 -
 drivers/rtc/rtc-pcf50633.c                   | 284 -----------
 drivers/video/backlight/Kconfig              |   7 -
 drivers/video/backlight/Makefile             |   1 -
 drivers/video/backlight/pcf50633-backlight.c | 154 ------
 include/linux/mfd/pcf50633/adc.h             |  69 ---
 include/linux/mfd/pcf50633/backlight.h       |  42 --
 include/linux/mfd/pcf50633/core.h            | 232 ---------
 include/linux/mfd/pcf50633/gpio.h            |  48 --
 include/linux/mfd/pcf50633/mbc.h             | 130 ------
 include/linux/mfd/pcf50633/pmic.h            |  68 ---
 28 files changed, 2763 deletions(-)
 delete mode 100644 drivers/input/misc/pcf50633-input.c
 delete mode 100644 drivers/mfd/pcf50633-adc.c
 delete mode 100644 drivers/mfd/pcf50633-core.c
 delete mode 100644 drivers/mfd/pcf50633-gpio.c
 delete mode 100644 drivers/mfd/pcf50633-irq.c
 delete mode 100644 drivers/power/supply/pcf50633-charger.c
 delete mode 100644 drivers/regulator/pcf50633-regulator.c
 delete mode 100644 drivers/rtc/rtc-pcf50633.c
 delete mode 100644 drivers/video/backlight/pcf50633-backlight.c
 delete mode 100644 include/linux/mfd/pcf50633/adc.h
 delete mode 100644 include/linux/mfd/pcf50633/backlight.h
 delete mode 100644 include/linux/mfd/pcf50633/core.h
 delete mode 100644 include/linux/mfd/pcf50633/gpio.h
 delete mode 100644 include/linux/mfd/pcf50633/mbc.h
 delete mode 100644 include/linux/mfd/pcf50633/pmic.h

-- 
2.48.1


