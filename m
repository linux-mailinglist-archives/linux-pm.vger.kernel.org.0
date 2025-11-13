Return-Path: <linux-pm+bounces-37915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059AC565CC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E09D3B824B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8253328EB;
	Thu, 13 Nov 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALXDqWi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FDA3321D9;
	Thu, 13 Nov 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023887; cv=none; b=L3ihs0l/wV9zLPA9xSjMpvhZl78jpfgmGnJ9EkB4ViqenTrMfOWNV5rY9gMwZIu74s3sFG8+ok90jCqr8wn0p71JAGtC2suJWJTHZl0N6VkjT28JgQYVBBJAhC38oHDy31O6U+8+2CoBKXlSjWb9cUsLch6f1vE5E+dMBpV1NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023887; c=relaxed/simple;
	bh=gErgExs0giELNyDUhov4fCt/tgP4xuvM5MPlSNyKCQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ArRha/+wDbR4N/87FGfZWswZfw9rmsHwFf7JNTwawJaUx+AKgam4t/tYLS0nzOoS8/B74D2ahH0ZDQn0MaYKndQcElHrl4etl/3cvRtHI5NjjUvwzJ7751AS8MPg78b6hRBAcc+LI1/ZgNDEOU3l69vtMVFdX1JyjpiMJOJNbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALXDqWi4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:51:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763023873; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=4Cu0d6W6TNdyyOOYee94EXw4t7os5fCG6nMUY/+KWMU=;
	b=ALXDqWi4fMqjrdjYjYsvwPp+xOCvKCXNir1cgSmEAmSUfH5pTQmzSYnqU7yox5q+lwSQPl
	ToJXsn5lJF7X+Izzp4pI68MjKOu3jZbrXxFelDM+4hQ0J6kkEhzprhSM9tmDgUo3YfnKic
	F8kilmrxA6A4UQMpa2ooICj+KUZJLGQ=
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
Subject: [PATCH v4 00/16] Support ROHM BD72720 PMIC
Message-ID: <cover.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dKFZS09m7tQZCgSp"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--dKFZS09m7tQZCgSp
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
 .../bindings/mfd/rohm,bd72720-pmic.yaml       |  338 ++++++
 .../bindings/power/supply/battery.yaml        |   11 +-
 .../power/supply/rohm,vdr-battery.yaml        |   80 ++
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
 20 files changed, 3177 insertions(+), 130 deletions(-)
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
2.51.1


--dKFZS09m7tQZCgSp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVm/kACgkQeFA3/03a
ocX7IwgAzz6P/Y+KNbJ7ZjWahFcHUI1wgYDFcf/SlBI/HhU9hi+MX66swIV7RDkm
VU8AUpREZDAa8F+YPBoDb+SWRVVkwN9NzP4rLsWiBL66HaHFtabSm0vRglj6AEY3
71wtOXR0faeX2crZd8J2ID861dHix3A2mxomBmoAL6kF1E8arv7rIhyx3RonJ1dH
rIT/DaJ7f/O7zJOHm9/YKTk4sN6paGFqGOIsj4qvLq87E/+70MZ02RsfSLWUDEIM
4ITyfhALAxsa9Rq0Qw5XFB5jQzpQw7SCrJ+ms8Dkx2TX9H94UXj7Tj7pW6jTOa+L
6GPekxZMEliDsXSVFdBkg/d3zK6C9Q==
=03Sq
-----END PGP SIGNATURE-----

--dKFZS09m7tQZCgSp--

