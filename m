Return-Path: <linux-pm+bounces-7825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A58C4F6C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12551F22EB7
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398713F454;
	Tue, 14 May 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wto5xzZ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCSERmpJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0986634
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681943; cv=none; b=sWwUwjODfK9uN9e0sc12hFu6NhLGc6CGamQY3LPFjnRSi07qSSXNBgSfM/mCZGkdye4Tj7CQd0yGPDGP/90hPaJ7JoWY75AfZy+AXqmRH1EVe/37JR85Q7iBjkqxgAY/iBRHPx+N2OGE2BczsOc1hXwG81DsHYWMzNBsLiMtoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681943; c=relaxed/simple;
	bh=mrJaP43eUKzm89DtImKklmujQAEq2NdgZCUace7AY8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TR8av9BRpl4UqkdkFEYQ3Q4j+s1Wd1PkqZeyS/x7NpUKEy7nft4QCP/Rl6+k0qQBdws+DDgd6bjiDN6HdH1i+SKJefpk8oyoO58oYkyLIdaIILCDHuM2dnZ1pKq57BVmAVjg0cqaDJhzaH9Zvex0u74VDPyYksfes65wjH6cBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wto5xzZ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCSERmpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2WXm8NSRLp3N7FH7xYz8FKTya1CCs68uspTS66jtrU=;
	b=wto5xzZ+xf6kRN1esd9mufmZkWDiOPNJPlsXBsOScIrw2GigIauP5oEX0qFizeu+sLEulC
	1CrQn9rgC9Eo1pG7el+KW3/WfsLibdznqZipJXcpuPwLt265dEnWFovPm/7Jns+uL74Dz2
	wDK4sdHr5JZHRYpYvH9f+//uHhyn7U4dUxi1KAtqjZfYPaMOKlgEEQildN+hKviuO4mgbJ
	xoudTNJdtLPau9aEcju9Xn68eAnevmRMcrNYZJWSXb/wh5lXR1F+FLgEar5VjcNMU0vUtF
	RFq37zZYTimt5XF1pWp+sfaXR46pQay4UKMu3+YgISkhs8DS9OdB13Hz7kaLFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2WXm8NSRLp3N7FH7xYz8FKTya1CCs68uspTS66jtrU=;
	b=nCSERmpJfYYKVzD7CHD2IslI9cWeWIehfF9Uw/Xtne4mSaIkJeYUvrIewq2lwnx8AqmOFm
	PVHVuDCyvccrqZCQ==
From:
 thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/rcar_gen3: Move Tj_T storage
 to shared private data
Cc: niklas.soderlund+renesas@ragnatech.se,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240327133013.3982199-2-niklas.soderlund+renesas@ragnatech.se>
References: <20240327133013.3982199-2-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193515.10875.13744914230847731393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     566e0ea7d02ff596d7bcd81ca547e91b5074032f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//566e0ea7d02ff596d7bcd81ca547e91b5074032f
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 27 Mar 2024 14:30:12 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/rcar_gen3: Move Tj_T storage to shared private data

The calculated Tj_T constant is calculated from the PTAT data either
read from the first TSC zone on the device if calibration data is fused,
or from fallback values in the driver itself. The value calculated is
shared among all TSC zones.

Move the Tj_T constant to the shared private data structure instead of
duplicating it in each TSC private data. This requires adding a pointer
to the shared data to the TSC private data structure. This back pointer
make it easier to further rework the temperature conversion logic.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240327133013.3982199-2-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 35 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index a764cb1..7c1ca91 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -81,10 +81,10 @@ struct rcar_thermal_info {
 };
=20
 struct rcar_gen3_thermal_tsc {
+	struct rcar_gen3_thermal_priv *priv;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
-	int tj_t;
 	int thcode[3];
 };
=20
@@ -93,6 +93,7 @@ struct rcar_gen3_thermal_priv {
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
 	int ptat[3];
+	int tj_t;
 	const struct rcar_thermal_info *info;
 };
=20
@@ -136,26 +137,32 @@ static inline void rcar_gen3_thermal_write(struct rcar_=
gen3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
=20
-static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_priv *priv,
-					 struct rcar_gen3_thermal_tsc *tsc,
-					 int ths_tj_1)
+static void rcar_gen3_thermal_shared_coefs(struct rcar_gen3_thermal_priv *pr=
iv)
+{
+	int tj1 =3D priv->info->ths_tj_1;
+
+	priv->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (tj1 - TJ_3))
+		      / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
+}
+
+static void rcar_gen3_thermal_tsc_coefs(struct rcar_gen3_thermal_priv *priv,
+					struct rcar_gen3_thermal_tsc *tsc)
 {
+	int tj1 =3D priv->info->ths_tj_1;
+
 	/* TODO: Find documentation and document constant calculation formula */
=20
 	/*
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tsc->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_tj_1 - TJ_3=
))
-		     / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
-
 	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
-				 tsc->tj_t - FIXPT_INT(TJ_3));
+				 priv->tj_t - FIXPT_INT(TJ_3));
 	tsc->coef.b1 =3D FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
=20
 	tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
-				 tsc->tj_t - FIXPT_INT(ths_tj_1));
-	tsc->coef.b2 =3D FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * ths_tj_1;
+				 priv->tj_t - FIXPT_INT(tj1));
+	tsc->coef.b2 =3D FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * tj1;
 }
=20
 static int rcar_gen3_thermal_round(int temp)
@@ -196,10 +203,11 @@ static int rcar_gen3_thermal_get_temp(struct thermal_zo=
ne_device *tz, int *temp)
 static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *=
tsc,
 					      int mcelsius)
 {
+	struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
 	int celsius, val;
=20
 	celsius =3D DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <=3D INT_FIXPT(tsc->tj_t))
+	if (celsius <=3D INT_FIXPT(priv->tj_t))
 		val =3D celsius * tsc->coef.a1 + tsc->coef.b1;
 	else
 		val =3D celsius * tsc->coef.a2 + tsc->coef.b2;
@@ -516,6 +524,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 			goto error_unregister;
 		}
=20
+		tsc->priv =3D priv;
 		tsc->base =3D devm_ioremap_resource(dev, res);
 		if (IS_ERR(tsc->base)) {
 			ret =3D PTR_ERR(tsc->base);
@@ -530,11 +539,13 @@ static int rcar_gen3_thermal_probe(struct platform_devi=
ce *pdev)
 	if (!rcar_gen3_thermal_read_fuses(priv))
 		dev_info(dev, "No calibration values fused, fallback to driver values\n");
=20
+	rcar_gen3_thermal_shared_coefs(priv);
+
 	for (i =3D 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
=20
 		rcar_gen3_thermal_init(priv, tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, priv->info->ths_tj_1);
+		rcar_gen3_thermal_tsc_coefs(priv, tsc);
=20
 		zone =3D devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {

