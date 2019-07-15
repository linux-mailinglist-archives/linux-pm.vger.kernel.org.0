Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CF69BAB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 21:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfGOTth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 15:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbfGOTtg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 15:49:36 -0400
Received: from earth.universe (ip4d16e7f3.dynamic.kabel-deutschland.de [77.22.231.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA20720659;
        Mon, 15 Jul 2019 19:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563220175;
        bh=CWlhifr0S74KzpUYXPlw1+4sVyl5iHaUCHdWSKTfiZE=;
        h=Date:From:To:Cc:Subject:From;
        b=Vh4JMDIBGrMfrDLOhPvg1XQqHtTBYrMeSem0llhZz4Y82PBKnq46/oDCLlRe6czjG
         MxOTE7k3mlJrxu9etpDNcVOwKY99ovUU/Y5suDXbWy/BP4N6mg9RtApqxfxCIge0s1
         3dVfy84G64/qRu9ir90iG5VAtEos6ZqnmN4ydWvM=
Received: by earth.universe (Postfix, from userid 1000)
        id D26513C0944; Mon, 15 Jul 2019 21:49:33 +0200 (CEST)
Date:   Mon, 15 Jul 2019 21:49:33 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [GIT PULL] power-supply changes for 5.3
Message-ID: <20190715194933.cq3cfz7g6j3mnbmc@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oilo27qmkp2bf3ya"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oilo27qmkp2bf3ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is the power-supply pull request for v5.3. Stephen reported a
merge conflict with the PCI tree in linux-next, which contains a
patch updating the power related documentation files to ReST format.
The merge conflict solution from Stephen looks correct to me:

https://lkml.org/lkml/2019/6/27/1284

-- Sebastian

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.3

for you to fetch changes up to caa2b557841c8cedc1d4862cd31cf76ee940d105:

  power: reset: nvmem-reboot-mode: add CONFIG_OF dependency (2019-07-09 00:28:49 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.3 series

Core:
 * Add HWMON compat layer
 * New properties
  - input power limit
  - input voltage limit

Drivers:
 * qcom-pon: add gen2 support
 * New driver for storing reboot move in NVMEM
 * New driver for Wilco EC charger configuration
 * simplify getting the adapter of a client

----------------------------------------------------------------
Andrey Smirnov (1):
      power: supply: Add HWMON compatibility layer

Arnd Bergmann (1):
      power: reset: nvmem-reboot-mode: add CONFIG_OF dependency

Enric Balletbo i Serra (2):
      power: supply: add input power and voltage limit properties
      power: supply: cros: allow to set input voltage and current limit

Han Nandor (2):
      dt-bindings: power: reset: add document for NVMEM based reboot-mode
      power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface

John Stultz (2):
      dt-bindings: power: reset: qcom: Add qcom,pm8998-pon compatibility line
      reset: qcom-pon: Add support for gen2 pon

Nick Crews (2):
      platform/chrome: wilco_ec: Add property helper library
      power_supply: wilco_ec: Add charging config driver

Sebastian Reichel (1):
      Merge tag 'tags/ib-chrome-psy-5.3' into psy-next

Wolfram Sang (9):
      power: supply: bq24190_charger: simplify getting the adapter of a client
      power: supply: bq24257_charger: simplify getting the adapter of a client
      power: supply: bq25890_charger: simplify getting the adapter of a client
      power: supply: max14656_charger_detector: simplify getting the adapter of a client
      power: supply: max17040_battery: simplify getting the adapter of a client
      power: supply: max17042_battery: simplify getting the adapter of a client
      power: supply: rt5033_battery: simplify getting the adapter of a client
      power: supply: rt9455_charger: simplify getting the adapter of a client
      power: supply: sbs-manager: simplify getting the adapter of a client

kbuild test robot (1):
      power: supply: fix semicolon.cocci warnings

 Documentation/ABI/testing/sysfs-class-power        |  32 ++
 Documentation/ABI/testing/sysfs-class-power-wilco  |  30 ++
 .../bindings/power/reset/nvmem-reboot-mode.txt     |  26 ++
 .../devicetree/bindings/power/reset/qcom,pon.txt   |   1 +
 Documentation/power/power_supply_class.txt         |   4 +
 drivers/platform/chrome/wilco_ec/Makefile          |   2 +-
 drivers/platform/chrome/wilco_ec/properties.c      | 132 ++++++++
 drivers/power/reset/Kconfig                        |  10 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/nvmem-reboot-mode.c            |  76 +++++
 drivers/power/reset/qcom-pon.c                     |  12 +-
 drivers/power/supply/Kconfig                       |  23 ++
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/bq24190_charger.c             |   2 +-
 drivers/power/supply/bq24257_charger.c             |   2 +-
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          | 116 +++++++
 drivers/power/supply/max14656_charger_detector.c   |   2 +-
 drivers/power/supply/max17040_battery.c            |   2 +-
 drivers/power/supply/max17042_battery.c            |   2 +-
 drivers/power/supply/power_supply_core.c           |   7 +
 drivers/power/supply/power_supply_hwmon.c          | 355 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/power/supply/rt5033_battery.c              |   2 +-
 drivers/power/supply/rt9455_charger.c              |   2 +-
 drivers/power/supply/sbs-manager.c                 |   2 +-
 drivers/power/supply/ucs1002_power.c               |   2 +-
 drivers/power/supply/wilco-charger.c               | 187 +++++++++++
 include/linux/platform_data/wilco-ec.h             |  71 +++++
 include/linux/power_supply.h                       |  15 +
 30 files changed, 1110 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
 create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/power/reset/nvmem-reboot-mode.c
 create mode 100644 drivers/power/supply/power_supply_hwmon.c
 create mode 100644 drivers/power/supply/wilco-charger.c

--oilo27qmkp2bf3ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0s2MoACgkQ2O7X88g7
+prt0RAAgV6wJa9RgwamhO5IAoxGjhgzkTDNVmAyKcplFjsOEORihCc3iIcbc1Kg
PaaYdLaArxBBBhIvFvxx5G+sXNrppe2aFv32g6X6pagZDouq1IWE8JmjUrb0sX0u
2FnEzK26Vzk2oc9yjsEWXxI/IEGt4ia6QLvtqCH2mryIT1lFivdaNMAT0v3kZd8l
nAzCU7sbA4iiZbq9SDJHrf+8vWmmo3ZD8hhbWm75itXmJW+w3+wnjoJHYiybcGXb
Nc5EzB8S75yv8Jb6wcMzRCu71S7U9EULcBqtEXoAXfKJSW0mBo2vC4EtP6TDSJGX
pSShwTztRacr4HajPpPBL7Wn8N1Cv0DbLmz4YRGeqqJ8Q85V0OUhdJpU60KIUr0v
x6hMC8XgtoQxus8LlsW+Y1EWUrgIHWSKFXIHvlZgZS8heDCW/X3hAgUHvAZ6DIjU
wuBqNteGsX2e+4Y6RrAouO3JjBlnYurbpa0YGN01FOSmaoxgFC0rfhN3hhZ25oOL
iAOpLrV/MlVRt09M5fZIVIF5OZiNoalFRYeBe3YCXg/Z1E9ev9GtTLK/DTrRuNG7
6smyD/TNM1dioVCyGsf7QxcH0OyYX6Ytu7BaOr5tpanrgfDKUX0/KfoKdexfa8+O
zxs1UeAiS5cjzuQskFJrd17qbwp8qVkdxBx9yLR+1E1deVTRSnI=
=qOqz
-----END PGP SIGNATURE-----

--oilo27qmkp2bf3ya--
