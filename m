Return-Path: <linux-pm+bounces-18188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439279DAFB4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 00:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CE9280E33
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830CE202F71;
	Wed, 27 Nov 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1u5SvjE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58265191F75;
	Wed, 27 Nov 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748740; cv=none; b=tT8BjopfdAjIW3bevf//sKb3qdrS0YLGZmXMDytWTo1jPZAX1Z2547myrUaEsZ8cZQTC9whdXost6JBRKtmkzWstTO1Py+muGQ8Q6PQBk+DRFwUTn6bxgLMx67gCO3F/Ym7/0Iq0Q6R1JKF33bNAplEcXz8UB3SFZfivGfj2FrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748740; c=relaxed/simple;
	bh=z8NgIlDrNAeGr2/ntkWL1FSUBzM8rEJw8L5UI+Kgu18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n4bNuOf4cI7KU36co0zXs2gIc2OsgMIILxAl2V5l3AlPe6ruo86VuTXeeusQvqQvh689zmu4Pup5MrrMAdpAhPv7RLumBAr/LUv7sVV+Vn/+rqpQ3G5cPpjafJ9DTs2ipvl98HBK/a3knsDOELbcerzekCMQlY650ZT4mKrj3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1u5SvjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A46C4CECC;
	Wed, 27 Nov 2024 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732748739;
	bh=z8NgIlDrNAeGr2/ntkWL1FSUBzM8rEJw8L5UI+Kgu18=;
	h=Date:From:To:Cc:Subject:From;
	b=q1u5SvjEqifRUpiMq/iOr7DX4R5QHIJmkWVCtJJpN1cQEyHa4FOWlWVdzwamARJgP
	 0qGr7FGZaR6HL2lCxOTyPmXXOFZWGPSy8uJXpekuF09oayfjctbUrbsKySBlQ4db3G
	 nphK/t03yQQnrzdHG53x4IO/MCBlBqRGqEIXpv0Mpfv/kjs9PWOFHXAALbMr38nriV
	 BEC/QJvp30anaFcmHvrNxztE3Y8UnZAlYw8EZURHqv2iGxaimHS8JuV120Akx2c7Ua
	 kIvUNhlrA+DNkOYWCBDhjxjrLUvi0aTwAOtxXi+D/6jqxVX8OWXeH67ggDvhjvlk50
	 DXvQMHBtzXOFA==
Received: by mercury (Postfix, from userid 1000)
	id 36EB610604CF; Thu, 28 Nov 2024 00:05:37 +0100 (CET)
Date: Thu, 28 Nov 2024 00:05:37 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.13
Message-ID: <rxg72umwpo3ltl4inbidhmgqpzxmqluk4wr6irmhwuo7ukpmnc@liqfo2svz3in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="taddozhm4ifcqzw7"
Content-Disposition: inline


--taddozhm4ifcqzw7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.13
MIME-Version: 1.0

Hi Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.13

for you to fetch changes up to b6d445f6724deda3fd87fa33358009d947a64c5d:

  power: reset: ep93xx: add AUXILIARY_BUS dependency (2024-11-12 00:07:00 +=
0100)

----------------------------------------------------------------
power supply and reset changes for the 6.13 series

 * power-supply core
  - replace power_supply_register_no_ws() with power_supply_register() and a
    new "no_wakeup_source" field in struct power_supply_config
  - constify battery info tables in the core and all drivers
  - switch back to remove callback for all platform drivers
  - allow power_supply_put() to be called from atomic context
  - mark attribute arrays read-only after init

 * power-supply drivers
  - new driver for TWL6030 and TWL6032
  - rk817: improve battery capacity calibration
  - misc. small cleanups and fixes

----------------------------------------------------------------
Andreas Kemnade (2):
      dt-bindings: power: supply: Add TI TWL603X charger
      power: supply: initial support for TWL6030/32

Andrew Kreimer (1):
      power: supply: Fix a typo

Arnd Bergmann (1):
      power: reset: ep93xx: add AUXILIARY_BUS dependency

Ba Jing (1):
      reset: keystone-reset: remove unused macros

Barnab=E1s Cz=E9m=E1n (1):
      power: supply: bq27xxx: Fix registers of bq27426

Bart Van Assche (1):
      power: supply: core: Remove might_sleep() from power_supply_put()

ChiYuan Huang (2):
      power: supply: rt9471: Fix wrong WDT function regfield declaration
      power: supply: rt9471: Use IC status regfield to report real charger =
