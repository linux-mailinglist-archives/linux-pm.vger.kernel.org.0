Return-Path: <linux-pm+bounces-7830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35F8C4F71
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E09A1C20CA9
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0BD13FD6E;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juDQ9V4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cz8WRDlD"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1598627C
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=JO69d5UJaiUZSdFCqNS2NCU76JjKOsnRu5o41zf4YA7bkQ2LSSYHUuxGc+ROm7sxjW5p/pSPpTblwJcwXVp2/3Hfl3B5/4SfN4EmnRxUDyTL60Q6yaPpIv5bskEJmYLgdNcQ1tuulEa2DaTPkuF17g7OvHOubYyV0x5fU5KAtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=OrsKSIQd8VlIUziEu8ut1BV6MflIROzYj279lH3UXMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DONrdxZYmcIpct841BSWoIE2AXNCGHjZEcLFjfdHHEoHUa77R1QvNGBM/QnIjkj0si3mKQfuAZzeIFN04syf/GIT5K/3XWRlM7p54zHbbzS+znquqtSiou0K7BmMV4VEX1S3NEsWkSSHiGG/k7i/vfSpj5npD75Ey3J6UOAirNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juDQ9V4h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cz8WRDlD; arc=none smtp.client-ip=193.142.43.55
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
	bh=tPpcBsAWIQKzuPO5Fyzw/oFxajW3l3c2JcQYc5ejZi4=;
	b=juDQ9V4hlbPgNBcJZGAYFPkxFSI/KKjgGPUK8q1VYcs3PwQ7t0tnNEU4JSj36siA2QqLsg
	Xm+UQj3NHUK2wGpvj5RbyBXz4PX8G+yimKz+H1zOzc3JoUfBR9F+BJ17otctxwZNPahQWm
	ncx+kMJADZjXYsJoOJZh5Jd5Ey8QgrfH/uczfVI+eZuxhQ6xNJ6fRdB9MdY36/TaU26YYj
	4uHRcAVAUVTwfP3S1lhHM/JP+QjOXyMTjDu+871ymAzN3j2I95bG1kQ0BSg6kpUfIZ7TNx
	OGxq6J0dx1jml2vxn+sosVemNrH+4BHr873Plhyh6ztTOxUpBFF/e0FoGW85zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPpcBsAWIQKzuPO5Fyzw/oFxajW3l3c2JcQYc5ejZi4=;
	b=cz8WRDlD1Vh4TlYPq3i88BK3n052wyhyf7NmWS3KlL+idTuy7kAOHUNWjuDCuwQCxwnBUa
	giC/AHwNOQSSbiBQ==
From:
 thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/rcar_gen3: Update
 temperature approximation calculation
Cc: niklas.soderlund+renesas@ragnatech.se,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240327133013.3982199-3-niklas.soderlund+renesas@ragnatech.se>
References: <20240327133013.3982199-3-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193500.10875.11392204125969869858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     63d23fb78140a882e268201ff730453cd8b4f8e8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//63d23fb78140a882e268201ff730453cd8b4f8e8
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 27 Mar 2024 14:30:13 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/rcar_gen3: Update temperature approximation calculation

The initial driver used a formula to approximate the temperature and
register values reversed engineered from an out-of-tree BSP driver. This
was needed as the datasheet at the time did not contain any information
on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
this information.

Update the approximation formula to use the datasheet's information
instead of the reversed-engineered one.

On an idle M3-N without fused calibration values for PTAT and THCODE the
old formula reports,

    zone0: 52000
    zone1: 53000
    zone2: 52500

While the new formula under the same circumstances reports,

    zone0: 52500
    zone1: 54000
    zone2: 54000

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240327133013.3982199-3-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 156 +++++++++++++--------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 7c1ca91..02494fa 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -65,26 +65,29 @@
=20
 #define TSC_MAX_NUM	5
=20
-/* Structure for thermal temperature calculation */
-struct equation_coefs {
-	int a1;
-	int b1;
-	int a2;
-	int b2;
-};
-
 struct rcar_gen3_thermal_priv;
=20
 struct rcar_thermal_info {
-	int ths_tj_1;
+	int scale;
+	int adj_below;
+	int adj_above;
 	void (*read_fuses)(struct rcar_gen3_thermal_priv *priv);
 };
