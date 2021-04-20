Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B344365F57
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhDTSel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTSej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25EC06174A;
        Tue, 20 Apr 2021 11:34:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so46254313edt.13;
        Tue, 20 Apr 2021 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=737hIwn3pods25c8zCbCGP0noOsJUI3v0XpSgnln2no=;
        b=rxiJGGTcBqWxKSZaTlWQtUL6gPZ1Hfbf+P0DLOZjdyP0/rcK021JJYZwkaZnXvFoMa
         Xs1xAc8sC0KYTO2gmjh7wftkLPkUMZUxnkXkLs3mFGE/EWOTDu9+/f5mwhcyEneDPZO7
         NxvZPHbVzR+BbmtG40POUsMW2w9LxMpzeJ8tjIS2GOTJXl82qhplVtnO91UACvrO4H9m
         cAt3viEIw8ByPRCWq3XM0FK0JidZMKnXCxbrmWzioR5SlQLzf5NkJFbd+RE9ss9tbhg8
         Zcyw19+M77jAkm2r0fGrHYW8mdOEJ8mo75YyC2c92+RgGDG0gEOB2SvrWs7P1ADCAM/Q
         JhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=737hIwn3pods25c8zCbCGP0noOsJUI3v0XpSgnln2no=;
        b=KP0JdbBYVHHfRmtd7v4T8H+nnbxk5aaLxLN8LyWjkjiQ0fQyeramV7/UdHcaGbAwr/
         C1E5CN5P12cybyd4dIm13ouQ6MXQsYUcCp4+CMDQ6gbIIP8WZr+OC5BfqBeP1MUsS0Wm
         aohpGOFj9+jzbNi//rvawWbHtqOxWHJk6W+f59UKX1Ptk7zrAmcKAF+BE5RB/KUgLP09
         T4lOWDRumdIROX6u8B85iPA+9RhGDF4zFi6tJyuAyethLNjxFPPzy3ks8HQvCH7Zubok
         pTO+AMC5jGGBFrvRz2UM4jev1OtpuMEHTXeIdeR6DkhiC8p8a6eY9JW9mYKxoy5mPsRH
         flmQ==
X-Gm-Message-State: AOAM530taHPCVFqtg2hbmFOJuBlX+rtooxPOeH7W0UGMr7Dt9y6uofjx
        SJzv34iU3EJP6mfBCxy07vg3VNcOnKp2VA==
X-Google-Smtp-Source: ABdhPJyuMrP9eVLWpML0qlk/eabKQdCAr+2D8Oi5vKhs8Zd3JzzhX0o7j8zL6PuNi2x9Nlal69SnQg==
X-Received: by 2002:aa7:cd6e:: with SMTP id ca14mr17477070edb.111.1618943643368;
        Tue, 20 Apr 2021 11:34:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 2/9] drivers: thermal: tsens: Convert msm8960 to reg_field
Date:   Tue, 20 Apr 2021 20:33:36 +0200
Message-Id: <20210420183343.2272-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert msm9860 driver to reg_field to use the init_common
function.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 73 ++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af2..0d0c2647d 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -51,11 +51,22 @@
 #define MIN_LIMIT_TH		0x0
 #define MAX_LIMIT_TH		0xff
 
-#define S0_STATUS_ADDR		0x3628
 #define INT_STATUS_ADDR		0x363c
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
 
+#define S0_STATUS_OFF		0x3628
+#define S1_STATUS_OFF		0x362c
+#define S2_STATUS_OFF		0x3630
+#define S3_STATUS_OFF		0x3634
+#define S4_STATUS_OFF		0x3638
+#define S5_STATUS_OFF		0x3664  /* Sensors 5-10 found on apq8064/msm8960 */
+#define S6_STATUS_OFF		0x3668
+#define S7_STATUS_OFF		0x366c
+#define S8_STATUS_OFF		0x3670
+#define S9_STATUS_OFF		0x3674
+#define S10_STATUS_OFF		0x3678
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -179,7 +190,7 @@ static int init_8960(struct tsens_priv *priv)
 	 */
 	for (i = 0; i < priv->num_sensors; i++) {
 		if (i >= 5)
-			priv->sensor[i].status = S0_STATUS_ADDR + 40;
+			priv->sensor[i].status = S0_STATUS_OFF + 40;
 		priv->sensor[i].status += i * 4;
 	}
 
