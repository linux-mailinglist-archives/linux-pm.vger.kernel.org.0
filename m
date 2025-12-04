Return-Path: <linux-pm+bounces-39221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE8CA593C
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 22:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 163113084A37
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAC2DAFAF;
	Thu,  4 Dec 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHcOltT6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43C2D1916;
	Thu,  4 Dec 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885501; cv=none; b=XqcGPEgm2z8v5ObukdT8gNhLmO7sKY3Bev1nfwdI18Tv+vuAJBuHQNy1FcBmWw+Y9LhkSz8vRGkJB6IoMUksSbCjJNIHUY7c667Q9X7bhQVJ5VYBglXPSmSMe2YoThzmNSEwzkI1Y7IJBgCI8WQCdW0depQFX5Z2SlysFPCnBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885501; c=relaxed/simple;
	bh=gfs6rAjwYWaIUTgv8HxrK+FjEtpB5r8ybGFamMTRmUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sQp11KtmMwOXSxpMzs3jTw4Oc73y0b0VP7y0B7U4favkR5eXLsYWWNfCW02aeEwHKZ3f+4zKBq9eHbYi5jtUc2A2E8V8uov6syKt9um7XZST5SZNOSIOZN9xsbow9dcdSgXda8/1kXqsJMaacidi0KkAgTIJJ1I306QEOMSOU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHcOltT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7D8C4CEFB;
	Thu,  4 Dec 2025 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764885500;
	bh=gfs6rAjwYWaIUTgv8HxrK+FjEtpB5r8ybGFamMTRmUY=;
	h=Date:From:To:Cc:Subject:From;
	b=CHcOltT6+W5RNtfPK0kcXL3GybDcI02os14PUrVoa2eymOp2/8FNdMzEfFk5q+C1Y
	 W/zidFfctmiywY+gzS44OraJIOEUqVqaxmy7QDXKtMfi8MWxBRJdoF+sacif2uyEfM
	 MdVljR4aPdnczpC9HMG5gP9sBzB+eNf90b307XCZMivS5mzYzegO9yhzSDvw7qeQna
	 y8xX9K9ympm9TCmnOiAkWAWvXNvY2lyN6J3lKnlWxbhW7ohrEA2NYDk5fXXvGGA4n+
	 o/j4JWcq+m+9tg5ZtzN5rhDH3iD0+Mp3axb6q4uxZLT5ABrx7mDZjuuk7dBrPjCMDu
	 u2GnbKh1YnBew==
Received: by venus (Postfix, from userid 1000)
	id C7DD1184BEE; Thu, 04 Dec 2025 22:58:18 +0100 (CET)
Date: Thu, 4 Dec 2025 22:58:18 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.19
Message-ID: <rxziuamy4owgazy3oqvawwyxyih4fylzg7jselbubo666ofhid@orwemcdl2bx5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htkcijv6gdbhafx6"
Content-Disposition: inline


--htkcijv6gdbhafx6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.19
MIME-Version: 1.0

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.19

for you to fetch changes up to 8e8856396b54bea5c00a7ae88d87c6254aef2d94:

  Revert "power: supply: qcom_battmgr: support disabling charge control" (2=
025-11-03 15:32:47 +0100)

This pull request will conflict with your branch due to 'power:
supply: use ktime_divns() to avoid 64-bit division' as you added
your own fix. I expect you do the same as Stephen Rothwell [0] and
drop the patch I queued in favour of your own.

[0] https://lore.kernel.org/linux-next/20251127113054.5112674d@canb.auug.or=
g.au/

Greetings and have a good trip to Tokyo,

-- Sebastian

----------------------------------------------------------------
power supply and reset changes for the 6.19 series

 * power-supply core
  - documentation fixes
 * power-supply drivers
  - add BD71828 charger driver
  - add Richtek RT9756 driver
  - max77705: add adaptive input current support
  - max77705: add support for multiple devices
  - misc. small fixes
 * reset drivers
  - add spacemit-p1 poweroff/reboot driver

----------------------------------------------------------------
Ahelenia Ziemia=C5=84ska (1):
      power: supply: apm_power: only unset own apm_get_power_status

Andreas Kemnade (2):
      power: supply: Add bd718(15/28/78) charger driver
      MAINTAINERS: Add entry for BD71828 charger

Aurelien Jarno (1):
      driver: reset: spacemit-p1: add driver for poweroff/reboot

ChiYuan Huang (3):
      dt-bindings: power: supply: Add Richtek RT9756 smart cap divider char=
ger
      power: supply: rt9756: Add Richtek RT9756 smart cap divider charger
      Documentation: power: rt9756: Document exported sysfs entries

