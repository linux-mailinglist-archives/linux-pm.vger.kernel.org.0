Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044158434F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiG1Plv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiG1Plu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4F68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:49 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QoGcdqWYpXKGevUndNi+8I4wyPRfpEvbczsVtb8fFE=;
        b=Kxz26DADZfihdyZkBJCcvY15LiBV0j0lv5e+5IXdzrKQ4suFNQpbCuGDF29zeh1EwsX18U
        +NirR0AaH8svgu7S3FadTtiCvsvg0Tc0cDTtsJ1okIZ9BqDi/b7o11lAdfXp9J5/lR4diP
        zoFpusx6fE53bsCHqZoAEaHR7Ss83zd0aoVhL53/83JawzOc4L1pyck7hIFWNp+i5co/Pu
        q2faPkBoGl/fL9DeswTc7yeNtpppFSTDnKWrGdOiQi+35xq/3dIHdippTfAhLrm4zHJJEs
        xDyZl/kgN0NA608jlG1JL6lMdBovD5giu3dpZXVhOJlaKyq90V4VSnYaE5I8iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QoGcdqWYpXKGevUndNi+8I4wyPRfpEvbczsVtb8fFE=;
        b=XM9IKgQy0pl5MHA37NMk3NLoqbj+btohx28JOgzJ1VJq7O6CV7utuS8q7jTsYDnduap8UK
        LrkOCUm/HGlvq2BQ==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rzg2l: Fix comments
Cc:     Pavel Machek <pavel@denx.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220718121440.556408-1-biju.das.jz@bp.renesas.com>
References: <20220718121440.556408-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165902290684.15455.6768618703496287374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8f5a9371e69664cf4ad22a84204340323d5165cc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//8f5a9371e69664cf4ad22a84204340323d5165cc
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 18 Jul 2022 13:14:40 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:49 +02:00

thermal/drivers/rzg2l: Fix comments

This patch replaces 'Capture times'->'Total number of ADC data samples' as
the former does not really explain much.

It also fixes the typo
 * caliberation->calibration

Lastly, as per the coding style /* should be on a separate line.
This patch fixes this issue.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718121440.556408-1-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rzg2l_thermal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index be07e04..51ae80e 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -47,7 +47,7 @@
=20
 #define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
 #define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
-#define TS_CODE_CAP_TIMES	8	/* Capture  times */
+#define TS_CODE_CAP_TIMES	8	/* Total number of ADC data samples */
=20
 #define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
 #define RZG2L_TSU_SS_TIMEOUT_US	1000
@@ -80,7 +80,8 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	int val, i;
=20
 	for (i =3D 0; i < TS_CODE_CAP_TIMES ; i++) {
-		/* TSU repeats measurement at 20 microseconds intervals and
+		/*
+		 * TSU repeats measurement at 20 microseconds intervals and
 		 * automatically updates the results of measurement. As per
 		 * the HW manual for measuring temperature we need to read 8
 		 * values consecutively and then take the average.
@@ -92,16 +93,18 @@ static int rzg2l_thermal_get_temp(void *devdata, int *tem=
p)
=20
 	ts_code_ave =3D result / TS_CODE_CAP_TIMES;
=20
-	/* Calculate actual sensor value by applying curvature correction formula
+	/*
+	 * Calculate actual sensor value by applying curvature correction formula
 	 * dsensor =3D ts_code_ave / (1 + ts_code_ave * 0.000013). Here we are doing
 	 * integer calculation by scaling all the values by 1000000.
 	 */
 	dsensor =3D TS_CODE_AVE_SCALE(ts_code_ave) /
 		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * CURVATURE_CORRECTION_CONST));
=20
-	/* The temperature Tj is calculated by the formula
+	/*
+	 * The temperature Tj is calculated by the formula
 	 * Tj =3D (dsensor =E2=88=92 calib1) * 165/ (calib0 =E2=88=92 calib1) =E2=
=88=92 40
-	 * where calib0 and calib1 are the caliberation values.
+	 * where calib0 and calib1 are the calibration values.
 	 */
 	val =3D ((dsensor - priv->calib1) * (MCELSIUS(165) /
 		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
@@ -122,7 +125,8 @@ static int rzg2l_thermal_init(struct rzg2l_thermal_priv *=
priv)
 	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
 	rzg2l_thermal_write(priv, TSU_ST, 0);
=20
-	/* Before setting the START bit, TSU should be in normal operating
+	/*
+	 * Before setting the START bit, TSU should be in normal operating
 	 * mode. As per the HW manual, it will take 60 =C2=B5s to place the TSU
 	 * into normal operating mode.
 	 */
@@ -217,7 +221,7 @@ static int rzg2l_thermal_probe(struct platform_device *pd=
ev)
 	if (ret)
 		goto err;
=20
-	dev_dbg(dev, "TSU probed with %s caliberation values",
+	dev_dbg(dev, "TSU probed with %s calibration values",
 		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
=20
 	return 0;
