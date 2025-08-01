Return-Path: <linux-pm+bounces-31716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE5B17AAF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 03:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04651AA534D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF61E50E;
	Fri,  1 Aug 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbEPdPsB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0D2E3716;
	Fri,  1 Aug 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010067; cv=none; b=WY0ObGxvzKk1TA1UHHMD6glEWqQ/GduhIx0ocdGJUnB5Q40TEBOV2PUQJej9HAV92iwIBoUy8iBqFs3+RU/ppYNHtL1MUEv3YSJhQAnpE233WGdTa0dHtc6/uE5T1S0yAMiKbM+vtvDpKc+EwlPFqlXxoah4n8SEbmtbP+jmtM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010067; c=relaxed/simple;
	bh=dT4ConVyfMXiyNgz06cCu0+BF4hquV7M7ru6+Ki8MRE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2lOaSd3qpfx5C/sYXd+lnsFXBjgvnxeyWerULhDep62EATgf35+k4zwFRNQ11n+dBkMyd9RF9m+ZdGYWYmmeOsK/oOkATRB2io0IrppZP3wNxaIU/ketitXQS1GiDeCasSAMQIYyMg0lOLOMUFliB4xilBYpbkRhWhDnrYP0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbEPdPsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB51FC4CEEF;
	Fri,  1 Aug 2025 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754010067;
	bh=dT4ConVyfMXiyNgz06cCu0+BF4hquV7M7ru6+Ki8MRE=;
	h=Date:From:To:Cc:Subject:From;
	b=QbEPdPsBIcJ6wSdQBpDV+Vb/mnxmOvE2/XiAoQRPxtqLfBP7o7LB5GH7qjbSczuxR
	 USu+0WX3rSAz/B2COjY+aQAvTy8lUDAKs1iTb2OklRTuyRns24KHVLEp540kH8wKN1
	 J6orDa+tfQaLxy3dIp1WNG6KKO++u0vpiCzR8tlCMxZXsRlleanD4JnvZojUfaB8lP
	 cXp6ESqAlpFJym3QBrEjrTgtzF2EiYT+txgqfNMi6sO495fpaXznrVwPsHvdtZddea
	 0L/cgy1vqoN6+iGgymcftWiIcLoIMvc/8iZezPdeKfun59cNntoTwCvJsKGTp/Ci/s
	 E5Wcvc0oZu0rg==
Received: by venus (Postfix, from userid 1000)
	id C95931808A7; Fri, 01 Aug 2025 03:01:04 +0200 (CEST)
Date: Fri, 1 Aug 2025 03:01:04 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.17
Message-ID: <ipmplcihen5gpch4qg2rixwmdoad23w4d5qtdchcv24qx2mkrj@5bsvfer4a5lw>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dexs6ivb4h2aauqo"
Content-Disposition: inline


--dexs6ivb4h2aauqo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.17
MIME-Version: 1.0

Hi Linus,

Some more power-supply core changes flow through the platform tree,
which needed some improvements in the power-supply extension API. No
merge conflicts have been found in linux-next and everything from my
tree has been in there for at least 3 weeks.

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.17

for you to fetch changes up to 7b41a2341fa62babda5d5c7a32c632e9eba2ee11:

  power: supply: core: fix static checker warning (2025-07-12 20:45:17 +020=
0)

----------------------------------------------------------------
power supply and reset changes for the 6.17 series

 * power-supply core
  - battery-info: replace any DT specific bits with fwnode usage
  - replace any device-tree code with generic fwnode based handling
 * power-supply drivers
  - ug3105_battery: use battery-info API
  - qcom_battmgr: report capacity
  - qcom_battmgr: support LiPo battery reporting
  - add missing missing power-supply ref to a bunch of DT bindings
  - update drivers regarding pm_runtime_autosuspend() usage
  - misc. minor fixes and cleanups
 * reset drivers
  - misc. minor cleanups

----------------------------------------------------------------
Abel Vesa (1):
      power: supply: qcom_battmgr: Add lithium-polymer entry

Casey Connolly (3):
      power: supply: qcom_pmi8998_charger: fix wakeirq
      power: supply: pmi8998_charger: rename to qcom_smbx
      MAINTAINERS: add myself as smbx charger driver maintainer

Charles Han (2):
      power: supply: cpcap-charger: Fix null check for power_supply_get_by_=
name
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Geert Uytterhoeven (1):
      power: reset: POWER_RESET_TORADEX_EC should depend on ARCH_MXC

Hans de Goede (3):
      power: supply: ug3105_battery: Use psy->battery_info
      power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv2cap=
()
      power: supply: bq24190: Free battery_info

Kornel Dul=C4=99ba (1):
      power: supply: qcom_battmgr: Report battery capacity

Krzysztof Kozlowski (8):
      dt-bindings: power: supply: bq2515x: Add missing power-supply ref
      dt-bindings: power: supply: bq256xx: Add missing power-supply ref
      dt-bindings: power: supply: qcom,pmi8998: Add missing power-supply ref
      dt-bindings: power: supply: richtek,rt5033: Add missing power-supply =
ref
      dt-bindings: power: supply: summit,smb347: Add missing power-supply r=
ef
      dt-bindings: power: supply: Drop redundant monitored-battery ref
      power: supply: bq256xx_charger: Constify reg_default array
      power: supply: bq25980_charger: Constify reg_default array

Lukas Bulwahn (1):
      MAINTAINERS: rectify file entry in QUALCOMM SMB CHARGER DRIVER

Mihai Sain (1):
      power: reset: at91-sama5d2_shdwc: Refactor wake-up source logging to =
