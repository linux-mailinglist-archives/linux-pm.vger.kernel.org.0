Return-Path: <linux-pm+bounces-37403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0FC343D1
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8B3AF2BC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F42D0C8B;
	Wed,  5 Nov 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+nBzIgd"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E82D2493
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328110; cv=none; b=EmzsQnrHTC8m1oI16bYbBq6Yj0ezSghPhPvAI5Eq7zYDGZ5D3+i8wjY25p7RKVy0zUUTwwNqWtslprWmJRBaCZo7kz6sw1lCwiVs29Svt9iUupdJ8KcdvGkZ0DlN9gPw7D1bSv6DDDmEaNjym7Uo2YOpIwLYSMYKInmx6DiNQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328110; c=relaxed/simple;
	bh=JK6okU5PfulTr7e7T/BxvrOr2lJJpI7i2sbtWCEL5KU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z+XcmAw42iXUvnlRFTn8WAKxPn1yq9DwRU8oPbAIU9rGUyUE1tlgQpJsaKYhsK5hBxVblHDXxVvPPniiQS8Iws9LUjhNwqy2OqvMNtTimRIgfNd9BzubQeI/jLHsie3c26yDXzyAalLcgv6YfD/tMdF4BryCV2n6H5qtVG/8/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+nBzIgd; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:34:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328096; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=QbD+o+lTdBbJ4VK2xPHI9/3MX7eK+Z0tbDcJ/GiPy9E=;
	b=R+nBzIgdl/QxCPWFQG/LJ6YDXXG9yX9Msf5uRT4zmx6bI/u1FH1u7FWWxEERf926cU50x4
	w1PPN+3l8c/BrTbrX5hREaT3c8YGdlK9FEVJ9Exue1i0U4mUvQb61aL/mMTuydERiR8PTd
	Bot82+EAQZWGBZ0HVE/hf7l4edh5vN0=
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
Subject: [PATCH v3 00/16] Support ROHM BD72720 PMIC
Message-ID: <cover.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4MYywFglvLP9uBSk"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--4MYywFglvLP9uBSk
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

Revision history:
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

It may be worth nothing that the 'From' header changed as I send these
now via linux.dev mail, because gmail started filtering some of the
outgoing patch mails. Commits should still be from "Matti Vaittinen
<mazziesaccount@gmail.com>", which should be handed by in-(mail)-body
=46rom -line. Please, let me know if I messed it up.

---

Matti Vaittinen (16):
  dt-bindings: regulator: ROHM BD72720
  dt-bindings: battery: Clarify trickle-charge
  dt-bindings: battery: Add trickle-charge upper limit
  dt-bindings: power: supply: BD72720 managed battery
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
 .../bindings/mfd/rohm,bd72720-pmic.yaml       |  273 +++++
 .../bindings/power/supply/battery.yaml        |   11 +-
 .../power/supply/rohm,vdr-battery.yaml        |   80 ++
 .../regulator/rohm,bd72720-regulator.yaml     |  149 +++
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
 20 files changed, 3113 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,vdr=
-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7272=
0-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd72720.c
 create mode 100644 include/linux/mfd/rohm-bd72720.h


base-commit: 8e8856396b54bea5c00a7ae88d87c6254aef2d94
--=20
2.51.0


--4MYywFglvLP9uBSk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/goACgkQeFA3/03a
ocUMWggAxyyhg33bB+WW0Pvu9hCQfppFoOnvvl4Mt2X2my0jPUwpGldz76pva2lE
tVk0jdx19eg9LEDMjdBBj2eg6Y/uBETvbCrgW7i59BjoRljjdkncoNFYx16IBmCU
/egxpv/Nx1A2Zivy2Pl7pddQzgBSrwDDe91/Ian9ocR5+k0hZztCxJsSuI+iYYYm
jg0GU85f6gT6hxLDGS6ii5HhIzgrJG4QV42iB8r/wxNCZAidPuyiiH3HWcxiAta2
eXl3IH5OrsQMC9s4p02qISMGg3VmVtH7pTelVqQComeMDKH6mHOD6r/ofXCofESp
BGwnSFtgX39MlY6DnrCZtOn6CyshDg==
=4L+m
-----END PGP SIGNATURE-----

--4MYywFglvLP9uBSk--

