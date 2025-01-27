Return-Path: <linux-pm+bounces-20981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECFA1D977
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D413A3ADA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76727468;
	Mon, 27 Jan 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tssHdRo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8478F4B;
	Mon, 27 Jan 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991597; cv=none; b=Yf5jiZb+PgYlpYpRL5MEt71GF3+45927jcGIPQ73D/pS6vJsCF95qVeplZFfsDHCMT9iekX0gfsHm/zeCVJv7rJRY3JuzecwMc6ZRUjVkKX/J1lBt5ckY2jlvhEiAw2H+hJ2rnvhnUD68NDLV1mxb9W53KawKqr2B0JPsygVshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991597; c=relaxed/simple;
	bh=P8KYITM6qzbJG5n/5mdDLPimyvYfg1D6F8rYXUzpCvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Od5wYFsTWlbkDhtfwqMpxpK9sua+6PBoJ0T2Aw1avFZ7r0rsrIH+n1K5ZhGTpHrxbN7aTIAbyUCA+xSGMkhZNgM39zsWZzCOs7xyFMu7OzaMeU/tuIBOSlN55nT2zO6XKEei9txwMfDgcPFRFacyQ+5BezNH1utYK8pbNBEJUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tssHdRo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A3C4CED2;
	Mon, 27 Jan 2025 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737991597;
	bh=P8KYITM6qzbJG5n/5mdDLPimyvYfg1D6F8rYXUzpCvo=;
	h=Date:From:To:Cc:Subject:From;
	b=tssHdRo87/4omm9HWD1QTk6j9dN+6XaROEsUCg/brGpiNsueHDKlJB0Cjj5MDf4AF
	 aptRR5L3zckc6BNgh3cNqWPPGmnhpXZuJaMdYzkTaMQO73EGKoSOrW0D1J2SOqCRxg
	 szy58ct9u2FdPrdZuzINdM0SlpXhc9Hcu5GwHg3vrAPSH5d/EvY66JvxJ9QI0aiDN9
	 jxtXrFwRGit9l4J3i6OJDaUkMDETCiEVH2liPblV7vrC/tUCT3tKUb4oIM6UPe8PTy
	 9ZXY6/OVJlJPtoEijxIR8sqnPXQazMPIYahiSQLwU0X+nmqenanFGiJR9P9jZzL3cU
	 pfjIoB8YHdlNw==
Received: by mercury (Postfix, from userid 1000)
	id A27D81060357; Mon, 27 Jan 2025 16:26:34 +0100 (CET)
Date: Mon, 27 Jan 2025 16:26:34 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.14
Message-ID: <epxxhdzetjg55wv4gmzaszcoao26p6n5onujohcvgf7accw2eq@tx5qg6nr2c5y>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjt5im7jz4jvfybw"
Content-Disposition: inline


--rjt5im7jz4jvfybw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.14
MIME-Version: 1.0

Hi Linus,

Here are the power-supply changes for the v6.14 cycle. There is one
change to the dell-laptop x86 platform driver, which goes to my tree
due to dependencies. Otherwise business as usual with quite some
core changes thanks to Thomas Wei=DFschuh, which will hopefully help
cleaning up the x86 charge threshold platform drivers in the next
releases. No merge issues have been noticed in linux-next.

Greetings,

-- Sebastian

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.14

for you to fetch changes up to b4a95b8fd3e67c1222c76bdd1078d43c9a11d132:

  power: supply: max1720x: add support for reading internal and thermistor =
temperatures (2025-01-17 22:33:04 +0100)

----------------------------------------------------------------
power supply and reset changes for the 6.14 series

 * power-supply core
  - introduce power supply extensions, which allows adding properties to
    a power supply device from a separate driver. This will be used
    initially to extend the generic ACPI charger/battery driver with
    vendor extensions for charge thresholds.
  - convert all drivers from power_supply_for_each_device to new
    power_supply_for_each_psy(), which avoids lots of casting being
    done in the drivers.
  - avoid LED trigger like values in uevent for POWER_SUPPLY_PROP_CHARGE_BE=
