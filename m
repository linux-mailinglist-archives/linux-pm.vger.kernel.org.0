Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008F4459BD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhKDSb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 14:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233932AbhKDSb7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 14:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA1D61212;
        Thu,  4 Nov 2021 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636050560;
        bh=7dONt4J1TqjYGPV4HWrCgKohbev1hDMDfz/GjnNRL/o=;
        h=Date:From:To:Cc:Subject:From;
        b=vDN0azxiOmm6kR4MxswDmX/t+xWRubUr+2iV8yilCLOCpNlhMNLw7eCKslGPC45z5
         1HpezdUujd0GdGDtJMC+YQtl92gRacB2gwxw3eVbobxoBLxL9uPzkfG7htXxTuWcKC
         cTyzimVbhHieXniQFZyPaRqibV4Fr+LHR4e0dHaQDQMRCh+eYU5b1RVUVXPYFOicUG
         gNJDBUyNWfbxBjLU5fDHTJXs9BZ3rqDsbyKsikE/qpqzsjFs18ZI0DclhtmYWGfL3a
         gnGHVp08KxtupmEo2av2I0WUoIT70XvND7S0Jysx4tQufrKwr49EbCytuK9xe8YM/V
         y1zlDzYydE5zQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 3B04F3C0F95; Thu,  4 Nov 2021 19:29:18 +0100 (CET)
Date:   Thu, 4 Nov 2021 19:29:18 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.16
Message-ID: <20211104182918.nqvaukg6y6qq6mbp@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szuc5cz5kprafwzc"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--szuc5cz5kprafwzc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.16