@@ -269,6 +280,63 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 	return -ETIMEDOUT;
 }
 
+static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* No VERSION information */
+
+	/* CNTL */
+	[TSENS_EN]     = REG_FIELD(CNTL_ADDR,  0, 0),
+	[TSENS_SW_RST] = REG_FIELD(CNTL_ADDR,  1, 1),
+	/* 8960 has 5 sensors, 8660 has 11, we only handle 5 */
+	[SENSOR_EN]    = REG_FIELD(CNTL_ADDR,  3, 7),
+
+	/* ----- TM ------ */
+	/* INTERRUPT ENABLE */
+	/* NO INTERRUPT ENABLE */
+
+	/* Single UPPER/LOWER TEMPERATURE THRESHOLD for all sensors */
+	[LOW_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR,  0,  7),
+	[UP_THRESH_0]    = REG_FIELD(THRESHOLD_ADDR,  8, 15),
+	/* MIN_THRESH_0 and MAX_THRESH_0 are not present in the regfield
+	 * Recycle CRIT_THRESH_0 and 1 to set the required regs to hardcoded temp
+	 * MIN_THRESH_0 -> CRIT_THRESH_1
+	 * MAX_THRESH_0 -> CRIT_THRESH_0
+	 */
+	[CRIT_THRESH_1]   = REG_FIELD(THRESHOLD_ADDR, 16, 23),
+	[CRIT_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 24, 31),
+
+	/* UPPER/LOWER INTERRUPT [CLEAR/STATUS] */
+	/* 1 == clear, 0 == normal operation */
+	[LOW_INT_CLEAR_0]   = REG_FIELD(CNTL_ADDR,  9,  9),
+	[UP_INT_CLEAR_0]    = REG_FIELD(CNTL_ADDR, 10, 10),
+
+	/* NO CRITICAL INTERRUPT SUPPORT on 8960 */
+
+	/* Sn_STATUS */
+	[LAST_TEMP_0]  = REG_FIELD(S0_STATUS_OFF,  0,  7),
+	[LAST_TEMP_1]  = REG_FIELD(S1_STATUS_OFF,  0,  7),
+	[LAST_TEMP_2]  = REG_FIELD(S2_STATUS_OFF,  0,  7),
+	[LAST_TEMP_3]  = REG_FIELD(S3_STATUS_OFF,  0,  7),
+	[LAST_TEMP_4]  = REG_FIELD(S4_STATUS_OFF,  0,  7),
+	[LAST_TEMP_5]  = REG_FIELD(S5_STATUS_OFF,  0,  7),
+	[LAST_TEMP_6]  = REG_FIELD(S6_STATUS_OFF,  0,  7),
+	[LAST_TEMP_7]  = REG_FIELD(S7_STATUS_OFF,  0,  7),
+	[LAST_TEMP_8]  = REG_FIELD(S8_STATUS_OFF,  0,  7),
+	[LAST_TEMP_9]  = REG_FIELD(S9_STATUS_OFF,  0,  7),
+	[LAST_TEMP_10] = REG_FIELD(S10_STATUS_OFF, 0,  7),
+
+	/* No VALID field on 8960 */
+	/* TSENS_INT_STATUS bits: 1 == threshold violated */
+	[MIN_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 0, 0),
+	[LOWER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 1, 1),
+	[UPPER_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 2, 2),
+	/* No CRITICAL field on 8960 */
+	[MAX_STATUS_0] = REG_FIELD(INT_STATUS_ADDR, 3, 3),
+
+	/* TRDY: 1=ready, 0=in progress */
+	[TRDY] = REG_FIELD(INT_STATUS_ADDR, 7, 7),
+};
+
 static const struct tsens_ops ops_8960 = {
 	.init		= init_8960,
 	.calibrate	= calibrate_8960,
@@ -282,4 +350,5 @@ static const struct tsens_ops ops_8960 = {
 struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
+	.fields		= tsens_8960_regfields,
 };
-- 
2.30.2

