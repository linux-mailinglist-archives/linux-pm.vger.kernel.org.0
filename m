Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C616588E8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiL2DBb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiL2DBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB741274F
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so25883891lfb.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBYfLgB5XZjYPnLTkY/89t/VQdLmxU6vZgVD6CyWzV4=;
        b=DPqWy+xFMvLip6wsVgj8jz1VVHxjf+zKeylhOMOGlDtxGSZAvPkN+a+VidVSoUhXCQ
         syqOV/TA8zOJnlpDLcwTwIbxO30EbDeJWYXZ/glsRLTeZp70cn+FngEGSlfbkiSujGBO
         26EDxC0WfVHu/K79+/efM8GgMB7F9zxo1bCTzyvS8QUjCzTyhzkyG7KEaPLHQQPL4rXr
         UmAgvnAxGt/dGZ+01u7RnVVXaiAtuwU6J3Ol0rZZnaPq2MUNBVo2xOfg7XoXCs8Q4HrT
         QSiwR1z92Bw/++OeI+aIEQKxcO5t7Z2i4NnnABNaoEq6YIOyh9mV90XJKspCLhuhh1BJ
         URvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBYfLgB5XZjYPnLTkY/89t/VQdLmxU6vZgVD6CyWzV4=;
        b=GXz8WWUY0MZR+3GR7A4HZq7JS3O+GPzKHn18FB133gJxTBYKvtrQICCXqfCKqQCE0i
         UiiuIk3WxQnUC9Zl8Gu42nrcjTrcj1surTHtY/4HBlr1ApnHJM5RZWCveQlyvphxNlbh
         1//NSOjHpfd6puVo9HK77lhzuUX7eM0ZtF4sohWQ7xtwHTfU/3Lf8DUMznT98AsNi7PV
         2gV9nmjwTYGJDvH6lhoCG1TuTkb+JGVPa35meZZzOxyn7DlhWn58A9WRCF3oIVQhiK2T
         wDiy+5G46M+vaw6TwYmkWbJ4dI4BhwUlbH0g3L9S91+g9PgYHKrSnjV8OAojUDCeTVDp
         WrJw==
X-Gm-Message-State: AFqh2kqqjlVbROKQ8F+DIhabQGFwtlxm2KoUxo0vftMvOIAERmZ846yr
        ygG1ZSl+NVLOLGITjU6Ajedv8w==
X-Google-Smtp-Source: AMrXdXuIKVrtvaBguDYWMRUAMDa8onBYE/EQD2t1N9aooy6pgWlEixPp5VV3SaGYEuOBAU5Z/isa5w==
X-Received: by 2002:a05:6512:c24:b0:4b5:964d:499b with SMTP id z36-20020a0565120c2400b004b5964d499bmr9048001lfu.34.1672282874486;
        Wed, 28 Dec 2022 19:01:14 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:14 -0800 (PST)
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
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 08/20] thermal/drivers/tsens: limit num_sensors to 9 for msm8939
Date:   Thu, 29 Dec 2022 05:00:54 +0200
Message-Id: <20221229030106.3303205-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
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

On msm8939 last (hwid=10) sensor was added in the hw revision 3.0.
Calibration data for it was placed outside of the main calibration data
blob, so it is not accessible by the current blob-parsing code.

Moreover data for the sensor's p2 is not contiguous in the fuses. This
makes it hard to use nvmem_cell API to parse calibration data in a
generic way.

Since the sensor doesn't seem to be actually used by the existing
hardware, disable the sensor for now.

Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6645c98ff56c..579028ea48f4 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -285,7 +285,7 @@ static int calibrate_8939(struct tsens_priv *priv)
 	u32 p1[10], p2[10];
 	int mode = 0;
 	u32 *qfprom_cdata;
-	u32 cdata[6];
+	u32 cdata[4];
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
@@ -296,8 +296,6 @@ static int calibrate_8939(struct tsens_priv *priv)
 	cdata[1] = qfprom_cdata[13];
 	cdata[2] = qfprom_cdata[0];
 	cdata[3] = qfprom_cdata[1];
-	cdata[4] = qfprom_cdata[22];
-	cdata[5] = qfprom_cdata[21];
 
 	mode = (cdata[0] & MSM8939_CAL_SEL_MASK) >> MSM8939_CAL_SEL_SHIFT;
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
@@ -314,8 +312,6 @@ static int calibrate_8939(struct tsens_priv *priv)
 		p2[6] = (cdata[2] & MSM8939_S6_P2_MASK) >> MSM8939_S6_P2_SHIFT;
 		p2[7] = (cdata[3] & MSM8939_S7_P2_MASK) >> MSM8939_S7_P2_SHIFT;
 		p2[8] = (cdata[3] & MSM8939_S8_P2_MASK) >> MSM8939_S8_P2_SHIFT;
-		p2[9] = (cdata[4] & MSM8939_S9_P2_MASK_0_4) >> MSM8939_S9_P2_SHIFT_0_4;
-		p2[9] |= ((cdata[5] & MSM8939_S9_P2_MASK_5) >> MSM8939_S9_P2_SHIFT_5) << 5;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = (base1 + p2[i]) << 2;
 		fallthrough;
@@ -331,7 +327,6 @@ static int calibrate_8939(struct tsens_priv *priv)
 		p1[6] = (cdata[2] & MSM8939_S6_P1_MASK) >> MSM8939_S6_P1_SHIFT;
 		p1[7] = (cdata[3] & MSM8939_S7_P1_MASK) >> MSM8939_S7_P1_SHIFT;
 		p1[8] = (cdata[3] & MSM8939_S8_P1_MASK) >> MSM8939_S8_P1_SHIFT;
-		p1[9] = (cdata[4] & MSM8939_S9_P1_MASK) >> MSM8939_S9_P1_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = ((base0) + p1[i]) << 2;
 		break;
@@ -544,7 +539,7 @@ static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[6].slope = 2833;
 	priv->sensor[7].slope = 2838;
 	priv->sensor[8].slope = 2840;
-	priv->sensor[9].slope = 2852;
+	/* priv->sensor[9].slope = 2852; */
 
 	return init_common(priv);
 }
@@ -620,9 +615,9 @@ static const struct tsens_ops ops_8939 = {
 };
 
 struct tsens_plat_data data_8939 = {
-	.num_sensors	= 10,
+	.num_sensors	= 9,
 	.ops		= &ops_8939,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, /* 10 */ },
 
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
-- 
2.39.0

