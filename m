Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F165AB49
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjAATkq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjAATkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:45 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF801082
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so28506577lfj.11
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+QyReNeKQ7VChfSL5c4X0M1KNpysUipua99JNIB2DI=;
        b=kjkiBXtyWNd/HybSMFlvQ3+bLJel7+AOdDzcLs0zuWzT+XsR0MTk6QgitEHceeig6n
         X/MBjcAEj10JkMfT1ndcGrwU+LVrHV2+vijOhxGjIjp6TTTc0JminSGAS4SyJi0rZHr/
         CGo46JN39vyERjWqLFE8+GdEK0pU7pOA9CWR0XFtr4YYwgi10ny87i/n3mViCVTp4yjl
         zHBEC+1a5ZxfKd7JUS6R+6zIJTf5L9rP7guq4UdQgARPCES9cZPvsgG3pgiBGwr4jbpr
         j85IgDsjwv2x2UqL4VfYeB5BQ49ve+2YvmVfbmT1ytkEXRAkTU/QKAhugY+kF3ERLgJH
         exRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+QyReNeKQ7VChfSL5c4X0M1KNpysUipua99JNIB2DI=;
        b=xsIZ2alqPevFJtm8VWTjbimxV0Nz+s+J0nDklcGXPOLOVp4FvXSaODvVVWOt8CpZ+w
         O56ENYQCTAmkrZ+SQBuHbAUVm+i3QuEwa5y8D+SNt/Rv6Z0cREQaWl75nbT6JTQuotnB
         yr3ZKC3TE2HQ4PG2DVVbynSWRyEMN76xgCxZ8XHrVCMpnck0EixOHJ17IRXdH2pV2oNU
         IC3VPjH7WTRM6X41f7jl9JAD0fvUgbQ50CsD6B6tzjZq1LndgGClhj6PUykMceqZ6ogs
         18Hsu7pzIPSx0fEfzu2VAZRl4Zi94rBfhSZCiT7zoAyHt+ohlX2HTlQ2Z2A6bIVJkQbt
         B+Yw==
X-Gm-Message-State: AFqh2kqO5r1mPkWnIyKLsD279d1Zzz121kcivw20G7BqVUMypC3UWdUz
        iypjktuq2q1ZF3ia/tEKCZdHpw==
X-Google-Smtp-Source: AMrXdXtCRZ1tvIzmUTXEI03LgsxKCO8RWTE4LM7KFgc63Ns9t2p+NvKdtUDEj1290/Q0rkaMpWnRsQ==
X-Received: by 2002:a05:6512:3d1f:b0:4a4:68b8:f4d0 with SMTP id d31-20020a0565123d1f00b004a468b8f4d0mr12341737lfv.22.1672602041392;
        Sun, 01 Jan 2023 11:40:41 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:40 -0800 (PST)
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
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 06/20] thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
Date:   Sun,  1 Jan 2023 21:40:20 +0200
Message-Id: <20230101194034.831222-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 56 ++++++++++++++++++---------------
 drivers/thermal/qcom/tsens.c    |  3 ++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index a7f53966156b..83c2853546d0 100644
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
@@ -360,6 +336,22 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static int __init init_8956(struct tsens_priv *priv) {
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
@@ -372,13 +364,25 @@ struct tsens_plat_data data_tsens_v1 = {
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
index b5b136ff323f..b191e19df93d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -983,6 +983,9 @@ static const struct of_device_id tsens_table[] = {
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
index 899af128855f..7dd5fc246894 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -594,7 +594,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976;
+extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-- 
2.39.0

