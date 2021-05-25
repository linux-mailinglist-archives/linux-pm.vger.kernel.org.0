Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791038FEB7
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEYKQO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:16:14 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37431 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhEYKQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:16:11 -0400
Received: by mail-lj1-f177.google.com with SMTP id e2so31044725ljk.4;
        Tue, 25 May 2021 03:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pvp1EMD3cM23xbQomRI++cJ+h3aHyG7yPxE9BDdxJsY=;
        b=Fp3RgKe+7TzDT5kZaApI6rYDr1O8aSfMCv43MncTNuLWd/FKFFZx103oQnY31VVLdc
         7SBeruR1AIqXcgRJ0eqd0D7ae/6LQlqIUG1qcs8kPgjDtzTrEswuZ9tqprVhqSnfmmwU
         +1SvkcLXIsOFVWJFnu13Z0Qi4ZtFyMyE1VNEi9B1iX+ZjGVPN/m0L27NOV3F+AgoH1HO
         1IQO0K1HFw6uraRj1VEP3TDKpKROQilQmUZN2gDAIH9/JdQygNv4MHlHUczWcxvfkSB2
         BfBf5rg2IxmbUqrvQPD78VIVs58VBN8nAgbTE6gljiexHSLUyagCgTjzBsvLD5UFXc4c
         xLhA==
X-Gm-Message-State: AOAM533tem9sozn6fLAeqFKoFh5GGmslOc4QsUkmFntII3+rHu7H3emg
        cAq5kSH/nnx2TB1lq2QRtOA=
X-Google-Smtp-Source: ABdhPJyZtB1U9VstuKQw189kN6xAez8rRLU49AAmOIgZ8AAiwefOUs5Uwyv1kiWj9MUdcu+IrolEWA==
X-Received: by 2002:a2e:a58d:: with SMTP id m13mr20087921ljp.252.1621937678916;
        Tue, 25 May 2021 03:14:38 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id z13sm2036939lji.115.2021.05.25.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:14:38 -0700 (PDT)
Date:   Tue, 25 May 2021 13:14:31 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 3/9] watchdog: bd70528 drop bd70528 support
Message-ID: <994d2e374262c3f59f4465c03ef23d3116120778.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only known BD70528 use-cases are such that the PMIC is controlled
=66rom separate MCU which is not running Linux. I am not aware of
any Linux driver users. Furthermore, it seems there is no demand for
this IC. Let's ease the maintenance burden and drop the driver. We can
always add it back if there is sudden need for it.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Please let me know if some of you think the driver is needed.
---
 drivers/watchdog/Kconfig       |  12 --
 drivers/watchdog/Makefile      |   1 -
 drivers/watchdog/bd70528_wdt.c | 291 ---------------------------------
 3 files changed, 304 deletions(-)
 delete mode 100644 drivers/watchdog/bd70528_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 355100dad60a..26824ac6c5bc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -160,18 +160,6 @@ config SOFT_WATCHDOG_PRETIMEOUT
 	  watchdog. Be aware that governors might affect the watchdog because it
 	  is purely software, e.g. the panic governor will stall it!
=20
-config BD70528_WATCHDOG
-	tristate "ROHM BD70528 PMIC Watchdog"
-	depends on MFD_ROHM_BD70528
-	select WATCHDOG_CORE
-	help
-	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
-	  cause system reset.
-
-	  Say Y here to include support for the ROHM BD70528 watchdog.
-	  Alternatively say M to compile the driver as a module,
-	  which will be called bd70528_wdt.
-
 config BD957XMUF_WATCHDOG
 	tristate "ROHM BD9576MUF and BD9573MUF PMIC Watchdog"
 	depends on MFD_ROHM_BD957XMUF
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index a7eade8b4d45..1838df3ed650 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -203,7 +203,6 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+=3D sun4v_wdt.o
 obj-$(CONFIG_XEN_WDT) +=3D xen_wdt.o
=20
 # Architecture Independent
-obj-$(CONFIG_BD70528_WATCHDOG) +=3D bd70528_wdt.o
 obj-$(CONFIG_BD957XMUF_WATCHDOG) +=3D bd9576_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) +=3D da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) +=3D da9055_wdt.o
diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
deleted file mode 100644
index 0170b37e6674..000000000000
--- a/drivers/watchdog/bd70528_wdt.c
+++ /dev/null
@@ -1,291 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 ROHM Semiconductors
-// ROHM BD70528MWV watchdog driver
-
-#include <linux/bcd.h>
-#include <linux/kernel.h>
-#include <linux/mfd/rohm-bd70528.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/watchdog.h>
-
-/*
- * Max time we can set is 1 hour, 59 minutes and 59 seconds
- * and Minimum time is 1 second
- */
-#define WDT_MAX_MS	((2 * 60 * 60 - 1) * 1000)
-#define WDT_MIN_MS	1000
-#define DEFAULT_TIMEOUT	60
-
-#define WD_CTRL_MAGIC1 0x55
-#define WD_CTRL_MAGIC2 0xAA
-
-struct wdtbd70528 {
-	struct device *dev;
-	struct regmap *regmap;
-	struct rohm_regmap_dev *mfd;
-	struct watchdog_device wdt;
-};
-
-/**
- * bd70528_wdt_set - arm or disarm watchdog timer
- *
- * @data:	device data for the PMIC instance we want to operate on
- * @enable:	new state of WDT. zero to disable, non zero to enable
- * @old_state:	previous state of WDT will be filled here
- *
- * Arm or disarm WDT on BD70528 PMIC. Expected to be called only by
- * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock must be taken
- * by calling bd70528_wdt_lock before calling bd70528_wdt_set.
- */
-int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_sta=
te)
-{
-	int ret, i;
-	unsigned int tmp;
-	struct bd70528_data *bd70528 =3D container_of(data, struct bd70528_data,
-						 chip);
-	u8 wd_ctrl_arr[3] =3D { WD_CTRL_MAGIC1, WD_CTRL_MAGIC2, 0 };
-	u8 *wd_ctrl =3D &wd_ctrl_arr[2];
-
-	ret =3D regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
-	if (ret)
-		return ret;
-
-	*wd_ctrl =3D (u8)tmp;
-
-	if (old_state) {
-		if (*wd_ctrl & BD70528_MASK_WDT_EN)
-			*old_state |=3D BD70528_WDT_STATE_BIT;
-		else
-			*old_state &=3D ~BD70528_WDT_STATE_BIT;
-		if ((!enable) =3D=3D (!(*old_state & BD70528_WDT_STATE_BIT)))
-			return 0;
-	}
-
-	if (enable) {
-		if (*wd_ctrl & BD70528_MASK_WDT_EN)
-			return 0;
-		*wd_ctrl |=3D BD70528_MASK_WDT_EN;
-	} else {
-		if (*wd_ctrl & BD70528_MASK_WDT_EN)
-			*wd_ctrl &=3D ~BD70528_MASK_WDT_EN;
-		else
-			return 0;
-	}
-
-	for (i =3D 0; i < 3; i++) {
-		ret =3D regmap_write(bd70528->chip.regmap, BD70528_REG_WDT_CTRL,
-				   wd_ctrl_arr[i]);
-		if (ret)
-			return ret;
-	}
-
-	ret =3D regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
-	if ((tmp & BD70528_MASK_WDT_EN) !=3D (*wd_ctrl & BD70528_MASK_WDT_EN)) {
-		dev_err(bd70528->chip.dev,
-			"Watchdog ctrl mismatch (hw) 0x%x (set) 0x%x\n",
-			tmp, *wd_ctrl);
-		ret =3D -EIO;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(bd70528_wdt_set);
-
-/**
- * bd70528_wdt_lock - take WDT lock
- *
- * @data:	device data for the PMIC instance we want to operate on
- *
- * Lock WDT for arming/disarming in order to avoid race condition caused
- * by WDT state changes initiated by WDT and RTC drivers.
- */
-void bd70528_wdt_lock(struct rohm_regmap_dev *data)
-{
-	struct bd70528_data *bd70528 =3D container_of(data, struct bd70528_data,
-						 chip);
-
-	mutex_lock(&bd70528->rtc_timer_lock);
-}
-EXPORT_SYMBOL(bd70528_wdt_lock);
-
-/**
- * bd70528_wdt_unlock - unlock WDT lock
- *
- * @data:	device data for the PMIC instance we want to operate on
- *
- * Unlock WDT lock which has previously been taken by call to
- * bd70528_wdt_lock.
- */
-void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
-{
-	struct bd70528_data *bd70528 =3D container_of(data, struct bd70528_data,
-						 chip);
-
-	mutex_unlock(&bd70528->rtc_timer_lock);
-}
-EXPORT_SYMBOL(bd70528_wdt_unlock);
-
-static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
-{
-	return bd70528_wdt_set(w->mfd, enable, NULL);
-}
-
-static int bd70528_wdt_change(struct wdtbd70528 *w, int enable)
-{
-	int ret;
-
-	bd70528_wdt_lock(w->mfd);
-	ret =3D bd70528_wdt_set_locked(w, enable);
-	bd70528_wdt_unlock(w->mfd);
-
-	return ret;
-}
-
-static int bd70528_wdt_start(struct watchdog_device *wdt)
-{
-	struct wdtbd70528 *w =3D watchdog_get_drvdata(wdt);
-
-	dev_dbg(w->dev, "WDT ping...\n");
-	return bd70528_wdt_change(w, 1);
-}
-
-static int bd70528_wdt_stop(struct watchdog_device *wdt)
-{
-	struct wdtbd70528 *w =3D watchdog_get_drvdata(wdt);
-
-	dev_dbg(w->dev, "WDT stopping...\n");
-	return bd70528_wdt_change(w, 0);
-}
-
-static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
-				   unsigned int timeout)
-{
-	unsigned int hours;
-	unsigned int minutes;
-	unsigned int seconds;
-	int ret;
-	struct wdtbd70528 *w =3D watchdog_get_drvdata(wdt);
-
-	seconds =3D timeout;
-	hours =3D timeout / (60 * 60);
-	/* Maximum timeout is 1h 59m 59s =3D> hours is 1 or 0 */
-	if (hours)
-		seconds -=3D (60 * 60);
-	minutes =3D seconds / 60;
-	seconds =3D seconds % 60;
-
-	bd70528_wdt_lock(w->mfd);
-
-	ret =3D bd70528_wdt_set_locked(w, 0);
-	if (ret)
-		goto out_unlock;
-
-	ret =3D regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
-				 BD70528_MASK_WDT_HOUR, hours);
-	if (ret) {
-		dev_err(w->dev, "Failed to set WDT hours\n");
-		goto out_en_unlock;
-	}
-	ret =3D regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
-				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
-	if (ret) {
-		dev_err(w->dev, "Failed to set WDT minutes\n");
-		goto out_en_unlock;
-	}
-	ret =3D regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
-				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
-	if (ret)
-		dev_err(w->dev, "Failed to set WDT seconds\n");
-	else
-		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
-
-out_en_unlock:
-	ret =3D bd70528_wdt_set_locked(w, 1);
-out_unlock:
-	bd70528_wdt_unlock(w->mfd);
-
-	return ret;
-}
-
-static const struct watchdog_info bd70528_wdt_info =3D {
-	.identity =3D "bd70528-wdt",
-	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-};
-
-static const struct watchdog_ops bd70528_wdt_ops =3D {
-	.start		=3D bd70528_wdt_start,
-	.stop		=3D bd70528_wdt_stop,
-	.set_timeout	=3D bd70528_wdt_set_timeout,
-};
-
-static int bd70528_wdt_probe(struct platform_device *pdev)
-{
-	struct rohm_regmap_dev *bd70528;
-	struct wdtbd70528 *w;
-	int ret;
-	unsigned int reg;
-
-	bd70528 =3D dev_get_drvdata(pdev->dev.parent);
-	if (!bd70528) {
-		dev_err(&pdev->dev, "No MFD driver data\n");
-		return -EINVAL;
-	}
-	w =3D devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
-	if (!w)
-		return -ENOMEM;
-
-	w->regmap =3D bd70528->regmap;
-	w->mfd =3D bd70528;
-	w->dev =3D &pdev->dev;
-
-	w->wdt.info =3D &bd70528_wdt_info;
-	w->wdt.ops =3D  &bd70528_wdt_ops;
-	w->wdt.min_hw_heartbeat_ms =3D WDT_MIN_MS;
-	w->wdt.max_hw_heartbeat_ms =3D WDT_MAX_MS;
-	w->wdt.parent =3D pdev->dev.parent;
-	w->wdt.timeout =3D DEFAULT_TIMEOUT;
-	watchdog_set_drvdata(&w->wdt, w);
-	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
-
-	ret =3D bd70528_wdt_set_timeout(&w->wdt, w->wdt.timeout);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
-		return ret;
-	}
-
-	bd70528_wdt_lock(w->mfd);
-	ret =3D regmap_read(w->regmap, BD70528_REG_WDT_CTRL, &reg);
-	bd70528_wdt_unlock(w->mfd);
-
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
-		return ret;
-	}
-	if (reg & BD70528_MASK_WDT_EN) {
-		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
-		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
-	}
-
-	ret =3D devm_watchdog_register_device(&pdev->dev, &w->wdt);
-	if (ret < 0)
-		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
-
-	return ret;
-}
-
-static struct platform_driver bd70528_wdt =3D {
-	.driver =3D {
-		.name =3D "bd70528-wdt"
-	},
-	.probe =3D bd70528_wdt_probe,
-};
-
-module_platform_driver(bd70528_wdt);
-
-MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD70528 watchdog driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bd70528-wdt");
--=20
2.25.4


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszgcACgkQeFA3/03a
ocUDlwgAxT279/4gGh+1Yb+Js2iek1PUafUN1mlIVFqSKkj9eV35bVfhAL3aikej
MzEkdSZaMnviDH+iC9trDTfKauS9fzA5AotUHIFNm7/6AynEInCYcdCLND/8TUVz
2PkBuNiuZRzg5OtshqVr6e0DrEcAJ+cbqSZS92ZbsC2v8Is8Wh8m6USb+vIvSZWJ
Q1+3o8/0AvjWOwuOW4RobJ3mFoSZ0rwsK8vYwt/X8tJs28zp22ObiTwx31vxGUId
t1QUFlpNIROkxzcFmxFjdcaEkQNM+ThIRtvXQGf4QUY6igRQKG0pXVggN6t17WLh
EovrqunrEyNT97vm7R2nBzHEOwaEsQ==
=FJDH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
