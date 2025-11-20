Return-Path: <linux-pm+bounces-38278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B7C72D55
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC9EC35AB10
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99038309F0A;
	Thu, 20 Nov 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VRmqaruD"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCF30E0FB
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626890; cv=none; b=Q8bRQggI282WFr6HZ/xo/TMDZwwVUx8+VaLE84MVQa2fzSJE9NMZ6qD4Iv19Tu1na80ktcNk5Ml+XV/M7nHXW8Jsqocchjf4+Qhy7IVU9WV3V7vYlvfDS6cOdbAOZAqD5k7oDcLpbiqLvcBkLWjvSY/pa9rgQIVts9GKj7Y9Ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626890; c=relaxed/simple;
	bh=s/16VOdpr0QUIyU0oAkl6ONql9+SiafPwXCzHW/0OdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfGlo1O2y0J1zUhtuXmUp1bZaq+p+GatAV1nbFj4ANKaAuaDLaa5QkoaG5nUwJYm6qYnZM6dspLePmadKEEuleGesE8Kjd0qb/KMmh0/AtFV0u4yAmv3+q6vP6MgDijp8VvtixMHV61EhXksexpiPrffnqPch0MN27WltnROcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VRmqaruD; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:21:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626886; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=zmi7c6vmk+RrdayqIHmndICemIZ6fzioj9RusF0N01g=;
	b=VRmqaruDtrK1wH66NfZqP17t/T6FdWdJAf2D2+I5EeKn7Y3/bzczu7+oivFlO7ABTouL8l
	rY9SKA/typvpIaXA4iVhrg4+gLvGVmdfRvw74jYTIVe37ifR0+Xj0UE5hYC/eo5odcQ0TR
	ijMdfTDoNKTh04Q8Uf73itsz2Ycx9dM=
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
Subject: [PATCH v5 07/16] mfd: rohm-bd71828: Use regmap_reg_range()
Message-ID: <b0c6256deb1388f0774b3c855c0614d363aa003b.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2UwjvEMUYcurv6R"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--x2UwjvEMUYcurv6R
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


--x2UwjvEMUYcurv6R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkez38ACgkQeFA3/03a
ocXyOQf/RrD6qS8POc+8LMIzVsn8w0IcQb75XjPnP1ShvY9z+jWF22gzjR9Bc0fM
tso5EfUySRNCyE74Ee/xCbsDiH/Gds6wjWCqtaDcSO51mCjOT+WUjGKqTLD53/jB
jwQIZanv6ajVOfoLK1Ol5TelhrfZYNnHpfJcspY6JDrNsgw9oPvSMd5q8RV3Gx2P
MS6c8uLqXhEan2p/Gj2eUTf3xkm19L4BOAZkLfjpGPOf+3HAX4oyzp92oFDGdg9n
GJKEQDQ+LGzE+FsvxF5gtOZFs97n+xPuO9misDemuPh6nS6GkWk/m/jrC3GphhGo
oG/oxis09pT8kFKNP5azTt0AHclSgQ==
=M5eq
-----END PGP SIGNATURE-----

--x2UwjvEMUYcurv6R--

