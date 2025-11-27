Return-Path: <linux-pm+bounces-38776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40036C8DEC2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E674E4E5ECB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796FB2D73BC;
	Thu, 27 Nov 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+G+x08x"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F387CA4E;
	Thu, 27 Nov 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242222; cv=none; b=SkOFEowTiO70RVGhpeRx9kIj3QeT6BSFfFpQmU3Q0KLG/tfrgcXYCzQM4ox9bcIQveaIZQWjeGnoPhDBXdbmeJ+8hkXuW01NiHrdyWP3LUEFl7iux/ToFp6P/JZfGxX3o/AR7LIRezrc0o7nO6wOSUPSJztj3YYO82uK1pMgpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242222; c=relaxed/simple;
	bh=804ceyBGHqbefEPQWTkdZRhdVURFUGnKTLfLYDclMD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qGgHElsqi+6BdZuODUye0xSsvYXoXTvKS4GvUN36ifp/gs+HhZgL0XLrSf1CsWAKUXE4nltBBvz1dj2b3O2ILKJoCU5Y5nR505u3JfoYmmYYcE1jZewnjHCD02IHBshq25+U0alaTS2aSuVySSRtNh48/eABHtGy5sXI6kkn4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+G+x08x; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242208; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=yP3EFfJTxAeia/9Vu0TmVp9NfMqyS9Ik349w5xHdWnU=;
	b=b+G+x08xZsVQF6s/Vq7Fe+FhRbykkdrGnHERP3I63lLvoR0Ss/YXtXVM7cjwjC9sK8Rh9M
	Yk8G/BG8R5tHBY9s6nWN+aEI51Gbr4qk1TZAHqL3XnJV3Li37+lb3S1danDMXwTNGT3ecY
	2ZkZIsvSjcxoTv6jUTAQBPYR/g2B4CM=
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
Subject: [PATCH v6 00/17] Support ROHM BD72720 PMIC
Message-ID: <cover.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nM2u6DKchnFGDNSs"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--nM2u6DKchnFGDNSs
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

The testing since v4 has suffered some hardware-issues after I
accidentally enabled charging while the PMIC's battery pin was connected
to the I/O domain. Some heat was generated, not terribly lot smoke
though...

After the incident I've had occasional I2C failures. I, however, suspect
the root cause is HW damage in I/O lines.

Revision history:
  v5 =3D> v6:
  - MFD fixes as suggested by Lee
    - Styling mostly
    - New patch to Fix comment style for MFD driver
  More accurate changelog in individual patches

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


Matti Vaittinen (17):
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
 drivers/mfd/rohm-bd71828.c                    |  555 ++++++++-
 drivers/power/supply/bd71828-power.c          |  160 ++-
 drivers/regulator/Kconfig                     |    8 +-
 drivers/regulator/bd71828-regulator.c         | 1025 ++++++++++++++++-
 drivers/rtc/Kconfig                           |    3 +-
 drivers/rtc/rtc-bd70528.c                     |   21 +-
 include/linux/mfd/rohm-bd72720.h              |  634 ++++++++++
 include/linux/mfd/rohm-generic.h              |    1 +
 19 files changed, 3127 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7272=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd72720.c
 create mode 100644 include/linux/mfd/rohm-bd72720.h


base-commit: 8e8856396b54bea5c00a7ae88d87c6254aef2d94
--=20
2.52.0


--nM2u6DKchnFGDNSs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoMwYACgkQeFA3/03a
ocVMLggAiRllV7Pe5eiR+ywDOkuH2WvgDoSauSp06dwozDeEPagdlX6BAl/2FQ6C
EiTC+ycyFJ/hCYkrV7f5/FVfUcT7AK6xIpFDlo7mzks8VUhFHUBFHTVE3KuAxA1/
V2zCrGOBhLrOKSETxr/iAGWrAJH0HUEX9mjCnQTN25k55GGKiY2+tiLg3Ippa2s/
WhEswxyAQ6Hn0j+0TvtEcvEVc5zqe5ak2v1TYSdESSSpNt9a2hacUydnCIJaSRNs
+ILrtQHFmkxsnUqds1OvxlOtMWZkMrCIfGPA4Gf/gk8Si13k6j53I1gvctBh5+fX
Kn4d6R/J002dJlrggZlY077CsMwxtw==
=xx9/
-----END PGP SIGNATURE-----

--nM2u6DKchnFGDNSs--

