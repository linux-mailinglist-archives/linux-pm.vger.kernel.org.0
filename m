Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E575A641AF6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiLDF72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLDF7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:20 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC561A3B8
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a7so9917815ljq.12
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNvGXwUb+zVmurd4YeNJ7ib2kG+fO0j8NGyJuku0Tio=;
        b=Kd/zth6Ce5qrOYZ9S4owJ89GfTR/WB2ro+SdV94FrFYLy7TKBEMmxzqEvTPo/meep5
         s585EpjG1dsAOerZlpakyfVmGCDUQ5/oqHtMBxDetp3q6JzObRvb4ivfF+wC0XXpehTI
         WjcytsOUuN+2oQNtU/XirayB4S7o0MnoGrUMcK1wGMX7bsVz53l8VUzQLYyLoSRdnwnT
         PxRRzDj5R6oNEqoSco2mAS73Sf8R3F9N3GMLZ7EB+mlI2EzZ9fUQdWGThp7xKmvssxS+
         ILYO/D66jb0j69I9BUdX6lBkPjNUJOffR1eD0R7D71GHHqkLA4GEzbJ3VZEinX0RCwE2
         xt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNvGXwUb+zVmurd4YeNJ7ib2kG+fO0j8NGyJuku0Tio=;
        b=H4IuVgnmicxxBqNOWJNJWITOlDZg8uQzR27U47mlX+Ysg3QtbdJlBP/d9rZ0ytY3VX
         zO/m1VTFddgTh7RywJ/Fe/CgEb67nP6S7oNXpZ4XzYi6dhuIOEUio4QWgTYLU1lXnDCt
         QKT6kTIGnaDFaVnwg5xg14CeG4/haIP2nBF2ObDEAY1pq9wohH0uztycgGIHcAU/C4EE
         LGAYpFr8jk8+hApQsajhNwwyRP9ilD7SZcHYpf2pZ+o14t5wTvM8u2FzjBSUxPL5kXAp
         Un8RTCnH1UAWifXIWXL2/r3vjZcQ26ojbK3X+YlZSEawy6yLgzHtKvvZmgOilz9++b8u
         iWxQ==
X-Gm-Message-State: ANoB5pmZo2pP9h3j+tUzL9gcdZfyxJVY2NCLtxyKFl5uLqiltfGNFpLO
        H3M/3BW82nwQth6u2jtPp5bvgg==
X-Google-Smtp-Source: AA0mqf4klechCusk0BXHdAvEwJOeD4yRjxjqjqgI6kICAp34Kj0IF/o2E5inEcLjDuFVMTN6LqnQeQ==
X-Received: by 2002:a2e:a54d:0:b0:278:f31b:2770 with SMTP id e13-20020a2ea54d000000b00278f31b2770mr19906972ljn.310.1670133558835;
        Sat, 03 Dec 2022 21:59:18 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:18 -0800 (PST)
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
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 10/15] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
Date:   Sun,  4 Dec 2022 07:59:04 +0200
Message-Id: <20221204055909.1351895-11-dmitry.baryshkov@linaro.org>
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

There is no dtsi file for msm8976 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on msm8976.

Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 126 +-------------------------------
 1 file changed, 2 insertions(+), 124 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 2684c4a0941a..51bcf2a93773 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -21,63 +21,6 @@
 #define TM_HIGH_LOW_INT_STATUS_OFF		0x0088
 #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
-/* eeprom layout data for msm8956/76 (v1) */
-#define MSM8976_BASE0_MASK	0xff
-#define MSM8976_BASE1_MASK	0xff
-#define MSM8976_BASE1_SHIFT	8
-
-#define MSM8976_S0_P1_MASK	0x3f00
-#define MSM8976_S1_P1_MASK	0x3f00000
-#define MSM8976_S2_P1_MASK	0x3f
-#define MSM8976_S3_P1_MASK	0x3f000
-#define MSM8976_S4_P1_MASK	0x3f00
-#define MSM8976_S5_P1_MASK	0x3f00000
-#define MSM8976_S6_P1_MASK	0x3f
-#define MSM8976_S7_P1_MASK	0x3f000
-#define MSM8976_S8_P1_MASK	0x1f8
-#define MSM8976_S9_P1_MASK	0x1f8000
-#define MSM8976_S10_P1_MASK	0xf8000000
-#define MSM8976_S10_P1_MASK_1	0x1
-
-#define MSM8976_S0_P2_MASK	0xfc000
-#define MSM8976_S1_P2_MASK	0xfc000000
-#define MSM8976_S2_P2_MASK	0xfc0
-#define MSM8976_S3_P2_MASK	0xfc0000
-#define MSM8976_S4_P2_MASK	0xfc000
-#define MSM8976_S5_P2_MASK	0xfc000000
-#define MSM8976_S6_P2_MASK	0xfc0
-#define MSM8976_S7_P2_MASK	0xfc0000
-#define MSM8976_S8_P2_MASK	0x7e00
-#define MSM8976_S9_P2_MASK	0x7e00000
-#define MSM8976_S10_P2_MASK	0x7e
-
-#define MSM8976_S0_P1_SHIFT	8
-#define MSM8976_S1_P1_SHIFT	20
-#define MSM8976_S2_P1_SHIFT	0
-#define MSM8976_S3_P1_SHIFT	12
-#define MSM8976_S4_P1_SHIFT	8
-#define MSM8976_S5_P1_SHIFT	20
-#define MSM8976_S6_P1_SHIFT	0
-#define MSM8976_S7_P1_SHIFT	12
-#define MSM8976_S8_P1_SHIFT	3
-#define MSM8976_S9_P1_SHIFT	15
-#define MSM8976_S10_P1_SHIFT	27
-#define MSM8976_S10_P1_SHIFT_1	0
-
-#define MSM8976_S0_P2_SHIFT	14
-#define MSM8976_S1_P2_SHIFT	26
-#define MSM8976_S2_P2_SHIFT	6
-#define MSM8976_S3_P2_SHIFT	18
-#define MSM8976_S4_P2_SHIFT	14
-#define MSM8976_S5_P2_SHIFT	26
-#define MSM8976_S6_P2_SHIFT	6
-#define MSM8976_S7_P2_SHIFT	18
-#define MSM8976_S8_P2_SHIFT	9
-#define MSM8976_S9_P2_SHIFT	21
-#define MSM8976_S10_P2_SHIFT	1
-
-#define MSM8976_CAL_SEL_MASK	0x3
-
 /* eeprom layout data for qcs404/405 (v1) */
 #define BASE0_MASK	0x000007f8
 #define BASE1_MASK	0x0007f800
