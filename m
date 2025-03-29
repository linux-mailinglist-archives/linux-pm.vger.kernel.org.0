Return-Path: <linux-pm+bounces-24598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B38A753B4
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 01:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E763AE7D9
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074B211C;
	Sat, 29 Mar 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr+G2dEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691F81E;
	Sat, 29 Mar 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743207999; cv=none; b=ASDSFatowThWMfb11CpMTwl1o/5XgQI9WbPNl3A8OOU8HsUk1pPNCPZpPJhHtpvmYjoSTdlyWGVNwnwX2QfJYkGxP9zwJpiUteOQGZqgK02vwvYoFcL9iTKd98xOm/kFGx+q8KH4036n/GTSTCPrLUEZKdPC3I5kIQWbihU0zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743207999; c=relaxed/simple;
	bh=zpDCzelW2PppKIndLELYeS46J15TFCTFPRgNdgMFDxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hcwn6lzLOrjIMtjNfWGH6am+IF2TGNtEFhrs2ZM5yUizrss7i2AqLWNj7XmROK3OiWe34rPLyMLRBcerIBysZM/PKjydoILI5BsDiHe8PwS0HXgLcvgbg1qmPGbQ+CemsD3Ocnv8g0ZprO4py/S7WdxnM0vym2u8VJ825i+WWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr+G2dEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F580C4CEE4;
	Sat, 29 Mar 2025 00:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743207999;
	bh=zpDCzelW2PppKIndLELYeS46J15TFCTFPRgNdgMFDxA=;
	h=Date:From:To:Cc:Subject:From;
	b=Qr+G2dEo7aRY1sdstMqefb42LskLHNrydytAhhMQK0J3ElrXM+6MDq1vojE9MsmX9
	 ueqLRCvW9qg87A1CF9IERCj5SZAgm2M9exb8pRYRQPouGmOyfoOaFKh9vj43t8SbVH
	 i8DC8RW6skEjGUAg9yy6s8CaYCFsDHteMjQoBHcVFxwPmc8Qxd9MwTgDSFb2SRwqTX
	 HlTXxka7gHM1OzHdgmtgqifyy3HE9daJlKh9fstqJvvMVR6EWDN/wlBTyjv3qxDfaW
	 RgTHTLDIr1lbSVCoH1FTB4VWBXETG4AhLRuHnb+S4byVayrq/M24yrWfgoMQJcamC1
	 HCGsRCNbJ8CZw==
Received: by venus (Postfix, from userid 1000)
	id 273591809A1; Sat, 29 Mar 2025 01:26:37 +0100 (CET)
Date: Sat, 29 Mar 2025 01:26:37 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.15
Message-ID: <45zu47bzlzyh726zsf3wfi7xqxvsg3fkhmfqm6ejfyqm76rnp4@ddilazwcs566>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgvkouzpizatkwo7"
Content-Disposition: inline


--kgvkouzpizatkwo7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.15
MIME-Version: 1.0

Hi Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.15

for you to fetch changes up to 0b8d073f6c66d7110ac9fab1f13a09337e03f1b6:

  power: supply: mt6370: Remove redundant 'flush_workqueue()' calls (2025-0=
3-17 16:00:09 +0100)

----------------------------------------------------------------
power supply and reset changes for the 6.15 series

 * power-supply core
  - remove unused set_charged infrastructure
  - drop of_node from power_supply struct
 * power-supply drivers
  - axp717: support devices without thermistors
  - bq27xxx: support max design voltage for bq270x0 and bq27x10
  - pcf50633: drop charger driver
  - max1720x: add battery health support
  - switch all power-supply devices from of_node to fwnode
  - convert regmap users to maple tree register cache
  - convert drivers to devm_kmemdup_array
  - misc cleanups and fixes
 * reset drivers
  - at91-sama5d2_shdwc: add sama7d65 support

----------------------------------------------------------------
Andrew Kreimer (1):
      power: supply: axp20x_usb_power: Fix typo in dev_warn message

Andr=E9 Draszik (1):
      power: supply: max1720x: fix a comment typo

Andy Shevchenko (3):
      driver core: Split devres APIs to device/devres.h
      iio: imu: st_lsm9ds0: Replace device.h with what is needed
      Merge patch series "Split devres APIs to device/devres.h and introduc=
e devm_kmemdup_array()"

Artur Weber (1):
      power: supply: max77693: Fix wrong conversion of charge input thresho=
ld value

