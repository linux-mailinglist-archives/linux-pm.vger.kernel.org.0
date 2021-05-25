Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798F438FEA6
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEYKP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:15:27 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37825 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhEYKP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:15:27 -0400
Received: by mail-lj1-f174.google.com with SMTP id e2so31042209ljk.4;
        Tue, 25 May 2021 03:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5d6klbAXAHHpipDjNbY52bLQTN2Lh8bVHSkeMx8zUE=;
        b=TiIheOoJXFEimDoqkk/zexzTqWCtNUoCQnGxXAGjQvoF91VcFnJY+EzHp3M9iNurUZ
         93HsybGvVKsBW+845X8Hlc0lYmTdWQYQ1WzO0VVWRGRcNPp2CDgVHIxJqei6qIJFHnWA
         d7nDtX/xRIVxga/YNRYtUkOvPCOSL86jA1Cnkg1dkrD46GLawwUDmmcWaNvUR+7Wb0MH
         KJM1z+QFs3OwTD+5nbW0rk3RB8p5OoEWKYu2vKx3ZQG8vXchdWQkeqYE/N9fddTBHpJv
         PNtjZfRvrcDJEcGkRG95pkpyXBxZVQbY6abfoTNZMe8F1u9q5t3bF62Cm7CZCoXaSmRy
         iSuw==
X-Gm-Message-State: AOAM531AKZ3I2V1iGjDQQXGTviPxpi6U2y5xaxbiTEkMq3H8zGQeE5bq
        XWX79k1ytK2qno3iQpldFAg=
X-Google-Smtp-Source: ABdhPJyQB1YqiGf4i0eIIdejKwMth3V9NepMex/3BfQ2cMeErbn8NWvxO0QOjDtjYniS+JugynP4Sg==
X-Received: by 2002:a2e:8942:: with SMTP id b2mr19667077ljk.488.1621937635314;
        Tue, 25 May 2021 03:13:55 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id t13sm2037343lji.19.2021.05.25.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:13:54 -0700 (PDT)
Date:   Tue, 25 May 2021 13:13:47 +0300
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
Subject: [PATCH 1/9] dt-bindings: mfd: regulator: Drop BD70528 support
Message-ID: <edc5169b10a6eaac6f587c002a6014100717fc01.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
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
Bah. My heart is bleeding as I personally liked playing with this IC.
Still, It makes no sense to waste the time of you guys by maintaining
something which is not likely to be used. Please let me know if some
of you think the binding is needed.
---
 .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ------------------
 .../regulator/rohm,bd70528-regulator.txt      |  68 ------------
 2 files changed, 170 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic=
