Return-Path: <linux-pm+bounces-14316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F09798BC
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D46E1F223DD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF147F46;
	Sun, 15 Sep 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCS/mjQf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45A2F855;
	Sun, 15 Sep 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432866; cv=none; b=PRHPf5tr6zLmnZldjotiH04OPA6yUDvpF3peARH7HSxqWRd6FfIqCCe6pK3TZx5cAc2sth8b8soBSqdAREXTlmEQJv6nqjqr++CTizhKdwjvhz2hk0AigOWIW3lxvZBigPwah3eSCW4aX1XtI1NYZrt2vR+4rkIXJGk4HclkeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432866; c=relaxed/simple;
	bh=qAhUw/C5p73M8nKgqGRDmurmz93DCyvEkK15cfvXW84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=peaI79F3/VLuQtcbuDR2xr/QJMKI/H7jTgOyPcRZrHqUe/Q2k0kIvQfH00Uf6HbKOqCEcyARhxYwKw1HvidgM2PtWSH81cCFmQdtmNfYfD0Nejjj95bjHxPxeeW1sgRw1XqQ4bwa3dXDH8VcgIoxZ1vhaLCFB2wA7Ia4dUpOWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCS/mjQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1CDC4CEC3;
	Sun, 15 Sep 2024 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726432865;
	bh=qAhUw/C5p73M8nKgqGRDmurmz93DCyvEkK15cfvXW84=;
	h=Date:From:To:Cc:Subject:From;
	b=fCS/mjQfzHQXunxuPB12gTNGLZrXII9ZXuz2eoc4JygvM0OsFVNAeNd6k8fwI09Od
	 OqDM3mRTF0jmahy3M4Xy+l2i+M63MTuYt7sinYI7d+0cIEZAL9L/6r6hql1KOL2ECI
	 exppzsU3RtMmkwHej5UCrA56UxKuVtY8EoNZuaod7F5xovodLgXxboHAqL3FTkKobK
	 MU7/2ijuBrA1dE2Chez0VF0nHGDIYi7Z4GvB5X8msDa3GWaoiO9zl33boGDYb0g4gi
	 RT0w2Kr4WkQgmKnw6soNeYSGlWhjKdnK+YEft2tju+aqJ8gYbsb223XU572B+mpSnW
	 eQqcM3eVA3TZA==
Received: by mercury (Postfix, from userid 1000)
	id C4F4E1060578; Sun, 15 Sep 2024 22:41:02 +0200 (CEST)
Date: Sun, 15 Sep 2024 22:41:02 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.12
Message-ID: <yzvnkktljfia7cuatut6nzbgt3rl2sxrewxfvufs3bffipqru7@owejanrgjppt>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5iyho5naygwzboo"
Content-Disposition: inline


--v5iyho5naygwzboo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Lot's of small things this time. The pull contains two merges of
immutable branches, one for the AXP717 support, which is shared
with MFD and one for the usb_types change, which is shared with
extcon to fix up a newly introduced driver using usb_types (also
touching a couple of other subsystems). Everything but the last
two commits have been in linux-next for at least 10 days. I only
pushed the last two commits some minutes ago. Those two are fixes
originally intended for 6.11. I received them a few days ago and
gave them some testing while travelling to Vienna. I independently
received a second patch fixing the issue, so it should be fixed
soon and I will be on vacation with limited network access for 3
weeks after LPC. Thus I think its better to have them included now
even though they received limited testing.

Greetings,

-- Sebastian


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.12

