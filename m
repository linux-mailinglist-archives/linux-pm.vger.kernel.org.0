Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21348641AF0
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLDF70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLDF7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D300F1A39C
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:17 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so13728312lfi.7
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS8+Tw8CpPa5UI72UFBU+Fs2VulFRliA0Wpow1r/YP4=;
        b=fy0VGVO7YprmBCR0tjk+K/81WJzaTOKgQPfL0CyOHoTzDViuZBWWJuwmhNENNw6CYB
         3hhk7NJpoK4D3qqLGsFgDEt96ZJlB7aOuys3fbbgZUrvbMOU5VZAwm1lsrOdpr8l2gC1
         XT7wk8nelF7JgfyY64Ga4oLZGSTz7gONsuX8Yog6ol6uIkSd/H/7h2rWPzGcggxM9JUi
         v1GWEeVNvkxNquJjlruXtbq1+o2KblbByKVCGE7WdNJgwIs76GTodwwcXxb5qMjPeRgg
         7pn7j3TdIT1ZheaGJ/uJBNiZeXKOIwqKgodOK7QXK24Y4C5O02EvcYTkH4tNRR7DLvkR
         Cepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS8+Tw8CpPa5UI72UFBU+Fs2VulFRliA0Wpow1r/YP4=;
        b=amTU8tw4y76J71tPS8teBpZ/KuqN3uVTEXtYstvQXw2tPl+JqvmO1GGFKoRSiKi5uq
         z2D9mEmyFzjTXC/EiVvEuXRgpW+Vwh9WYb41wxyuUoVcmMElmxKfKTFOHDqEDl4I6QKR
         JfO6MEsw5VnN2gHxcITGdfjh81/x/Y194nOu2gyL5rLKgyzkxh/r/G45Qd4GK4Q7wv8P
         wckEnFkAXnlhY2LlAE2oIoLck574MD6dJrlBJ8RsyNrqkjeix5kVw5fJbBqLCaazhk5G
         LKEUItIeeDEMHmaO9pxVhZ3hiSPNicLp07Fj69DJWL04AMSZ+6VsytbEg6xHslzIfdcb
         7IWQ==
X-Gm-Message-State: ANoB5plw5UwA2WubgbO6rlmqVPVv30z2w6S1ezYxLrHOVfvnqWw9ktDl
        p071sxD0sUO7gAM0vv5nH3M7vw==
X-Google-Smtp-Source: AA0mqf7hIRoMbi2xRnYfAAuB8wdS5UK6nRxoSS1Z9ICXULPcCcYVo5LknSrShnCkLNHaPTSzWGwynQ==
X-Received: by 2002:ac2:5331:0:b0:4ab:35a8:2fa0 with SMTP id f17-20020ac25331000000b004ab35a82fa0mr25317184lfh.233.1670133557365;
        Sat, 03 Dec 2022 21:59:17 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:17 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 08/15] thermal/drivers/tsens: Drop single-cell code for msm8939
Date:   Sun,  4 Dec 2022 07:59:02 +0200
Message-Id: <20221204055909.1351895-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no dtsi file for msm8939 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on msm8939.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 146 ++----------------------------
 1 file changed, 7 insertions(+), 139 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 56c4e47db0c0..a273a0643053 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -48,63 +48,6 @@
 #define MSM8916_CAL_SEL_MASK	0xe0000000
 #define MSM8916_CAL_SEL_SHIFT	29
 
-/* eeprom layout data for 8939 */
-#define MSM8939_BASE0_MASK	0x000000ff
-#define MSM8939_BASE1_MASK	0xff000000
-#define MSM8939_BASE0_SHIFT	0
-#define MSM8939_BASE1_SHIFT	24
-
-#define MSM8939_S0_P1_MASK	0x000001f8
-#define MSM8939_S1_P1_MASK	0x001f8000
-#define MSM8939_S2_P1_MASK_0_4	0xf8000000
-#define MSM8939_S2_P1_MASK_5	0x00000001
-#define MSM8939_S3_P1_MASK	0x00001f80
-#define MSM8939_S4_P1_MASK	0x01f80000
-#define MSM8939_S5_P1_MASK	0x00003f00
-#define MSM8939_S6_P1_MASK	0x03f00000
-#define MSM8939_S7_P1_MASK	0x0000003f
-#define MSM8939_S8_P1_MASK	0x0003f000
-#define MSM8939_S9_P1_MASK	0x07e00000
-
-#define MSM8939_S0_P2_MASK	0x00007e00
-#define MSM8939_S1_P2_MASK	0x07e00000
-#define MSM8939_S2_P2_MASK	0x0000007e
-#define MSM8939_S3_P2_MASK	0x0007e000
-#define MSM8939_S4_P2_MASK	0x7e000000
-#define MSM8939_S5_P2_MASK	0x000fc000
-#define MSM8939_S6_P2_MASK	0xfc000000
-#define MSM8939_S7_P2_MASK	0x00000fc0
-#define MSM8939_S8_P2_MASK	0x00fc0000
-#define MSM8939_S9_P2_MASK_0_4	0xf8000000
-#define MSM8939_S9_P2_MASK_5	0x00002000
-
-#define MSM8939_S0_P1_SHIFT	3
-#define MSM8939_S1_P1_SHIFT	15
-#define MSM8939_S2_P1_SHIFT_0_4	27
-#define MSM8939_S2_P1_SHIFT_5	0
-#define MSM8939_S3_P1_SHIFT	7
-#define MSM8939_S4_P1_SHIFT	19
-#define MSM8939_S5_P1_SHIFT	8
-#define MSM8939_S6_P1_SHIFT	20
-#define MSM8939_S7_P1_SHIFT	0
-#define MSM8939_S8_P1_SHIFT	12
-#define MSM8939_S9_P1_SHIFT	21
-
-#define MSM8939_S0_P2_SHIFT	9
-#define MSM8939_S1_P2_SHIFT	21
-#define MSM8939_S2_P2_SHIFT	1
-#define MSM8939_S3_P2_SHIFT	13
-#define MSM8939_S4_P2_SHIFT	25
-#define MSM8939_S5_P2_SHIFT	14
-#define MSM8939_S6_P2_SHIFT	26
-#define MSM8939_S7_P2_SHIFT	6
-#define MSM8939_S8_P2_SHIFT	18
-#define MSM8939_S9_P2_SHIFT_0_4	27
-#define MSM8939_S9_P2_SHIFT_5	13
-
-#define MSM8939_CAL_SEL_MASK	0x7
-#define MSM8939_CAL_SEL_SHIFT	0
-
 /* eeprom layout data for 8974 */
 #define BASE1_MASK		0xff
 #define S0_P1_MASK		0x3f00
