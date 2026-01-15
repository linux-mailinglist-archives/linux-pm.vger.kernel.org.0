Return-Path: <linux-pm+bounces-40914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7627D23E5E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4943014D86
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E9337B9F;
	Thu, 15 Jan 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lf97RDW9"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5E221DAE
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472359; cv=none; b=MqDmMZF4UZ5fXVRO7BXMehmrXWZJXVh4lDvGUltQuOeTTmNRciIwMRlbce2t/7s3UTG+Ywy+OGPiepZ+zE0P8bouUpX6mvZdDAfAs4TyW83W5yebGnKKt/DPfbV9wtHo3dv2rRtbFOsU2p8dY+M85VAOg8Opaoj0Ii0opuHWNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472359; c=relaxed/simple;
	bh=VlB5rBBkWSMx7ezL9jBK+o+zTlbr1hEkzIUO8z7NLCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xhv2kCll8NqHAamiWxuwLUm3gAl2U/y/zYnkEd+cB97u6dUnpwTfAOG9TY8r6VdTcWXzE7HeZmn1w7z3guHWr93kUcpcP+6eDDRxbDYiH+os5aIHWleJmbElUMCXEPQ3iZx73kT23tL/AjPuP3F/mWV6MzKozyxrX5eszL6T+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lf97RDW9; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 12:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768472356; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=5+BOOFzH8ArDS4gtyMkYiUMDSfO+DALiP0vJPwkcvPQ=;
	b=Lf97RDW91g3RW1auL7z4mxIqEyzuAgxbBq1455TF8f55/0eo4pDdHa9PrFk/kx5j/l9/+R
	Y51qDyEETifr6IyffvslpEPlktD2fcM8XKeJv/Q4IQsYmcdgRSg6gQ/RkqRfOonSEN2PDt
	hsKR1SEeos7/wVLbsBQzXIad6uT0Qgw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] power: supply: bd71828: Use dev_err_probe()
Message-ID: <aWi_GG74sZRfajA_@mva-rohm>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HlnHiPctAo4Hjm7t"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--HlnHiPctAo4Hjm7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The driver uses separate error printing and error returning at probe()
for locations where the error value is hard-coded and can't be
EPROBE_DEFER. This helps to omit the extra return value check which is
done in dev_err_probe().

Using the dev_err_probe() has some other benefits besides handling the
-EPROBE_DEFER though, like standardizing the print for error numbers.
Some believe thes outweigh the benefit of skipping the extra check.

Use dev_err_probe() consistently in the bd71828 power-supply probe.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

This patch depends on, and is done on top of, the series:
https://lore.kernel.org/all/cover.1765804226.git.mazziesaccount@gmail.com/
as discussed:
https://lore.kernel.org/all/aWbg3PTf677Jt9rG@venus/

 drivers/power/supply/bd71828-power.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index 438e220a9cb7..0e00acb58993 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -1058,10 +1058,8 @@ static int bd71828_power_probe(struct platform_devic=
e *pdev)
 		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
 	else
 		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, "wrap-map");
-	if (!pwr->regmap) {
-		dev_err(&pdev->dev, "No parent regmap\n");
-		return -EINVAL;
-	}
+	if (!pwr->regmap)
+		return dev_err_probe(&pdev->dev, -EINVAL, "No parent regmap\n");
=20
 	pwr->dev =3D &pdev->dev;
=20
@@ -1083,8 +1081,7 @@ static int bd71828_power_probe(struct platform_device=
 *pdev)
 		dev_dbg(pwr->dev, "Found ROHM BD72720\n");
 		break;
 	default:
-		dev_err(pwr->dev, "Unknown PMIC\n");
-		return -EINVAL;
+		return dev_err_probe(pwr->dev, -EINVAL, "Unknown PMIC\n");
 	}
=20
 	ret =3D bd7182x_get_rsens(pwr);
--=20
2.52.0


--HlnHiPctAo4Hjm7t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlovxMACgkQeFA3/03a
ocXuVAgAiw62+uVf5uS15LxDE87X1clV/GIzvuz6h5N3cec4a7jwPzWfzLIUqZ4a
u2iw2I3KxnCjL6oy9xkM/q+mxweTKFzlM/YMaWxfc7cWF/AvzDXG0UyOgNfnxVkK
BvVTFR6V7IckG18CqrYWd13Hfb8BDkO37uO05fYSB3/rljrlpRPy+CU7lrZgs3qE
0MBjEqsxJ3hdBpCe1KTizWQxXGeCat8a9y1pVsTE804XiXcod/R8OkWJNIdVK0ao
etjBmeiTY8UqdhFl/2YtAkj9KZ3+pul/gbi5/DUrLvmeszC4Z2m9L/6cqfyDIgFY
1pF1cQFJwuUrMFR478pOcTzDCCSd+Q==
=xU3s
-----END PGP SIGNATURE-----

--HlnHiPctAo4Hjm7t--

