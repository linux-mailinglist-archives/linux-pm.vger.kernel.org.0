Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232538FE9F
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEYKPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:15:09 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42951 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEYKPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:15:06 -0400
Received: by mail-lf1-f47.google.com with SMTP id a2so45194131lfc.9;
        Tue, 25 May 2021 03:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bKfxY6mSloECBEhPINl3+vEHZAIdmfDNQyztmX6YrqA=;
        b=XoyXQFPQPyaib28Fy0xl0TeFElHKa2X+m6JBQSMI8lCUcR8HrZ+pIvBaRDhbgIbkuM
         LC68jeUwYHB7J7hvlGDz8WhX3rfqcRKEOQ5745bYqKSOXVZicRXX+nqZhBk5HAmFQ8Jy
         b/VPm3TTsRJJdS+kEzLHoiIgIRlBZenT0otS1HItwlVicRcy11O1d6M66NrbnbeNNWWi
         iCrYwBul2dI3btIMd8BsZOcDJIcwif7G1lfaUffxK7L6R2XjqoikREV9uYv1h5o+aoJh
         O9sMNMQ6ka+WXEjpa+0ZpIhQoowHYQtEXvEyUHdgj7GBVLwNWnXGusvmhly/H3mU5IFt
         njQg==
X-Gm-Message-State: AOAM5302GvLvtwmaxRYEnxFzIyifz3Njh09+jCdgu99MdF7zwKAEBgDo
        vNZ1v5Kdyv7vwcG9EbvD9EE=
X-Google-Smtp-Source: ABdhPJyd/seBDSLExiEdshhwpoFZVPNcW5lavyyG/mPGb5jIxHr/rfjgXrEarA8o4tc3kjdoUcqFQg==
X-Received: by 2002:ac2:5edb:: with SMTP id d27mr13199748lfq.577.1621937613182;
        Tue, 25 May 2021 03:13:33 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id c9sm2170474lji.18.2021.05.25.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:13:32 -0700 (PDT)
Date:   Tue, 25 May 2021 13:13:25 +0300
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
Subject: [PATCH 0/9] Drop ROHM BD70528 support
Message-ID: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop ROHM BD70528 support

Unfortunately there has not been a big demand for ROHM BD70528
IC. The few users I know control PMIC from separate M4-core,
which is not running Linux. I am not aware of any users of this
Linux driver.

While I did really like this IC and writing the drivers for it,
seems like these drivers are becoming useless burden. So, I see
no point in maintaining them. Let's just drop the drivers if
there is no objections to this series. :(

Few notes:

The GPIO, regulator, power-supply and watchdog drivers should be
only used on BD70528 and depend on the BD70528 MFD Kconfig. I guess
the removal can be independently merged to the respective subsystems.

The BD70528 RTC driver is still used by BD71815 and BD71828 -
but the watchdog-hack can be removed and driver is greatly
simplified. However, it's worth noting that there is dependency
=66rom the BD70528 RTC driver to the header files - thus the
RTC driver changes should be merged before MFD changes. Also the
CLK driver remains in use and needs the BD70528 IC-type.

As a final note - Few improvements/fixes were just applied to the
regulator tree so this series is likely to conflict. Some fixes
were also added to RTC Kconfig - which means also the RTC tree
may have conflicts. Please let me know if you wish me to rebase
this series or those patches.

---

Matti Vaittinen (9):
  dt-bindings: mfd: regulator: Drop BD70528 support
  rtc: bd70528: Drop BD70528 support
  watchdog: bd70528 drop bd70528 support
  regulator: bd70528: Drop BD70528 support
  clk: bd718xx: Drop BD70528 support
  gpio: bd70528 Drop BD70528 support
  power: supply: Drop BD70528 support
  mfd: bd70528: Drop BD70528 support
  MAINTAINERS: bd70528: Drop ROHM BD70528 drivers

 .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ---
 .../regulator/rohm,bd70528-regulator.txt      |  68 --
 MAINTAINERS                                   |   8 -
 drivers/clk/Kconfig                           |   6 +-
 drivers/clk/clk-bd718x7.c                     |  11 +-
 drivers/gpio/Kconfig                          |  11 -
 drivers/gpio/Makefile                         |   1 -
 drivers/gpio/gpio-bd70528.c                   | 230 ------
 drivers/mfd/Kconfig                           |  17 -
 drivers/mfd/Makefile                          |   1 -
 drivers/mfd/rohm-bd70528.c                    | 314 --------
 drivers/power/supply/Kconfig                  |   9 -
 drivers/power/supply/Makefile                 |   1 -
 drivers/power/supply/bd70528-charger.c        | 710 ------------------
 drivers/regulator/Kconfig                     |  11 -
 drivers/regulator/Makefile                    |   1 -
 drivers/regulator/bd70528-regulator.c         | 283 -------
 drivers/rtc/Kconfig                           |   4 +-
 drivers/rtc/rtc-bd70528.c                     | 316 +-------
 drivers/watchdog/Kconfig                      |  12 -
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/bd70528_wdt.c                | 291 -------
 include/linux/mfd/rohm-bd70528.h              | 391 ----------
 include/linux/mfd/rohm-generic.h              |   1 -
 24 files changed, 18 insertions(+), 2782 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic=
=2Etxt
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7052=
8-regulator.txt
 delete mode 100644 drivers/gpio/gpio-bd70528.c
 delete mode 100644 drivers/mfd/rohm-bd70528.c
 delete mode 100644 drivers/power/supply/bd70528-charger.c
 delete mode 100644 drivers/regulator/bd70528-regulator.c
 delete mode 100644 drivers/watchdog/bd70528_wdt.c
 delete mode 100644 include/linux/mfd/rohm-bd70528.h


base-commit: c4681547bcce777daf576925a966ffa824edd09d
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

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCsza8ACgkQeFA3/03a
ocVoGwf+O32fpxiyhvf67obU6gAfgVe/c6gTD1F1YVRt7tE4QU0fnJBZKSu+koIh
TS7j0JMGIqZ2XZqnplgCpiElLge8rHFLn4p/qGY1b8+M8e0yRo6zCx6GecX8pvIt
UlXRv6CWL2S1f/4ajG/wvmjtMLrpEkXHP9o+0QeXABCbvRzJSkXzw5NsPKrV/9ga
Pof3oQVhhPII1B5pngglL+gpLdzgpOuxkL2uAgX+ipuXLULqZxy2mnjsakSj+X6G
qc3kyslrN32OmN68FPL1FjomO4YL6VItDrcx7aaP/4EWICe4q91msdgbu/kI+osC
OgH7n0Gdbhtpax5YULdpd1jVnSG1Iw==
=0spF
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
