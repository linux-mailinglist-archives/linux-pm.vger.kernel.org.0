Return-Path: <linux-pm+bounces-39557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE2CBDF95
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B7330109A8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0CC2D979F;
	Mon, 15 Dec 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GnLwksGI"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90142D7D2E;
	Mon, 15 Dec 2025 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804631; cv=none; b=pkOLGLF/oV1CHzj0XHmMhwNjNdKBftF3vyxyNFDfO1YsQZG2tIeGczXfiTrwkKSrjHIRA5eClg02rFeLUfVeLmgiDGGp25AiGuRBuFy8OssRP+a4fbOUZsiex2QMBU9m1gA1VPyIuDUp5qXVsTeKnUP6O7dzZoq2cfQjWDa/vA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804631; c=relaxed/simple;
	bh=t+3/rBH8Fou7YH7QS+lXRreFqP+9OwpFHCCxzxu16JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qMCAXxViGQ1yAbk8+ZbR+VBG53k4W3gS47qQUhxVBMD9PF3rAokgilVdiccgN7Yl4mKO/JSmzm7qSaGSZBzj1mILdC1hAaq7jZyBQIalV30Qd92xinuYS0cUOMBVE6n6kJJrzEvrPWXB3sCE+biWaLeWv0mn7JIWH5t1caFYLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GnLwksGI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804612; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=WiDNFAxR5yiVwu+hAtbQBY28p8F8f+gFH61h9WqQhIo=;
	b=GnLwksGIPDesCnH5nLgzqbszxAc83W9+2jFI9EeJ23KcYY3MPN/RZqRYRp3wxqjBVKThnW
	d0GMoVbLfZ2uwxsKyNMpxRjmg5ZkFUxMpGNxof3KJNi4Hpvlw59D9WtPC8nmDOUqm+whn0
	fWJHCjchn8dFDflUHsGH9XCA/xdhL1A=
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
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
Message-ID: <cover.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ZIbSEWw5sj//Cs4"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--6ZIbSEWw5sj//Cs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resending the v6

Series is same as v6 _except_ being rebased on v6.19-rc1 - and adding rb
tags which were replied to v6.

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
  v6 resend:
  - Rebased on v6.19-rc1 and collected rb-tags from v6.

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


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--=20
2.52.0


--6ZIbSEWw5sj//Cs4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACjQACgkQeFA3/03a
ocVvXAf/aLg1mLcDMQctdZXd7r8pJ+3IdKs/8MIgXbLFX7s5jdJQe0eKVKmVjxpT
irXNoLXsm/9rr9isLWL3cw7Mp43js/nt8XHEODlhnUR3X0xgqziT1WYFQQrFZHP0
Vji6T+4dPH26Rf5Im1Sj38pl7mujbmKrqjtcfX5SCxAg8mUzm7BWdZVoNfyj1VbH
IAPtHGngvqBPH3E17qFo7ki24BNFHQsn7rj5PKFAVFDpHL/A5m9MlaUXhlb5AKxA
3/eawVNqe5+D/OvamKViZ0JAxdTxwc/d1oW3tSy0hYPsEHkqKmQPDokjuBZo+wfx
YRBJk5U3v2ciuwq4SBuy/VzH9xw55w==
=1Nk1
-----END PGP SIGNATURE-----

--6ZIbSEWw5sj//Cs4--