@@ -284,81 +227,6 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_8939(struct tsens_priv *priv)
-{
-	int base0 = 0, base1 = 0, i;
-	u32 p1[10], p2[10];
-	int mode = 0;
-	u32 *qfprom_cdata;
-	u32 cdata[6];
-	int ret;
-
-	ret = tsens_calibrate_common(priv);
-	if (!ret)
-		return 0;
-
-	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata))
-		return PTR_ERR(qfprom_cdata);
-
-	/* Mapping between qfprom nvmem and calibration data */
-	cdata[0] = qfprom_cdata[12];
-	cdata[1] = qfprom_cdata[13];
-	cdata[2] = qfprom_cdata[0];
-	cdata[3] = qfprom_cdata[1];
-	cdata[4] = qfprom_cdata[22];
-	cdata[5] = qfprom_cdata[21];
-
-	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (cdata[3] & MSM8939_BASE1_MASK) >> MSM8939_BASE1_SHIFT;
-		p2[0] = (cdata[0] & MSM8939_S0_P2_MASK) >> MSM8939_S0_P2_SHIFT;
-		p2[1] = (cdata[0] & MSM8939_S1_P2_MASK) >> MSM8939_S1_P2_SHIFT;
-		p2[2] = (cdata[1] & MSM8939_S2_P2_MASK) >> MSM8939_S2_P2_SHIFT;
-		p2[3] = (cdata[1] & MSM8939_S3_P2_MASK) >> MSM8939_S3_P2_SHIFT;
-		p2[4] = (cdata[1] & MSM8939_S4_P2_MASK) >> MSM8939_S4_P2_SHIFT;
-		p2[5] = (cdata[2] & MSM8939_S5_P2_MASK) >> MSM8939_S5_P2_SHIFT;
-		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
-		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
-		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
-		p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
-		p2[9] |= ((cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5) << 5;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = (base1 + p2[i]) << 2;
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = (cdata[2] & MSM8939_BASE0_MASK) >> MSM8939_BASE0_SHIFT;
-		p1[0] = (cdata[0] & MSM8939_S0_P1_MASK) >> MSM8939_S0_P1_SHIFT;
-		p1[1] = (cdata[0] & MSM8939_S1_P1_MASK) >> MSM8939_S1_P1_SHIFT;
-		p1[2] = (cdata[0] & MSM8939_S2_P1_MASK_0_4) >> MSM8939_S2_P1_SHIFT_0_4;
-		p1[2] |= ((cdata[1] & MSM8939_S2_P1_MASK_5) >> MSM8939_S2_P1_SHIFT_5) << 5;
-		p1[3] = (cdata[1] & MSM8939_S3_P1_MASK) >> MSM8939_S3_P1_SHIFT;
-		p1[4] = (cdata[1] & MSM8939_S4_P1_MASK) >> MSM8939_S4_P1_SHIFT;
-		p1[5] = (cdata[2] & MSM8939_S5_P1_MASK) >> MSM8939_S5_P1_SHIFT;
-		p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
-		p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
-		p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
-		p1[9] = (cdata[4] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = ((base0) + p1[i]) << 2;
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
-
-	compute_intercept_slope(priv, p1, p2, mode);
-	kfree(qfprom_cdata);
-
-	return 0;
-}
-
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
@@ -595,6 +463,12 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static const struct tsens_ops ops_v0_1 = {
+	.init		= init_common,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
@@ -610,15 +484,9 @@ struct tsens_plat_data data_8916 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
-static const struct tsens_ops ops_8939 = {
-	.init		= init_common,
-	.calibrate	= calibrate_8939,
-	.get_temp	= get_temp_common,
-};
-
 struct tsens_plat_data data_8939 = {
 	.num_sensors	= 10,
-	.ops		= &ops_8939,
+	.ops		= &ops_v0_1,
 	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
 
 	.feat		= &tsens_v0_1_feat,
-- 
2.35.1

