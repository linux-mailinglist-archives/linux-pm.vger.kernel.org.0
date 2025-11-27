Return-Path: <linux-pm+bounces-38784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA2C8DFEE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AE03B6861
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277BB32C95C;
	Thu, 27 Nov 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wU3C7GTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA432C95E
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242341; cv=none; b=OYtO1OFF9iWrBoPHNIkOiOQ+zQt7a2C0W373O9FYOP0e+Z5fWqtKcwlJAntjqd2z7kYCm3Oqs2n7cv1jAK9WHZY+2+lqEFkfElL7K1ugi0KRl62wLnEoLHUGKV/6rg5Eohz0H2RBLFUa3SG3hlIJm3TNZTp8eYj1+lt0NloXaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242341; c=relaxed/simple;
	bh=DyvL/Ta3eRXfwdz4u069RB97Z6vVKEhMegXkDdnHKPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6yo+AgpIXj+D9jArXbMVPguBxkcg4Ko1bsiNKQZtrgiazK1lsRJqD7kc7QadSbyuzXZ0fZerj2r8J52b918UBzUqem9/gx+GKimzlILQC0D3YQn9EQhiPkWI36VmEMCm1oCkbnBeonL299afiISt1ej2+MlVTsK7rgFDso7naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wU3C7GTH; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242336; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=DyvL/Ta3eRXfwdz4u069RB97Z6vVKEhMegXkDdnHKPU=;
	b=wU3C7GTHrn2xy27dZMgC7DbJuUZapFOyY7hp1V/7qATr1eGpNq/i2C/e95YVziLFwqI6Qf
	Fdz8YbJhm05lnFFHAeHsDnUmDV9MQUNMCDDE18K8M+uU1W2tUcZR7jckkH1eTYkaAuiHDm
	kcofG7VM9fwwutpUoLI03fS9iOKn/FI=
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
Subject: [PATCH v6 08/17] mfd: rohm-bd71828: Use standard file header format
Message-ID: <5d37d7a017caa081c03db67a4ff346277019e4e3.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yZqfrnVomjvN5Cww"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--yZqfrnVomjvN5Cww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The MFD subsystem uses C-style comments also in the 'file header'
section. Switch to this for the sake of the consistency. The header
content is not changed.

Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v5 =3D> v6
 - New patch
---
 drivers/mfd/rohm-bd71828.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 2a43005b67ee..218945a8ec94 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-//
-// Copyright (C) 2019 ROHM Semiconductors
-//
-// ROHM BD71828/BD71815 PMIC driver
+/*
+ * Copyright (C) 2019 ROHM Semiconductors
+ *
+ * ROHM BD71828/BD71815 PMIC driver
+ */
=20
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
--=20
2.52.0


--yZqfrnVomjvN5Cww
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoM5gACgkQeFA3/03a
ocW6mggAqCNEjP5xVnKh5+CKXJdSGxhbhrOfCmaVlZ6GLwz+RY5uIsq6tfdwN2JD
LTt/u4b0/2MJtY9cfNDCm/67qd6zPZ54tgDTXZ6id3skpuD20tcCKVrnIvYYIven
iwFhvBN1xtQRPl69+cTwjQZa/iLvyk/wGYzze/RfZutgVu4I2comKzKCoElRZB+e
3cuiC11UqPviReTVxp9LTXDCKkPE+ttMsvw49oBOpIfhwKtvFOvKW0/4cnoCvErD
D5se4+hYHgI9srgAPyaWsdboxLbm/BGv2RWdetd3Y2Bu1ZYrkFCb/4NBpZT7mKJY
WW5ORMZwjl0MAmXVLn5f45QAFG0D+Q==
=ZwmJ
-----END PGP SIGNATURE-----

--yZqfrnVomjvN5Cww--