=20
+struct equation_set_coef {
+	int a;
+	int b;
+};
+
 struct rcar_gen3_thermal_tsc {
 	struct rcar_gen3_thermal_priv *priv;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
-	struct equation_coefs coef;
+	/* Different coefficients are used depending on a threshold. */
+	struct {
+		struct equation_set_coef below;
+		struct equation_set_coef above;
+	} coef;
 	int thcode[3];
 };
=20
@@ -112,90 +115,75 @@ static inline void rcar_gen3_thermal_write(struct rcar_=
gen3_thermal_tsc *tsc,
 /*
  * Linear approximation for temperature
  *
- * [reg] =3D [temp] * a + b =3D> [temp] =3D ([reg] - b) / a
+ * [temp] =3D ((thadj - [reg]) * a) / b + adj
+ * [reg] =3D thadj - ([temp] - adj) * b / a
  *
  * The constants a and b are calculated using two triplets of int values PTAT
  * and THCODE. PTAT and THCODE can either be read from hardware or use hard
- * coded values from driver. The formula to calculate a and b are taken from
- * BSP and sparsely documented and understood.
+ * coded values from the driver. The formula to calculate a and b are taken =
from
+ * the datasheet. Different calculations are needed for a and b depending on
+ * if the input variables ([temp] or [reg]) are above or below a threshold. =
The
+ * threshold is also calculated from PTAT and THCODE using formulas from the
+ * datasheet.
+ *
+ * The constant thadj is one of the THCODE values, which one to use depends =
on
+ * the threshold and input value.
  *
- * Examining the linear formula and the formula used to calculate constants a
- * and b while knowing that the span for PTAT and THCODE values are between
- * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff =3D=3D 0xff=
e001.
- * Integer also needs to be signed so that leaves 7 bits for binary
- * fixed point scaling.
+ * The constants adj is taken verbatim from the datasheet. Two values exists,
+ * which one to use depends on the input value and the calculated threshold.
+ * Furthermore different SoC models supported by the driver have different s=
ets
+ * of values. The values for each model are stored in the device match data.
  */
=20
-#define FIXPT_SHIFT 7
-#define FIXPT_INT(_x) ((_x) << FIXPT_SHIFT)
-#define INT_FIXPT(_x) ((_x) >> FIXPT_SHIFT)
-#define FIXPT_DIV(_a, _b) DIV_ROUND_CLOSEST(((_a) << FIXPT_SHIFT), (_b))
-#define FIXPT_TO_MCELSIUS(_x) ((_x) * 1000 >> FIXPT_SHIFT)
-
-#define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
-
-/* no idea where these constants come from */
-#define TJ_3 -41
-
 static void rcar_gen3_thermal_shared_coefs(struct rcar_gen3_thermal_priv *pr=
iv)
 {
-	int tj1 =3D priv->info->ths_tj_1;
-
-	priv->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (tj1 - TJ_3))
-		      / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
+	priv->tj_t =3D
+		DIV_ROUND_CLOSEST((priv->ptat[1] - priv->ptat[2]) * priv->info->scale,
+				  priv->ptat[0] - priv->ptat[2])
+		+ priv->info->adj_below;
 }
-
 static void rcar_gen3_thermal_tsc_coefs(struct rcar_gen3_thermal_priv *priv,
 					struct rcar_gen3_thermal_tsc *tsc)
 {
-	int tj1 =3D priv->info->ths_tj_1;
-
-	/* TODO: Find documentation and document constant calculation formula */
-
-	/*
-	 * Division is not scaled in BSP and if scaled it might overflow
-	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
-	 */
-	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
-				 priv->tj_t - FIXPT_INT(TJ_3));
-	tsc->coef.b1 =3D FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
-
-	tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
-				 priv->tj_t - FIXPT_INT(tj1));
-	tsc->coef.b2 =3D FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * tj1;
-}
-
-static int rcar_gen3_thermal_round(int temp)
-{
-	int result, round_offs;
+	tsc->coef.below.a =3D priv->info->scale * (priv->ptat[2] - priv->ptat[1]);
+	tsc->coef.above.a =3D priv->info->scale * (priv->ptat[0] - priv->ptat[1]);
=20
-	round_offs =3D temp >=3D 0 ? RCAR3_THERMAL_GRAN / 2 :
-		-RCAR3_THERMAL_GRAN / 2;
-	result =3D (temp + round_offs) / RCAR3_THERMAL_GRAN;
-	return result * RCAR3_THERMAL_GRAN;
+	tsc->coef.below.b =3D (priv->ptat[2] - priv->ptat[0]) * (tsc->thcode[2] - t=
sc->thcode[1]);
+	tsc->coef.above.b =3D (priv->ptat[0] - priv->ptat[2]) * (tsc->thcode[1] - t=
sc->thcode[0]);
 }