@@ -207,71 +150,6 @@ static int calibrate_v1(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_8976(struct tsens_priv *priv)
-{
-	int base0 = 0, base1 = 0, i;
-	u32 p1[11], p2[11];
-	int mode = 0, tmp = 0;
-	u32 *qfprom_cdata;
-
-	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata))
-		return PTR_ERR(qfprom_cdata);
-
-	mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >> MSM8976_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MSM8976_S0_P2_MASK) >> MSM8976_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MSM8976_S1_P2_MASK) >> MSM8976_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MSM8976_S2_P2_MASK) >> MSM8976_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MSM8976_S3_P2_MASK) >> MSM8976_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[2] & MSM8976_S4_P2_MASK) >> MSM8976_S4_P2_SHIFT;
-		p2[5] = (qfprom_cdata[2] & MSM8976_S5_P2_MASK) >> MSM8976_S5_P2_SHIFT;
-		p2[6] = (qfprom_cdata[3] & MSM8976_S6_P2_MASK) >> MSM8976_S6_P2_SHIFT;
-		p2[7] = (qfprom_cdata[3] & MSM8976_S7_P2_MASK) >> MSM8976_S7_P2_SHIFT;
-		p2[8] = (qfprom_cdata[4] & MSM8976_S8_P2_MASK) >> MSM8976_S8_P2_SHIFT;
-		p2[9] = (qfprom_cdata[4] & MSM8976_S9_P2_MASK) >> MSM8976_S9_P2_SHIFT;
-		p2[10] = (qfprom_cdata[5] & MSM8976_S10_P2_MASK) >> MSM8976_S10_P2_SHIFT;
-
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base1 + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
-		p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MSM8976_S1_P1_MASK) >> MSM8976_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[1] & MSM8976_S2_P1_MASK) >> MSM8976_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MSM8976_S3_P1_MASK) >> MSM8976_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[2] & MSM8976_S4_P1_MASK) >> MSM8976_S4_P1_SHIFT;
-		p1[5] = (qfprom_cdata[2] & MSM8976_S5_P1_MASK) >> MSM8976_S5_P1_SHIFT;
-		p1[6] = (qfprom_cdata[3] & MSM8976_S6_P1_MASK) >> MSM8976_S6_P1_SHIFT;
-		p1[7] = (qfprom_cdata[3] & MSM8976_S7_P1_MASK) >> MSM8976_S7_P1_SHIFT;
-		p1[8] = (qfprom_cdata[4] & MSM8976_S8_P1_MASK) >> MSM8976_S8_P1_SHIFT;
-		p1[9] = (qfprom_cdata[4] & MSM8976_S9_P1_MASK) >> MSM8976_S9_P1_SHIFT;
-		p1[10] = (qfprom_cdata[4] & MSM8976_S10_P1_MASK) >> MSM8976_S10_P1_SHIFT;
-		tmp = (qfprom_cdata[5] & MSM8976_S10_P1_MASK_1) << MSM8976_S10_P1_SHIFT_1;
-		p1[10] |= tmp;
-
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = (((base0) + p1[i]) << 2);
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
 /* v1.x: msm8956,8976,qcs404,405 */
 
 static struct tsens_features tsens_v1_feat = {
@@ -367,7 +245,7 @@ struct tsens_plat_data data_tsens_v1 = {
 
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
@@ -380,7 +258,7 @@ struct tsens_plat_data data_8956 = {
 
 static const struct tsens_ops ops_8976 = {
 	.init		= init_common,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
-- 
2.35.1

