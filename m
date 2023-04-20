Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F406E8DE0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjDTJWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjDTJWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 05:22:02 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BAE4EDE
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=/
        jibvsfqCcVhEmRkQFpc6NYTB8t0y/k/0Q/UNHfzCHc=; b=iCcFey5hz1TbabaOm
        dSaxbKd05fBmxa+kTMMnBrwbu/1ZaoCUJkg8vz3zB/IfW8zDahvy8p/vNjjFF/gt
        JjBrQCToj0PHNwgc7vKkFHVRxDR2cUjgiKjmqYWkgrO5jbBjBi0XSZ6J92QeQo0f
        8IgPP5evUXGKeJKa5edAcpmTUE=
Received: (qmail 4000118 invoked from network); 20 Apr 2023 11:21:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Apr 2023 11:21:46 +0200
X-UD-Smtp-Session: l3s3148p1@W5/SEcH53M0ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 2/3] drivers/thermal/rcar_gen3_thermal: refactor reading fuses into seprarate function
Date:   Thu, 20 Apr 2023 11:21:26 +0200
Message-Id: <20230420092128.6073-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
References: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gen4 will be very different, so refactor Gen3 access into separate call
first.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 60 +++++++++++++++++------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e9b0aa0a2016..39b382ee08c8 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -66,8 +66,11 @@ struct equation_coefs {
 	int b2;
 };
 
+struct rcar_gen3_thermal_priv;
+
 struct rcar_thermal_info {
 	int ths_tj_1;
+	void (*read_fuses)(struct rcar_gen3_thermal_priv *priv);
 };
 
 struct rcar_gen3_thermal_tsc {
@@ -241,6 +244,34 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
+		GEN3_FUSE_MASK;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
+		GEN3_FUSE_MASK;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
+		GEN3_FUSE_MASK;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
+			GEN3_FUSE_MASK;
+	}
+}
+
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
 	unsigned int i;
@@ -248,7 +279,8 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 
 	/* If fuses are not set, fallback to pseudo values. */
 	thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
-	if ((thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
+	if (!priv->info->read_fuses ||
+	    (thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
 		/* Default THCODE values in case FUSEs are not set. */
 		static const int thcodes[TSC_MAX_NUM][3] = {
 			{ 3397, 2800, 2221 },
@@ -273,29 +305,7 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 		return false;
 	}
 
-	/*
-	 * Set the pseudo calibration points with fused values.
-	 * PTAT is shared between all TSCs but only fused for the first
-	 * TSC while THCODEs are fused for each TSC.
-	 */
-	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
-		GEN3_FUSE_MASK;
-	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
-		GEN3_FUSE_MASK;
-	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
-		GEN3_FUSE_MASK;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
-
-		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
-			GEN3_FUSE_MASK;
-		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
-			GEN3_FUSE_MASK;
-	}
-
+	priv->info->read_fuses(priv);
 	return true;
 }
 
@@ -325,10 +335,12 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
 	.ths_tj_1 = 116,
+	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.ths_tj_1 = 126,
+	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-- 
2.30.2

