Return-Path: <linux-pm+bounces-37417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF3C34530
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31EE18C80D6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738C2DCF7C;
	Wed,  5 Nov 2025 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SZOmc4Bw"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002F2D8370
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328385; cv=none; b=K/0coc91b4Nk6AC/6E1SBokpw/YrZ84BP64tAQ2e3nMbcFqYOU9IZee6ScTtHsPiuz6y0A9uUfnVlJpZbD8MbNv+puGALcrNFNvLP21TSGNnPAakwwS2078ADNwpyiTc4aRp8NmkW9DBOe7iKwg/DdCBW7+G+nFhVQN1I9DHsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328385; c=relaxed/simple;
	bh=FzU68KgfWd0Ag+ZNIa/sYCVuLPYQCRz4V7ZnZID9rcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQRpfJpd3GdCAc681BiTg9oT/iC35CYUptW9735Suxa1YD/mwmkEwsC5R5iCqVLMH0QLXBQKyRcI79pRjAnh5xk8c4xkFXJdJ1BAA5JDUdeb4V8XhN0X08RLnpZVhAloVvDZYfKBdBqCBoTWU290PC5fs2nqAjtaTuNoXMbKvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SZOmc4Bw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:39:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328382; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=dHdKl5NTAo+EJl7nxyYj/jaxADZc5iBvVUPFVMj0iS0=;
	b=SZOmc4BwUQlyC7Xac7B1qPITme3IllFExOQVyU2yIMO4w8k+eXaKs84AUo57s2UCvIKdtj
	vPgQwe/a9SqIIj9XiUmVuzD23n8dB4ECAxYrZHlvcg/bDAGipIctqpsdtVlZNZJ4RBxKPS
	3L6Ih9CU5n2QR5Btn9976cKJ6o9luNw=
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
Subject: [PATCH v3 14/16] power: supply: bd71828: Support wider register
 addresses
Message-ID: <903c078d0ea74862e4f8595dd9c162677e5c0399.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4F51MbzgHAMPXqGB"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--4F51MbzgHAMPXqGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD71828 power-supply driver assumes register addresses to be 8-bit.
The new BD72720 will use stacked register maps to hide paging which is
done using secondary I2C slave address. This requires use of 9-bit
register addresses in the power-supply driver (added offset 0x100 to
the 8-bit hardware register addresses).

The cost is slightly used memory consumption as the members in the
struct pwr_regs will be changed from u8 to unsigned int, which means 3
byte increase / member / instance.
This is currently 14 members (expected to possibly be increased when
adding new variants / new functionality which may introduce new
registers, but not expected to grow much) and 2 instances (will be 3
instances when BD72720 gets added).

So, even if the number of registers grew to 50 it'd be 150 bytes /
instance. Assuming we eventually supported 5 variants, it'd be
5 * 150 bytes, which stays very reasonable considering systems we are
dealing with.

As a side note, we can reduce the "wasted space / member / instance" from
3 bytes to 1 byte, by using u16 instead of the unsigned int if needed. I
rather use unsigned int to be initially prepared for devices with 32 bit
registers if there is no need to count bytes.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v2 =3D> :
 - No changes

 RFCv1 =3D> v2:
 - New patch
---
 drivers/power/supply/bd71828-power.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index f667baedeb77..ce73c0f48397 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -44,19 +44,19 @@
 #define VBAT_LOW_TH			0x00D4
=20
 struct pwr_regs {
-	u8 vbat_avg;
-	u8 ibat;
-	u8 ibat_avg;
-	u8 btemp_vth;
-	u8 chg_state;
-	u8 bat_temp;
-	u8 dcin_stat;
-	u8 dcin_collapse_limit;
-	u8 chg_set1;
-	u8 chg_en;
-	u8 vbat_alm_limit_u;
-	u8 conf;
-	u8 vdcin;
+	unsigned int vbat_avg;
+	unsigned int ibat;
+	unsigned int ibat_avg;
+	unsigned int btemp_vth;
+	unsigned int chg_state;
+	unsigned int bat_temp;
+	unsigned int dcin_stat;
+	unsigned int dcin_collapse_limit;
+	unsigned int chg_set1;
+	unsigned int chg_en;
+	unsigned int vbat_alm_limit_u;
+	unsigned int conf;
+	unsigned int vdcin;
 };
=20
 static const struct pwr_regs pwr_regs_bd71828 =3D {
--=20
2.51.0


--4F51MbzgHAMPXqGB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/zgACgkQeFA3/03a
ocU1IAgAtAPo754Dgh/kqxA7PstHheEX5dg3WyX7i8k3vOgns0hEUL7EUHKNhLsk
AttEnpsHdwzp/BvufbtzSaYx/NoMD7KKGtsusCTOqfpwypJN3PqPMIrC3sQlfWQU
aQKx8JmT40N4l7sLIPNe9U1rgX1b5s8STRuUkTVgcQ65A+hwz6jsF60v1gy6WJIj
2MWSKb0sP1AATXaMgQ23OAmGY43V4t8to9MO02D3D4EV39aQnxJBqn1XF9kCcjIl
wvSbw7uFOYXAG5dNuykxVvoGbUOka32YIBe97AIHzV55zS6v4gPVDWti2kp3vuDo
UdS3LQEieV7JlqmjItZ/YEJc+fqsMg==
=M2qa
-----END PGP SIGNATURE-----

--4F51MbzgHAMPXqGB--