for you to fetch changes up to 22ad4f99f63fc892412cde5a45d43b2288a60b88:

  power: supply: bq25890: Fix initial setting of the F_CONV_RATE field (202=
1-11-02 16:48:47 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.16 series

Miscellaneous small fixes and improvements all over
the place. Nothing stands out in particular.

----------------------------------------------------------------
Claudiu Beznea (1):
      power: reset: at91-reset: check properly the return value of devm_of_=
iomap

Colin Ian King (1):
      power: supply: wm831x_power: fix spelling mistake on function name

David Heidelberg (1):
      dt-bindings: power: supply: max17040: switch to unevaluatedProperties

Geert Uytterhoeven (1):
      power: supply: core: Move psy_has_property() to fix build

Hans de Goede (7):
      docs: ABI: sysfs-class-power: Documented cycle_count property
      power: supply: axp288-charger: Add depends on IOSF_MBIO to Kconfig
      power: supply: axp288-charger: Remove unnecessary is_present and is_o=
nline helpers
      power: supply: axp288-charger: Simplify axp288_get_charger_health()
      power: supply: bq27xxx: Fix kernel crash on IRQ handler register error
      power: supply: bq25890: Fix race causing oops at boot
      power: supply: bq25890: Fix initial setting of the F_CONV_RATE field

Henrik Grimler (2):
      power: supply: max17042_battery: use VFSOC for capacity when no rsns
      power: supply: max17042_battery: fix typo in MAX17042_IAvg_empty

Jakob Hauser (1):
      power: supply: rt5033_battery: Change voltage values to =B5V

Kate Hsuan (1):
      power: supply: axp288-charger: Optimize register reading method

Krzysztof Kozlowski (4):
      power: supply: max17040: extend help/description
      power: supply: max17042: extend help/description
      MAINTAINERS: power: supply: max17042: add entry with reviewers
      MAINTAINERS: power: supply: max17040: add entry with reviewers

Linus Walleij (3):
      dt-bindings: power: Bindings for Samsung batteries
      dt-bindings: power: supply: ab8500: Standard monitored-battery
      power: supply: ab8500_bmdata: Use standard phandle

Martin Kepplinger (1):
      power: bq25890: add return values to error messages

Matthias Kaehlcke (1):
      power: supply: core: Add psy_has_property()

Sebastian Krzyszkowiak (2):
      power: supply: max17042_battery: Clear status bits in interrupt handl=
er
      power: supply: max17042_battery: Prevent int underflow in set_soc_thr=
eshold

Tang Bin (1):
      power: supply: cpcap-battery: use device_get_match_data() to simplify=
 code

Thomas Gleixner (1):
      power: reset: ltc2952: Use hrtimer_forward_now()

Wei Yongjun (1):
      power: supply: axp288_charger: Fix missing mutex_init()

Yang Yingliang (1):
      power: supply: max17040: fix null-ptr-deref in max17040_probe()

 Documentation/ABI/testing/sysfs-class-power        |  13 ++
 .../bindings/power/supply/maxim,max17040.yaml      |   2 +-
 .../bindings/power/supply/samsung,battery.yaml     |  56 +++++++
 .../power/supply/stericsson,ab8500-btemp.yaml      |  10 +-
 .../power/supply/stericsson,ab8500-chargalg.yaml   |  10 +-
 .../power/supply/stericsson,ab8500-charger.yaml    |  10 +-
 .../power/supply/stericsson,ab8500-fg.yaml         |  10 +-
 MAINTAINERS                                        |  21 +++
 drivers/power/reset/at91-reset.c                   |   4 +-
 drivers/power/reset/ltc2952-poweroff.c             |   4 +-
 drivers/power/supply/Kconfig                       |  23 +--
 drivers/power/supply/ab8500_bmdata.c               |   3 +-
 drivers/power/supply/axp288_charger.c              | 178 ++++++++++++-----=
----
 drivers/power/supply/bq25890_charger.c             |  65 ++++----
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/cpcap-battery.c               |  15 +-
 drivers/power/supply/max17040_battery.c            |   2 +
 drivers/power/supply/max17042_battery.c            |  14 +-
 drivers/power/supply/power_supply_core.c           |  65 ++++----
 drivers/power/supply/rt5033_battery.c              |   2 +-
 drivers/power/supply/wm831x_power.c                |  12 +-
 include/linux/power/max17042_battery.h             |   4 +-
 22 files changed, 335 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/samsung,=
battery.yaml

--szuc5cz5kprafwzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGEJncACgkQ2O7X88g7
+prNYA/9E8Vo3yPjGarCPhfoRHTXBqS4pXSAPTrwDGF/+oKxH5aTP596kyIwDVDy
vkzTfqULz4bUeT9EiA+Q3DgNVkMlUyTGCj4W85Z3rzMCzfgytyvnNy8QUPht3d+a
0aL90B09E/A7rL2S13906Mg4O+FgdVobh21A6eSQAOBgiev8fckE/RUdOQofZRZh
x1r00+pxeQzN+Dl2nebnjVcaaHAECoInl/Jasyi4lpn0l0kOKpF148hsiOsILwP0
EWISHFYer4ETHrKTH73i72VZVKK1X5K3XNlTRNHslHhteWFLG+y3DVs0SNWuw/Hz
LAqzHaG1RKowQtf9nlYPGs7E1ahsQVshWlVILCrGuUO4hM1qaFFZQmGv4GgfWUTc
TZ7s84dkuxVdENJPCmxC+/VCUqqTWNviv7a4QtSdDXDzIVYw/r/ZwcuvW+wLcACw
JFpDi+0VIBuHOAklEa3+DBnHO5+eprmexydrHFx/99r7ndvxBtoxZHQSNlq8DS5w
axj6YHsFayteKOkAb8/yCnBnJsxue3LRdBL7rCZVTkS3uvyU95dEy1GVjEKAF1GR
vymqCRwsL6MYcmKTLJB/dKB4h7s9xK77fydlKTEhHKfhUOXK1ey7dodOPnEOyPvg
WiEWVKh1rtXscDozmEHuwf3M5G3o9W6TzqqORrMNfRnqEilsQl0=
=WBON
-----END PGP SIGNATURE-----

--szuc5cz5kprafwzc--