status

Chris Morgan (4):
      power: supply: rk817: stop updating info in suspend
      power: supply: rk817: Update battery capacity calibration
      power: supply: axp20x_usb_power: Use scaled iio_read_channel
      power: supply: axp20x_battery: Use scaled iio_read_channel

Chris Packham (2):
      dt-bindings: reset: syscon-reboot: Add reg property
      power: reset: syscon-reboot: Accept reg property

Ed Robbins (1):
      power: supply: pmu_battery: Set power supply type to BATTERY

Elliot Berman (1):
      dt-bindings: power: reset: Convert mode-.* properties to array

Rob Herring (Arm) (1):
      dt-bindings: power/supply: qcom,pmi8998-charger: Drop incorrect "#int=
errupt-cells" from example

Shen Lichuan (1):
      power: supply: Correct multiple typos in comments

Stanislav Jakubek (2):
      dt-bindings: power: supply: sc27xx-fg: document deprecated bat-detect=
-gpio
      power: supply: sc27xx: Fix battery detect GPIO probe

Thomas Wei=DFschuh (19):
      power: supply: core: constify power_supply_battery_info::resist_table
      power: supply: ab8500: constify resistance table
      power: supply: samsung-sdi-battery: constify resistance table
      power: supply: sc27xx: use const reference to ocv table
      power: supply: core: constify power_supply_battery_info::ocv_table
      power: supply: ab8500: constify ocv table
      power: supply: samsung-sdi-battery: constify ocv table
      power: supply: core: add wakeup source inhibit by power_supply_config
      ACPI: battery: Register power supply with power_supply_register()
      power: supply: acer_a500_battery: register power supply with devm_pow=
er_supply_register()
      power: supply: bq27xxx_battery: register power supply with power_supp=
ly_register()
      power: supply: cros_usbpd-charger: register power supply with devm_po=
wer_supply_register()
      power: supply: lenovo_yoga_c630_battery: register power supplies with=
 power_supply_register()
      power: supply: max77976_charger: register power supply with devm_powe=
r_supply_register()
      power: supply: core: remove {,devm_}power_supply_register_no_ws()
      power: supply: core: use device mutex wrappers
      power: supply: core: unexport power_supply_property_is_writeable()
      power: supply: core: mark attribute arrays as ro_after_init
      power: supply: hwmon: move interface to private header

Uwe Kleine-K=F6nig (1):
      power: Switch back to struct platform_driver::remove()

