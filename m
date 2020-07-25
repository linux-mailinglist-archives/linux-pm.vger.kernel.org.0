Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22D822D944
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgGYSO3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGYSO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C042C08C5C0;
        Sat, 25 Jul 2020 11:14:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bm28so9288238edb.2;
        Sat, 25 Jul 2020 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMyMGYrFfQSctOOMrucGFh64gStiW/eHvmw7ez5Z6CU=;
        b=oTARhCbkPjI4BKJRV9chITt/Y8H/5wmyAbyFDfa8GjeE/I7IIJo8jOBYMZPcv1Q0MG
         CWFZKz+zTtero8C8zEINOcmmgJyP2D2I3X+etEmgfsJOGz787LKM1gZFK9OfUmAZvCd5
         vn84h3XC7hxz5sbgdAPHHHvTGBz4TQ5cC39IHx0V0klowRzYB7T3nriKnYAQmYed3fmp
         6Vrar1R4pUcgAoGlIZhYfFr+e1bXGLWNv7C9A34HIaQgwTiRnMEzAFd7urpVysFmAZwm
         oS6y82Xgsx2q87cFbfbo3lWAOg7R3i+MenK0xdSJjsIcjr1WjdxWhoMdKKD8ZjyAV39h
         hgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMyMGYrFfQSctOOMrucGFh64gStiW/eHvmw7ez5Z6CU=;
        b=IGi5MXEMmche1seG/j0LyF4RqXN1AExqedaXAM2XjDOoCy5uNYQmK7Yljkce5UcVrr
         oxp8s2YLP8TkXRK1InobN+hFG958O94wdDhYrnR2mIPFbO6AIHdj5Aah69tJzAfQaezb
         uq9fCTFTkj/4Tk8C0sL/DvuoLMVipTRTyD7qTWig6oBrVkyEV834GdJ8N86Fch64VO3E
         T/z2iYXgCZDUq4NCqi74veMc3Av3qjr1T1Rkz+sEcE+Qch9JvGog3VfT2BjOYVaWPcxb
         UZxEH7V2hZejrMzYmP8gSOJwIy9R5SVlv+D4opoRELyqqjzR89kjXzIsonqWfyK03BeA
         er3g==
X-Gm-Message-State: AOAM5311LdXTSSptoenS4H0xUz9nvk8Bp0tnEXULwEMs8B0mT1vIIMuc
        jS8xX74fPoVH+fOUNyCkvlo=
X-Google-Smtp-Source: ABdhPJyj96yYLDm7rybaJQw4Df11TuPmKe1u6dYpJu7upaxjCIsuvQDhOp6r3xM44w7qo7crm3MMtw==
X-Received: by 2002:a50:ef10:: with SMTP id m16mr14099258eds.206.1595700866743;
        Sat, 25 Jul 2020 11:14:26 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:26 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 2/7] drivers: thermal: tsens: Convert msm8960 to reg_field
Date:   Sat, 25 Jul 2020 20:13:58 +0200
Message-Id: <20200725181404.18951-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Covert msm9860 driver to reg_filed to use the init_common
function.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af209e..45cd0cdff2f5 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -56,6 +56,18 @@
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
 
+#define S0_STATUS_OFF		0x3628
+#define S1_STATUS_OFF		0x362c
+#define S2_STATUS_OFF		0x3630
+#define S3_STATUS_OFF		0x3634
+#define S4_STATUS_OFF		0x3638
+#define S5_STATUS_OFF		0x3664  /* Sensors 5 thru 10 found on apq8064/msm8960 */
+#define S6_STATUS_OFF		0x3668
+#define S7_STATUS_OFF		0x366c
+#define S8_STATUS_OFF		0x3670
+#define S9_STATUS_OFF		0x3674
+#define S10_STATUS_OFF		0x3678
+
 static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
@@ -269,6 +281,66 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
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
+	// [INT_EN] = REG_FIELD(TM_INT_EN_OFF, 0, 0),
+
+	/* Single UPPER/LOWER TEMPERATURE THRESHOLD for all sensors */
+	[LOW_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR,  0,  7),
+	[UP_THRESH_0]    = REG_FIELD(THRESHOLD_ADDR,  8, 15),
+	[MIN_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 16, 23),
+	[MAX_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 24, 31),
+
+	// /* UPPER/LOWER INTERRUPT [CLEAR/STATUS] */
+	// /* 1 == clear, 0 == normal operation */
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
@@ -282,4 +354,6 @@ static const struct tsens_ops ops_8960 = {
 struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
+	.feat		= &tsens_8960_feat,
+	.fields		= tsens_8960_regfields,
 };
-- 
2.27.0

