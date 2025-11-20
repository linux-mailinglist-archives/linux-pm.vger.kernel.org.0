Return-Path: <linux-pm+bounces-38270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC0C72C1B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E78F52923F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF672F7AA3;
	Thu, 20 Nov 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OcEUBQBB"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C752BEFE4
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626785; cv=none; b=d1NTxhgJikrVlolHWVxRGaxnE474PkBu5RUslo2o1R9y7eLwrjJ1kEArQbfMBbAGHYMcGc5effpgslI7Qaut2MG/fhfYNomcW8h4Bn/3K+40mxtDRf+JkYWebxsAF5RPDilnC0PKxvbLKg8is3XET2F2Qv71wuVIak0GhvW0mwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626785; c=relaxed/simple;
	bh=gPS6lCGIRGcxxQSZNthifmSBFCXs3B3kMXmWi4bEZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s6I5tySHwwiZRFmii+dHeXeN5PD7llcbQY+ZGW812bPbISdIJKcRoCuQ/h9NKrAgZ3tudwlRAMXsQewI2X5BGO5z+EBJfbBFnglr09+OeSR/9mTNKF8vdPeLWVoE6FTC/T53YSqDGB4eEl9oVVXsDrkROTXje4mUMo/3ZzUjI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OcEUBQBB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:19:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626771; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=lqP09SI4iTaIvX15z16i9CR8/quVrC8ublsHH/F3wTE=;
	b=OcEUBQBBrl8TzgVKxhqvy/WbAbsSuYduJgSrQuemdiF1E4B/kfTNZ2PFPZy50Ro9DPE1Yr
	JfwDNLZAn2+X3wDWuOqk0P13dxdBSwc9pxjhFHtSuGDfF1/pXSJ6ZfZ2bPpXj0hkPuuhZ7
	8v4p8kbm8WyRaLtpYqTeycSiXI89Tts=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 00/16] Support ROHM BD72720 PMIC
Message-ID: <cover.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txQLuSbT+MkGzS45"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--txQLuSbT+MkGzS45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD72720 is a new power management IC for portable, battery
powered devices. It integrates 10 BUCKs and 11 LDOs, RTC, charger, LEDs,
GPIOs and a clock gate. To me the BD72720 seems like a successor to the
BD71828 and BD71815 PMICs.

This series depends on
5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
which is in power-supply tree, for-next. Thus, the series is based on
it.

The testing of v4 suffered some hardware-issues after I accidentally
enabled charging while the PMIC's battery pin was connected to the I/O
domain. Some heat was generated, not terribly lot smoke though...

After the incident I've had occasional I2C failures. I, however, suspect
the root cause is HW damage in I/O lines since changes in this revision
have been made to dt-bindings. It's still fair to note that though, as
my testing was impacted.

Revision history:
  v4 =3D> v5:
  - dt-binding fixes as discussed in v4 reviews.
    - Drop rohm,vdr-battery.yaml and add vdr properties to battery.yaml
    - Drop 'rohm,' -vendor-prefix from vdr properties
  - Link to v4:
    https://lore.kernel.org/all/cover.1763022807.git.mazziesaccount@gmail.c=
om/
  More accurate changelog in individual patches

  v3 =3D> v4:
  - dt-binding fixes to the BD72720 MFD example and regulator bindings
  More accurate changelog in individual patches

  v2 =3D> v3:
  - rebased to power-supply/for-next as dependencies are merged to there
  - plenty of dt-binding changes as suggested by reviewers
  - add new patch to better document existing 'trickle-charging' property
  More accurate changelog in individual patches

  RFCv1 =3D> v2:
  - Drop RFC status
  - Use stacked regmaps to hide secondary map from the sub-drivers
  - Quite a few styling fixes and improvements as suggested by
    reviewers. More accurate changelog in individual patches.
  - Link to v1:
    https://lore.kernel.org/all/cover.1759824376.git.mazziesaccount@gmail.c=
om/

---

Matti Vaittinen (16):
  dt-bindings: regulator: ROHM BD72720
  dt-bindings: battery: Clarify trickle-charge
  dt-bindings: battery: Add trickle-charge upper limit
  dt-bindings: battery: Voltage drop properties
  dt-bindings: mfd: ROHM BD72720
  dt-bindings: leds: bd72720: Add BD72720
  mfd: rohm-bd71828: Use regmap_reg_range()
  mfd: bd71828: Support ROHM BD72720
  regulator: bd71828: rename IC specific entities
  regulator: bd71828: Support ROHM BD72720
  gpio: Support ROHM BD72720 gpios
  clk: clk-bd718x7: Support BD72720 clk gate
  rtc: bd70528: Support BD72720 rtc
  power: supply: bd71828: Support wider register addresses
  power: supply: bd71828-power: Support ROHM BD72720
  MAINTAINERS: Add ROHM BD72720 PMIC

 .../bindings/leds/rohm,bd71828-leds.yaml      |    7 +-
 .../bindings/mfd/rohm,bd72720-pmic.yaml       |  339 ++++++
 .../bindings/power/supply/battery.yaml        |   33 +-
 .../regulator/rohm,bd72720-regulator.yaml     |  148 +++
 MAINTAINERS                                   |    2 +
 drivers/clk/Kconfig                           |    4 +-
 drivers/clk/clk-bd718x7.c                     |   10 +-
 drivers/gpio/Kconfig                          |    9 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-bd72720.c                   |  281 +++++
 drivers/mfd/Kconfig                           |   18 +-
 drivers/mfd/rohm-bd71828.c                    |  546 ++++++++-
 drivers/power/supply/bd71828-power.c          |  160 ++-
 drivers/regulator/Kconfig                     |    8 +-
 drivers/regulator/bd71828-regulator.c         | 1025 ++++++++++++++++-
 drivers/rtc/Kconfig                           |    3 +-
 drivers/rtc/rtc-bd70528.c                     |   21 +-
 include/linux/mfd/rohm-bd72720.h              |  634 ++++++++++
 include/linux/mfd/rohm-generic.h              |    1 +
 19 files changed, 3120 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7272=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd72720.c
 create mode 100644 include/linux/mfd/rohm-bd72720.h


base-commit: 8e8856396b54bea5c00a7ae88d87c6254aef2d94
--=20
2.51.1


--txQLuSbT+MkGzS45
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkezwYACgkQeFA3/03a
ocV+vgf/a1KAYMhU5YxlbMf2zyzVkzG9a0t6DZvk8PFqDx5TcU0QKkeEjONsuhre
i98P+Ou5A0MdX3vFWPDyPpsUFcniGkAvoDqKwEgiZS0tdQLrN6fTVxq1YpArcXtZ
fCNrYVoaNn7/DU/RGjx9vL36e+nSawnCZMKOhWxJboFU40XnSnX3+GpHYcxBtrxI
igcXO97YI0efNWcfLpGUy2DWW4FIZ5YCTe4l3TztcAsYMpg1oW7QOkBS0AH3T3Zf
jDZ9rH4LBhQ9zuyGOUCMySA6n5pLyE+alzIlesAq7t/GLXJwMFoMeELXZkkDVSdj
nYZCl4mpUPRHG+ApdEPUfQSNp5nVvQ==
=MOad
-----END PGP SIGNATURE-----

--txQLuSbT+MkGzS45--

