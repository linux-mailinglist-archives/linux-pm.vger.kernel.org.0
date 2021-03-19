Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3B342444
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSSP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCSSP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F7C06174A;
        Fri, 19 Mar 2021 11:15:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t18so11177411ejc.13;
        Fri, 19 Mar 2021 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu81fKlLAFW3uWu/bLxRNDUvKBG2yYeAnb3WyHS2HYs=;
        b=fPtprulfv/tUFPQWWx2PE4g9EdUZlieej9ulalUcxAvpEWGjJRajvaBUjh40nLh4b7
         OjWTsMXSsBQh5a6V9Y82iGElCYDpflEZ7y8TkzfV11PZqj27QA5gbIm8DgzY+FEwlcTk
         hHVhnVTyIaU2NJPmmrXmzeFqmOfhYaDiqczkMlWkhz/N4YrA3epKQXdpdslNJgFyS3Sv
         ejaW0JterSm/hlDaMS+MZeRDTKZ9blm19ZfxFR8VlltqQmVDDZdGTz1QxPogYmK8qgBw
         VyITczr4ESSnhIBIZj0VenE8Hu5/llr6hlK5dvCM7iXA1/kAs91zPJtsZRC0SgZ6qSLi
         dqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu81fKlLAFW3uWu/bLxRNDUvKBG2yYeAnb3WyHS2HYs=;
        b=gC5a/jPXmL1V3VBiiIRtameONJ/53KYK4IQ7mYgoHz+UWEG8qSsTdhZn+i34VZJwuw
         Cl+XnIqfW/9n28GNLZtdTKNwp22bWIpikjbmJAl1jli+8telrouVNf8a4ae46SzAgJUu
         t61Ci1nZ8eQbuePI7LzpG5eQpYrVmoFGOWGc4tafsahrvL87L70VeWShyxUAqZC7axu2
         TKs2+Yqw/zIGGc5mbYcC2qcqpRhXnOAX6wyphFnSJPRLYb4zSP2d2e1A8eHWK41VnSYM
         RsBNenfQUD8Fd1MPddvsWQOmQxBZ5NlF95UB3MksBxMME5t3pu97Z1AvdyLIoEd1sAsT
         p9hQ==
X-Gm-Message-State: AOAM530mSIaptxip3aRIYuif18Qdyooenv4YlZAMc2qj/+0028VwrQj1
        epzSiJWzBPelOB8gCCIFLHDQK0haC5U=
X-Google-Smtp-Source: ABdhPJy6me0LzH6XPZFFcxHPrG9yj5MREFswrxauCt0Lzeji4d7COnO8KdVo7EUEvPXKer+bNlPdEw==
X-Received: by 2002:a17:906:5203:: with SMTP id g3mr5673119ejm.95.1616177727659;
        Fri, 19 Mar 2021 11:15:27 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:27 -0700 (PDT)
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
Subject: [PATCH v12 3/9] drivers: thermal: tsens: Convert msm8960 to reg_field
Date:   Fri, 19 Mar 2021 19:15:06 +0100
Message-Id: <20210319181512.7757-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
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

