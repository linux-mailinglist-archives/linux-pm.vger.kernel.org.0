Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01F531E3A2
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBRA5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBRA5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE8C061786;
        Wed, 17 Feb 2021 16:56:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r21so761855wrr.9;
        Wed, 17 Feb 2021 16:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EFfWJlXCEEG+vYoTfpfhWkRrfLX0DfhG7Ytjy0Ctig=;
        b=WCyhB9O0FHFguaDUc/Fd/147LKwc26H+P2NH0l2K+YfsO+HXBACbD1F7lySAJTb5q9
         8IQ4ct+W15q3NNRuK/ZlLmaSTsfhpXSraLGs4TvLfy54u+Q71+a7zmX2W2h83pVrXcTh
         YgpOYPoPelYXa8sDzsVl2Uqf3ODiq7IDoVGykKm8FNCPCOK8UCE8mL7eXTsDR/6HPlT6
         ORJJIlJUJRxC3r3d0PjGrapjxOYA1hxZS3zSQleBqySvJ3qKYlGVjq6A8nm3aZK1Rg9i
         naGudpyfC2WzkaQd9tIxjjOmAdMsiFbGoo1B+APJS0OlHlOYptOZ311J4z3YbQDVSTld
         Yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EFfWJlXCEEG+vYoTfpfhWkRrfLX0DfhG7Ytjy0Ctig=;
        b=VYOrafGL3kfKX1K8mexBTpb3HhEOhxwJlhNkmz0SsN18UKX9ZBkzgv3/ujb1fTP3Tg
         NkOxq+wo5uSgPQfayq4gBJZY3HtTiz8/sQ3qr03xJQdF/cMEI5otVTjtFLOi0U17Ol74
         p1oXp5rmR0sv48IHIDtbgOKq7vOUA2hbO+miIgbjBA1Gzm3ASTrw/9zYvYNo9MhPdb5o
         Ka3y7pNaixy2sqcxtjDDDapvOT5aNnMcx5ETz9iXaoj143+hXYw8/rLF7ZVOzy0wWWgV
         wDeTLCb1h+v4bvUfdrJ4aaKtCl90Pj6wXb7c3uYuBKLWMOM1bXfcRnOdpjXXFj60GraJ
         FBxQ==
X-Gm-Message-State: AOAM531egVjbtceK8TiFv+Sc5YjqbfWfDLmzfapXCqGQx+zqffMmmJUF
        G3r2/UancYB+WiT/OcLIgqE=
X-Google-Smtp-Source: ABdhPJzCj8yOejMHAg8b4jh4wB2yzRJAOT7oxqaKNX/Aa7/5a0UAYC2AzxQMcYqZPUR9D//DL2IrSw==
X-Received: by 2002:a5d:4e10:: with SMTP id p16mr1700387wrt.360.1613609783684;
        Wed, 17 Feb 2021 16:56:23 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:23 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/8] drivers: thermal: tsens: Convert msm8960 to reg_field
Date:   Wed, 17 Feb 2021 20:40:05 +0100
Message-Id: <20210217194011.22649-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert msm9860 driver to reg_field to use the init_common
function.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 80 ++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af209e..3f4fc1ffe679 100644
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
@@ -269,6 +280,71 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 	return -ETIMEDOUT;
 }
 
+static struct tsens_features tsens_8960_feat = {
+	.ver_major	= VER_0,
+	.crit_int	= 0,
+	.adc		= 1,
+	.srot_split	= 0,
+	.max_sensors	= 11,
+};
+
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
@@ -282,4 +358,6 @@ static const struct tsens_ops ops_8960 = {
 struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
+	.feat		= &tsens_8960_feat,
+	.fields		= tsens_8960_regfields,
 };
-- 
2.30.0