=20
 static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *t=
emp)
 {
 	struct rcar_gen3_thermal_tsc *tsc =3D thermal_zone_device_priv(tz);
-	int mcelsius, val;
-	int reg;
+	struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
+	const struct equation_set_coef *coef;
+	int adj, decicelsius, reg, thcode;
=20
 	/* Read register and convert to mili Celsius */
 	reg =3D rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
=20
-	if (reg <=3D tsc->thcode[1])
-		val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
-				tsc->coef.a1);
-	else
-		val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
-				tsc->coef.a2);
-	mcelsius =3D FIXPT_TO_MCELSIUS(val);
+	if (reg < tsc->thcode[1]) {
+		adj =3D priv->info->adj_below;
+		coef =3D &tsc->coef.below;
+		thcode =3D tsc->thcode[2];
+	} else {
+		adj =3D priv->info->adj_above;
+		coef =3D &tsc->coef.above;
+		thcode =3D tsc->thcode[0];
+	}
+
+	/*
+	 * The dividend can't be grown as it might overflow, instead shorten the
+	 * divisor to convert to decidegree Celsius. If we convert after the
+	 * division precision is lost as we will scale up from whole degrees
+	 * Celsius.
+	 */
+	decicelsius =3D DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 10);
=20
 	/* Guaranteed operating range is -40C to 125C. */
=20
-	/* Round value to device granularity setting */
-	*temp =3D rcar_gen3_thermal_round(mcelsius);
+	/* Reporting is done in millidegree Celsius */
+	*temp =3D decicelsius * 100 + adj * 1000;
=20
 	return 0;
 }
@@ -204,15 +192,21 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rc=
ar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
 	struct rcar_gen3_thermal_priv *priv =3D tsc->priv;
-	int celsius, val;
+	const struct equation_set_coef *coef;
+	int adj, celsius, thcode;
=20
 	celsius =3D DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <=3D INT_FIXPT(priv->tj_t))
-		val =3D celsius * tsc->coef.a1 + tsc->coef.b1;
-	else
-		val =3D celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius < priv->tj_t) {
+		coef =3D &tsc->coef.below;
+		adj =3D priv->info->adj_below;
+		thcode =3D tsc->thcode[2];
+	} else {
+		coef =3D &tsc->coef.above;
+		adj =3D priv->info->adj_above;
+		thcode =3D tsc->thcode[0];
+	}
=20
-	return INT_FIXPT(val);
+	return thcode - DIV_ROUND_CLOSEST((celsius - adj) * coef->b, coef->a);
 }
=20
 static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int l=
ow, int high)
@@ -377,17 +371,23 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_the=
rmal_priv *priv,
 }
=20
 static const struct rcar_thermal_info rcar_m3w_thermal_info =3D {
-	.ths_tj_1 =3D 116,
+	.scale =3D 157,
+	.adj_below =3D -41,
+	.adj_above =3D 116,
 	.read_fuses =3D rcar_gen3_thermal_read_fuses_gen3,
 };
=20
 static const struct rcar_thermal_info rcar_gen3_thermal_info =3D {
-	.ths_tj_1 =3D 126,
+	.scale =3D 167,
+	.adj_below =3D -41,
+	.adj_above =3D 126,
 	.read_fuses =3D rcar_gen3_thermal_read_fuses_gen3,
 };
=20
 static const struct rcar_thermal_info rcar_gen4_thermal_info =3D {
-	.ths_tj_1 =3D 126,
+	.scale =3D 167,
+	.adj_below =3D -41,
+	.adj_above =3D 126,
 	.read_fuses =3D rcar_gen3_thermal_read_fuses_gen4,
 };
=20