anish kumar (1):
      power: supply: generic-adc-battery: change my gmail

 .../bindings/power/reset/nvmem-reboot-mode.yaml    |   4 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   7 +
 .../bindings/power/reset/reboot-mode.yaml          |   4 +-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |   4 +
 .../bindings/power/reset/syscon-reboot.yaml        |  11 +-
 .../power/supply/qcom,pmi8998-charger.yaml         |   1 -
 .../bindings/power/supply/sc27xx-fg.yaml           |   5 +
 .../bindings/power/supply/ti,twl6030-charger.yaml  |  48 ++
 drivers/acpi/battery.c                             |   3 +-
 drivers/power/reset/Kconfig                        |   1 +
 drivers/power/reset/at91-poweroff.c                |   2 +-
 drivers/power/reset/at91-reset.c                   |   2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   2 +-
 drivers/power/reset/keystone-reset.c               |   2 -
 drivers/power/reset/ltc2952-poweroff.c             |   2 +-
 drivers/power/reset/qnap-poweroff.c                |   2 +-
 drivers/power/reset/syscon-reboot.c                |   3 +-
 drivers/power/supply/88pm860x_battery.c            |   4 +-
 drivers/power/supply/Kconfig                       |  10 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500_bmdata.c               |   4 +-
 drivers/power/supply/ab8500_btemp.c                |   4 +-
 drivers/power/supply/ab8500_chargalg.c             |   2 +-
 drivers/power/supply/ab8500_charger.c              |   2 +-
 drivers/power/supply/ab8500_fg.c                   |   2 +-
 drivers/power/supply/acer_a500_battery.c           |   9 +-
 drivers/power/supply/act8945a_charger.c            |   2 +-
 drivers/power/supply/adp5061.c                     |   2 +-
 drivers/power/supply/axp20x_battery.c              |  33 +-
 drivers/power/supply/axp20x_usb_power.c            |  33 +-
 drivers/power/supply/bq27xxx_battery.c             |  40 +-
 drivers/power/supply/charger-manager.c             |   4 +-
 drivers/power/supply/cpcap-battery.c               |   2 +-
 drivers/power/supply/cpcap-charger.c               |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          |   4 +-
 drivers/power/supply/da9030_battery.c              |   6 +-
 drivers/power/supply/da9052-battery.c              |   2 +-
 drivers/power/supply/da9150-charger.c              |   2 +-
 drivers/power/supply/generic-adc-battery.c         |   4 +-
 drivers/power/supply/ipaq_micro_battery.c          |   2 +-
 drivers/power/supply/isp1704_charger.c             |   2 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c    |  14 +-
 drivers/power/supply/lp8788-charger.c              |   2 +-
 drivers/power/supply/max14577_charger.c            |   2 +-
 drivers/power/supply/max77650-charger.c            |   2 +-
 drivers/power/supply/max77693_charger.c            |   2 +-
 drivers/power/supply/max77976_charger.c            |   3 +-
 drivers/power/supply/max8925_power.c               |   4 +-
 drivers/power/supply/pcf50633-charger.c            |   2 +-
 drivers/power/supply/pmu_battery.c                 |   1 +
 drivers/power/supply/power_supply.h                |  22 +-
 drivers/power/supply/power_supply_core.c           |  87 +--
 drivers/power/supply/power_supply_hwmon.c          |   1 +
 drivers/power/supply/power_supply_sysfs.c          |  12 +-
 drivers/power/supply/qcom_battmgr.c                |   2 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |   2 +-
 drivers/power/supply/qcom_smbb.c                   |   8 +-
 drivers/power/supply/rk817_charger.c               | 112 ++--
 drivers/power/supply/rt9471.c                      |  52 +-
 drivers/power/supply/samsung-sdi-battery.c         |  10 +-
 drivers/power/supply/sc2731_charger.c              |   2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |  12 +-
 drivers/power/supply/tps65090-charger.c            |   2 +-
 drivers/power/supply/tps65217_charger.c            |   2 +-
 drivers/power/supply/twl4030_charger.c             |   2 +-
 drivers/power/supply/twl6030_charger.c             | 581 +++++++++++++++++=
++++
 drivers/power/supply/wm831x_power.c                |   2 +-
 drivers/power/supply/wm8350_power.c                |   2 +-
 drivers/power/supply/wm97xx_battery.c              |   2 +-
 include/linux/power_supply.h                       |  35 +-
 70 files changed, 971 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl60=
30-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

--taddozhm4ifcqzw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdHpb0ACgkQ2O7X88g7
+pq5CQ/0C0mnat9JL7/BQC4I1hp3VIfdBgzTBR2+75uOzFZPmT4KVA5vLv23GiyG
aYzIj0eFNg61tZCUHqwdYPG2wSPiVREEeJE9og1Wp5neHfsGczfF4zJKN5aE3KED
3SIyJqdsufm+i50hnDSv5Q6E0E1VBJ0Lsu2BzVKCIWNY7iQEk5wRxZV/KUZiLftx
MK+tQkrPlDd+bcClQySSO/wzJ+J2MNP+p7vILLWLfCG2uel0vVG766Buty6N04J/
kIpAMtWEubOW98fH6lFTHWwpdqJmMAi71iTXPCIXlHpZ6GHxM/k6wx/3raejwaFJ
o7UVCtPoyHu93aYYEaxf10pTPzi2PicZ8uTB6ykexdY0rDK8nnFX8NbSSwuuYgRO
VicTX6HQ6IHGc1rWfhOtj+nzg2iyQyWoY4HSKepihsYWyVeyUAofj4st8LLIiyGF
s9CF1/AJx1eOGOUUaUKF3LYQHXIESKUiTkCVxy3Or4L9GNRd4UkV2P1DuUb2ztkN
ZcGjR14VnzqXXiCdTJmwsadFob90QPPEHOH5Fo83DE/c6dF3CHeFF1JrSRJUS9o2
0CqHDVnZA3/HTyabFyh3GUcPfyX3BoPxKLwI3Jt6sy+577lBzAPpg1L+rnhlbWWZ
hmcgzKCUfQQmuMM6l36cLVyNjmklbFRlCbT/PCl5wOwPvoktnA==
=oaBD
-----END PGP SIGNATURE-----

--taddozhm4ifcqzw7--

