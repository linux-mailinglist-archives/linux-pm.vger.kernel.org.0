Return-Path: <linux-pm+bounces-39572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EFCBE07C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 999E7301D631
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580B31BCAF;
	Mon, 15 Dec 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LH8JqM5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4732D43B;
	Mon, 15 Dec 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804880; cv=none; b=oJrs80xecBP5EyS8T752KQULHgs3PBbpQhKAczoJwGugqilmHodBkxb39f6TPBwPxLEFqMDwvcV6H5Yuu+SDytpdFvrmTXW3FO+8vYi06cKiKvqZ1RyF5wNjM0eYQZJIxAgmEPRTs3XYfvdsmCjw1km5e0bi8gidVDIPiD4HRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804880; c=relaxed/simple;
	bh=Jw+CX3PHdG2rHH3xrE0jpWheNpQR9tkuVjIZOkOxeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPtGjbWToNGIdXqykU97LbspOkDsnyV9fIfS1yPcSuKVrKF0OIIv3OMtKc2FePv5MHNyNsx4wHDYgPkETfGPQwom5oGLFnwsihtbkwMj4GI/FzueT/i/oRLOxKSl7hwOpTl6hRrUtOotvcA3rIQbScXalgrAY9oGIQkokigdLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LH8JqM5G; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804872; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=aIDX8dlrQfZYDV9HKQkvFvrDlGxMhp6dMUe5xU4EmoA=;
	b=LH8JqM5GKm+62fg3Y9/5ch2nGoFMzwpXp615ZbEYkM5Z1S58/BzvBFWvgLrM+mRURC65Um
	5kJ2Ehs2DvchUvmV+BKlJ/DWHQYVuGkC3ykYRXVKFN94gLice1KM1FrtYh+F0dHuqm8dBN
	HwCwvTcj0PP401mb8LmYDTgdjcfbb7c=
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
Subject: [PATCH RESEND v6 15/17] power: supply: bd71828: Support wider
 register addresses
Message-ID: <57c87f7e2082a666f0adeafcd11f673c0af7d326.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54kIi+IO5qC+nA/M"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--54kIi+IO5qC+nA/M
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


--54kIi+IO5qC+nA/M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACz8ACgkQeFA3/03a
ocVqxggAj3bxN7BT3GSQ2QVWHScrNKrRMRVFc3iP68Nd9RFiIi5Ov/+uWUR24H7+
8Yiz5/dSaRG1LCvaritIa/mUdmma8fcsTF9dGialP36OhRGSPcu0uEYqkCR3acMY
asB8C6XrQYIIXD/48D1SWX2ar1sdkIMzqmeQ3RlYpgZmalNEsaBqUeCGanDtguVu
OMtxomHQJ6Glm8nvaYKLbGEkL4g9A0mZh9ArQwLlvaGaswdMd1AH+lDlUeIG3Zdd
tkrfAb1zlu2irUfwo+0+gPw/A6mBry6eMGBrEN4vHxmpKgYb5HweysGcCQ9hIzgC
JFYNxkgJ0Lynd4Do5u77t3ysxOJcmg==
=eSjJ
-----END PGP SIGNATURE-----

--54kIi+IO5qC+nA/M--

