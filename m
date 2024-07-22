Return-Path: <linux-pm+bounces-11312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786793953A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43686281A7C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5438DC7;
	Mon, 22 Jul 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7akdbAs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359A288B1;
	Mon, 22 Jul 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682626; cv=none; b=tpsglx5ZzbkJDrTD62UkkGjzfi3BwVzIx8RNyfsJhhyOfrUW8KxGTsmMatFiwJ7IczYxX+ChFJRGgyLwQFS4+iLmMlGN46wCe7zoeuqUKaFz7TsWU7xTtnSFvH9DsreDFW4tpbk9FmiCSHZiZD8hXgqstdMBN+lTZ/vqsLrucgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682626; c=relaxed/simple;
	bh=wJdVcZtA8Vz7D5QJ3TkCiKzty3+W9DJoGYii77MYDTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gelbNQacQLmHbfVxee3HERU2WgglKfHh2GXe1aPnQw4b79el0qEH1PPZenQvbTzg6Q0go+qnkoqff/D40Lk80IewclRQfNwRmyDJiUgzS8Fq8G06ToMRt7lSWV1qbM9m/ZLclrf2dDkF3SA7fo4QDDH71OhnxjtbZjXLVUhL+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7akdbAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3B8C116B1;
	Mon, 22 Jul 2024 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682626;
	bh=wJdVcZtA8Vz7D5QJ3TkCiKzty3+W9DJoGYii77MYDTI=;
	h=Date:From:To:Cc:Subject:From;
	b=V7akdbAsoP93wXeMj8WaZwVMYlZiU8eAKJYoqa55+0DWmXWVVD9qM4sOkClJgtB8F
	 CrdVyL9bIEd9ej42CxbJyEJ/DjCX15/Mv1OLYB+joWK189OvNqGGElxrxE2iRZdvNV
	 r4kg+lOWyEg+MJ15UmbCoRts2tJ0zL7sZ8vU0GFE9TGDA+KpoUFVem0cQ84Mz2XXJ1
	 5pUkGXAvFxaEswO/0TdZAjqtQUOvGYnn1yvBlVCE0NP3KiD+LqPeRj43wlNkP3aiUt
	 g9zzgYnIehSN+meSBEjZrN91dKX08fORLq5AWaKTDew5ehFtt/Sn+pZ0aAjC8yF3DJ
	 LBVQUuEqyDzHQ==
Received: by mercury (Postfix, from userid 1000)
	id 44B89106097F; Mon, 22 Jul 2024 23:10:23 +0200 (CEST)
Date: Mon, 22 Jul 2024 23:10:23 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.11
Message-ID: <sk3tppb46bmrbk6x67lzrrqmuu45jhfxlb7tazol36av7i6ozr@pdmyqxobq3yj>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ip5bv667r5wohcbv"
Content-Disposition: inline


--ip5bv667r5wohcbv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This time Stephen Rothwell noticed one merge conflict
with the LED tree. The discussion around that can be
found here:

https://lore.kernel.org/all/20240709133420.55645c59@canb.auug.org.au/

All changes have been in -next for 3 weeks and are
well-hung by now.

Greetings,

-- Sebastian

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.11

