Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA4BA308
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2019 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfIVQD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Sep 2019 12:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbfIVQD6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Sep 2019 12:03:58 -0400
Received: from earth.universe (dyndsl-037-138-173-172.ewe-ip-backbone.de [37.138.173.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064C4206C2;
        Sun, 22 Sep 2019 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569168237;
        bh=awpo/2PicyBFUwHrd1jaD/gJteZQVbQPn8RlOcfIf0w=;
        h=Date:From:To:Cc:Subject:From;
        b=i0yFepP9QKyHnFKURqnWhRomGko4VaoE5wHkdafaO6rhOKLPBzMTJAEEAnERopzky
         s2XTUvhznal8RS54M7LpaCW887aAMlD9Ve6qmlfmeJ7Euof/GxpVxQaPjn3WWQNpzg
         FbiFGnGUBA1/NOi6H5DIQYRJbZy8hIidY+4daxf4=
Received: by earth.universe (Postfix, from userid 1000)
        id 3081C3C0CA1; Sun, 22 Sep 2019 18:03:55 +0200 (CEST)
Date:   Sun, 22 Sep 2019 18:03:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.4
Message-ID: <20190922160355.7f5snmbvwlykekxb@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6fnwy5xbwtp4w7i"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r6fnwy5xbwtp4w7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.4

for you to fetch changes up to 7f7378618b4103c083db7de5017df958f8ada070:

  power: supply: cpcap-charger: Enable vbus boost voltage (2019-09-02 23:08:07 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.4 series

Core:
 * Ensure HWMON devices are registered with valid names
 * Fix device wakeup code

Drivers:
 * bq25890_charger: Add BQ25895 support
 * axp288_fuel_gauge: Add Minix Neo Z83-4 to blacklist
 * sc27xx: improve battery calibration
 * misc. small fixes all over drivers

----------------------------------------------------------------
Angus Ainslie (Purism) (1):
      power: supply: bq25890_charger: Add the BQ25895 part

Bartosz Golaszewski (1):
      power: supply: max77650: add MODULE_ALIAS()

Christophe JAILLET (1):
      power: supply: max17042_battery: Fix a typo in function names

Colin Ian King (1):
      power: supply: isp1704: remove redundant assignment to variable ret

Denis Efremov (1):
      MAINTAINERS: N900: Remove isp1704_charger.h record

Fuqian Huang (2):
      power: supply: sc27xx: Introduce local variable 'struct device *dev'
      power: supply: sc27xx: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()

Gustavo A. R. Silva (1):
      power: supply: ab8500_charger: Mark expected switch fall-through

Hans de Goede (2):
      power: supply: axp288_fuel_gauge: Sort the DMI blacklist alphabetically
      power: supply: axp288_fuel_gauge: Add Minix Neo Z83-4 to the blacklist

Matwey V. Kornilov (1):
      power: reset: reboot-mode: Fix author email format

Michael Nosthoff (2):
      power: supply: sbs-battery: use correct flags field
      power: supply: sbs-battery: only return health when battery present

Michal Simek (1):
      power: reset: gpio-restart: Fix typo when gpio reset is not found

Romain Izard (1):
      power: supply: register HWMON devices with valid names

Stephen Boyd (1):
      power: supply: Init device wakeup after device_add()

Tony Lindgren (1):
      power: supply: cpcap-charger: Enable vbus boost voltage

Yuanjiang Yu (6):
      power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN attribute
      power: supply: sc27xx: Fix conditon to enable the FGU interrupt
      power: supply: sc27xx: Fix the the accuracy issue of coulomb calculation
      power: supply: sc27xx: Make sure the alarm capacity is larger than 0
      power: supply: sc27xx: Optimize the battery capacity calibration
      power: supply: sc27xx: Add POWER_SUPPLY_PROP_CALIBRATE attribute

YueHaibing (1):
      power: supply: ab8500: remove set but not used variables 'vbup33_vrtcn' and 'bup_vch_range'

 MAINTAINERS                               |   1 -
 drivers/phy/motorola/phy-cpcap-usb.c      |   8 +-
 drivers/power/reset/gpio-restart.c        |   2 +-
 drivers/power/reset/reboot-mode.c         |   2 +-
 drivers/power/supply/ab8500_charger.c     |   8 +-
 drivers/power/supply/axp288_fuel_gauge.c  |  14 +-
 drivers/power/supply/bq25890_charger.c    |  12 +-
 drivers/power/supply/cpcap-charger.c      |  23 ++-
 drivers/power/supply/isp1704_charger.c    |   2 +-
 drivers/power/supply/max17042_battery.c   |   8 +-
 drivers/power/supply/max77650-charger.c   |   1 +
 drivers/power/supply/power_supply_core.c  |  10 +-
 drivers/power/supply/power_supply_hwmon.c |  15 +-
 drivers/power/supply/sbs-battery.c        |  27 ++--
 drivers/power/supply/sc27xx_fuel_gauge.c  | 223 ++++++++++++++++++++----------
 15 files changed, 237 insertions(+), 119 deletions(-)

--r6fnwy5xbwtp4w7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2Hm2sACgkQ2O7X88g7
+prupxAAlRQBjTH6JF0zzgptzuqcqmIlWiojvoN+6sECzOHvHJvvKuaf+hS4miga
umI5wIi9QuA5Xu2nSzu1my4rToTgBQn6XZqnfdAOY/0J2pAqJH5bLUZURCOHFqJc
KLfUcgtoOQdg0GqCeVm/a2A3b6eR+l/+mP5N0oUmuEA5dTDlohRjf2fTPduDQAN7
VjJU2OC//RQJfajLTQ6cxq3z4/GPupQyBIHBfTFZ4YpSAOVq/Y+JflECj4hjXGfC
r+nGm7gcfaDegC32nNyw8q7AVkDnQb2VQFVSrd/7lGIyBzWXzd9IUgMqiSp+iVRR
lmOqAWPnF1nv2+/VUMaDQTpIWxCJ5NlMZf06h4u43h1FJBSep+xOhleNws9guEIF
WEVFDJvE3AbqOZS3MZmKiL80u8QeOTNp5GRlXzk4/w7p9CdRFFfI/nX2HFdFQupa
4a3k51yK+Rbi39tB2QpuytT1STtizXozgPz/0VcRQS7ehOyc92gXdGWnpNVK1KWP
KoR5ghjZagSl/luEFFwlufoBFtQoo2IiXPXbe4H8JEK8YkdEF+RovneZxASWQJiB
JaQUQAzx8F34NewhqHipHGlvkWLo1GC6KVXIdzmTC/S/7VLPU3pRCkXs66g1MB9l
X7nFOLg1iF0kMzaQWyckpsOA61jwY2hPpu8zWyHCwRRyaETjk3Y=
=Kdl7
-----END PGP SIGNATURE-----

--r6fnwy5xbwtp4w7i--
