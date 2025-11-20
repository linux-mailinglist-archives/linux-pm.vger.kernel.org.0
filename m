Return-Path: <linux-pm+bounces-38285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 138BAC72D75
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C3B9B2FA9D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6331961B;
	Thu, 20 Nov 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFy/2K/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581EC314B69
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627060; cv=none; b=iRuoYJN6VERy3bItaGN2PxGpIUZ/vtVhNS2HWxPMr2YQQ8uAUt2JCWNoisLaz5/T1SeavY+hKeVFF8ExaYi/h1RV5Nn0rXTbEuOYfQxL6WZa7w865wgVOKqp+QevoOx2jRG4ceghJHErCFUAgb9jJ8AM4699m8nyVVB6R82vOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627060; c=relaxed/simple;
	bh=02EnkwBQQgsUlQA53El06lyP4e0YQxBYtej5GOfmtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZxk7HONK1yCfFUtfEhSlDzBjjOcgpfI+lDr57nCy4ucfRbw0KrzI3uo7z5nlBUYTjnEw5hR2lDC4GhPsOrzho2vVSvhSJ/gKqho3eQ/P4WDtbMNF7ZG3kZjIaq0x/G+iuaU5iKsNkeFKCPHvPoiavN4kLYKNoHMkR9E1q3bvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFy/2K/x; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:24:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763627056; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=2ZsLBDjXMAlj3TJmEnf94+IOD5/Sh64Gr7xVrTPAx2M=;
	b=iFy/2K/x2ZoM1DxS/+Ht1JjjsKJRP1fYSC1Ka3zxJzzMWuME06ly4bqyK93eCxTVZyvGj+
	ZGL/b9P1OQeWFbvZmC2QgZOoYqYdQjrRiRlR/gI/nRZAF42o8Q64sEGZ0nCo767Y/gngua
	sujNeAZIIlSyFRjxChsTyw5IQ9mNbmg=
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
Subject: [PATCH v5 14/16] power: supply: bd71828: Support wider register
 addresses
Message-ID: <cdb9b6fc15bcce8b82781ba8c3ca6c600493a4ef.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z8iX/zv5HmYisccf"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--z8iX/zv5HmYisccf
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
2.51.1


--z8iX/zv5HmYisccf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmke0CkACgkQeFA3/03a
ocVj8Af+PIsWKAcr8Ea49HTK360VQXR2IxFPFZPGhZgWs9xWND1CDKCYQMyDOb0V
9HSQ/tl5vtKj6/2sqFMAm9tLntXWHM8QZvYoTpHfuCUtkBoAQdvn07UJempnbzjr
fp17aahsfCgzTsXP5beRr5DOdG5VUZgmY3JjKEQIIInshG0ghHem8idjJoHn+aTS
MqXlf2FNfQw4yLjoYqzeADbhMsnypZZOZbJJJw/AyCwr2rr8fooqa6+KOFQFlR5Q
EVgpfvOshlZDIqbcIGMiQgTOowqqYZMJH6uQI5oN3hVTq2CFk7w8zKKqViIumUh1
YbRwe9OY0EpYLqLZlK7ybiTqHW8ckQ==
=fBiW
-----END PGP SIGNATURE-----

--z8iX/zv5HmYisccf--

