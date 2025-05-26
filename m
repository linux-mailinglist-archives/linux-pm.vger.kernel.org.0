Return-Path: <linux-pm+bounces-27658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC595AC3EB5
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7121620F7
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D51F2388;
	Mon, 26 May 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9qY6bzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B761D2F42;
	Mon, 26 May 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259678; cv=none; b=ugqO8CUn1RfX1OZNAIb1y9n5Zq7Vafj1Zdwkj7UgfftqSlKU+DzHtqEC1YjDrBO1lnNGE2EvdpOMNaeyY8bwaiaulgIfCea44KfF1Tim+fRq7OyFpkJrVrjco7n2zOq1V9ZxjT3Yvt5AIkACwLnTrBGTBgp6wLt5/shCmQqClHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259678; c=relaxed/simple;
	bh=9i7MvmICkgbd+ZJq3VnyeJ/DAjkLW/+jSZJbWWJ/Ys0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ICwKSlVuYbP+8C1+SKzC3KdgEtuhdkrZoO47+Zgf3JQj1F75Xo/0ivNmIjDpKyV08MuJtmLuRJnOsJGgyXpOJ+iuAz/0I96Eu9pypsKEC24QTFlKB4xHQWXye5NYtIzRoUfUdtMag/K2mgfrwQ5y7pUG5QE4SK6WTIyUVk2Luk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9qY6bzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D0BC4CEE7;
	Mon, 26 May 2025 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748259677;
	bh=9i7MvmICkgbd+ZJq3VnyeJ/DAjkLW/+jSZJbWWJ/Ys0=;
	h=Date:From:To:Cc:Subject:From;
	b=k9qY6bzMX66E9wsJ/VIrVqmBc5yOzokjcsYCFRkLlBdLA+D8HbIJIB3GBibkTIaft
	 sYrqOwfP1OQPyQxvyn3hUjdsFd+CoNbDYOaxcbaoECxh4cF3cPg8V4dt9DJz8WQ7Ex
	 C5vypp1GhiAM/xDqp1ETK4v7b/0AP0GhU6+XllHFGUOx6Y5Sj4BXAiqmbHF26ehLTy
	 dRuI4yUJBmHpgr59gBONdmEeVNPt+hKaoJqfJe1nY7NgV664HDUDJS6jYTdAevSzCL
	 n162ii/tNQb7AdxzFcGA9mhQO4Gogqk/iSn+RC9s5bXe8Hc4zfkMJ1KU5FGePmCQzU
	 Ts5DFRDifhYaw==
Received: by venus (Postfix, from userid 1000)
	id C6CA01805BA; Mon, 26 May 2025 13:41:14 +0200 (CEST)
Date: Mon, 26 May 2025 13:41:14 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.16
Message-ID: <qhvmgti6jmqnepwx2fbhgsflclznw7hnjco5xebytwxuh2mf5g@m33klrxrhaew>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3kinmntwcc6dqdm"
Content-Disposition: inline


--o3kinmntwcc6dqdm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] power-supply changes for 6.16
MIME-Version: 1.0

Hi Linus,

Everything has been in linux-next for 3 weeks, so I don't expect
any issues. Some additional power-supply patches are flowing through
the platform tree this time as they are used by x86 laptops. Stephen
Rothwell reported a trivial merge conflict in the MAINTAINERS file
between the USB and my tree:                                               =
       =20
                                                                           =
 =20
https://lore.kernel.org/linux-next/20250501161515.21916747@canb.auug.org.au=
/   =20
=20
Last but not least: I will be on a 3 week trekking trip without my         =
  =20
laptop starting today, so if (unexpectedly) something urgent pops          =
            =20
up don't expect any response from me.
                                                                          =
=20
Greetings,

-- Sebastian

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.16

