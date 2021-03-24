Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537B3483FE
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhCXVoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhCXVoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A6C06174A;
        Wed, 24 Mar 2021 14:44:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so35342356ejc.4;
        Wed, 24 Mar 2021 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu81fKlLAFW3uWu/bLxRNDUvKBG2yYeAnb3WyHS2HYs=;
        b=i2D9Kvc38yv1+9Yg84HLOFvIj9mFhkPa4EQeF5f2pXhvHbMBxjLllQwMPXJr4UFr/y
         cfI4n/BFe00XtdBB75mU84a4W4d4neWyIqhcS0GKiXU3jfJStFqi1mI7Mi2q6+6lN1qh
         j1J+fmiqLPot13NcFuv98Qw/vZNk3kKN6M3JwP7pkB2Yq4ei60MmlKUVAD2VVa9w8nbz
         N5TIgEAE9Eg0nVCIHEx2NRetF36wk4pYrsi8LbM0eoVbbWuwvdcV3jh5GeKov1RfGGqv
         Ix6qYpgXOCB39/8CRmalzTqb9im5rGaFrTKUKgUUCW3+XK4TNsStCkUZjJyrprCfnImR
         YwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu81fKlLAFW3uWu/bLxRNDUvKBG2yYeAnb3WyHS2HYs=;
        b=kQthNVpxwLT5DNlZjlStQOhpBhv31eyqx+lDXTUuqrpiKbz9XfcXXD0vGi6JNfYK/n
         RivZXmlGt3FdEp8BwqvHYUvq7861KPPayaWkVcYxcbMZOqqrBiZruq9tGeJjTcka4M8N
         eYbKZdnugLF9kHqO6lcarl33KfqzMz9lDRXefhJ8QunrDETisIf/ffR1qcAoBqn9rpxL
         rkRexl+8BGODLAiZnbkbUKm3RDIV6FcNQ7G6b1BJYyjbyy/vMn4U4PMsr8UogV3AwWIY
         azBo3TaKoowLsrKNbXqFByRUB2YwVmf3/NSDJHK0r3It2mSUBAVH7N4PnHRw5MYK14mz
         +Aqg==
X-Gm-Message-State: AOAM532l0F6ODvtzSBdUZ9PiVz4I3M1GgFRd24EcWYl2GsN3LbeV30Ic
        +R0gAM8LertjH0EzHPpCKa4=
X-Google-Smtp-Source: ABdhPJw1Bh3uTOzY3WJs21ahYpj3zCQzEsKR1F92diGcN0Y5rVLTdvEvatOTRqX0BfdYFVq3ERGFkQ==
X-Received: by 2002:a17:907:119b:: with SMTP id uz27mr5822994ejb.464.1616622252580;
        Wed, 24 Mar 2021 14:44:12 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 3/9] drivers: thermal: tsens: Convert msm8960 to reg_field
Date:   Wed, 24 Mar 2021 22:43:57 +0100
Message-Id: <20210324214404.798-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
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
2.30.2