Dzmitry Sankouski (1):
      power: supply: max77705_charger: implement aicl feature

Haotian Zhang (1):
      power: supply: rt5033_charger: Fix device node reference leaks

Ivan Abramov (4):
      power: supply: cw2015: Check devm_delayed_work_autocancel() return co=
de
      power: supply: max17040: Check iio_read_channel_processed() return co=
de
      power: supply: rt9467: Return error on failure in rt9467_set_value_fr=
om_ranges()
      power: supply: wm831x: Check wm831x_set_bits() return value

Krzysztof Kozlowski (1):
      power: supply: max77705: Fix potential IRQ chip conflict when probing=
 two devices

Michal Kubecek (1):
      power: supply: use ktime_divns() to avoid 64-bit division

Murad Masimov (1):
      power: supply: rt9467: Prevent using uninitialized local variable in =
rt9467_set_value_from_ranges()

Randy Dunlap (1):
      docs: power: clean up power_supply_class.rst

Sebastian Reichel (1):
      Revert "power: supply: qcom_battmgr: support disabling charge control"

Val Packett (2):
      power: supply: qcom_battmgr: clamp charge control thresholds
      power: supply: qcom_battmgr: support disabling charge control

 Documentation/ABI/testing/sysfs-class-power-rt9756 |   30 +
 .../bindings/power/supply/richtek,rt9756.yaml      |   72 ++
 Documentation/power/power_supply_class.rst         |   84 +-
 MAINTAINERS                                        |    6 +
 drivers/power/reset/Kconfig                        |    9 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/spacemit-p1-reboot.c           |   88 ++
 drivers/power/supply/Kconfig                       |   24 +
 drivers/power/supply/Makefile                      |    2 +
 drivers/power/supply/apm_power.c                   |    3 +-
 drivers/power/supply/bd71828-power.c               | 1049 ++++++++++++++++=
++++
 drivers/power/supply/cw2015_battery.c              |    8 +-
 drivers/power/supply/intel_dc_ti_battery.c         |    4 +-
 drivers/power/supply/max17040_battery.c            |    6 +-
 drivers/power/supply/max77705_charger.c            |   56 +-
 drivers/power/supply/qcom_battmgr.c                |   14 +-
 drivers/power/supply/rt5033_charger.c              |    2 +
 drivers/power/supply/rt9467-charger.c              |    6 +-
 drivers/power/supply/rt9756.c                      |  955 ++++++++++++++++=
++
 drivers/power/supply/wm831x_power.c                |   10 +-
 include/linux/power/max77705_charger.h             |    2 +
 21 files changed, 2365 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,=
rt9756.yaml
 create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
 create mode 100644 drivers/power/supply/bd71828-power.c
 create mode 100644 drivers/power/supply/rt9756.c

--htkcijv6gdbhafx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkyA/oACgkQ2O7X88g7
+prA+RAAnjczSvAUunnuaEN9cCUKyPzTUbQceoxifvfiO00FM97++90MYoPnZo6k
WMdb7oxs/j/1HgDZWGAFdFhHpMki2zBIKxMeZxqEGzRwXsCYbTYuX6mKKrn5oHpB
m2r4K8wsHraNLXaRP+fdVw32xxIuSGA3bRzqu/gQjeVT3zbrLGwzKVV1Qv6NsJ9c
+acRPfcBjl/CBc7M3hgn5ZzfGSVDZEWaGDhBhdF8IULf+4BOvaDuYzuntCXdBJN9
94XWmmfbVWmaeSr/2aMgiq7mPSCHOwmaBLJq83oTR51KkRL9Yz2jSlrKAsgtojBL
2Tqg3XVmz8LtECzdv7KcoxD2xG8j3jIXBmevQAXbOBwgdB/vxs67a+trDvGneN0C
ltzzh5rwLemwRlqY5cLUQK2R18r5Ein/v9QtDhhQ2YrIjUdxoQ1nIMXCUhjoIv8o
mZx6PZlUNb2EDi619F6TO+g6BIXQTojdOEL3FwhJKQM6iCUzhz5IFF/9cR79MgKW
/fPH+xwSuyO7w0zp90s76nHsEkl6rpguZd9fnMvsB+2n74mDdYz28tk7S0GsMOaQ
TmPtbD696Kjyspg9KzcP/IymhOsNOcAUsTEmXZO3hYiLxulsz/GEm1SCae6Jluz9
LE9M514UnuxqHmMxKxF/lANtR3bNuXBQoRN1talZ1JFOGaC2mUk=
=J8Yd
-----END PGP SIGNATURE-----

--htkcijv6gdbhafx6--