=2Etxt
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7052=
8-regulator.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/=
Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
deleted file mode 100644
index 386eec06cf08..000000000000
--- a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-* ROHM BD70528 Power Management Integrated Circuit bindings
-
-BD70528MWV is an ultra-low quiescent current general purpose, single-chip,
-power management IC for battery-powered portable devices. The IC
-integrates 3 ultra-low current consumption buck converters, 3 LDOs and 2
-LED Drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
-clock gate, high-accuracy VREF for use with an external ADC, flexible
-dual-input power path, 10 bit SAR ADC for battery temperature monitor and
-1S battery charger with scalable charge currents.
-
-Required properties:
- - compatible		: Should be "rohm,bd70528"
- - reg			: I2C slave address.
- - interrupts		: The interrupt line the device is connected to.
- - interrupt-controller	: To indicate BD70528 acts as an interrupt control=
ler.
- - #interrupt-cells	: Should be 2. Usage is compliant to the 2 cells
-			  variant of ../interrupt-controller/interrupts.txt
- - gpio-controller	: To indicate BD70528 acts as a GPIO controller.
- - #gpio-cells		: Should be 2. The first cell is the pin number and
-			  the second cell is used to specify flags. See
-			  ../gpio/gpio.txt for more information.
- - #clock-cells		: Should be 0.
- - regulators:		: List of child nodes that specify the regulators.
-			  Please see ../regulator/rohm,bd70528-regulator.txt
-
-Optional properties:
- - clock-output-names	: Should contain name for output clock.
-
-Example:
-/* External oscillator */
-osc: oscillator {
-	compatible =3D "fixed-clock";
-	#clock-cells =3D <1>;
-	clock-frequency  =3D <32768>;
-	clock-output-names =3D "osc";
-};
-
-pmic: pmic@4b {
-	compatible =3D "rohm,bd70528";
-	reg =3D <0x4b>;
-	interrupt-parent =3D <&gpio1>;
-	interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
-	clocks =3D <&osc 0>;
-	#clock-cells =3D <0>;
-	clock-output-names =3D "bd70528-32k-out";
-	#gpio-cells =3D <2>;
-	gpio-controller;
-	interrupt-controller;
-	#interrupt-cells =3D <2>;
-
-	regulators {
-		buck1: BUCK1 {
-			regulator-name =3D "buck1";
-			regulator-min-microvolt =3D <1200000>;
-			regulator-max-microvolt =3D <3400000>;
-			regulator-boot-on;
-			regulator-ramp-delay =3D <125>;
-		};
-		buck2: BUCK2 {
-			regulator-name =3D "buck2";
-			regulator-min-microvolt =3D <1200000>;
-			regulator-max-microvolt =3D <3300000>;
-			regulator-boot-on;
-			regulator-ramp-delay =3D <125>;
-		};
-		buck3: BUCK3 {
-			regulator-name =3D "buck3";
-			regulator-min-microvolt =3D <800000>;
-			regulator-max-microvolt =3D <1800000>;
-			regulator-boot-on;
-			regulator-ramp-delay =3D <250>;
-		};
-		ldo1: LDO1 {
-			regulator-name =3D "ldo1";
-			regulator-min-microvolt =3D <1650000>;
-			regulator-max-microvolt =3D <3300000>;
-			regulator-boot-on;
-		};
-		ldo2: LDO2 {
-			regulator-name =3D "ldo2";
-			regulator-min-microvolt =3D <1650000>;
-			regulator-max-microvolt =3D <3300000>;
-			regulator-boot-on;
-		};
-
-		ldo3: LDO3 {
-			regulator-name =3D "ldo3";
-			regulator-min-microvolt =3D <1650000>;
-			regulator-max-microvolt =3D <3300000>;
-		};
-		led_ldo1: LED_LDO1 {
-			regulator-name =3D "led_ldo1";
-			regulator-min-microvolt =3D <200000>;
-			regulator-max-microvolt =3D <300000>;
-		};
-		led_ldo2: LED_LDO2 {
-			regulator-name =3D "led_ldo2";
-			regulator-min-microvolt =3D <200000>;
-			regulator-max-microvolt =3D <300000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd70528-regul=
ator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulat=
or.txt
deleted file mode 100644
index 698cfc3bc3dd..000000000000
--- a/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-ROHM BD70528 Power Management Integrated Circuit regulator bindings
-
-Required properties:
- - regulator-name: should be "buck1", "buck2", "buck3", "ldo1", "ldo2", "l=
do3",
-		   "led_ldo1", "led_ldo2"
-
-List of regulators provided by this controller. BD70528 regulators node
-should be sub node of the BD70528 MFD node. See BD70528 MFD bindings at
-Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
-
-The valid names for BD70528 regulator nodes are:
-BUCK1, BUCK2, BUCK3, LDO1, LDO2, LDO3, LED_LDO1, LED_LDO2
-
-Optional properties:
-- Any optional property defined in bindings/regulator/regulator.txt
-
-Example:
-regulators {
-	buck1: BUCK1 {
-		regulator-name =3D "buck1";
-		regulator-min-microvolt =3D <1200000>;
-		regulator-max-microvolt =3D <3400000>;
-		regulator-boot-on;
-		regulator-ramp-delay =3D <125>;
-	};
-	buck2: BUCK2 {
-		regulator-name =3D "buck2";
-		regulator-min-microvolt =3D <1200000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-boot-on;
-		regulator-ramp-delay =3D <125>;
-	};
-	buck3: BUCK3 {
-		regulator-name =3D "buck3";
-		regulator-min-microvolt =3D <800000>;
-		regulator-max-microvolt =3D <1800000>;
-		regulator-boot-on;
-		regulator-ramp-delay =3D <250>;
-	};
-	ldo1: LDO1 {
-		regulator-name =3D "ldo1";
-		regulator-min-microvolt =3D <1650000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-boot-on;
-	};
-	ldo2: LDO2 {
-		regulator-name =3D "ldo2";
-		regulator-min-microvolt =3D <1650000>;
-		regulator-max-microvolt =3D <3300000>;
-		regulator-boot-on;
-	};
-
-	ldo3: LDO3 {
-		regulator-name =3D "ldo3";
-		regulator-min-microvolt =3D <1650000>;
-		regulator-max-microvolt =3D <3300000>;
-	};
-	led_ldo1: LED_LDO1 {
-		regulator-name =3D "led_ldo1";
-		regulator-min-microvolt =3D <200000>;
-		regulator-max-microvolt =3D <300000>;
-	};
-	led_ldo2: LED_LDO2 {
-		regulator-name =3D "led_ldo2";
-		regulator-min-microvolt =3D <200000>;
-		regulator-max-microvolt =3D <300000>;
-	};
-};
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

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszdsACgkQeFA3/03a
ocUmvggAruNUedCyu8obc+Nmdw50TWyqZt1oLvohXqB+frc21yWRcXkAJVS6YDW5
4U4AOXMCxRplwQ4AGYz4ns+RMxHR0MlOH8vwfEzlyJXVOm1Vu+6fO7pw5vuwW1fn
hW7EfCNtA5HDj0T4F2q9GGeFbTJVCUMWJzCWtzreDl5GUpTYIc6FSU+4kDVXTqIY
dmuRbMkF1veHflFuXp2xw7Mah86UozNZAquklySeK4yyWz7z14n/lbNlh7/0vA2J
1/Hy4cLEkAVqGa5WLW/Ku6ALqrCyHXE082G9s+kArMRfAfRIPN14RKk9Tao65lPg
O9FESv1a1vQG6txRUacguhsgGH80IA==
=17ZX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