use dev_info

Sakari Ailus (8):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      power: supply: bq24190: Remove redundant pm_runtime_mark_last_busy() =
calls
      power: supply: twl4030_charger: Remove redundant pm_runtime_mark_last=
_busy() calls

Sebastian Reichel (8):
      regulator: act8865-regulator: switch psy_cfg from of_node to fwnode
      Merge tag 'ib-regulator-psy-for-v6.17-signed' into psy-next
      power: supply: core: remove of_node from power_supply_config
      power: supply: core: battery-info: fully switch to fwnode
      power: supply: core: convert to fwnnode
      power: supply: core: rename power_supply_get_by_phandle to power_supp=
ly_get_by_reference
      Merge tag 'pm-runtime-6.17-rc1'
      power: supply: core: fix static checker warning

Taeyoung Kwon (1):
      power: reset: qcom-pon: Rename variables to use generic naming

Thomas Antoine (1):
      power: supply: max1720x correct capacity computation

Yuanjun Gong (1):
      power: return the correct error code

 .../devicetree/bindings/power/supply/bq24190.yaml  |   1 -
 .../devicetree/bindings/power/supply/bq2515x.yaml  |   7 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   5 +-
 .../devicetree/bindings/power/supply/bq25980.yaml  |   4 +-
 .../bindings/power/supply/cw2015_battery.yaml      |   5 +-
 .../power/supply/qcom,pmi8998-charger.yaml         |   7 +-
 .../power/supply/richtek,rt5033-charger.yaml       |   4 +-
 .../power/supply/stericsson,ab8500-btemp.yaml      |   4 +-
 .../power/supply/stericsson,ab8500-chargalg.yaml   |   4 +-
 .../power/supply/stericsson,ab8500-charger.yaml    |   4 +-
 .../power/supply/stericsson,ab8500-fg.yaml         |   4 +-
 .../power/supply/summit,smb347-charger.yaml        |   5 +-
 .../x-powers,axp20x-battery-power-supply.yaml      |   6 +-
 Documentation/power/runtime_pm.rst                 |  50 +++---
 MAINTAINERS                                        |   7 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   2 +-
 drivers/power/reset/Kconfig                        |   1 +
 drivers/power/reset/at91-sama5d2_shdwc.c           |   2 +-
 drivers/power/reset/qcom-pon.c                     |  30 ++--
 drivers/power/supply/Makefile                      |   2 +-
 drivers/power/supply/bq2415x_charger.c             |   2 +-
 drivers/power/supply/bq24190_charger.c             |  16 +-
 drivers/power/supply/bq256xx_charger.c             |   6 +-
 drivers/power/supply/bq25980_charger.c             |   6 +-
 drivers/power/supply/cpcap-charger.c               |   5 +-
 drivers/power/supply/max14577_charger.c            |   4 +-
 drivers/power/supply/max1720x_battery.c            |  13 +-
 drivers/power/supply/power_supply_core.c           | 185 ++++++++++-------=
---
 drivers/power/supply/qcom_battmgr.c                |  25 +++
 .../supply/{qcom_pmi8998_charger.c =3D> qcom_smbx.c} | 152 ++++++++-------=
--
 drivers/power/supply/twl4030_charger.c             |   1 -
 drivers/power/supply/ug3105_battery.c              |  81 ++-------
 drivers/regulator/act8865-regulator.c              |   2 +-
 include/linux/pm_runtime.h                         | 187 +++++++++++++++++=
+---
 include/linux/power_supply.h                       |  16 +-
 35 files changed, 471 insertions(+), 384 deletions(-)
 rename drivers/power/supply/{qcom_pmi8998_charger.c =3D> qcom_smbx.c} (88%)

--dexs6ivb4h2aauqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmiMEdAACgkQ2O7X88g7
+posMRAAoIwWul24K3RD+OEqKJtolUOho00ea7isvn/QyRm07ZonHnAWd3Ns57k8
mB1koV5W3hnCTgyyLP5bpVzZN2QgZMWZSzJBuJwN8WGu+yRjoJX2+naY/tuqWYFV
MrWbo0OAjInPVn+XwykC/zsUWE+9+dk7IKsZ7fxrlbxg6Y1pB8soxwytG28AhoNW
IJoXD+DIanxVr/GmhEY5kytevnTFCfG9NZwBLFNXTqZ9/rVWrEpQP5nmS6Lu/ts+
RbR2Zb8gFcl3A4h2Waa0logmbYH++gTAH8Y1R4X9DBWXNPTEaE3wO4in7+CSxRxm
GfIapD3KJeHftSeiAJZhayP4QesObID+sQXL6mcXPSkZxuEsTPqUSNFAW58WIDdM
tJRX0iCaUtg++8DS+Tf0Ymqg6MAlsuU4qcJ2xZ5BzV6b3fU07p0ERPwbktoblFZS
h5OC+vTciz5fw6swuM+fvdRWX+ZJRgfF22aGhJAP0r2Ja0A+OmycixaGqvgJDBaX
jwMn8CIfVJHfW3slvlkG1iFBuhHoeniOCAWF/hSTFpYKTkOngF2hCopjlFapsCsZ
6QRiqhE024J0xHtYMwVc/ZwHFAAVf/U0VkPOXJPRZ3iwg/yhT5LLw9EsUYCsXClu
V12mWzXs4tTrhVvcYFEgRn2pN0IrTvAUujoITOkG1+rc/Z6lB4o=
=cvqM
-----END PGP SIGNATURE-----

--dexs6ivb4h2aauqo--