for you to fetch changes up to e50a57d16f897e45de1112eb6478577b197fab52:

  power: supply: hwmon: Fix missing temp1_max_alarm attribute (2024-09-14 1=
1:06:07 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.12 series

 * power-supply core
   - introduce power_supply_show_enum_with_available() helper
   - change usb_types from an array into a bitmask
   - fix early usage of power_supply_property_is_writeable() resulting
     in sysfs files not being writable
   - fix missing temp1_max_alarm attribute in power-supply's hwmon devices
 * drivers
   - max1720x: expose nvmem device
   - brcmstb: cleanup driver to use latest APIs
   - max77693: expose input and charging current limit
   - max17042_battery: fix state of charge reading for devices without
     current sensing
   - axp20x_battery: add AXP717 support
   - axp20x_battery: fix min/max voltage properties
   - axp20x_usb_power: add AXP717 support
   - axp20x_usb_power: add DT based input current limit
 * Documentation updates
 * misc. minor cleanups and fixes

----------------------------------------------------------------
Andres Salomon (1):
      ABI: testing: sysfs-class-power: clarify charge_type documentation

Andrew Davis (5):
      power: reset: brcmstb: Use normal driver register function
      power: reset: brcmstb: Use device_get_match_data() for matching
      power: reset: brcmstb: Use syscon_regmap_lookup_by_phandle_args() hel=
per
      power: reset: brcmstb: Use devm_register_sys_off_handler()
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Artur Weber (2):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current=
 sense
      power: supply: max77693: Expose input current limit and CC current pr=
operties

Asmaa Mnebhi (1):
      power: reset: pwr-mlxbf: support graceful shutdown

Chen Ni (1):
      power: supply: cpcap-charger: Convert comma to semicolon

Chris Morgan (11):
      power: supply: axp20x_battery: Remove design from min and max voltage
      power: supply: axp20x_battery: Make iio and battery config per device
      power: supply: axp20x_usb_power: Make VBUS and IIO config per device
      dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
      power: supply: axp20x_usb_power: add input-current-limit-microamp
      dt-bindings: power: supply: axp20x-battery: Add monitored-battery
      mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
      dt-bindings: power: supply: axp20x: Add AXP717 compatible
      dt-bindings: power: supply: axp20x: Add AXP717 compatible
      power: supply: axp20x_usb_power: Add support for AXP717
      power: supply: axp20x_battery: add support for AXP717

Colin Ian King (1):
      power: supply: axp20x_usb_power: Fix spelling mistake "reqested" -> "=
requested"

Dan Carpenter (1):
      power: supply: max1720x: fix a double free on error in probe()

Dimitri Fedrau (1):
      power: supply: max1720x: add read support for nvmem

Hans de Goede (8):
      power: supply: "usb_type" property may be written to
      power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept strin=
g values
      power: supply: rt9467-charger: Remove "usb_type" property write suppo=
rt
      power: supply: sysfs: Add power_supply_show_enum_with_available() hel=
per
      power: supply: sysfs: Move power_supply_show_enum_with_available() up
      power: supply: Change usb_types from an array into a bitmask
      power: supply: Drop use_cnt check from power_supply_property_is_write=
able()
      power: supply: hwmon: Fix missing temp1_max_alarm attribute

Hongbo Li (1):
      power: supply: ab8500: Constify struct kobj_type

Jinjie Ruan (1):
      power: supply: max8998_charger: Fix module autoloading

Krzysztof Kozlowski (2):
      power: supply: core: simplify with cleanup.h
      power: supply: twl4030_charger: correct comparision with old current

Sebastian Reichel (2):
      Merge tag 'ib-psy-usb-types-signed' into psy-next
      Merge tag 'tags/ib-mfd-for-iio-power-v6.12' into psy-next

Stanislav Jakubek (1):
      dt-bindings: power: supply: sc27xx-fg: add low voltage alarm IRQ

Thomas Wei=DFschuh (1):
      power: supply: core: constify psy_tzd_ops

 Documentation/ABI/testing/sysfs-class-power        |  45 +-
 .../bindings/power/supply/sc27xx-fg.yaml           |   6 +
 .../x-powers,axp20x-battery-power-supply.yaml      |   7 +
 .../supply/x-powers,axp20x-usb-power-supply.yaml   |  72 ++-
 drivers/extcon/extcon-intel-cht-wc.c               |  15 +-
 drivers/mfd/axp20x.c                               |  25 +-
 drivers/phy/ti/phy-tusb1210.c                      |  11 +-
 drivers/power/reset/brcmstb-reboot.c               |  59 +-
 drivers/power/reset/pwr-mlxbf.c                    |  16 +-
 drivers/power/supply/ab8500_fg.c                   |   2 +-
 drivers/power/supply/axp20x_battery.c              | 591 +++++++++++++++++=
++--
 drivers/power/supply/axp20x_usb_power.c            | 368 +++++++++++--
 drivers/power/supply/bq256xx_charger.c             |  15 +-
 drivers/power/supply/cpcap-charger.c               |   2 +-
 drivers/power/supply/cros_usbpd-charger.c          |  22 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c    |   7 +-
 drivers/power/supply/max17042_battery.c            |   5 +-
 drivers/power/supply/max1720x_battery.c            | 209 +++++++-
 drivers/power/supply/max77693_charger.c            |  52 ++
 drivers/power/supply/max8998_charger.c             |   1 +
 drivers/power/supply/mp2629_charger.c              |  15 +-
 drivers/power/supply/mt6360_charger.c              |  13 +-
 drivers/power/supply/mt6370-charger.c              |  13 +-
 drivers/power/supply/power_supply_core.c           |  19 +-
 drivers/power/supply/power_supply_hwmon.c          |   3 +-
 drivers/power/supply/power_supply_sysfs.c          |  66 +--
 drivers/power/supply/qcom_battmgr.c                |  37 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |  13 +-
 drivers/power/supply/rk817_charger.c               |   9 +-
 drivers/power/supply/rn5t618_power.c               |  13 +-
 drivers/power/supply/rt9467-charger.c              |  16 +-
 drivers/power/supply/rt9471.c                      |  15 +-
 drivers/power/supply/twl4030_charger.c             |   2 +-
 drivers/power/supply/ucs1002_power.c               |  26 +-
 drivers/usb/typec/anx7411.c                        |  11 +-
 drivers/usb/typec/rt1719.c                         |  11 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  11 +-
 drivers/usb/typec/tipd/core.c                      |   9 +-
 drivers/usb/typec/ucsi/psy.c                       |  11 +-
 include/linux/mfd/axp20x.h                         |  26 +
 include/linux/mfd/max77693-private.h               |   5 +
 include/linux/power_supply.h                       |   3 +-
 42 files changed, 1435 insertions(+), 442 deletions(-)

--v5iyho5naygwzboo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbnRl4ACgkQ2O7X88g7
+powXg//Vf3fVIDf/G1bKemg7VNryDRxdlWp4Wv4He/odZESQvm71eedHrNTfHjH
ySIVAPJbCIYcfpJVrNpJ08hGYkmO4MYAsG0faRtW9tL2dhnyQrcan1A9TS9RDvJl
zaltwAOs118aNpZSNEWqT2iC8FJ/Sh/UK7NQORKn/tNx7/BkrA+w/LIY1iOj3LCq
3jjowsy4U0Ha2K/az6MfrBFQlOuX3McrTpDSljb2zitlNTRhh3pAmdCwc4ts0jp3
XFaIoZLv+dVBkEvCmkAcPG1gTTMpVe9hzZw4Wj2ZeRy+Yt7T0gQeD7ii7zkwcMbz
fTe03KIRzlehdSj2qpzfml4wkwb9mOJiKqvgNTx5fs9vqXybY3Jk13T1uvCVwVwR
5lTZpCZQXIS0xnz3EVLUs2lJWPesjKtjk88mbLkUDa3Xms8Z0S1f26dto6bGo35M
6Sxj+RZ3ZHHVkvWdd05bed29seaTaJ8r1qp0Wu9K1JTZll+w+yq0jvIo0K1B5he8
5fvruXT7M609a7Emb7n5HafxmN8pJJ47EtZlYGXgmbHNVzOlxz8e6Z09MG14dOof
FlBoq4K1CoM5cECdqoDKFSxFH/2DFYJHg0Qnk4s09ESVveeSKv3ddCQKvEqKgqdU
0nuoaljyc2y51A1NI7oflR+1caiCTaycV2eQo+Vlz3pudae/+RI=
=QAp9
-----END PGP SIGNATURE-----

--v5iyho5naygwzboo--