HAVIOUR
  - introduce POWER_SUPPLY_PROP_CHARGE_TYPES, which is similar to the
    POWER_SUPPLY_PROP_CHARGE_TYPE property, but also lists the available
    options on the specific platform

 * power-supply drivers
  - dell-laptop: use new power_supply_charge_types_show/_parse helpers
  - stc3117: new driver for equally named fuel gauge chip
  - bq24190: add support for new POWER_SUPPLY_PROP_CHARGE_TYPES
  - bq24190: add BQ24297 support
  - bq27xxx: add voltage min design for bq27000/bq27200
  - cros_charge-control: convert to new power supply extension API
  - multiple drivers: constify 'struct bin_attribute'
  - ds2782: convert to device managed resources
  - max1720x: add charge full property
  - max1720x: support extra thermistor temperatures
  - max17042: add max77705 support
  - ip5xxx-power: add support for IP5306
  - ltc4162-l-charger: add ltc4162-f/s and ltc4015 support
  - gpio-charger: support for default charge current limit
  - misc. small cleanups and fixes

 * reset drivers
  - at91-poweroff: add sam9x7 support

----------------------------------------------------------------
Andrew Davis (5):
      power: supply: ds2782: Switch to simpler IDA interface
      power: supply: ds2782: Free IDA with devm action
      power: supply: ds2782: Use devm based memory allocators
      power: supply: ds2782: Use devm_power_supply_register() helper
      power: supply: ds2782: Use devm_delayed_work_autocancel() helper

Bence Cs=F3k=E1s (1):
      power: ip5xxx_power: Fix uninitialized variable read

Bhavin Sharma (1):
      power: supply: Add STC3117 fuel gauge unit driver

Cs=F3k=E1s, Bence (8):
      power: ip5xxx_power: Fix return value on ADC read errors
      power: ip5xxx_power: Use regmap_field API
      power: ip5xxx_power: Allow for more parameters to be configured
      power: ip5xxx_power: Add battery type for 4.4V
      power: ip5xxx_power: Check for optional bits
      power: ip5xxx_power: Fall back to Charge End bit if status register i=
s absent
      dt-bindings: trivial-devices: Add Injoinic IP5306
      power: ip5xxx_power: Add support for IP5306

Dimitri Fedrau (5):
      power: supply: max1720x: add charge full property
      power: supply: gpio-charger: Fix set charge current limits
      dt-bindings: power: supply: gpio-charger: add support for default cha=
rge current limit
      power: supply: gpio-charger: add support for default charge current l=
imit
      power: supply: max1720x: add support for reading internal and thermis=
tor temperatures

Dzmitry Sankouski (5):
      power: supply: max17042: make interrupt shared
      power: supply: max17042: add platform driver variant
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: add max77705 support
      power: supply: max17042: add max77705 fuel gauge support

Fabio Estevam (1):
      power: reset: gpio-poweroff: Clarify the warning message

Hans de Goede (8):
      power: supply: power_supply_show_enum_with_available(): Replace space=
s with '_'
      power: supply: core: Add new "charge_types" property
      power: supply: bq24190_charger: Add support for "charge_types" proper=
ty
      dt-bindings: power: supply: bq24190: Add BQ24297 compatible
      power: supply: bq24190: Add BQ24297 support
      power: supply: Use power_supply_external_power_changed() in __power_s=
upply_changed_work()
      power: supply: ug3105_battery: Let the core handle POWER_SUPPLY_PROP_=
TECHNOLOGY
      platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse(=
) helpers

Hardevsinh Palaniya (1):
      dt-bindings: power: supply: Add STC3117 Fuel Gauge

Kim Seer Paller (3):
      dt-bindings: power: supply: ltc4162-l-charger: Add ltc4162-f/s and lt=
c4015
      power: supply: ltc4162-l-charger: Add support for ltc4162-f/s and ltc=
4015
      power: supply: ltc4162l: Use GENMASK macro in bitmask operation

Krzysztof Kozlowski (2):
      power: supply: Use str_enable_disable-like helpers
      power: reset: keystone: Use syscon_regmap_lookup_by_phandle_args

