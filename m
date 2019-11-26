Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D290B109D8C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 13:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKZMJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 07:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfKZMJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 07:09:42 -0500
Received: from earth.universe (unknown [89.248.140.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40AC2075C;
        Tue, 26 Nov 2019 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574770181;
        bh=/SbrLZpyJJ7X5Bos7DrIFqUfse/MchttoWTj+JKEi1s=;
        h=Date:From:To:Cc:Subject:From;
        b=M+wdGTOaYCCakG/Q8cgES8yggcNRazT9m+u5hBDVCVneZoSU7f7GCX7QrsjFgqq68
         8Wb1Hms7qZu/rjpwRJpl08HZlnQfPDeDYCjebir4WB5r7/AVP0T4/zBbYajJDhj6kM
         zM4k6lURnw8fvMnTeQZ+XuscI46lgKf/UEzhm2ao=
Received: by earth.universe (Postfix, from userid 1000)
        id 043373C0C71; Tue, 26 Nov 2019 13:09:40 +0100 (CET)
Date:   Tue, 26 Nov 2019 13:09:40 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.5
Message-ID: <20191126120940.sjiiqdngnbez2a7x@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ffj6i4c5c3znzmz"
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3ffj6i4c5c3znzmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The pull-request contains immutable branches shared with IIO for the
ab8500 changes and with ARM for the cpcap changes. I don't expect
any issues, since all patches have been in linux-next for roughly 4
weeks.

-- Sebastian

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.5

for you to fetch changes up to 9480029fe5c24d482efad38dc631bd555fc7afe2:

  power: supply: bd70528: Add MODULE_ALIAS to allow module auto loading (2019-10-27 22:33:44 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.5 series

Drivers:
 * test_power: add support for current and charge_counter
 * cpcap-charger: improve charge calculation and limit default charge voltage
 * ab8500: convert to IIO
 * misc. small fixes all over drivers

----------------------------------------------------------------
Ben Dooks (Codethink) (1):
      power: reset: at91: fix __le32 cast in reset code

Claudiu Beznea (1):
      power: reset: at91-poweroff: lookup for proper PMC DT node

Gustavo A. R. Silva (1):
      power: supply: ab8500_charger: Fix inconsistent IS_ERR and PTR_ERR

Icenowy Zheng (1):
      power: supply: axp20x_usb_power: enable USB BC detection on AXP813

Krzysztof Kozlowski (3):
      power: supply: ab8500: Cleanup probe in reverse order
      power: supply: ab8500_fg: Do not free non-requested IRQs in probe's error path
      power: supply: ab8500: Handle invalid IRQ from platform_get_irq_byname()

Linus Walleij (7):
      power: supply: ab8500_btemp: Convert to IIO ADC
      power: supply: ab8500_charger: Convert to IIO ADC
      power: supply: ab8500_fg: Convert to IIO ADC
      hwmon: ab8500: Convert to IIO ADC
      mfd: ab8500: Augment DT bindings
      iio: adc: New driver for the AB8500 GPADC
      mfd: Switch the AB8500 GPADC to IIO

Madhuparna Bhowmik (1):
      power: supply: abx500_chargalg: Fix code indentation

Matti Vaittinen (1):
      power: supply: bd70528: Add MODULE_ALIAS to allow module auto loading

Sebastian Reichel (2):
      Merge remote-tracking branch 'ib-ab8500-5.4-rc1' into for-next
      Merge tag 'psy-cpcap-charge-volt-limit-signed' into psy-next

Tony Lindgren (10):
      power: supply: cpcap-charger: Limit voltage to 4.2V for battery
      power: supply: cpcap-battery: Check voltage before orderly_poweroff
      power: supply: cpcap-charger: Improve battery detection
      power: supply: cpcap-battery: Fix handling of lowered charger voltage
      power: supply: cpcap-charger: Allow changing constant charge voltage
      power: supply: cpcap-battery: Move coulomb counter units per lsb to ddata
      power: supply: cpcap-battery: Simplify coulomb counter calculation with div_s64
      power: supply: cpcap-battery: Simplify short term power average calculation
      power: supply: cpcap-battery: Read and save integrator register CCI
      power: supply: cpcap-battery: Add basic coulomb counter calibrate support

kbuild test robot (1):
      power: supply: cpcap-charger: cpcap_charger_voltage_to_regval() can be static

lecopzer@gmail.com (2):
      test_power: Add CHARGE_COUNTER properties
      test_power: Add CURRENT properties

 Documentation/devicetree/bindings/mfd/ab8500.txt   |  119 ++
 .../bindings/power/supply/cpcap-charger.txt        |    9 +-
 MAINTAINERS                                        |    1 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    6 +-
 drivers/hwmon/Kconfig                              |    3 +-
 drivers/hwmon/ab8500.c                             |   65 +-
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ab8500-gpadc.c                     | 1218 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |    7 -
 drivers/mfd/Makefile                               |    1 -
 drivers/mfd/ab8500-debugfs.c                       |  715 ------------
 drivers/mfd/ab8500-gpadc.c                         | 1075 -----------------
 drivers/power/reset/at91-reset.c                   |    6 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |    8 +-
 drivers/power/supply/Kconfig                       |    2 +-
 drivers/power/supply/ab8500_btemp.c                |   50 +-
 drivers/power/supply/ab8500_charger.c              |   83 +-
 drivers/power/supply/ab8500_fg.c                   |   49 +-
 drivers/power/supply/abx500_chargalg.c             |    8 +-
 drivers/power/supply/axp20x_usb_power.c            |    8 +
 drivers/power/supply/bd70528-charger.c             |    1 +
 drivers/power/supply/cpcap-battery.c               |  271 ++++-
 drivers/power/supply/cpcap-charger.c               |  222 +++-
 drivers/power/supply/test_power.c                  |   61 +
 include/linux/mfd/abx500/ab8500-gpadc.h            |   75 --
 26 files changed, 2044 insertions(+), 2030 deletions(-)
 create mode 100644 drivers/iio/adc/ab8500-gpadc.c
 delete mode 100644 drivers/mfd/ab8500-gpadc.c
 delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h

--3ffj6i4c5c3znzmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3dFgMACgkQ2O7X88g7
+pqbLA//YgSLmh30GUiXxGj0F+UASNSKlkJnpgQnjfG/Jkdi0Ft6nT3n4tHFY4wY
EYzMZ6DDW/DAClOyeXZyNQ73ZITBo5Ff1/aMYPTUbXPXSAn8bb3QyZRp5YnjHMH1
dLqxCKgBv+rfobTbx6NasmOezhOEP9vtMrXK6bHoN9NyLIdbTJ3rZXXvBVgqBkDO
LeOXAKt/NvScRKlAVQ/bae9IihBFD149Qr3RvpE+qwueAITiIGFPkWOsDro5AHu4
amShlPVUz/Vwvb7ot/c8rBkF27XkUDjzOeX/OFUBPzLzp+MeyOpBR0AjBeLQWfgT
eB127zLSGY/INDC98N6prrtJQ96ghCs4XbshdviWK3PlcP/bdACsW7zwD5QcMT18
bQUFkFokeXs1Jpc/6hQGYqrV1idgKLi4CfUHFwxej8oZdhxTtd0CVBcTsnFoGq6N
IgUqf1uS9z2DcG0ig0243gWJRPzUPxfmMMGJ6C5T/mAExPuCx3/aM7rM7gSU7HJc
G8PdRdMY0pPjHoYtulrhuzVDQzgSVV+ArrPAEDDikw6sDAn8wSYqAB7cXum6HGTq
bxZXYlFbziBi6LY0Vu8XTQn73uQdhij7g8GkaUOpOVo9/Kd9Lyno4U/CR2coz7Ch
hrXgmY0nGUVpqe4AP2874uLtL86ThsYDzsdmDbKmuvXu7jYEppk=
=XB6W
-----END PGP SIGNATURE-----

--3ffj6i4c5c3znzmz--
