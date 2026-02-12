Return-Path: <linux-pm+bounces-42588-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJrZJnxbjmkjBwEAu9opvQ
	(envelope-from <linux-pm+bounces-42588-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:00:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A6131A0C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6913069AD2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B9334C3D;
	Thu, 12 Feb 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq3+0f8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BEE2E1C63;
	Thu, 12 Feb 2026 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937210; cv=none; b=luWtCFzzeaojfc6qdJLVMFVC2YUxhQvyq3MJMLZZftJtiU8wGQjWXes5aBeuAi3oVX8Pf9Uwxh4hGLQedHkwrt16FGTrh7Ehgqm3HEc2aOoqSwwSMeTDOA1r6vqOUwhTIlUHLNnprrZUn6Mtc94ny+tS0eV+/r5u4qgD4o9I+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937210; c=relaxed/simple;
	bh=H80wI9Iol6hYagPnYUKeVewDMz+uLshrjq8IuafrCME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kUlnfgMZnazyBx/XgyES5mfkL6ZX6lwwuC/k6MX82r1Ud3N4OGLoomUoL7WOp11TeUhVlyrI40bWWbrD5fEORPKpgH0QwtzZYYU4NU2TVxPPqZhbYsz9cha9Ehc5EuYQMyHf3CvIltYxSuoUZXeJy0Gf817cm5B1RePZzpA8LEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq3+0f8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A29BC4CEF7;
	Thu, 12 Feb 2026 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770937209;
	bh=H80wI9Iol6hYagPnYUKeVewDMz+uLshrjq8IuafrCME=;
	h=Date:From:To:Cc:Subject:From;
	b=rq3+0f8taWrWB5Jb4Y4GU4SoXsf0hAhC1L0sfQZ4ERcG/I1YWhxlRU5xMH6QH8PuF
	 LGgQMYO8YQi6IeTcOazTGBAcFJiSgLgei0rzsAC2D0nDlpP4W36LUk3HOcRguBnQna
	 pDvvhd1Erq4z7FE34IxiJ2HbNyotbLIfILzRTVFEJSRuStqzV6YSutuyzVrHe26Rma
	 s11TOErhFeoO9KfEr+OiFJHCtINgRrkALwEve/v7a7WbDRFuiP921DeZnCHe15+ExY
	 7IeyikjWZeiDkHc/gvPSlxHRLRUQWhN1PDvcSAOMxOuO3R4WnEAVfNpZ+/peMHfxbW
	 W3k+sSDmw7uag==
Received: by venus (Postfix, from userid 1000)
	id 9017F182491; Fri, 13 Feb 2026 00:00:07 +0100 (CET)
Date: Fri, 13 Feb 2026 00:00:07 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.0
Message-ID: <aY5Y09CgG1iUvWQZ@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4uasim2y4jvjyngb"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42588-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sre@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC9A6131A0C
X-Rspamd-Action: no action


--4uasim2y4jvjyngb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply changes for 7.0
MIME-Version: 1.0

Hello Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.0

for you to fetch changes up to 12bdf471e374b34cb0e48b29bb9eb9127ed26fc5:

  power: supply: bd71828: Use dev_err_probe() (2026-01-30 22:41:17 +0100)

----------------------------------------------------------------
power supply and reset changes for the 7.0 series

 * power-supply core
  - sysfs: Constify pointer passed to dev_attr_psp
  - extend DT binding documentation for battery cells to allow
    describing voltage drop behaviour
 * power-supply drivers
  - multiple: Remove unused gpio include header
  - multiple: Fix potential IRQ use-after-free on driver unload
  - bd71828: Add support for ROHM BD72720
  - misc. small fixes
 * reset drivers
  - tdx-ec-poweroff: fix restart

----------------------------------------------------------------
Alexander Koskovich (1):
      power: reset: nvmem-reboot-mode: respect cell size for nvmem_cell_write

Emanuele Ghidoli (1):
      power: reset: tdx-ec-poweroff: fix restart

Haotian Zhang (1):
      power: supply: bq27xxx: fix wrong errno when bus ops are unsupported

Julia Lawall (1):
      docs: power: update documentation about removed function

Krzysztof Kozlowski (1):
      power: supply: sysfs: Constify pointer passed to dev_attr_psp()

Kuan-Wei Chiu (1):
      dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER

Matti Vaittinen (18):
      dt-bindings: regulator: ROHM BD72720
      dt-bindings: battery: Clarify trickle-charge
      dt-bindings: battery: Add trickle-charge upper limit
      dt-bindings: battery: Voltage drop properties
      dt-bindings: mfd: ROHM BD72720
      dt-bindings: leds: bd72720: Add BD72720
      mfd: rohm-bd71828: Use regmap_reg_range()
      mfd: rohm-bd71828: Use standard file header format
      mfd: rohm-bd71828: Support ROHM BD72720
      regulator: bd71828: rename IC specific entities
      regulator: bd71828: Support ROHM BD72720
      gpio: Support ROHM BD72720 gpios
      clk: clk-bd718x7: Support BD72720 clk gate
      rtc: bd70528: Support BD72720 rtc
      power: supply: bd71828: Support wider register addresses
      power: supply: bd71828-power: Support ROHM BD72720
      MAINTAINERS: Add ROHM BD72720 PMIC
      power: supply: bd71828: Use dev_err_probe()

Randy Dunlap (1):
      power: supply: ab8500_chargalg: improve kernel-doc

Sebastian Reichel (1):
      Merge tag 'ib-mfd-clk-gpio-power-regulator-rtc-v6.20' into psy-next

Val Packett (1):
      power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer

Waqar Hameed (20):
      power: supply: bd99954: Remove unused gpio include header
      power: supply: bq256xx: Remove unused gpio include header
      power: supply: bq25980: Remove unused gpio include header
      power: supply: cw2015: Remove unused gpio include header
      power: supply: ucs1002: Remove unused gpio include header
      power: supply: ab8500: Fix use-after-free in power_supply_changed()
      power: supply: act8945a: Fix use-after-free in power_supply_changed()
      power: supply: bq256xx: Fix use-after-free in power_supply_changed()
      power: supply: bq25980: Fix use-after-free in power_supply_changed()
      power: supply: cpcap-battery: Fix use-after-free in power_supply_changed()
      power: supply: goldfish: Fix use-after-free in power_supply_changed()
      power: supply: pf1550: Fix use-after-free in power_supply_changed()
      power: supply: pm8916_bms_vm: Fix use-after-free in power_supply_changed()
      power: supply: pm8916_lbc: Fix use-after-free in power_supply_changed()
      power: supply: rt9455: Fix use-after-free in power_supply_changed()
      power: supply: sbs-battery: Fix use-after-free in power_supply_changed()
      power: supply: wm97xx: Fix NULL pointer dereference in power_supply_changed()
      power: supply: pm8916_lbc: Fix use-after-free for extcon in IRQ handler
      power: supply: wm97xx: Use devm_kcalloc()
      power: supply: wm97xx: Use devm_power_supply_register()

 .../devicetree/bindings/goldfish/battery.txt       |   17 -
 .../bindings/leds/rohm,bd71828-leds.yaml           |    7 +-
 .../devicetree/bindings/mfd/rohm,bd72720-pmic.yaml |  339 +++++++
 .../devicetree/bindings/power/supply/battery.yaml  |   33 +-
 .../power/supply/google,goldfish-battery.yaml      |   41 +
 .../bindings/regulator/rohm,bd72720-regulator.yaml |  148 +++
 Documentation/power/charger-manager.rst            |   12 +-
 MAINTAINERS                                        |    4 +-
 drivers/clk/Kconfig                                |    4 +-
 drivers/clk/clk-bd718x7.c                          |   10 +-
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bd72720.c                        |  281 ++++++
 drivers/mfd/Kconfig                                |   18 +-
 drivers/mfd/rohm-bd71828.c                         |  555 ++++++++++-
 drivers/power/reset/nvmem-reboot-mode.c            |   15 +-
 drivers/power/reset/tdx-ec-poweroff.c              |   19 +
 drivers/power/supply/ab8500_chargalg.c             |   15 +-
 drivers/power/supply/ab8500_charger.c              |   40 +-
 drivers/power/supply/act8945a_charger.c            |   16 +-
 drivers/power/supply/bd71828-power.c               |  161 ++-
 drivers/power/supply/bd99954-charger.c             |    1 -
 drivers/power/supply/bq256xx_charger.c             |   13 +-
 drivers/power/supply/bq25980_charger.c             |   13 +-
 drivers/power/supply/bq27xxx_battery.c             |    6 +-
 drivers/power/supply/cpcap-battery.c               |    8 +-
 drivers/power/supply/cw2015_battery.c              |    1 -
 drivers/power/supply/goldfish_battery.c            |   12 +-
 drivers/power/supply/pf1550-charger.c              |   32 +-
 drivers/power/supply/pm8916_bms_vm.c               |   18 +-
 drivers/power/supply/pm8916_lbc.c                  |   18 +-
 drivers/power/supply/power_supply_sysfs.c          |    6 +-
 drivers/power/supply/qcom_battmgr.c                |    3 +-
 drivers/power/supply/rt9455_charger.c              |   17 +-
 drivers/power/supply/sbs-battery.c                 |   36 +-
 drivers/power/supply/ucs1002_power.c               |    1 -
 drivers/power/supply/wm97xx_battery.c              |   40 +-
 drivers/regulator/Kconfig                          |    8 +-
 drivers/regulator/bd71828-regulator.c              | 1027 +++++++++++++++++++-
 drivers/rtc/Kconfig                                |    3 +-
 drivers/rtc/rtc-bd70528.c                          |   21 +-
 include/linux/mfd/rohm-bd72720.h                   |  634 ++++++++++++
 include/linux/mfd/rohm-generic.h                   |    1 +
 43 files changed, 3345 insertions(+), 319 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd72720.c
 create mode 100644 include/linux/mfd/rohm-bd72720.h

Greetings,

-- Sebastian

--4uasim2y4jvjyngb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmOW3EACgkQ2O7X88g7
+pqsCxAAnd4wcvgbvgN6aMESaY7nfFb8XyZvCYbOsaekGAJrlFU1v+Cpy0KGIMfC
RMoZiuSoQMBvuw6ikwW4JxxCzyI1/qTCRFuUTN21c+nEBmNLUEfFFsuo6s8SE4qq
KOV1l0/L6Yv6bCjZvSfUlDStkiZc2Xm5hqHVRp6mohGuoBSRoaS1gIYMhuVAYlqG
L9xO1BoPRsHxiq9j51lDt6uf3wkFhbvbgqDUe2KlehJzcey22Ph3fJrH9/MVIEj5
HuOnam2+BHmHFS0YmLtVveiVoZbBoYx4Zg9xU1Syx2xJWV/+I5kdJY6kNA4ovGc2
9syxtk49nLvBlx9Gl2KPjDGeMT/gvC05LFo4KHYtbaod+2OfOZeK4rjnwP1hUO9M
E6FFkqKTHl5cthYE1SiUrm12WWW1ATIt2/70LvfdqJFXx5ncHQhx9x8I2I7lltq9
a85kP2rRJdxf87Rc7fQXZufqht6Cq2nP0XhgZYjAroYuJqD5Tj9wD9fbPxaBZMyU
R+wkvPGDis/k7GiKaJDw925dmLcR+L0nDiTbXPnJtwpq6lBrHvUlFAhgjBI2lGM9
KJDXgyW8ktD52dhahd0sDRzTP5U5/jKL2dq4IZxYsS8X+fVHm8+4mllnLD+9AfZq
qkeRs19Thk+n6Kcv356rKbkcJ+YJ4AeemGyKsmKLtK+gSriWX3M=
=iLwe
-----END PGP SIGNATURE-----

--4uasim2y4jvjyngb--

