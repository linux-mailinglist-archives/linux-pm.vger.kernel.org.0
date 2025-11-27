Return-Path: <linux-pm+bounces-38791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EDC8DFC9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 833E734E762
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC032D7D6;
	Thu, 27 Nov 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgNar8A0"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77732D0DF
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242440; cv=none; b=c6iCEoRy9lI8WkkrxM0W4pEThmSrqCbS2kH8JPH0VfSYXBtvCMVa6oDEAd8FpGKhZmYvRv0jNcWhOb5jc0A0aPljtCddBwI0iMNazvwVTEm/di4Q/7kZS76TYDtnNOysvj5CM0SuXWivQJOGYdyau0RIIspteviBBApp49nZxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242440; c=relaxed/simple;
	bh=fOslbdq9zF3WBS1BYYu/Gyt5v+d3+aSXJt6p0ZG7umY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW8znr+CFwkINWvnGl564Uxkun8ChzzIO1B0Wmm0cs9dLrYog4IQtTkfwxnJ1tsnAA4bnKaEqWOn6Sf79qG4hPEXJrLuYRq8nxig5YobHoGNqS0x/ENPGFcSDruJ92VwRkBX8j7ItSeVZIb25n26pfNUH1EvJ9o5Wk8I9eProE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgNar8A0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:20:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242436; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=y4+tCJI7Rbc1T0M29RSQPQizzK5G4DGKXnhyxRdGSu0=;
	b=dgNar8A0mMP6WlyY9+LMNB/uULY+f4/pZ8t992aQMvHkplVt/FuxW9arIn5ESZLTebBYOk
	cqyuEO0DDLdZFTRRbcewxUW0OQ5KDeza2mXcMF8uDLaalv94IW2vU1iCsmkIAcmNynUv3U
	e7TslN3t6+A2gpFHNUzEKvN9UFP+xuY=
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
Subject: [PATCH v6 15/17] power: supply: bd71828: Support wider register
 addresses
Message-ID: <fc231dd4070de4417ec8a10de3a05c7abbc3fbb2.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="etUK1ThQ5Gc0kEdr"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--etUK1ThQ5Gc0kEdr
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
2.52.0


--etUK1ThQ5Gc0kEdr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoM/sACgkQeFA3/03a
ocVcXwgAhHayYkawdzox9A96YZs13yb/5VOj75hpAl8rCEFP4pQw27znOlORZGyu
AZUJ0dHglOkQ0EAQ8ZniIlpPo86ERS9PNso9RfCqGmw2wHlVH491N0LlMJ5+1tva
6S1c1qbDLOt3KscqIDm67wqk8791wTBT9m/H270hV329ubvuM1IACrP6QQ5hhDkv
5B97wB1Ilgq8oF5d7dz3NH6Os5S+Xfig0Ppp6QLmGD+0yXh9hk7Ws73EAxm3LJEa
NHasm6n2PFIaXtCwwSh3kmq5J39Z5jwc2iTsJNkjyrh0FQwwuNm7ezmxjYyxnSzw
YEc1TPX++ZGn/sDIFv0euMD+GT3alg==
=hGXE
-----END PGP SIGNATURE-----

--etUK1ThQ5Gc0kEdr--

