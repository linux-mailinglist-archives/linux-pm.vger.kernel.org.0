Return-Path: <linux-pm+bounces-37922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673DC56680
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F5B4E70F9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EDB333756;
	Thu, 13 Nov 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R49H1O1J"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F50330D32
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023997; cv=none; b=fNIy48YsIbdneT7Zm6pFnVQm00gHSaHIhOTroVK5HzTbMEblOTwSRr+hjP+iOcIK1Uhuy0HRaiivmW7u+qErNnSCPXS225n0SrO1+jn0eFBLmPOf+Spj1NJLHArr6CgWEC4dR1uMeXazH9zST5gkvcMJf3mJi2bOFX7VEl4vSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023997; c=relaxed/simple;
	bh=1YZRmBNlepkATlvAZsgLip5h9yPpsKDB8Ve0w3eLi0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj91P4FR7TjYBf4kXzRgHbpQTIWRqYCJoaoigFi86UM6z10ip0EHnDiOKMhoqjN2IDlOtLpm5azK9a6MMAm/0StUavOApn5MQemqxdHBgw46qjIjyEDjMiZahS7VZDNIKO1uDx7xyhrtUdfaiIfhTDNn3buFDyVY+g34p18fIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R49H1O1J; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763023992; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=/eTa0NJ3DTjCZ/Zj/UbEujKDtzwwAvVBRBi75gVWYGs=;
	b=R49H1O1JAuWCyqxxaA3Q71S3ior4PCQUcQRTf8ByCB8Fss0B5KIhDyBd9SpAfsIzzoMp/F
	GHlt+b1dzfEYkn52bBnv7aUtzQPf4JLYmGsx5SZQ+n9gbrzbgpkYt35Kg76cngOI/TZ5Ls
	UCz77GyxxCOHMdEZlr/snllepvtG9wo=
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
Subject: [PATCH v4 07/16] mfd: rohm-bd71828: Use regmap_reg_range()
Message-ID: <8629b93c778910dd3d55a3f4c3aa4e7c0232a906.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWnnQx6gIBuLXqbQ"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--OWnnQx6gIBuLXqbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The regmap range tables tend to be somewhat verbose. Using the
regmap_reg_range() can make the definitions slightly mode compact.

Tidy the regmap range tables by using the regmap_reg_range().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v2 =3D> :
 - no changes
 RFCv1 =3D> v2:
 - New patch
---
 drivers/mfd/rohm-bd71828.c | 64 +++++++++++---------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 84a64c3b9c9f..2a43005b67ee 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -157,55 +157,27 @@ static struct mfd_cell bd71828_mfd_cells[] =3D {
 };
=20
 static const struct regmap_range bd71815_volatile_ranges[] =3D {
-	{
-		.range_min =3D BD71815_REG_SEC,
-		.range_max =3D BD71815_REG_YEAR,
-	}, {
-		.range_min =3D BD71815_REG_CONF,
-		.range_max =3D BD71815_REG_BAT_TEMP,
-	}, {
-		.range_min =3D BD71815_REG_VM_IBAT_U,
-		.range_max =3D BD71815_REG_CC_CTRL,
-	}, {
-		.range_min =3D BD71815_REG_CC_STAT,
-		.range_max =3D BD71815_REG_CC_CURCD_L,
-	}, {
-		.range_min =3D BD71815_REG_VM_BTMP_MON,
-		.range_max =3D BD71815_REG_VM_BTMP_MON,
-	}, {
-		.range_min =3D BD71815_REG_INT_STAT,
-		.range_max =3D BD71815_REG_INT_UPDATE,
-	}, {
-		.range_min =3D BD71815_REG_VM_VSYS_U,
-		.range_max =3D BD71815_REG_REX_CTRL_1,
-	}, {
-		.range_min =3D BD71815_REG_FULL_CCNTD_3,
-		.range_max =3D BD71815_REG_CCNTD_CHG_2,
-	},
+	regmap_reg_range(BD71815_REG_SEC, BD71815_REG_YEAR),
+	regmap_reg_range(BD71815_REG_CONF, BD71815_REG_BAT_TEMP),
+	regmap_reg_range(BD71815_REG_VM_IBAT_U, BD71815_REG_CC_CTRL),
+	regmap_reg_range(BD71815_REG_CC_STAT, BD71815_REG_CC_CURCD_L),
+	regmap_reg_range(BD71815_REG_VM_BTMP_MON, BD71815_REG_VM_BTMP_MON),
+	regmap_reg_range(BD71815_REG_INT_STAT, BD71815_REG_INT_UPDATE),
+	regmap_reg_range(BD71815_REG_VM_VSYS_U, BD71815_REG_REX_CTRL_1),
+	regmap_reg_range(BD71815_REG_FULL_CCNTD_3, BD71815_REG_CCNTD_CHG_2),
 };
=20
 static const struct regmap_range bd71828_volatile_ranges[] =3D {
-	{
-		.range_min =3D BD71828_REG_PS_CTRL_1,
-		.range_max =3D BD71828_REG_PS_CTRL_1,
-	}, {
-		.range_min =3D BD71828_REG_PS_CTRL_3,
-		.range_max =3D BD71828_REG_PS_CTRL_3,
-	}, {
-		.range_min =3D BD71828_REG_RTC_SEC,
-		.range_max =3D BD71828_REG_RTC_YEAR,
-	}, {
-		/*
-		 * For now make all charger registers volatile because many
-		 * needs to be and because the charger block is not that
-		 * performance critical.
-		 */
-		.range_min =3D BD71828_REG_CHG_STATE,
-		.range_max =3D BD71828_REG_CHG_FULL,
-	}, {
-		.range_min =3D BD71828_REG_INT_MAIN,
-		.range_max =3D BD71828_REG_IO_STAT,
-	},
+	regmap_reg_range(BD71828_REG_PS_CTRL_1, BD71828_REG_PS_CTRL_1),
+	regmap_reg_range(BD71828_REG_PS_CTRL_3, BD71828_REG_PS_CTRL_3),
+	regmap_reg_range(BD71828_REG_RTC_SEC, BD71828_REG_RTC_YEAR),
+	/*
+	 * For now make all charger registers volatile because many
+	 * needs to be and because the charger block is not that
+	 * performance critical.
+	 */
+	regmap_reg_range(BD71828_REG_CHG_STATE, BD71828_REG_CHG_FULL),
+	regmap_reg_range(BD71828_REG_INT_MAIN, BD71828_REG_IO_STAT),
 };
=20
 static const struct regmap_access_table bd71815_volatile_regs =3D {
--=20
2.51.1


--OWnnQx6gIBuLXqbQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnHIACgkQeFA3/03a
ocVDaAf9Ftz+J+DpPS3xjpGiXCoIqfLJuSpoCLAoczvx0r7o2bAPDDBPmLyWIcys
wGlCxN/T9jmXD1DA1BwNymrh7p5BYTY/4xZNjJNvCncC6nP6Kfznpddf09Plar0S
3e3j3S+QtdJHO8A5Rfh+pbMzRQFSAW36mr3xVaWWKsI2j0O8USq5ffpA/gxnjQES
74bph3aVgMPBBWK53cEK4lHMGexJ8+p5t6nOchq5nt5ReFGfX62Kri3ZgKo/y7+k
0NJ4atukU5+5pC4pq25rXrWKWaEVsnq83NqedYjcBd5DlEeZHXbs8D929QkmeZpi
iIiF3MaVlwy7qLAIbdLKaWPa2G4mGw==
=Rkq0
-----END PGP SIGNATURE-----

--OWnnQx6gIBuLXqbQ--