Bo Liu (9):
      power: supply: bd99954: convert to use maple tree register cache
      power: supply: bq24257: convert to use maple tree register cache
      power: supply: bq2515x: convert to use maple tree register cache
      power: supply: bq25890: convert to use maple tree register cache
      power: supply: bq25980: convert to use maple tree register cache
      power: supply: ltc4162l: convert to use maple tree register cache
      power: supply: max1720x: convert to use maple tree register cache
      power: supply: rt9455: convert to use maple tree register cache
      power: supply: smb347: convert to use maple tree register cache

Chen Ni (1):
      power: supply: mt6370: Remove redundant 'flush_workqueue()' calls

Chris Morgan (3):
      mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
      dt-bindings: power: supply: axp20x-battery: Add x-powers,no-thermistor
      power: supply: axp20x_battery: Update temp sensor for AXP717 from dev=
ice tree

Dimitri Fedrau (1):
      power: supply: max1720x: add health property

Dr. David Alan Gilbert (4):
      power: supply: core: Remove unused power_supply_set_battery_charged
      power: supply: ds2760: Remove unused ds2760_battery_set_charged
      power: supply: Remove unused set_charged method
      power: supply: pcf50633: Remove charger

Raag Jadav (11):
      err.h: move IOMEM_ERR_PTR() to err.h
      devres: Introduce devm_kmemdup_array()
      pinctrl: intel: copy communities using devm_kmemdup_array()
      pinctrl: baytrail: copy communities using devm_kmemdup_array()
      pinctrl: cherryview: use devm_kmemdup_array()
      pinctrl: tangier: use devm_kmemdup_array()
      pinctrl: pxa2xx: use devm_kmemdup_array()
      iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
      input: sparse-keymap: use devm_kmemdup_array()
      input: ipaq-micro-keys: use devm_kmemdup_array()
      power: supply: sc27xx: use devm_kmemdup_array()

Ryan Wanner (2):
      dt-bindings: power: reset: atmel,sama5d2-shdwc: Add microchip,sama7d6=
5-shdwc
      power: reset: at91-sama5d2_shdwc: Add sama7d65 PMC

Sebastian Reichel (4):
      Merge tag 'tags/ib-mfd-power-v6.15' into psy-next
      Merge tag 'ib-devres-iio-input-pinctrl-v6.15' into psy-next
      power: supply: core: get rid of of_node
      power: supply: all: switch psy_cfg from of_node to fwnode

Shubhrajyoti Datta (1):
      dt-bindings: power: reset: xilinx: Make "interrupts" property optional

Sicelo A. Mhlongo (4):
      power: supply: bq27xxx: Add voltage_max_design property for bq270x0 a=
