Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFCC651919
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiLTCrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiLTCrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60F13DE5
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bf43so16577426lfb.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDNZidy7fcy9zuf733Ls8ggAdRKj7buHFcJnduCCY6U=;
        b=pXz+jbfrGoSS1GZW773FMAmuladmJviZRfn5hOsablHdjd3JD1EMEvSG0tgt+mcWyx
         onQZABiWGqH7fb8JWjzAe21qxG9r1aymHKTd5LveGUZcVGPeiXfiinQQCv64/QJSkOOY
         /trymUbixqTw4SIfteYHxTaLOQLsa6zEumEgciUCxcW5x503tLnfucVJfkIWu/+jwxYa
         shQM6F46U0BTjf4QpRTpBnX/ke2Z7a84dhq9RMpTt0xazf4HQad1vm/mM7eavLL34ByU
         Hsler5dUVs2+4OFZAKpCKmsP3Yq3gwVr97vWXHlhZ7lXVo1bUpPaUjSx3mwR0PD2liee
         0Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDNZidy7fcy9zuf733Ls8ggAdRKj7buHFcJnduCCY6U=;
        b=fHYHhzhPBzIMWNbD+YOs7xpg8E6DUDagivacW0YkVRHBm2+treCfw2Naa6hNSRQgu7
         FhHAZxPoK8ao5kFwdKYa7eOGFedWrK+KXwVgut41/Mn5A7JgVrrJ9RiaPvY5HjHW1PwZ
         SnMIEZjT+gpQI9PV48vqdNpYYCuIYWvAg2rGVjhX2DgUgz/S7JOxMl36tOQ6v/57xD2T
         rxhZNVO89cAF9ot41+DbsrrLuIsfQW+kQqafekDKhlhZgpt396FmxyA2QZqrhnS+Fi88
         EK7YrjQgXB0pNQTua7iANCZY5Kc85dJq1cQAJsGceaGEdiRKWUJ2tDIojDD+OhWczDzj
         4QCQ==
X-Gm-Message-State: ANoB5pmahtof93KKHpT6KPBte7qa1p7suVqYurp/+B/JiS24ctLLuNxv
        qXACXiewLXII7nzC+uh/4Rw9UQ==
X-Google-Smtp-Source: AA0mqf7IbcThft016ff4lw9htkRCHBrBUJW7QT9u7OtlC1BbmApNd6PFZXXOk3+czqVrSgHrSZERuA==
X-Received: by 2002:a05:6512:2c85:b0:4a4:68b8:9c4e with SMTP id dw5-20020a0565122c8500b004a468b89c4emr12237474lfb.54.1671504451591;
        Mon, 19 Dec 2022 18:47:31 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:31 -0800 (PST)
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
Subject: [PATCH v3 10/15] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
Date:   Tue, 20 Dec 2022 04:47:16 +0200
Message-Id: <20221220024721.947147-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 89955522041d..9151c1043a11 100644
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
@@ -370,7 +248,7 @@ struct tsens_plat_data data_tsens_v1 = {
 
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
@@ -383,7 +261,7 @@ struct tsens_plat_data data_8956 = {
 
 static const struct tsens_ops ops_8976 = {
 	.init		= init_common,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
-- 
2.35.1

