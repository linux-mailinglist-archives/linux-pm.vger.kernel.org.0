Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610D38FEC6
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEYKQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:16:53 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43598 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhEYKQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:16:49 -0400
Received: by mail-lj1-f179.google.com with SMTP id w15so37368634ljo.10;
        Tue, 25 May 2021 03:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5iAshdCXnw1BVBaIb1XHybH6geP89RlZe5l7FSpD0uo=;
        b=bi8ktFMdI5xn6tXa7SosuWrw2R4ilnFvvmUwKHWdE8B+UW7LiPtk0MX+KAVI2k1aOJ
         76PxjIBW8PDB8CXa7mcwCw4z95dQOKgTZ+3T85mfADdT86GwPldc8bP1TaOEs1X3l7W1
         ryif9SaBFVFLT4/zoQSghGBdJKr2S7zwPvSHNjNeu+4h3HYB3YH3U6PZQP4jrz8eqTzU
         tl7jFzUE/msIV5VfMBVk1RUrzMZuR4ncf6i+ph3d5EZbvjmQcWi0AY2yDDdfPi7G19p3
         0bCc7slz6a0s24AVFnXNVeV3oq+f0d1cdJi07cgqK53l3umYfnaU60n8sAXgerwU8+4N
         FbLA==
X-Gm-Message-State: AOAM532RbJgN51QIixPdmdnMZIdEyJ7y+xWuz6+15knUns/YXW71fGP0
        NXWcF+LozvFWZ9adgUMUxeg=
X-Google-Smtp-Source: ABdhPJwS6WSw1KqYC3Xgi/hJAAt4DpLD8sNz14ETkiPYiR4uzjBsAAM3YvUxwUfhnlmsxWZI5X7Rbw==
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr20363681ljl.349.1621937717579;
        Tue, 25 May 2021 03:15:17 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id t13sm2037713lji.19.2021.05.25.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:15:17 -0700 (PDT)
Date:   Tue, 25 May 2021 13:15:10 +0300
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
Subject: [PATCH 5/9] clk: bd718xx: Drop BD70528 support
Message-ID: <937ed0828486a08e2d00bce2815d491c1c9c49b4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--opJtzjQTFsWo+cga
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
 drivers/clk/Kconfig       |  6 +++---
 drivers/clk/clk-bd718x7.c | 11 ++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e80918be8e9c..84983cd6029c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -358,10 +358,10 @@ config COMMON_CLK_MMP2_AUDIO
=20
 config COMMON_CLK_BD718XX
 	tristate "Clock driver for 32K clk gates on ROHM PMICs"
-	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD70528 || MFD_ROHM_BD71828
+	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD71828
 	help
-	  This driver supports ROHM BD71837, ROHM BD71847, ROHM BD71828 and
-	  ROHM BD70528 PMICs clock gates.
+	  This driver supports ROHM BD71837, BD71847, BD71850, BD71815
+	  and BD71828 PMICs clock gates.
=20
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index d9e70e506d18..ac40b669d60b 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -15,15 +15,13 @@
 /* clk control registers */
 /* BD71815 */
 #define BD71815_REG_OUT32K	0x1d
-/* BD70528 */
-#define BD70528_REG_OUT32K	0x2c
 /* BD71828 */
 #define BD71828_REG_OUT32K	0x4B
 /* BD71837 and BD71847 */
 #define BD718XX_REG_OUT32K	0x2E
=20
 /*
- * BD71837, BD71847, BD70528 and BD71828 all use bit [0] to clk output con=
trol
+ * BD71837, BD71847, and BD71828 all use bit [0] to clk output control
  */
 #define CLK_OUT_EN_MASK		BIT(0)
=20
@@ -116,10 +114,6 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
 		c->reg =3D BD71828_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
 		break;
-	case ROHM_CHIP_TYPE_BD70528:
-		c->reg =3D BD70528_REG_OUT32K;
-		c->mask =3D CLK_OUT_EN_MASK;
-		break;
 	case ROHM_CHIP_TYPE_BD71815:
 		c->reg =3D BD71815_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
@@ -150,7 +144,6 @@ static int bd71837_clk_probe(struct platform_device *pd=
ev)
 static const struct platform_device_id bd718x7_clk_id[] =3D {
 	{ "bd71837-clk", ROHM_CHIP_TYPE_BD71837 },
 	{ "bd71847-clk", ROHM_CHIP_TYPE_BD71847 },
-	{ "bd70528-clk", ROHM_CHIP_TYPE_BD70528 },
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
 	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
 	{ },
@@ -168,6 +161,6 @@ static struct platform_driver bd71837_clk =3D {
 module_platform_driver(bd71837_clk);
=20
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and BD70528 chip clk driver");
+MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and chip clk driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bd718xx-clk");
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

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszi4ACgkQeFA3/03a
ocXaaQf/ferkRQ1uYD/08eEs5vEYKCKDOUALyDSr72Qt6DuYlGxvUhTrDv1TvIdB
wlBqyeLLIZS7qNgdXMueNFe1AbNI4xgE3z2EQgw+ptsXKLaEYUy/iwqjG4AT9sLN
pVuJzKPbFmHE39RuqSqkmKtOb9VW317KryN7Be2Cbo4V751Z6fg0VArGnFEG/YD6
pJT0d8RulKin8JFgJKpDJjVPfDMktjMctrVcPvBlvXEjyM2cCU6irF4yoFrZoWeE
YhJ3NyQ6WQnVuKe/VyPGak87ghbO7CkC5apS1qs9Zof9owD1eMiFKGZByHuLGjka
dPHlaptm7bkgLYTkb6nFOuhESUXGtw==
=VcDL
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