nd bq27x10
      power: supply: bq27xxx: do not report bogus zero values
      power: supply: bq27xxx_battery: do not update cached flags prematurely
      Revert "power: supply: bq27xxx: do not report bogus zero values"

 .../bindings/power/reset/atmel,sama5d2-shdwc.yaml  |   5 +
 .../bindings/power/reset/xlnx,zynqmp-power.yaml    |   1 -
 .../x-powers,axp20x-battery-power-supply.yaml      |  20 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   4 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   2 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |   5 +-
 drivers/input/sparse-keymap.c                      |   3 +-
 drivers/mfd/axp20x.c                               |   1 +
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   6 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   6 +-
 drivers/pinctrl/intel/pinctrl-tangier.c            |   5 +-
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c               |   8 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   1 +
 drivers/power/supply/Kconfig                       |   6 -
 drivers/power/supply/Makefile                      |   1 -
 drivers/power/supply/ab8500_charger.c              |   4 +-
 drivers/power/supply/acer_a500_battery.c           |   3 +-
 drivers/power/supply/act8945a_charger.c            |   2 +-
 drivers/power/supply/axp20x_ac_power.c             |   2 +-
 drivers/power/supply/axp20x_battery.c              |  23 +-
 drivers/power/supply/axp20x_usb_power.c            |   4 +-
 drivers/power/supply/bd99954-charger.c             |   4 +-
 drivers/power/supply/bq2415x_charger.c             |   2 +-
 drivers/power/supply/bq24190_charger.c             |   2 +-
 drivers/power/supply/bq24257_charger.c             |   2 +-
 drivers/power/supply/bq24735-charger.c             |   2 +-
 drivers/power/supply/bq2515x_charger.c             |   6 +-
 drivers/power/supply/bq256xx_charger.c             |   2 +-
 drivers/power/supply/bq25890_charger.c             |   2 +-
 drivers/power/supply/bq25980_charger.c             |   8 +-
 drivers/power/supply/bq27xxx_battery.c             |  40 +-
 drivers/power/supply/cpcap-battery.c               |   2 +-
 drivers/power/supply/cpcap-charger.c               |   2 +-
 drivers/power/supply/ds2760_battery.c              |  52 +--
 drivers/power/supply/generic-adc-battery.c         |   2 +-
 drivers/power/supply/gpio-charger.c                |   2 +-
 drivers/power/supply/ingenic-battery.c             |   2 +-
 drivers/power/supply/ip5xxx_power.c                |   2 +-
 drivers/power/supply/lego_ev3_battery.c            |   3 +-
 drivers/power/supply/lt3651-charger.c              |   2 +-
 drivers/power/supply/ltc4162-l-charger.c           |   4 +-
 drivers/power/supply/max17042_battery.c            |   2 +-
 drivers/power/supply/max1720x_battery.c            |  51 ++-
 drivers/power/supply/max77650-charger.c            |   2 +-
 drivers/power/supply/max77693_charger.c            |   2 +-
 drivers/power/supply/max8903_charger.c             |   2 +-
 drivers/power/supply/mm8013.c                      |   2 +-
 drivers/power/supply/mt6360_charger.c              |   2 +-
 drivers/power/supply/mt6370-charger.c              |   3 +-
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/power/supply/pcf50633-charger.c            | 466 -----------------=
----
 drivers/power/supply/pm8916_bms_vm.c               |   2 +-
 drivers/power/supply/pm8916_lbc.c                  |   2 +-
 drivers/power/supply/power_supply_core.c           |  30 +-
 drivers/power/supply/qcom_battmgr.c                |   5 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |   2 +-
 drivers/power/supply/qcom_smbb.c                   |   2 +-
 drivers/power/supply/rk817_charger.c               |   2 +-
 drivers/power/supply/rt5033_battery.c              |   2 +-
 drivers/power/supply/rt5033_charger.c              |   3 +-
 drivers/power/supply/rt9455_charger.c              |   4 +-
 drivers/power/supply/rt9467-charger.c              |   2 +-
 drivers/power/supply/rt9471.c                      |   2 +-
 drivers/power/supply/sbs-battery.c                 |   2 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/power/supply/sbs-manager.c                 |   2 +-
 drivers/power/supply/sc2731_charger.c              |   2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   8 +-
 drivers/power/supply/smb347-charger.c              |   4 +-
 drivers/power/supply/tps65090-charger.c            |   2 +-
 drivers/power/supply/tps65217_charger.c            |   2 +-
 drivers/power/supply/ucs1002_power.c               |   2 +-
 include/linux/device.h                             | 119 +-----
 include/linux/device/devres.h                      | 129 ++++++
 include/linux/err.h                                |   3 +
 include/linux/io.h                                 |   2 -
 include/linux/mfd/axp20x.h                         |   1 +
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/power_supply.h                       |   3 -
 81 files changed, 366 insertions(+), 774 deletions(-)
 delete mode 100644 drivers/power/supply/pcf50633-charger.c
 create mode 100644 include/linux/device/devres.h

--kgvkouzpizatkwo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfnPjkACgkQ2O7X88g7
+ppCdw/+Jcq4GFczAaR2rPcMWiOKDQ5zuoSWU0vDOMLFgvzD9nP6Wm054LiAfUwA
CKhrjKFtLIPaHSLqpEDUZDHt68Xih92vXKFif2euuda3o7T5YpspraQxdOqt9Pba
Mali7SwZ242ta4Xmui5w0hwLWPOqwk3LE59dfFX2TQgVuZqvKpgsKpS90xjX6HwO
6xkU+S2t1cS3Gv9BNQwh0rZJvHBeMJunP9n2Au1hk2LuE6UAW9R3Ovb32heZ4+Zb
xaVEE5SGYJ1BTmMsYW+qgvV6UBRtw08u0W31r9ZVj6yKpWKt9vnMbo46U2p0Cv/C
eNE0Eh53UwcD84vpWpg7JWZTc5B3AOSfpkvumcDelfv8u3U3ZxeZ+MKow3Qi6Tmm
Pm2UDNCxPhG7NtBiv9bQNVsezoWLVhHHmXQat+l0AMIBllYQ2Dh/5MFoojK+nlQi
QLptGuNs/xLIe2v9+JbBLZWhXZ/OF+sJWIO2IAKo6bEbKd/yYNSO+bMGp/HHciRT
p3ohXvqCFOSKpHIuc4O+7JcusWkhEijl6/4AqgkDG/0LnhU1OHB97wVOe1McbY06
tjLisGaObsR0XZgOTgDzM2wTIY3yvnKgLAdDv8cVxxVTjkUmx32EVyEg0wsTmle/
avU7uAoDEItiobjjFjvXZEZhQSVVUi+fJCWlNWZ8h9PQTfFP4gI=
=yahJ
-----END PGP SIGNATURE-----

--kgvkouzpizatkwo7--