for you to fetch changes up to b1d8766052eb0534b27edda8af1865d53621bd6a:

  power: supply: rt9471: Simplify definition of some struct linear_range (2=
025-05-03 19:17:02 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.16 series

 * power-supply core
  - power: supply: support charge_types in extensions
 * power-supply drivers
  - new driver for Pegatron Chagall battery
  - new driver for Maxim MAX8971 charger
  - new driver for Huawei Matebook E Go
  - bq27xxx: retry failed I2C transmissions
  - bq24190: add BQ24193 support
  - misc. small cleanups and fixes
 * reset drivers
  - new driver for Toradex SMARC Embedded Controller
  - reboot-mode: add support for modes containing / in DT
  - atmel,at91sam9260-reset: support sama7d65
  - syscon-reboot: add Google GS101 support
  - misc. small cleanups and fixes

----------------------------------------------------------------
Aaron Kling (2):
      dt-bindings: power: supply: bq24190: Add BQ24193 compatible
      power: bq24190: Add BQ24193 support

Alexander Shiyan (1):
      power: reset: at91-reset: Optimize at91_reset()

Andr=E9 Draszik (3):
      power: reset: reboot-mode: better compatibility with DT (replace ' ,/=
')
      dt-bindings: reset: syscon-reboot: add google,gs101-reboot
      power: reset: syscon-reboot: add gs101-specific reset

Arnd Bergmann (1):
      power: supply: max77976: add EXTCON dependency

Christophe JAILLET (2):
      power: supply: wm831x: Constify struct chg_map and some arrays
      power: supply: rt9471: Simplify definition of some struct linear_range

Colin Ian King (1):
      power: supply: rk817: remove redundant null check on node

Dan Carpenter (1):
      power: supply: max77705: Fix workqueue error handling in probe

Emanuele Ghidoli (2):
      dt-bindings: power: reset: add toradex,smarc-ec
      power: reset: add Toradex Embedded Controller

Gustavo A. R. Silva (1):
      power: supply: cros_charge-control: Avoid -Wflex-array-member-not-at-=
end warning

Jelle van der Waa (1):
      power: supply: support charge_types in extensions

Jerry Lv (1):
      power: supply: bq27xxx: Retrieve again when busy

Kees Cook (1):
      power: supply: sysfs: Remove duplicate NUL termination

Krzysztof Kozlowski (3):
      power: supply: collie: Fix wakeup source leaks on device unbind
      power: supply: gpio-charger: Fix wakeup source leaks on device unbind
      dt-bindings: power: supply: Correct indentation and style in DTS exam=
ple

Pengyu Luo (1):
      power: supply: add Huawei Matebook E Go psy driver

Ryan Wanner (1):
      dt-bindings: reset: atmel,at91sam9260-reset: add microchip,sama7d65-r=
stc

Svyatoslav Ryhel (6):
      dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
      dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
      power: supply: Add driver for Pegatron Chagall battery
      power: supply: max17040: adjust thermal channel scaling
      dt-bindings: power: supply: Document Maxim MAX8971 charger
      power: supply: Add support for Maxim MAX8971 charger

 Documentation/ABI/testing/sysfs-class-power        |  43 ++
 Documentation/ABI/testing/sysfs-class-power-gaokun |  27 +
 .../bindings/power/reset/syscon-reboot.yaml        |  42 +-
 .../bindings/power/reset/toradex,smarc-ec.yaml     |  52 ++
 .../devicetree/bindings/power/supply/bq24190.yaml  |   1 +
 .../devicetree/bindings/power/supply/bq25980.yaml  |  34 +-
 .../bindings/power/supply/ingenic,battery.yaml     |  14 +-
 .../bindings/power/supply/ltc4162-l.yaml           |  18 +-
 .../bindings/power/supply/maxim,max77705.yaml      |   4 +-
 .../bindings/power/supply/maxim,max8971.yaml       |  68 ++
 .../bindings/power/supply/pegatron,chagall-ec.yaml |  49 ++
 .../bindings/reset/atmel,at91sam9260-reset.yaml    |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   8 +
 drivers/power/reset/Kconfig                        |  13 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-reset.c                   |   5 +-
 drivers/power/reset/reboot-mode.c                  |  25 +-
 drivers/power/reset/syscon-reboot.c                |  96 ++-
 drivers/power/reset/tdx-ec-poweroff.c              | 150 ++++
 drivers/power/supply/Kconfig                       |  37 +
 drivers/power/supply/Makefile                      |   3 +
 drivers/power/supply/bq24190_charger.c             |  14 +
 drivers/power/supply/bq27xxx_battery.c             |   2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  13 +-
 drivers/power/supply/chagall-battery.c             | 291 ++++++++
 drivers/power/supply/collie_battery.c              |   1 +
 drivers/power/supply/cros_charge-control.c         |  23 +-
 drivers/power/supply/gpio-charger.c                |   4 +-
 drivers/power/supply/huawei-gaokun-battery.c       | 645 ++++++++++++++++++
 drivers/power/supply/max17040_battery.c            |   5 +-
 drivers/power/supply/max77705_charger.c            |  20 +-
 drivers/power/supply/max8971_charger.c             | 752 +++++++++++++++++=
++++
 drivers/power/supply/power_supply_sysfs.c          |  25 +-
 drivers/power/supply/rk817_charger.c               |   2 +-
 drivers/power/supply/rt9471.c                      |  12 +-
 drivers/power/supply/test_power.c                  |  20 +-
 drivers/power/supply/wm831x_power.c                |  20 +-
 include/linux/power_supply.h                       |   1 +
 39 files changed, 2419 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
 create mode 100644 Documentation/devicetree/bindings/power/reset/toradex,s=
marc-ec.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ma=
x8971.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron=
,chagall-ec.yaml
 create mode 100644 drivers/power/reset/tdx-ec-poweroff.c
 create mode 100644 drivers/power/supply/chagall-battery.c
 create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
 create mode 100644 drivers/power/supply/max8971_charger.c

--o3kinmntwcc6dqdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmg0U1YACgkQ2O7X88g7
+pqJDBAAlLINmrRR+0Gl5tp+RTVPxhm/8bIjJzLA0yjwOzFn+aoOaQXXQL8AEaSb
pdZTcGGEtU7Vydh8Sfu/9X1icrFN+MJo1lxIt57kt1DnxPxSwjFHx41LaA6hiW9a
bg/2XVRn/T+x7VS62e+WosNUcmVccgKjSv0XSTClbel0hH6JorcWoeGqBwb9jjki
S8ujriKurkDqUsYNm1awofLBvVg4307PRdYR3ZGnXJTb0KFf4zguD8/rJYt9hy1Z
ICV16QpxJC+wSL39nu18NBTVDfFiqc+2rPimX9kK6W1Ku726b+bOEo/LX31XjUD0
/4xc1Ii23wl+MKNblkY6NerCJu9PD976eM4cGLKyBHYuRqggaFeVWFW5ysWpz71L
4Mb5QN6iyyJj8YDB1rF53VZMNtZGPI6cx1/BxVzs499OTvWIJLgAlv0gpWJdMS0u
ve4aIRVpjtT+GXJSR5+wyzv1piYpT/2fl2MGrst+ODGTDWRqyBdg+IWbyA3G5cx5
O0SHAyPkytxj+AVy/lq3CRe4i+QJZwkVxcOEKSdXH/oK+S/+BK5ao5QdDG8dMrJa
xdZzoN+erlOsz1UxdAN7fthrvQp+RWZHHsOdfyeQL/IY4Unm/lpbvxuR7faW0x/C
xmm+btXsXlBWtaYmtmzwWNhWcRnwrQDl3gQT1pVQvRny0TX0Ano=
=7KcP
-----END PGP SIGNATURE-----

--o3kinmntwcc6dqdm--

