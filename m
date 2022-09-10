Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D95B4650
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIJMrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIJMrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99957885
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f9so6521025lfr.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iyLJM2ivj9OayZ1Gbrfmv/SCUsNDLfYUYCHfT2xtVAg=;
        b=NMvRr+TL65NHCL8CIt/5F+p3LNeG/p125xgfrCXOIRzv9YCtBL4v5q9X/G0RNTZVhi
         Z2flYHSDIva4ULbuVeuNh1zNHX2Oo1IjPIrA0pYqDbwiqo224W+HFJE543qhmV/onyOT
         7T7EfsIO7YG153t3hCQNMC06iCUn12KUQvh445zI5y0vepb6E9TPeV2NoSTC8CRJWEhc
         5mzsL9ZB3Qz7eePDFISDTbzf5jdm4RAAqCUW93sn0uhIssjpnkSUepNztH8+mSTzxM4h
         P94RhN9UYsabf0stLKrSh0ysaJXSCplDj4cbWsnTN55ZGK56kK1cL3RUA3Ese9X8O1vv
         k2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iyLJM2ivj9OayZ1Gbrfmv/SCUsNDLfYUYCHfT2xtVAg=;
        b=mzL1xx3FGTjhYrwtmhpzeW1NcUoPXBznk6jip2IEFj9YhoBi9+sXsQpMh+7yOThj8+
         10BOLUn+I/dN8YIFbm6Wr2iZjiowj8pfZAgcS2iMFp6F3l6/SJWpyN3ePy2OmJgll4IX
         Huu9UB0aLJn+wWAU7O3PKzwEuz4DhQp3ucvUhI+ivCBZTy1ZNlPErofvVD6+rM+XM21I
         P9qn8lnCWmlBqINMXdWbqIOd4uX+BJd8td67c1uRmyOR5R8qDNTPzEVNl6deZau2V3Fa
         /IWcVoyLir5hJwVH/5jP1+gl6ARD14jj61CjqxhFu099P21KrDRTgrb4CGm3bq0jMS9P
         O83A==
X-Gm-Message-State: ACgBeo0Ztm0DsTxPdql0INL62fJH4n4NX2QQVKv9S21+3WfgULBbRnFU
        s7h2WYHVhL4SmDtxD446gKRpog==
X-Google-Smtp-Source: AA6agR7QvsF59RsHftc+KqJVxU60L8D8pkYueVPOrmiOFaIYA1p6vv8angtB52lmnHeoQXS/UOdeaA==
X-Received: by 2002:a05:6512:68e:b0:498:fe8e:e078 with SMTP id t14-20020a056512068e00b00498fe8ee078mr2045685lfe.364.1662814025083;
        Sat, 10 Sep 2022 05:47:05 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:04 -0700 (PDT)
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
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RFC PATCH 03/10] thermal/drivers/tsens: drop single-cell code for msm8939
Date:   Sat, 10 Sep 2022 15:46:54 +0300
Message-Id: <20220910124701.4060321-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/thermal/qcom/tsens-v0_1.c | 129 +-----------------------------
 1 file changed, 1 insertion(+), 128 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 2974eea578f4..add5d9dbc9d4 100644
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
@@ -286,77 +229,7 @@ static int calibrate_8916(struct tsens_priv *priv)
 
 static int calibrate_8939(struct tsens_priv *priv)
 {
-	int base0 = 0, base1 = 0, i;
-	u32 p1[10], p2[10];
-	int mode = 0;
-	u32 *qfprom_cdata;
-	u32 cdata[6];
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
+	return tsens_calibrate_nvmem(priv, 2);
 }
 
 static int calibrate_8974(struct tsens_priv *priv)
-- 
2.35.1

