Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51019EC7E
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDEQMN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 12:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgDEQMN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Apr 2020 12:12:13 -0400
Received: from earth.universe (dyndsl-091-096-057-090.ewe-ip-backbone.de [91.96.57.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51AD20644;
        Sun,  5 Apr 2020 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586103132;
        bh=mtSXkX7OOB0aOyV/m8pkSsqMvTiDnQoPwSOoeeK5Mfc=;
        h=Date:From:To:Cc:Subject:From;
        b=L6zOIPHYUyQ/9PgesvbXhZHxdpUbq4P1l5H2lpLEXJtNUsbKpsXdLNm0777e5w27o
         QesDW5OeRd79E9VPsXsxfPNWdQhwYf5vg18LOWF+TIP6IinMd1RUXuTaK0+RrS5hSt
         V3nVduI0LJex0oDz7H/SMNq8bQtp2Stp4BWs/Am0=
Received: by earth.universe (Postfix, from userid 1000)
        id 4D68A3C082A; Sun,  5 Apr 2020 18:12:09 +0200 (CEST)
Date:   Sun, 5 Apr 2020 18:12:09 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.7
Message-ID: <20200405161209.4e3z23eyvp2wsrus@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iuo7vvzt7573duva"
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iuo7vvzt7573duva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A bit less than normal due to a hardware fault on my side. Getting
spare parts took more time than normal due to Covid-19. Other than
that Stephen found a merge conflict in linux-next between the (already
merged) tip tree and power-supply and provided correct solution:

s/cpu_down/remove_cpu

You can find the thread about that here:

https://lore.kernel.org/linux-next/20200326135258.2764f0de@canb.auug.org.au/

Thanks,

-- Sebastian

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.7

for you to fetch changes up to f78c55e3b4806974f7d590b2aab8683232b7bd25:

  power: reset: sc27xx: Allow the SC27XX poweroff driver building into a module (2020-03-11 23:32:09 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.7 series

Core:
 * Nothing

Drivers:
 * at91-reset: cleanups, proper handling for sam9x60
 * sc27xx, charger-manager: allow building as module
 * sc27xx: add support to read current charge capacity
 * axp288: more quirks for weird hardware
 * misc. fixes

----------------------------------------------------------------
Ashish Chavan (1):
      power: supply: ab8500_charger: Fix typos in commit messages

Baolin Wang (4):
      power: supply: sc27xx: Add POWER_SUPPLY_PROP_CHARGE_NOW attribute
      power: supply: Allow charger manager can be built as a module
      power: reset: sc27xx: Change to use cpu_down()
      power: reset: sc27xx: Allow the SC27XX poweroff driver building into a module

Claudiu.Beznea@microchip.com (15):
      power: reset: at91-reset: introduce struct at91_reset
      power: reset: at91-reset: add ramc_base[] to struct at91_reset
      power: reset: at91-reset: add sclk to struct at91_reset
      power: reset: at91-reset: add notifier block to struct at91_reset
      power: reset: at91-reset: convert reset in pointer to struct at91_reset
      power: reset: at91-reset: pass rstc base address to at91_reset_status()
      power: reset: at91-reset: devm_kzalloc() for at91_reset data structure
      power: reset: at91-reset: introduce struct at91_reset_data
      power: reset: at91-reset: introduce args member in at91_reset_data
      power: reset: at91-reset: use r4 as tmp argument
      power: reset: at91-reset: introduce ramc_lpr to struct at91_reset
      power: reset: at91-reset: make at91sam9g45_restart() generic
      power: reset: at91-reset: keep only one reset function
      power: reset: at91-reset: get rid of at91_reset_data
      power: reset: at91-reset: handle nrst async for sam9x60

Dmitry Osipenko (1):
      power: supply: bq27xxx_battery: Silence deferred-probe error

Hans de Goede (1):
      power: supply: axp288_charger: Add special handling for HP Pavilion x2 10

Jeffery Miller (1):
      power: supply: axp288_fuel_gauge: Broaden vendor check for Intel Compute Sticks.

Paul Cercueil (1):
      power/supply: ingenic-battery: Don't print error on -EPROBE_DEFER

Sherry Zong (1):
      power: reset: sc27xx: Power off the external subsystems' connection

Takashi Iwai (1):
      power: twl4030: Use scnprintf() for avoiding potential buffer overflow

 drivers/power/reset/Kconfig              |   2 +-
 drivers/power/reset/at91-reset.c         | 190 +++++++++++++++----------------
 drivers/power/reset/sc27xx-poweroff.c    |  21 +++-
 drivers/power/supply/Kconfig             |   2 +-
 drivers/power/supply/ab8500_charger.c    |  35 +++---
 drivers/power/supply/axp288_charger.c    |  57 +++++++++-
 drivers/power/supply/axp288_fuel_gauge.c |   4 +-
 drivers/power/supply/bq27xxx_battery.c   |   5 +-
 drivers/power/supply/ingenic-battery.c   |   3 +-
 drivers/power/supply/sc27xx_fuel_gauge.c |  12 ++
 drivers/power/supply/twl4030_charger.c   |   4 +-
 include/linux/power/charger-manager.h    |   2 +-
 12 files changed, 211 insertions(+), 126 deletions(-)

--iuo7vvzt7573duva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6KA1QACgkQ2O7X88g7
+preORAAhzkOm9+wv0vX6fGJ7I/tKHxk9OytmQBWG+D4Y09KtNwdxDcJt8JGWnPU
TkaNO0A/JSEkFbu1htOqzsZohAyd+W2O7CbDMGFkns3o9/HFPWHivik0RQtqrZ2I
pZaXlsG5nhDjj42KjxnlusSZM2xmp2lPYHS47QsEeEHhiDWTyHBgrVvDF8Em4yvJ
eiVhwgaz+zShqWn9hxfoYJGBI4dxwoFsXrODy9fxVPUGKTPNe7Bbhra0rHYB5L8I
2JOYUJvf8pqH+IXCvJ0zww+bodb4GQ3J4UrFycEBogmuLVvtcre33YwLaE3y0G+/
hFrWgQGJvt3kWoBD7+X2Rmop/2CmRRLtGSnWC1qgOFyDbpbR/SxHYzrC7kiH81en
DHQIUqCwy1sernZJI9MN/LvLSVTkv69KKy4MnTiyoFdjGH7jVMs4pDyFMAap2Woz
+nABIuwJ1z473PrPzPEEcpdPzK+wJEGv7nIvhe2lD9idjQvhQfkzSG7KglPq5oOf
CqOUL7q8rY0uanZiXU/HrXzGbS7j8h3VaFf2PPryHHuQXct64Mjmb2pdKc61Q8fY
k6KPSKZDdklVtTFATGqyC5LRgnZAYMY79PNvgwxx43atuhsKGXSfLAIn24UaIN5r
+gqNXd5MK9D0EjaoCv6nFLJYjoCsoPPY/JsBJrqhWmVYZvOoz2o=
=rVDI
-----END PGP SIGNATURE-----

--iuo7vvzt7573duva--
