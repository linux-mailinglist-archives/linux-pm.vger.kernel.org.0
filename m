Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3BA38FEE5
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhEYKSK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:18:10 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:47025 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhEYKSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:18:05 -0400
Received: by mail-lf1-f53.google.com with SMTP id i9so45238464lfe.13;
        Tue, 25 May 2021 03:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqguKyOEJYDZbYyHiE06qZV0TINsWMdlMUTeTZPqjSY=;
        b=UCvrhVtblB8MQNZz9yOwj9Lh7tEUUmx2Wic7+AzU0epR011kHqD3+JOAV0eycDvJaK
         89Z/FXOvPF8ndlC8VZdOx6QvMpBDkYCaGQFT1WroipDTvya8qn+TDcjFF3G+MapEBpPH
         ySyG7sXAgKwQOdI38vMDul892/S7MEPcBBWln4BUtgarGwmI9pEOsQ0VkPKW0A4+lFFG
         4XB7v9yAVck085Ak19UfS0rHk8ZvAOPnd5x+F9J79uj37cvrhDActl6GfAIUBA+C6YfP
         CbM8hWNmAN/1nhHPb4UbGbdmThZYiodmK9KwQ7HSHaBCGl7EliHrD1E7G4V3TNYsYMUb
         qC/w==
X-Gm-Message-State: AOAM533IoQF07cR1YBMb2JEAI5usoiuLZdJr7x3pH7esD6lAM3kVPzQI
        bhlvvSxQSe/b6w/Cd1E02eY=
X-Google-Smtp-Source: ABdhPJzxq81YUZFLq9qqb8OJczvZO5SPfE0i6y1MPDyPPwllJ4leaaBZCvfaz1+z8Lgq+6tQhFNnIw==
X-Received: by 2002:a05:6512:74d:: with SMTP id c13mr190716lfs.75.1621937792809;
        Tue, 25 May 2021 03:16:32 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id s8sm2046006ljg.89.2021.05.25.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:16:32 -0700 (PDT)
Date:   Tue, 25 May 2021 13:16:24 +0300
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
Subject: [PATCH 9/9] MAINTAINERS: bd70528: Drop ROHM BD70528 drivers
Message-ID: <2c8d1e58d926fdf5117d19a39c66d25deabeeda7.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only known BD70528 use-cases are such that the PMIC is controlled
=66rom separate MCU which is not running Linux. I am not aware of
any Linux driver users. Furthermore, it seems there is no demand for
this IC.

Ease the maintenance burden and drop the driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81e1edeceae4..28d5783214b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15777,27 +15777,19 @@ ROHM POWER MANAGEMENT IC DEVICE DRIVERS
 R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
 L:	linux-power@fi.rohmeurope.com
 S:	Supported
-F:	Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
-F:	Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 F:	drivers/clk/clk-bd718x7.c
-F:	drivers/gpio/gpio-bd70528.c
 F:	drivers/gpio/gpio-bd71815.c
 F:	drivers/gpio/gpio-bd71828.c
-F:	drivers/mfd/rohm-bd70528.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
-F:	drivers/power/supply/bd70528-charger.c
-F:	drivers/regulator/bd70528-regulator.c
 F:	drivers/regulator/bd71815-regulator.c
 F:	drivers/regulator/bd71828-regulator.c
 F:	drivers/regulator/bd718x7-regulator.c
 F:	drivers/regulator/bd9576-regulator.c
 F:	drivers/regulator/rohm-regulator.c
 F:	drivers/rtc/rtc-bd70528.c
-F:	drivers/watchdog/bd70528_wdt.c
 F:	drivers/watchdog/bd9576_wdt.c
-F:	include/linux/mfd/rohm-bd70528.h
 F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
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

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszngACgkQeFA3/03a
ocUTqwf/QGN6qke6qCXJ1v1H+RF7F+S0JkfjXAtCj2oV8iG8ycpcrylANUMCsd9D
g281tfP4irI/nKa3xXqwck53gnnkjMN8AKa35D/T09O10j8vLkWHU3UsIzp5rIUw
eoAiAqhb91fQvk2GFZcruMEkR86NfE1oYLG/zQ5p30lbvrDJBQL25bmh/M+fbdX4
One8cPOcFQglnZpFhWqYZs6II3zHLkS8UjfsvCiwTQSnPCezSzNb8+ZyjJoUjvmv
ron2meVxtqdOtLWQWu0Cp3xzOfm5jvSPs0BH1C02MkCfuW5BCUpe+jnpUmjTE3DY
uDeMMoOJXesGJ9T53g37tMDuLk/HlQ==
=UUiw
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
