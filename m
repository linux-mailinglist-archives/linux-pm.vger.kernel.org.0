Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC1641AEF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLDF7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiLDF7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FB1A398
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so7961634lfb.1
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLW4pqXQy2v3Ss4XquahujdspSmUxh+viRfoGE7e7/I=;
        b=I5WiLXmSTtQJCUEJhBSZDie8/8FPrVr5zZQH5wDy/+IM8jxbIUfVHQEAmW0hryRPmr
         8bB/5ZV6sBNkwHBaH2KZFB2aEC4Haum+m4/a2X2vzPmqmcvoZiRmDvp24WAYuOygPiDb
         1ZdgF3b8VGfVscutwuKMM5JlWQH0aVOEDswfs4RwWzGg2WfE5cYP2Vu6rhgdHfSK7ftr
         DHQCIB8dZfr11IgA6NCv8FDXXL6w9c8Z6h1z2XSK+ngT/3OiaE/8urU9j0pr23drC8FB
         efs0M9/MzKpTJjjdKsA3dPrj9YRpmUAsvXyWLXPma/zICgUR1A9SO/8E+kME/mUJRKIf
         6QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLW4pqXQy2v3Ss4XquahujdspSmUxh+viRfoGE7e7/I=;
        b=v0qHYRt8k2Un20iX/JTDGjt1LaIcQ/GoFaJtRO1xA25JpONDg/cHggaUz3Yba9ng2M
         DAtoawhalOk8RuZ/2dqh0IN7A9TaV+hknK19WSCYV+cLD5zAcBRRu7Ff2cRaTRth76Gg
         +pYGj0gcrt2gByBIRXziKI1jVf9BbVP/Clpw+ptATJWwf6DY8Rh+UrzqzvwdBuIgIodE
         d/XdcsjkLG9E5PS8dqFFPstT7ngNYP4v2aCFz1t+tXWvnPeAnSdFLTYxy7/3o15CRuh7
         alSYV6B38/rR3iNa6ICyN5uq/T5513OU3GV3QOvCvMfxt0NU75ApCfMbQzS2RioOp7bP
         Kl7A==
X-Gm-Message-State: ANoB5pk5ztN0WHDnZDJNWCS+CP6FDZRK6HF/MRDLILb2Qu/H57ayjzDC
        It8H/Lxx9qZZtVimmvQi0XwR2A==
X-Google-Smtp-Source: AA0mqf6BkEFRA5S7js+8pf+nkG5y/nUMzpin2cRds0kyo4G271UHFNnDyFpEKf4oDUBE/78e+IET4Q==
X-Received: by 2002:ac2:4dad:0:b0:4b5:2f4e:a0cc with SMTP id h13-20020ac24dad000000b004b52f4ea0ccmr7495714lfe.392.1670133555818;
        Sat, 03 Dec 2022 21:59:15 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:15 -0800 (PST)
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
Subject: [PATCH v2 06/15] thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
Date:   Sun,  4 Dec 2022 07:59:00 +0200
Message-Id: <20221204055909.1351895-7-dmitry.baryshkov@linaro.org>
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

Tsens driver mentions that msm8976 data should be used for both msm8976
and msm8956 SoCs. This is not quite correct, as according to the
vendor kernels, msm8976 should use standard slope values (3200), while
msm8956 really uses the slope values found in the driver.

Add separate compatibility string for msm8956, move slope value
overrides to the corresponding init function and use the standard
compute_intercept_slope() function for both platforms.

Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 56 ++++++++++++++++++---------------
 drivers/thermal/qcom/tsens.c    |  3 ++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 5bceee535fc5..119b619e72c2 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -137,30 +137,6 @@
 #define CAL_SEL_MASK	7
 #define CAL_SEL_SHIFT	0
 
-static void compute_intercept_slope_8976(struct tsens_priv *priv,
-			      u32 *p1, u32 *p2, u32 mode)
-{
-	int i;
-
-	priv->sensor[0].slope = 3313;
-	priv->sensor[1].slope = 3275;
-	priv->sensor[2].slope = 3320;
-	priv->sensor[3].slope = 3246;
-	priv->sensor[4].slope = 3279;
-	priv->sensor[5].slope = 3257;
-	priv->sensor[6].slope = 3234;
-	priv->sensor[7].slope = 3269;
-	priv->sensor[8].slope = 3255;
-	priv->sensor[9].slope = 3239;
-	priv->sensor[10].slope = 3286;
-
-	for (i = 0; i < priv->num_sensors; i++) {
-		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
-				(CAL_DEGC_PT1 *
-				priv->sensor[i].slope);
-	}
-}
-
 static int calibrate_v1(struct tsens_priv *priv)
 {
 	u32 base0 = 0, base1 = 0;
@@ -286,7 +262,7 @@ static int calibrate_8976(struct tsens_priv *priv)
 		break;
 	}
 
-	compute_intercept_slope_8976(priv, p1, p2, mode);
+	compute_intercept_slope(priv, p1, p2, mode);
 	kfree(qfprom_cdata);
 
 	return 0;
@@ -357,6 +333,22 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+int __init init_8956(struct tsens_priv *priv) {
+	priv->sensor[0].slope = 3313;
+	priv->sensor[1].slope = 3275;
+	priv->sensor[2].slope = 3320;
+	priv->sensor[3].slope = 3246;
+	priv->sensor[4].slope = 3279;
+	priv->sensor[5].slope = 3257;
+	priv->sensor[6].slope = 3234;
+	priv->sensor[7].slope = 3269;
+	priv->sensor[8].slope = 3255;
+	priv->sensor[9].slope = 3239;
+	priv->sensor[10].slope = 3286;
+
+	return init_common(priv);
+}
+
 static const struct tsens_ops ops_generic_v1 = {
 	.init		= init_common,
 	.calibrate	= calibrate_v1,
@@ -369,13 +361,25 @@ struct tsens_plat_data data_tsens_v1 = {
 	.fields	= tsens_v1_regfields,
 };
 
+static const struct tsens_ops ops_8956 = {
+	.init		= init_8956,
+	.calibrate	= calibrate_8976,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8956 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8956,
+	.feat		= &tsens_v1_feat,
+	.fields		= tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8976 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8976,
 	.get_temp	= get_temp_tsens_valid,
 };
 
-/* Valid for both MSM8956 and MSM8976. */
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1b10005fb28..252c5ffdd1b6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -968,6 +968,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
+	}, {
+		.compatible = "qcom,msm8956-tsens",
+		.data = &data_8956,
 	}, {
 		.compatible = "qcom,msm8960-tsens",
 		.data = &data_8960,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ba05c8233356..4f969dd7dc47 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -588,7 +588,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976;
+extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_tsens_v2;
-- 
2.35.1

