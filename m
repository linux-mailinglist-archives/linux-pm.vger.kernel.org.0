Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA30C1BE56
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfEMUEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 16:04:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43500 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUEN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 16:04:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so7762706pfa.10;
        Mon, 13 May 2019 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kohCOyVtYT/37SXICTY60qowJFgNNpE4dJPKwqxFQI4=;
        b=DEE1mLA2YcaVr5H9RFmEJi0u32DKMlTK8ecX+WEeE/efUSF4xZTsS3bvmjLTjZUXey
         hCGwY/UOOgSDlE7lSKl8Y0sfFpy6xJ2547J+3SmR2bfwNKsbgbLyCtREuvwYlPwscpCT
         nyD8SNCYBgqIKmx5hYq1kC/Nzcg0GdOSQ45RDi8Ih5jwYsTae/aX8wHRJYUnUt60QRU1
         wG/tB0qbEXxXAOGGHKCeLypIFljnMorJ7JGOLVbd83/hCcoYJJ++W6TKXen/7c7ROmsq
         XJczR2ApsS14jhOSuhwBPEs7db4Aj6nGLDEAI6hk1o2CrE87kSMNdUrVQEUyRPyW5sP3
         V34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kohCOyVtYT/37SXICTY60qowJFgNNpE4dJPKwqxFQI4=;
        b=fkY94C9ZhrXfZkRdyaYUrvxT80CmYfhu8yx7pNLEelWMlMN23IGklSCIKUZ+cLNuT/
         Cn0X/SIdjLqsPbZaWXt6gt5Jhr19pOwkGFNh8tZSzv3gcXJj46+Z4rerikAI+9glHUtn
         bwG9zjnR5Erf5PHeogad2wZrEkn8inSD6E7+X3soodWpt7q/o8QNq+QY61uNPYE4hYwK
         rDcoLKcPSLqb+WPDOHYrbxqtCZo9rVMEBDm/I55zCQNA3rL0c2A12A+EuGJ2WkAnPdvp
         kS/+mJKO2iV29RlYdZNhWYjrpmpEt4f9tpCC2MIg1Ffi8SE2xiRNRFI8a9bz3/ZBNSTO
         3T7w==
X-Gm-Message-State: APjAAAVXwfIq/wj82lL2v/Bl0beY1A1Eby6kSMJFdyTpxVsIkyWoIuY6
        Qaued25nQVEwkp33gThrW2ak6V0y
X-Google-Smtp-Source: APXvYqyiVYHtDDyhZAgZtTuYWU1mPVzi2rMHI+6YpfHiCRF9r8hfbL8GxW+XCJfZJQCR2cPYyFUzLw==
X-Received: by 2002:a63:6647:: with SMTP id a68mr18125002pgc.292.1557777852952;
        Mon, 13 May 2019 13:04:12 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id y3sm19167506pfe.9.2019.05.13.13.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 13:04:12 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v3 1/3] thermal: rcar_gen3_thermal: Update value of Tj_1
Date:   Tue, 14 May 2019 05:03:53 +0900
Message-Id: <1557777835-19454-2-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
References: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As evaluation of hardware team, temperature calculation formula
of M3-W is difference from all other SoCs as below:
- M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
- Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41c..265ff6d 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -124,11 +124,11 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
 
 /* no idea where these constants come from */
-#define TJ_1 116
 #define TJ_3 -41
 
 static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
-					 int *ptat, int *thcode)
+					 int *ptat, int *thcode,
+					 int ths_tj_1)
 {
 	int tj_2;
 
@@ -139,15 +139,15 @@ static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
 	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) - FIXPT_INT(41);
+		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
 	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
 			     tj_2 - FIXPT_INT(TJ_3));
 	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
 
 	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(TJ_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * TJ_1;
+			     tj_2 - FIXPT_INT(ths_tj_1));
+	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -318,12 +318,29 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
+static const int rcar_gen3_ths_tj_1 = 126;
+static const int rcar_gen3_ths_tj_1_m3_w = 116;
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r8a774a1-thermal", },
-	{ .compatible = "renesas,r8a7795-thermal", },
-	{ .compatible = "renesas,r8a7796-thermal", },
-	{ .compatible = "renesas,r8a77965-thermal", },
-	{ .compatible = "renesas,r8a77980-thermal", },
+	{
+		.compatible = "renesas,r8a774a1-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a7795-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
+		.compatible = "renesas,r8a7796-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a77965-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
+		.compatible = "renesas,r8a77980-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
@@ -349,6 +366,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
+	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, irq, i;
@@ -422,7 +440,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
+		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
-- 
1.9.1

