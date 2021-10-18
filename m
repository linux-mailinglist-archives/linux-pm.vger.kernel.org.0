Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990434317BF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJRLsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhJRLsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B6C06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 04:46:03 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:46:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYWzFa1eJSsBIbpFrxfVI6heeq89CTXsE73LvSDIGn4=;
        b=tISS4mXmtkZOxCTkKpxNkZzddGkQICvjk/nhpo9mz5Vl0S+ZTtF3dhMbpdDiFOu/A7UgLS
        LHWH94Az8ddbcCXTfoxgzLoUqvyqkXbZ4xQKQsd2d5dtn7N/pyii3VnaoDCgHwNfI2elDi
        ffTTtoE6eav1J9qykBqj5eq0vN9UteM/aNc0cg12bnSyyyig8Fvo/SZ3ybG81crxe1dRdx
        WlSftUQlFD863GfM4duLwy2qkpzr+udlXS6992RZakXZyONF/wK2BsT+Dr7Hws6bUg1PHb
        CMpwz4Lfks/K2QLbSakm/S1YbpTnua++iI4culoGMrwVqQkHGImu3gfSziFNtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYWzFa1eJSsBIbpFrxfVI6heeq89CTXsE73LvSDIGn4=;
        b=pGrVky2kNPASQ+2ia6MdLzMxVakQkxa8S6PtGbs9+MqQUFyw+jD9C5j7O5bRI1Jig0zLMA
        3w95E4DOS9UGqPDA==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: rcar_gen3_thermal: Store thcode and
 ptat in priv data
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211014103816.1939782-2-niklas.soderlund+renesas@ragnatech.se>
References: <20211014103816.1939782-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <163455756063.25758.1280932998112405201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b8aaf1415a1bc3a61f870366b3f989b3bc3e2824
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//b8aaf1415a1bc3a61f870366b3f989b3bc3e2824
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 14 Oct 2021 12:38:15 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 09:15:52 +02:00

thermal: rcar_gen3_thermal: Store thcode and ptat in priv data

Prepare for reading the THCODE and PTAT values from hardware fuses by
storing the values used during calculations in the drivers private
data structures.

As the values are now stored directly in the private data structures
there is no need to keep track of the TSC channel id as its only usage
was to lookup the THCODE row, drop it.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211014103816.1939782-2-niklas.soderlund+ren=
esas@ragnatech.se
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 51 +++++++++++++++-------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 85228d3..7d7e6eb 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -62,15 +62,6 @@
=20
 #define TSC_MAX_NUM	5
=20
-/* default THCODE values if FUSEs are missing */
-static const int thcodes[TSC_MAX_NUM][3] =3D {
-	{ 3397, 2800, 2221 },
-	{ 3393, 2795, 2216 },
-	{ 3389, 2805, 2237 },
-	{ 3415, 2694, 2195 },
-	{ 3356, 2724, 2244 },
-};
-
 /* Structure for thermal temperature calculation */
 struct equation_coefs {
 	int a1;
@@ -84,13 +75,14 @@ struct rcar_gen3_thermal_tsc {
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
 	int tj_t;
-	unsigned int id; /* thermal channel id */
+	int thcode[3];
 };
=20
 struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
 	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
+	int ptat[3];
 };
=20
 static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
@@ -133,8 +125,8 @@ static inline void rcar_gen3_thermal_write(struct rcar_ge=
n3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
=20
-static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
-					 int *ptat, const int *thcode,
+static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_priv *priv,
+					 struct rcar_gen3_thermal_tsc *tsc,
 					 int ths_tj_1)
 {
 	/* TODO: Find documentation and document constant calculation formula */
@@ -143,16 +135,16 @@ static void rcar_gen3_thermal_calc_coefs(struct rcar_ge=
n3_thermal_tsc *tsc,
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * (ths_tj_1 - TJ_3))
-		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
+	tsc->tj_t =3D (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_tj_1 - TJ_3=
))
+		     / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
=20
-	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
+	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
 				 tsc->tj_t - FIXPT_INT(TJ_3));
-	tsc->coef.b1 =3D FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
+	tsc->coef.b1 =3D FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
=20
-	tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
+	tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
 				 tsc->tj_t - FIXPT_INT(ths_tj_1));
-	tsc->coef.b2 =3D FIXPT_INT(thcode[0]) - tsc->coef.a2 * ths_tj_1;
+	tsc->coef.b2 =3D FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * ths_tj_1;
 }
=20
 static int rcar_gen3_thermal_round(int temp)
@@ -174,7 +166,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int =
*temp)
 	/* Read register and convert to mili Celsius */
 	reg =3D rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
=20
-	if (reg <=3D thcodes[tsc->id][1])
+	if (reg <=3D tsc->thcode[1])
 		val =3D FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
 				tsc->coef.a1);
 	else
@@ -401,9 +393,15 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
 	unsigned int i;
 	int ret;
=20
-	/* default values if FUSEs are missing */
+	/* Default THCODE values in case FUSEs are not set. */
 	/* TODO: Read values from hardware on supported platforms */
-	int ptat[3] =3D { 2631, 1509, 435 };
+	static const int thcodes[TSC_MAX_NUM][3] =3D {
+		{ 3397, 2800, 2221 },
+		{ 3393, 2795, 2216 },
+		{ 3389, 2805, 2237 },
+		{ 3415, 2694, 2195 },
+		{ 3356, 2724, 2244 },
+	};
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -413,6 +411,10 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init =3D rcar_gen3_thermal_init_r8a7795es1;
=20
+	priv->ptat[0] =3D 2631;
+	priv->ptat[1] =3D 1509;
+	priv->ptat[2] =3D 435;
+
 	platform_set_drvdata(pdev, priv);
=20
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
@@ -439,7 +441,10 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
 			ret =3D PTR_ERR(tsc->base);
 			goto error_unregister;
 		}
-		tsc->id =3D i;
+
+		tsc->thcode[0] =3D thcodes[i][0];
+		tsc->thcode[1] =3D thcodes[i][1];
+		tsc->thcode[2] =3D thcodes[i][2];
=20
 		priv->tscs[i] =3D tsc;
=20
@@ -453,7 +458,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		tsc->zone =3D zone;
=20
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
=20
 		tsc->zone->tzp->no_hwmon =3D false;
 		ret =3D thermal_add_hwmon_sysfs(tsc->zone);
