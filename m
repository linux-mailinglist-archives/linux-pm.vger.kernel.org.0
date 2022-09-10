Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE95B465B
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiIJMrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIJMrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BD57574
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f11so7247909lfa.6
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CBVMWjg01odLYqTkWvaBQIvsO7JRHWZ4Q+bzbARqZjo=;
        b=frJGUv3H/KocJebgVhP0B5uTRInGVYGXF0XUjTSoNgABiFDjPKODBl1BnzSAa44JKq
         vIc2F4A7XdGjWemoiHB4rqwppYJU2iJB3FPdL2qK6kXpdWkSp4LuimGnKKl/DzFu2Smg
         K3uMaRoZsuMv5g2TwbB2Sj+cfjA92GiFQDm7NKxpuXIYHdLvJAeDjqnwohlUD+qgUgkQ
         HnKLtUhGnFWPjxbM9RqmiWadQeZJqaIu6koZui6NwaeZfG9wAkE193wIXHlzsEjhQO/5
         W/iFqD4Ohp/ilNl932eOncpvExqnA1TfCGLmMfcMxhSXo+RD103Fpa+DMuSDlIwMLvbS
         S5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CBVMWjg01odLYqTkWvaBQIvsO7JRHWZ4Q+bzbARqZjo=;
        b=Mom4nB+7ymaMjXAatDoRBRdbNrDZaCZA1c9CILLoDfzYEGLz9IS4KZxkRbJTW2HW57
         5VJWcJmMzYVnv+Tyu/z+zP7dvVClBqxFEVyqCryPa5zccrBzDXcKF0Kfy/XqmTrXOuVY
         nuKKWHdpPCeFGCuFbIjmpNcxwqTE6T1EBEcNY2bqRIYyRPyovvbZsxTrVOHFoSMBmBzS
         qE+nALHQgtpjesk8hl2117+rk3Hs+HDDOcg/bjWYvB6Ach/nZzSPl7quLSAosCHNgCWr
         zhofWQrmN6KQY/ahViUgPQMKqbleDMlWVxWl3EB2ibcp76c836qkfYUN5OH2NHtxDCc6
         HrLw==
X-Gm-Message-State: ACgBeo1EjP9LINhx9OKsPo88CLmups3wzvfEPOBYHsosp/rC9qJ9wN69
        zHyVKy8NW1g8wSJ3mCmG3Lj29A==
X-Google-Smtp-Source: AA6agR7i3DwpVyjMRmVwgRdsv3EZYAqGZgRalNrU00BpemCxDJxS6p7YczlQBCOa/dUJhs7tBi4rJA==
X-Received: by 2002:ac2:418a:0:b0:48b:aa2:1d9f with SMTP id z10-20020ac2418a000000b0048b0aa21d9fmr6337116lfh.195.1662814029211;
        Sat, 10 Sep 2022 05:47:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:08 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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
Subject: [RFC PATCH 08/10] thermal/drivers/tsens: drop single-cell code for msm8976
Date:   Sat, 10 Sep 2022 15:46:59 +0300
Message-Id: <20220910124701.4060321-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no dtsi file for msm8976 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on msm8976.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 124 +-------------------------------
 1 file changed, 1 insertion(+), 123 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 2a4440a34735..b6c2da3371e4 100644
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
@@ -209,72 +152,7 @@ static int calibrate_v1(struct tsens_priv *priv)
 
 static int calibrate_8976(struct tsens_priv *priv)
 {
-	int base0 = 0, base1 = 0, i;
-	u32 p1[11], p2[11];
-	int mode = 0, tmp = 0;
-	u32 *qfprom_cdata;
-	int ret;
-
-	ret = tsens_calibrate_nvmem(priv, 2);
-	if (!ret)
-		return 0;
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
+	return tsens_calibrate_nvmem(priv, 2);
 }
 
 /* v1.x: msm8956,8976,qcs404,405 */
-- 
2.35.1

