Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FAE1F3F8D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgFIPiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 11:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFIPh7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 11:37:59 -0400
Received: from earth.universe (dyndsl-037-138-184-022.ewe-ip-backbone.de [37.138.184.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5550E20774;
        Tue,  9 Jun 2020 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717078;
        bh=iR8N2iIawyWiTzawVileB4bmWBkoeEhPE46HgQN3S64=;
        h=Date:From:To:Cc:Subject:From;
        b=tsAyG+oE38U0uVzXyEq8BppjPPPUXFAoltmH7fjFm6kbJhz01+6wiDk3nbL0vrMNp
         C8amoyyYhSWXRkK2Hxbjg/mEneWMS9fk1aKKNQwvwzvXiG5UqW8LDJEuV6EuUU+sON
         b5Yv7rPtX0P7haxrxxmgPkGJhwgSCAGcjLKvHwHY=
Received: by earth.universe (Postfix, from userid 1000)
        id B99533C08C6; Tue,  9 Jun 2020 17:37:56 +0200 (CEST)
Date:   Tue, 9 Jun 2020 17:37:56 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.8
Message-ID: <20200609153756.rdkntdy4i6zgcpbu@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c5hwyhkxeduuwcww"
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c5hwyhkxeduuwcww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the power-supply pull request. As mentioned in my
pull request for 5.7, this time there are lots of changes.
Quite a few changes to the core, lots of driver changes
and one change to kobject core (with Ack from Greg). Please
find the details in the signed tag (or below).

No merge conflicts have been reported from linux-next.

-- Sebastian

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.8

for you to fetch changes up to 152204dbdcee6df9406f87c81f9591aeaf1ba55b:

  power: supply: cw2015: Attach OF ID table to the driver (2020-06-06 01:13=
:56 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.8 series

kobject:
 * Increase number of allowed uevent variables

power-supply core:
 * Add power-supply type in uevent
 * Cleanup property handling in core
 * Make property and usb_type pointers const
 * Convert core power-supply DT binding to YAML
 * Cleanup HWMON code
 * Add new health status "calibration required"
 * Add new properties for manufacture date and
   capacity error margin

battery drivers:
 * new cw2015 battery driver used by pine64 Pinebook Pro laptop
 * axp22: blacklist on Meegopad T02
 * sc27xx: support current/voltage reading
 * max17042: support time-to-empty reading
 * simple-battery: add more battery parameters
 * bq27xxx: convert DT binding document to YAML
 * sbs-battery: add TI BQ20Z65 support, fix technology property, convert
		DT binding to YAML, add option to disable charger
		broadcasts, add new properties: manufacture date,
		capacity error margin, average current, charge current
		and voltage and support calibration required health
		status
 * misc. fixes

charger drivers:
 * bq25890: cleanup, implement charge type, precharge current and input
            current limiting properties
 * bd70528: use new linear range helper library
 * bd99954: new charger driver
 * mp2629: new charger driver
 * misc. fixes

reboot drivers:
 * oxnas-restart: introduce new driver
 * syscon-reboot: convert DT binding to YAML, add parent syscon device supp=
ort
 * misc. fixes

----------------------------------------------------------------
Andy Shevchenko (1):
      power: supply: cw2015: Attach OF ID table to the driver

ChenTao (1):
      power: supply: cw2015: Make some symbols static

Christophe JAILLET (1):
      power: supply: lp8788: Fix an error handling path in 'lp8788_charger_=
probe()'

Dan Carpenter (1):
      power: bq25890: unlock on error paths in bq25890_resume()

Dan Murphy (2):
      dt-bindings: power: Convert power_supply text to yaml
      dt-bindings: power: Convert bq27xxx dt to yaml

Daniel Golle (1):
      power: reset: introduce oxnas-restart

David Heidelberg (1):
      power: supply: smb347-charger: Add delay before getting IRQSTAT

Dmitry Osipenko (1):
      power: supply: smb347-charger: IRQSTAT_D is volatile

Enric Balletbo i Serra (1):
      power: supply: bq24257_charger: Replace depends on REGMAP_I2C with se=
lect

Geordan Neukum (1):
      power: supply: max17042_battery: Add support for the TTE_NOW prop

Hongbo Yao (1):
      power: reset: ltc2952: remove unused variable

Jason Yan (2):
      power: supply: max14656: remove set but not used 'ret'
      power: supply: ab8500_fg: remove comparison to bool

Jean-Francois Dagenais (1):
      power: supply: sbs-battery: add ability to disable charger broadcasts

Jonathan Bakker (1):
      power: supply: max17040: Correct voltage reading

Kejia Hu (1):
      power: reset: qcom-pon: reg write mask depends on pon generation

Lubomir Rintel (1):
      power: supply: olpc_battery: fix the power supply name

Luca Ceresoli (1):
      power: reset: gpio-poweroff: add missing '
' in dev_err()

Marek Szyprowski (1):
      power: charger: max14577: Add proper dt-compatible strings

Mathew King (4):
      power: supply: core: Cleanup power supply sysfs attribute list
      power: supply: core: Use designated initializer for property text arr=
ays
      power: supply: core: Add a macro that maps enum properties to text va=
lues
      power: supply: core: Add type property to uevent env

Matti Vaittinen (11):
      lib: add linear ranges helpers
      lib/test_linear_ranges: add a test for the 'linear_ranges'
      power: supply: bd70528: rename linear_range to avoid collision
      regulator: use linear_ranges helper
      power: supply: bd70528: use linear ranges
      dt-bindings: battery: add new battery parameters
      power: supply: add battery parameters
      dt_bindings: ROHM BD99954 Charger
      power: supply: Support ROHM bd99954 charger
      power: supply: Fix Kconfig help text indentiation
      power: supply: KConfig cleanup default n

Micha=C5=82 Miros=C5=82aw (16):
      power: supply: core: reduce power_supply_show_usb_type() parameters
      power: supply: core: allow to constify property lists
      power: supply: core: fix HWMON temperature labels
      power: supply: core: hide unused HWMON labels
      power: charger-manager: clarify num_properties starting value
      power: supply: core: tabularize HWMON temperature labels
      power: bq25890: simplify chip name property getter
      power: bq25890: make property table const
      power: bq25890: remove redundant I2C bus check
      power: bq25890: protect view of the chip's state
      power: bq25890: use proper CURRENT_NOW property for I_BAT
      power: bq25890: fix ADC mode configuration
      power: bq25890: update state on property read
      power: bq25890: implement CHARGE_TYPE property
      power: bq25890: implement PRECHARGE_CURRENT property
      power: bq25890: implement INPUT_CURRENT_LIMIT property

Qiushi Wu (1):
      power: supply: core: fix memory leak in HWMON error path

Rafael Gandolfi (1):
      power: supply: axp288_fuel_gauge: Add the Meegopad T02 to the blackli=
st.

Samuel Zou (1):
      power: supply: Make bd9995x_chip_reset static

Saravanan Sekar (6):
      dt-bindings: mfd: Add document bindings for mp2629
      mfd: mp2629: Add support for mps battery charger
      iio: adc: mp2629: Add support for mp2629 ADC driver
      power: supply: Add support for mps mp2629 battery charger
      power: supply: mp2629: Add impedance compensation config
      MAINTAINERS: Add entry for mp2629 Battery Charger driver

Sebastian Reichel (24):
      power: supply: charger-manager: Prepare for const properties
      power: supply: generic-adc-battery: Prepare for const properties
      Merge tag 'tags/linear-ranges-lib' into psy-next
      Merge tag 'tags/ib-mfd-iio-power-v5.8' into psy-next
      kobject: increase allowed number of uevent variables
      power: supply: core: add capacity error margin property
      power: supply: core: add manufacture date properties
      power: supply: core: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED
      power: supply: sbs-battery: Add TI BQ20Z65 support
      power: supply: sbs-battery: add POWER_SUPPLY_PROP_CAPACITY_ERROR_MARG=
IN support
      power: supply: sbs-battery: simplify read_read_string_data
      power: supply: sbs-battery: add PEC support
      power: supply: sbs-battery: add POWER_SUPPLY_PROP_CURRENT_AVG support
      power: supply: sbs-battery: Improve POWER_SUPPLY_PROP_TECHNOLOGY supp=
ort
      power: supply: sbs-battery: add POWER_SUPPLY_PROP_CONSTANT_CHARGE_CUR=
RENT/VOLTAGE_MAX support
      power: supply: sbs-battery: add MANUFACTURE_DATE support
      power: supply: sbs-battery: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUI=
RED support
      power: supply: sbs-battery: fix idle battery status
      power: supply: sbs-battery: switch from of_property_* to device_prope=
rty_*
      power: supply: sbs-battery: switch to i2c's probe_new
      power: supply: sbs-battery: constify power-supply property array
      dt-bindings: power: sbs-battery: Convert to yaml
      Revert "power: supply: sbs-battery: add PEC support"
      Revert "power: supply: sbs-battery: simplify read_read_string_data"

Serge Semin (3):
      dt-bindings: power: reset: Convert syscon-reboot-mode to DT schema
      dt-bindings: power: reset: Unrequire regmap property in syscon-reboot=
 node
      power: reset: syscon-reboot: Add parental syscon support

Tang Bin (2):
      power: supply: 88pm860x_battery: remove redundant dev_err message
      power: supply: axp288_charger: Omit superfluous error message

Tobias Schramm (3):
      dt-bindings: Document cellwise vendor-prefix
      dt-bindings: power: supply: add cw2015_battery bindings
      power: supply: add CellWise cw2015 fuel gauge driver

Wolfram Sang (1):
      power: supply: bq24190_charger: convert to use i2c_new_client_device()

Yuanjiang Yu (4):
      power: supply: sc27xx: Set 'no_thermal' flag for SC27xx fuel gauge
      power: supply: sc27xx: Allow to change the battery full capacity
      power: supply: sc27xx: Add CURRENT_NOW/VOLTAGE_NOW properties support
      power: supply: sc27xx: Add boot voltage support

 Documentation/ABI/testing/sysfs-class-power        |   45 +-
 Documentation/ABI/testing/sysfs-class-power-mp2629 |    8 +
 .../devicetree/bindings/mfd/mps,mp2629.yaml        |   62 ++
 .../bindings/power/reset/syscon-reboot-mode.txt    |   35 -
 .../bindings/power/reset/syscon-reboot-mode.yaml   |   55 +
 .../bindings/power/reset/syscon-reboot.yaml        |   15 +-
 .../devicetree/bindings/power/supply/battery.txt   |    6 +
 .../devicetree/bindings/power/supply/bq27xxx.txt   |   56 -
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |   91 ++
 .../bindings/power/supply/cw2015_battery.yaml      |   82 ++
 .../bindings/power/supply/power-supply.yaml        |   40 +
 .../bindings/power/supply/power_supply.txt         |   25 +-
 .../bindings/power/supply/rohm,bd99954.yaml        |  155 +++
 .../bindings/power/supply/sbs,sbs-battery.yaml     |   83 ++
 .../bindings/power/supply/sbs_sbs-battery.txt      |   27 -
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   12 +
 arch/x86/platform/olpc/olpc-xo1-sci.c              |    4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c             |    4 +-
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/mp2629_adc.c                       |  208 ++++
 drivers/mfd/Kconfig                                |    9 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/mp2629.c                               |   79 ++
 drivers/platform/olpc/olpc-xo175-ec.c              |    4 +-
 drivers/power/reset/Kconfig                        |    7 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/gpio-poweroff.c                |    2 +-
 drivers/power/reset/ltc2952-poweroff.c             |    3 +-
 drivers/power/reset/oxnas-restart.c                |  233 ++++
 drivers/power/reset/qcom-pon.c                     |    3 +-
 drivers/power/reset/syscon-reboot.c                |    7 +-
 drivers/power/supply/88pm860x_battery.c            |    8 +-
 drivers/power/supply/Kconfig                       |   59 +-
 drivers/power/supply/Makefile                      |    3 +
 drivers/power/supply/ab8500_fg.c                   |    2 +-
 drivers/power/supply/axp288_charger.c              |    5 +-
 drivers/power/supply/axp288_fuel_gauge.c           |    6 +
 drivers/power/supply/bd70528-charger.c             |  140 +--
 drivers/power/supply/bd99954-charger.c             | 1142 ++++++++++++++++=
++++
 drivers/power/supply/bd99954-charger.h             | 1075 ++++++++++++++++=
++
 drivers/power/supply/bq24190_charger.c             |    2 +-
 drivers/power/supply/bq25890_charger.c             |  200 ++--
 drivers/power/supply/charger-manager.c             |   40 +-
 drivers/power/supply/cw2015_battery.c              |  750 +++++++++++++
 drivers/power/supply/generic-adc-battery.c         |   22 +-
 drivers/power/supply/lp8788-charger.c              |   18 +-
 drivers/power/supply/max14577_charger.c            |   10 +
 drivers/power/supply/max14656_charger_detector.c   |    5 +-
 drivers/power/supply/max17040_battery.c            |    2 +-
 drivers/power/supply/max17042_battery.c            |    8 +
 drivers/power/supply/mp2629_charger.c              |  669 ++++++++++++
 drivers/power/supply/olpc_battery.c                |    4 +-
 drivers/power/supply/power_supply_core.c           |    8 +
 drivers/power/supply/power_supply_hwmon.c          |   64 +-
 drivers/power/supply/power_supply_sysfs.c          |  484 +++++----
 drivers/power/supply/sbs-battery.c                 |  232 +++-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   77 +-
 drivers/power/supply/smb347-charger.c              |    5 +
 drivers/regulator/88pg86x.c                        |    4 +-
 drivers/regulator/88pm800-regulator.c              |    4 +-
 drivers/regulator/Kconfig                          |    1 +
 drivers/regulator/act8865-regulator.c              |    4 +-
 drivers/regulator/act8945a-regulator.c             |    2 +-
 drivers/regulator/arizona-ldo1.c                   |    2 +-
 drivers/regulator/arizona-micsupp.c                |    4 +-
 drivers/regulator/as3711-regulator.c               |    6 +-
 drivers/regulator/as3722-regulator.c               |    4 +-
 drivers/regulator/axp20x-regulator.c               |   16 +-
 drivers/regulator/bcm590xx-regulator.c             |    8 +-
 drivers/regulator/bd70528-regulator.c              |    8 +-
 drivers/regulator/bd71828-regulator.c              |   10 +-
 drivers/regulator/bd718x7-regulator.c              |   26 +-
 drivers/regulator/da903x.c                         |    2 +-
 drivers/regulator/helpers.c                        |  130 +--
 drivers/regulator/hi6421-regulator.c               |    4 +-
 drivers/regulator/lochnagar-regulator.c            |    4 +-
 drivers/regulator/lp873x-regulator.c               |    4 +-
 drivers/regulator/lp87565-regulator.c              |    2 +-
 drivers/regulator/lp8788-buck.c                    |    2 +-
 drivers/regulator/max77650-regulator.c             |    2 +-
 drivers/regulator/mcp16502.c                       |    4 +-
 drivers/regulator/mp8859.c                         |    2 +-
 drivers/regulator/mt6323-regulator.c               |    6 +-
 drivers/regulator/mt6358-regulator.c               |    8 +-
 drivers/regulator/mt6380-regulator.c               |    6 +-
 drivers/regulator/mt6397-regulator.c               |    6 +-
 drivers/regulator/palmas-regulator.c               |    4 +-
 drivers/regulator/qcom-rpmh-regulator.c            |    2 +-
 drivers/regulator/qcom_rpm-regulator.c             |   14 +-
 drivers/regulator/qcom_smd-regulator.c             |   78 +-
 drivers/regulator/rk808-regulator.c                |   10 +-
 drivers/regulator/s2mps11.c                        |   14 +-
 drivers/regulator/sky81452-regulator.c             |    2 +-
 drivers/regulator/stpmic1_regulator.c              |   18 +-
 drivers/regulator/tps65086-regulator.c             |   10 +-
 drivers/regulator/tps65217-regulator.c             |    4 +-
 drivers/regulator/tps65218-regulator.c             |    6 +-
 drivers/regulator/tps65912-regulator.c             |    4 +-
 drivers/regulator/twl-regulator.c                  |    4 +-
 drivers/regulator/twl6030-regulator.c              |    2 +-
 drivers/regulator/wm831x-dcdc.c                    |    2 +-
 drivers/regulator/wm831x-ldo.c                     |    4 +-
 drivers/regulator/wm8350-regulator.c               |    2 +-
 drivers/regulator/wm8400-regulator.c               |    2 +-
 include/linux/kobject.h                            |    2 +-
 include/linux/linear_range.h                       |   48 +
 include/linux/mfd/mp2629.h                         |   26 +
 include/linux/power_supply.h                       |   13 +-
 include/linux/regulator/driver.h                   |   27 +-
 lib/Kconfig                                        |    3 +
 lib/Kconfig.debug                                  |   12 +
 lib/Makefile                                       |    2 +
 lib/linear_ranges.c                                |  241 +++++
 lib/test_linear_ranges.c                           |  228 ++++
 116 files changed, 6544 insertions(+), 937 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-re=
boot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-re=
boot-mode.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.=
txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.=
yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_b=
attery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/power-su=
pply.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9=
9954.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-=
battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-=
battery.txt
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/reset/oxnas-restart.c
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 drivers/power/supply/bd99954-charger.h
 create mode 100644 drivers/power/supply/cw2015_battery.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/linear_range.h
 create mode 100644 include/linux/mfd/mp2629.h
 create mode 100644 lib/linear_ranges.c
 create mode 100644 lib/test_linear_ranges.c

--c5hwyhkxeduuwcww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7frM0ACgkQ2O7X88g7
+ppBbw//VCPXIkbsLm7YiAEAJtNza4VQIW6IH87qWqBm9wmJ41J88kiNNGhEExWc
zXJ8Gd6rRbDNTlCxoYd/YHMzbhLCaUORxE8Se3U8USCd4YzUwzdPhs180XEMu1ro
RDkCUR1dfnFcms3IP/gf8ESMts6WLMWnoYgkmBNXU5n4jn9AhGfOGP8ICOIx6YXe
ad+Wnyiet244rXoE+K2tJiXP2b6XS6E4DiE/Aiww4r6ppx+eK04HRZRPqze+ZEVL
VbC11HS28VtFFgQphgCAMk+YCjDbbWe2rqBAPepAVpSVSoaf/r9J9s0Evtktifv5
5jT94ddL9gziX0z17+OyIOTC1WmCMeNeRFAgSX5OukHYapjcFMYYy3OStXx1PV/C
vvPTVzlriC5nUxDK6yQMlY6SfVVfB5QVHA1M4g21668tUznYVH1XdArZhqzOSZx5
cMh+wTh4knYiJlOuJpPXAn9VEQDrSuFbYIajW2aeZWJgmcdGirRFj0WVZPzGvAnr
dl7AAOsnNlilGyGCLZs/ie2RM2jnJDFxkVxU+0N/vsCjzJgfO4qQIHcpXec/AF4s
cE0QAiKFST/T4L1l+sBuBx6u754VWGse447cGZ8Ob1HpT15F+4FDuly2PdEOy2WH
STlp2vxsiDh4IjdkKMQN5Ve2ssPgvv/v0eap/j16YxrAmPYZJGY=
=RU9l
-----END PGP SIGNATURE-----

--c5hwyhkxeduuwcww--
