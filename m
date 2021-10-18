Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5849D4317BD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJRLsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhJRLsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:12 -0400
Date:   Mon, 18 Oct 2021 11:45:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEcHhBvmDNuGhKbTLy0VsKziab7I8Phy3NVKDrg2Obw=;
        b=eqx82REawh7bDV6xX2PckEMWEG8nVGKNPqqQ79B2IroMzr+Fiaf9HYUHHmOMBSppYAQZ8E
        Yahz5wI7r7svH2sUpevS1/XQ5p0OrSUCdpgc9pQcd7UKQ7MH2kcww5Lj1LKxTEPQ+VJr5j
        KoHJ9eCJVLfLDAcPfdzywa0rWH3Lp2x+UWQp+h+GVk3LRwZda07yYqYjdfrCST+SVhCX3l
        HnRlsj2MYtvc4IrDcs93U4HFtg1nAQnKqP4BlBiaHUjUnOkMT44UKdxU1j9b+bYu23JH7Y
        BdpOqhQJfVyB2anSqgWoxxeH8RD/268HygGyEMHmbaY4EwTDaIM32LhzDae+zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEcHhBvmDNuGhKbTLy0VsKziab7I8Phy3NVKDrg2Obw=;
        b=5VXWSFFw9IKqIibvRTnF6MuFjxUprBB1A2v5A+tScvRfigikVHhaCJf1WgvUbCVND7aBVz
        6GZzuu/I1sNJYKCg==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: rcar_gen3_thermal: Read calibration
 from hardware
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211014103816.1939782-3-niklas.soderlund+renesas@ragnatech.se>
References: <20211014103816.1939782-3-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <163455755992.25758.13048367263186281980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c3131bd5586d3e8b67dc69516e1734a7a03e19d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//c3131bd5586d3e8b67dc69516e1734a7a03e19d7
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 14 Oct 2021 12:38:16 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 09:15:52 +02:00

thermal: rcar_gen3_thermal: Read calibration from hardware

In production hardware the calibration values used to convert register
values to temperatures can be read from hardware. While pre-production
hardware still depends on pseudo values hard-coded in the driver.

Add support for reading out calibration values from hardware if it's
fused. The presence of fused calibration is indicated in the THSCP
register.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211014103816.1939782-3-niklas.soderlund+ren=
esas@ragnatech.se
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 94 ++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 7d7e6eb..43eb25b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -34,6 +34,10 @@
 #define REG_GEN3_THCODE1	0x50
 #define REG_GEN3_THCODE2	0x54
 #define REG_GEN3_THCODE3	0x58
+#define REG_GEN3_PTAT1		0x5c
+#define REG_GEN3_PTAT2		0x60
+#define REG_GEN3_PTAT3		0x64
+#define REG_GEN3_THSCP		0x68
=20
 /* IRQ{STR,MSK,EN} bits */
 #define IRQ_TEMP1		BIT(0)
@@ -55,6 +59,9 @@
 #define THCTR_PONM	BIT(6)
 #define THCTR_THSST	BIT(0)
=20
+/* THSCP bits */
+#define THSCP_COR_PARA_VLD	(BIT(15) | BIT(14))
+
 #define CTEMP_MASK	0xFFF
=20
 #define MCELSIUS(temp)	((temp) * 1000)
@@ -245,6 +252,64 @@ static const struct soc_device_attribute r8a7795es1[] =
=3D {
 	{ /* sentinel */ }
 };
=20
+static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+	u32 thscp;
+
+	/* If fuses are not set, fallback to pseudo values. */
+	thscp =3D rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
+	if ((thscp & THSCP_COR_PARA_VLD) !=3D THSCP_COR_PARA_VLD) {
+		/* Default THCODE values in case FUSEs are not set. */
+		static const int thcodes[TSC_MAX_NUM][3] =3D {
+			{ 3397, 2800, 2221 },
+			{ 3393, 2795, 2216 },
+			{ 3389, 2805, 2237 },
+			{ 3415, 2694, 2195 },
+			{ 3356, 2724, 2244 },
+		};
+
+		priv->ptat[0] =3D 2631;
+		priv->ptat[1] =3D 1509;
+		priv->ptat[2] =3D 435;
+
+		for (i =3D 0; i < priv->num_tscs; i++) {
+			struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
+
+			tsc->thcode[0] =3D thcodes[i][0];
+			tsc->thcode[1] =3D thcodes[i][1];
+			tsc->thcode[2] =3D thcodes[i][2];
+		}
+
+		return false;
+	}
+
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] =3D rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
+		GEN3_FUSE_MASK;
+	priv->ptat[1] =3D rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
+		GEN3_FUSE_MASK;
+	priv->ptat[2] =3D rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
+		GEN3_FUSE_MASK;
+
+	for (i =3D 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
+
+		tsc->thcode[0] =3D rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[1] =3D rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[2] =3D rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
+			GEN3_FUSE_MASK;
+	}
+
+	return true;
+}
+
 static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *=
tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
@@ -393,16 +458,6 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
 	unsigned int i;
 	int ret;
=20
-	/* Default THCODE values in case FUSEs are not set. */
-	/* TODO: Read values from hardware on supported platforms */
-	static const int thcodes[TSC_MAX_NUM][3] =3D {
-		{ 3397, 2800, 2221 },
-		{ 3393, 2795, 2216 },
-		{ 3389, 2805, 2237 },
-		{ 3415, 2694, 2195 },
-		{ 3356, 2724, 2244 },
-	};
-
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -411,10 +466,6 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init =3D rcar_gen3_thermal_init_r8a7795es1;
=20
-	priv->ptat[0] =3D 2631;
-	priv->ptat[1] =3D 1509;
-	priv->ptat[2] =3D 435;
-
 	platform_set_drvdata(pdev, priv);
=20
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
@@ -442,11 +493,16 @@ static int rcar_gen3_thermal_probe(struct platform_devi=
ce *pdev)
 			goto error_unregister;
 		}
=20
-		tsc->thcode[0] =3D thcodes[i][0];
-		tsc->thcode[1] =3D thcodes[i][1];
-		tsc->thcode[2] =3D thcodes[i][2];
-
 		priv->tscs[i] =3D tsc;
+	}
+
+	priv->num_tscs =3D i;
+
+	if (!rcar_gen3_thermal_read_fuses(priv))
+		dev_info(dev, "No calibration values fused, fallback to driver values\n");
+
+	for (i =3D 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
=20
 		zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
@@ -476,8 +532,6 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
 	}
=20
-	priv->num_tscs =3D i;
-
 	if (!priv->num_tscs) {
 		ret =3D -ENODEV;
 		goto error_unregister;