for you to fetch changes up to be6299c6e55e971ffc060495708740a59aa0e45b:

  power: supply: sysfs: use power_supply_property_is_writeable() (2024-07-0=
4 12:30:49 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.11 series

 * power-supply core
   - new charging_orange_full_green RGB LED trigger
   - simplify and cleanup power-supply LED trigger code
   - expose power information via hwmon compatibility layer
 * new hardware support
   - enable battery support for Qualcomm Snapdragon X Elite
   - new battery driver for Maxim MAX17201/MAX17205
   - new battery driver for Lenovo Yoga C630 laptop (custom EC)
 * cleanup 'struct i2c_device_id' initializations
 * misc. small battery driver cleanups and fixes

----------------------------------------------------------------
Abel Vesa (1):
      power: supply: qcom_battmgr: Enable battery support on x1e80100

Armin Wolf (1):
      power: supply: hwmon: Add support for power sensors

Bjorn Andersson (1):
      dt-bindings: platform: Add Lenovo Yoga C630 EC

Christophe JAILLET (6):
      power: supply: ab8500: Fix error handling when calling iio_read_chann=
el_processed()
      power: supply: ab8500: Use iio_read_channel_processed_scale()
      power: supply: ab8500: Clean some error messages
      power: supply: ingenic: Fix some error handling paths in ingenic_batt=
ery_get_property()
      power: supply: samsung-sdi-battery: Constify struct power_supply_vbat=
_ri_table
      power: supply: samsung-sdi-battery: Constify struct power_supply_main=
tenance_charge_table

Dimitri Fedrau (2):
      dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel ga=
uge
      power: supply: add support for MAX1720x standalone fuel gauge

Dmitry Baryshkov (3):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver
      platform/arm64: build drivers even on non-ARM64 platforms
      power: supply: lenovo_yoga_c630_battery: add Lenovo C630 driver

Dr. David Alan Gilbert (2):
      power: supply: bd99954: remove unused struct 'battery_data'
      power: supply: ab8500: remove unused struct 'inst_curr_result_list'

Hans de Goede (6):
      leds: rgb: leds-ktd202x: Initialize mutex earlier
      leds: core: Add led_mc_set_brightness() function
      leds: trigger: Add led_mc_trigger_event() function
      power: supply: leds: Add power_supply_[un]register_led_trigger()
      power: supply: leds: Share trig pointer for online and charging_full
      power: supply: leds: Add activate() callback to triggers

Jeff Johnson (1):
      power: reset: piix4: add missing MODULE_DESCRIPTION() macro

Kate Hsuan (3):
      leds: rgb: leds-ktd202x: Get device properties through fwnode to supp=
ort ACPI
      leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
      power: supply: power-supply-leds: Add charging_orange_full_green trig=
ger for RGB LED

Sebastian Reichel (2):
      Merge tag 'ib-leds-platform-power-v6.11'
      Merge tag 'platform-drivers-x86-ib-lenovo-c630-v6.11-2'

Thomas Wei=DFschuh (1):
      power: supply: sysfs: use power_supply_property_is_writeable()

Uwe Kleine-K=F6nig (1):
      power: supply: Drop explicit initialization of struct i2c_device_id::=
driver_data to 0

 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 ++++
 .../bindings/power/supply/maxim,max17201.yaml      |  58 +++
 drivers/leds/led-class-multicolor.c                |   1 +
 drivers/leds/led-core.c                            |  31 ++
 drivers/leds/led-triggers.c                        |  20 +
 drivers/leds/rgb/Kconfig                           |   1 -
 drivers/leds/rgb/leds-ktd202x.c                    |  80 ++--
 drivers/platform/Makefile                          |   2 +-
 drivers/platform/arm64/Kconfig                     |  14 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 291 ++++++++++++
 drivers/power/reset/piix4-poweroff.c               |   1 +
 drivers/power/supply/Kconfig                       |  21 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/ab8500_chargalg.c             |   2 +-
 drivers/power/supply/ab8500_charger.c              |  52 ++-
 drivers/power/supply/ab8500_fg.c                   |   5 -
 drivers/power/supply/adp5061.c                     |   2 +-
 drivers/power/supply/bd99954-charger.c             |   7 -
 drivers/power/supply/bq24735-charger.c             |   2 +-
 drivers/power/supply/bq25890_charger.c             |  10 +-
 drivers/power/supply/cw2015_battery.c              |   2 +-
 drivers/power/supply/ingenic-battery.c             |  10 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c    | 501 +++++++++++++++++=
++++
 drivers/power/supply/lp8727_charger.c              |   2 +-
 drivers/power/supply/ltc4162-l-charger.c           |   4 +-
 drivers/power/supply/max14656_charger_detector.c   |   2 +-
 drivers/power/supply/max1720x_battery.c            | 337 ++++++++++++++
 drivers/power/supply/max77976_charger.c            |   4 +-
 drivers/power/supply/mm8013.c                      |   2 +-
 drivers/power/supply/power_supply_core.c           |   4 +-
 drivers/power/supply/power_supply_hwmon.c          |  25 +
 drivers/power/supply/power_supply_leds.c           | 179 +++++---
 drivers/power/supply/power_supply_sysfs.c          |   3 +-
 drivers/power/supply/qcom_battmgr.c                |   1 +
 drivers/power/supply/rt9455_charger.c              |   4 +-
 drivers/power/supply/samsung-sdi-battery.c         |  26 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/power/supply/sbs-manager.c                 |   4 +-
 include/linux/leds.h                               |  26 ++
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++
 include/linux/power_supply.h                       |  19 +-
 42 files changed, 1700 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-=
c630-ec.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ma=
x17201.yaml
 create mode 100644 drivers/platform/arm64/lenovo-yoga-c630.c
 create mode 100644 drivers/power/supply/lenovo_yoga_c630_battery.c
 create mode 100644 drivers/power/supply/max1720x_battery.c
 create mode 100644 include/linux/platform_data/lenovo-yoga-c630.h

--ip5bv667r5wohcbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaeyr4ACgkQ2O7X88g7
+pqPIhAAnrjfzh8GqtqP2GTcGyiALYX0GoJnmJx1yqxmtBlxe6wQwXK/X6Mtcd/z
28Jiz8UID1t0XsHL9LWBMg99CiT7oYBo0wncqE5Hx+/r8VlFIbU8aCUDgJ45y756
6tbfIhKjjqpiHX6Htc52Vs/OB1pXNRBeAxyYUi/yIzDw1HU4Peyh8nEraRM0MEpy
rVl+wi6JYBE/5TlMaGuXHubsQM3PMQTZDdhyCqdHgfrCug8lGiYZZRbuddjXyImI
ztJ0q/nhmhk3zG/Qp+EwB7d96qPYFpT7d6xUnDN/snmJ8EVwFKvjxsjtlFCXAaEB
Bd7Moo1hkcOmDbcH4tee84OoECfcy4pEAGHoIcS0Ooern38pMK1Uvi31E1unPoKm
agQbxSlIjTdd+h6BuN3E54S8UzCiQZkvwMuVQuwOIBKBds5y8/l/aipPnM5c8WA6
idTTL2HFtTIEbVWKSjPCggQCicuLR630sXaKA2adiMkxqmhtYU+wRGpe53MdpxDo
//dwHetmidMvHM2d+/LgIvLFovUv9Zlr4CN8WN4BftV+raxs0dntXT1EWd/lO1eM
ATBFSdgtoxOuhRxnIuNwrFlQ1dPf0MKslflqkJhx5SEL8LW+OvLMU/TDi13mFaPc
e0CR/6fTrwixzSDVNPhIv5mumOTzv/81ROj0/V+CD14THv8LZFI=
=yrtu
-----END PGP SIGNATURE-----

--ip5bv667r5wohcbv--