Nobuhiro Iwamatsu (1):
      power: reset: as3722-poweroff: Remove unnecessary return in as3722_po=
weroff_probe

Sebastian Reichel (1):
      power: supply: Merge fixes branch into for-next

Sho Tanimoto (1):
      power: supply: bq24190_charger: Fix typo 'jeta' -> 'jeita'

Sicelo A. Mhlongo (3):
      bq27xxx: add voltage min design for bq27000 and bq27200
      power: supply: bq2415x_charger: report charging state changes to user=
space
      power: supply: bq2415x_charger: Immediately reschedule delayed work o=
n notifier events

Thomas Wei=DFschuh (32):
      power: supply: ds2760: constify 'struct bin_attribute'
      power: supply: ds2780: constify 'struct bin_attribute'
      power: supply: ds2781: constify 'struct bin_attribute'
      power: supply: olpc_battery: constify 'struct bin_attribute'
      power: supply: sysfs: print single value in uevent for POWER_SUPPLY_P=
ROP_CHARGE_BEHAVIOUR
      power: supply: core: rename psy_has_property() to psy_desc_has_proper=
ty()
      power: supply: core: introduce power_supply_has_property()
      power: supply: hwmon: prepare for power supply extensions
      power: supply: sysfs: prepare for power supply extensions
      power: supply: sysfs: rework uevent property loop
      power: supply: cros_charge-control: add mutex for driver data
      power: supply: cros_charge-control: allow start_threshold =3D=3D end_=
threshold
      power: supply: cros_charge-control: hide start threshold on v2 cmd
      power: supply: mm8013: use accessor for driver data
      power: supply: core: introduce power_supply_for_each_psy()
      power: supply: core: use power_supply_for_each_psy()
      power: supply: ab8500: use power_supply_for_each_psy()
      power: supply: apm_power: use power_supply_for_each_psy()
      power: supply: core: remove power_supply_for_each_device()
      power: supply: core: introduce dev_to_psy()
      power: supply: core: use dev_to_psy()
      power: supply: sysfs: use dev_to_psy()
      power: supply: ab8500: use dev_to_psy()
      power: supply: surface_battery: use dev_to_psy()
      power: supply: bq2415x_charger: use dev_to_psy()
      power: supply: bq24190_charger: use dev_to_psy()
      power: supply: bq24257_charger: use dev_to_psy()
      power: supply: core: implement extension API
      power: supply: test-power: implement a power supply extension
      power: supply: cros_charge-control: implement a power supply extension
      power: supply: core: add UAPI to discover currently used extensions
      power: supply: core: fix build of extension sysfs group if CONFIG_SYS=
FS=3Dn

Varshini Rajendran (4):
      dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
      power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
      power: reset: at91-reset: add reset support for sam9x7 SoC
      power: reset: at91-reset: add sdhwc support for sam9x7 SoC

 Documentation/ABI/testing/sysfs-class-power        |  31 +-
 .../ABI/testing/sysfs-class-power-max1720x         |  32 ++
 .../bindings/power/reset/atmel,sama5d2-shdwc.yaml  |   3 +
 .../devicetree/bindings/power/supply/bq24190.yaml  |   1 +
 .../bindings/power/supply/gpio-charger.yaml        |   6 +
 .../bindings/power/supply/ltc4162-l.yaml           |   6 +
 .../bindings/power/supply/maxim,max17042.yaml      |   1 +
 .../bindings/power/supply/st,stc3117.yaml          |  74 +++
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |   8 +
 drivers/platform/x86/dell/dell-laptop.c            |  54 +-
 drivers/power/reset/Kconfig                        |   4 +-
 drivers/power/reset/as3722-poweroff.c              |   2 -
 drivers/power/reset/at91-sama5d2_shdwc.c           |   1 +
 drivers/power/reset/gpio-poweroff.c                |   8 +-
 drivers/power/reset/keystone-reset.c               |  18 +-
 drivers/power/supply/88pm860x_battery.c            |   4 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500_btemp.c                |   5 +-
 drivers/power/supply/ab8500_chargalg.c             |   5 +-
 drivers/power/supply/ab8500_charger.c              |   5 +-
 drivers/power/supply/ab8500_fg.c                   |  33 +-
 drivers/power/supply/apm_power.c                   |   6 +-
 drivers/power/supply/bq2415x_charger.c             |  36 +-
 drivers/power/supply/bq24190_charger.c             |  29 +-
 drivers/power/supply/bq24257_charger.c             |   8 +-
 drivers/power/supply/bq27xxx_battery.c             |  39 +-
 drivers/power/supply/charger-manager.c             |   3 +-
 drivers/power/supply/cpcap-charger.c               |   3 +-
 drivers/power/supply/cros_charge-control.c         | 222 ++++----
 drivers/power/supply/da9030_battery.c              |   3 +-
 drivers/power/supply/ds2760_battery.c              |   8 +-
 drivers/power/supply/ds2780_battery.c              |  24 +-
 drivers/power/supply/ds2781_battery.c              |  24 +-
 drivers/power/supply/ds2782_battery.c              |  87 ++-
 drivers/power/supply/gpio-charger.c                |  21 +
 drivers/power/supply/ip5xxx_power.c                | 572 +++++++++++++----=
--
 drivers/power/supply/ltc4162-l-charger.c           | 438 +++++++++++++--
 drivers/power/supply/max17042_battery.c            | 203 +++++--
 drivers/power/supply/max1720x_battery.c            |  66 ++-
 drivers/power/supply/mm8013.c                      |   2 +-
 drivers/power/supply/olpc_battery.c                |  11 +-
 drivers/power/supply/power_supply.h                |  31 ++
 drivers/power/supply/power_supply_core.c           | 266 +++++++--
 drivers/power/supply/power_supply_hwmon.c          |  48 +-
 drivers/power/supply/power_supply_sysfs.c          | 192 +++++--
 drivers/power/supply/sbs-battery.c                 |   5 +-
 drivers/power/supply/stc3117_fuel_gauge.c          | 612 +++++++++++++++++=
++++
 drivers/power/supply/surface_battery.c             |   4 +-
 drivers/power/supply/test_power.c                  | 113 ++++
 drivers/power/supply/ug3105_battery.c              |   4 -
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/power_supply.h                       |  63 ++-
 54 files changed, 2748 insertions(+), 709 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-max1720x
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc31=
17.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

--rjt5im7jz4jvfybw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeXpaMACgkQ2O7X88g7
+ppxHA/9Fy4jfLxJtIZEYuI6MOIiBvDykyxdjNI/FIXsP8CZ1YRfy1Enfg6SUHUD
iiwMap8Hu89cnLhgmehkG02vstxTuE3604FlUh4qCl5dlao/J6iHmd3Dfv7y3Me9
thDVD0XVm9Q5FtDNzJKbprSaB5dLfxPDUw+BGGWy1f3nrdNgR+Cvf9CaXBfqEJaC
fLnOj889cF6GL1yr6IZsTVNHP1tnMJHTKPmJEVIN2S458oCnKu0x9cgHa9k352hp
XrE0y8j2ORAohWk6EQ71CDywnk4zexdO6vgESBqEJ0hYbQSA1iD57kb0JXy8j/OD
i4ch6kpQ1vIwdNNAKyVYPl8yzK/8zzvj5n1wYpd2YaSwa5gKIoQi1qlNxbG968qH
beZ1cnQEREM8DH7kwocUI/oH0dp7+gevh009HPBNC4U/3WvWtKX6wmi5F7OhjCOX
JFnuBqtce363NsQkERwiuMkHdhp+WNjqz1yD6adZR1AEr89XZya7kMLOdqzj4MJs
mtpwuCQIj+ixganFZsU/QGikWaUiWf6irpX26WSu61pvq3hBoiyTLzvPVQq59G9o
BLHk1moN2wJRw8Hft5XmhTBuB1qAL3ZpQnUADE2mbz4Y61yU4cCldbCUSZs4bG5t
oZIoWTXfo89xUlxmlZL9EMbvL5KeGwGysRJTl77IEHfQkHpx6UU=
=YKsg
-----END PGP SIGNATURE-----

--rjt5im7jz4jvfybw--

