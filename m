Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A545F652B50
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiLUCFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiLUCFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:38 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE520362
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p36so21320800lfa.12
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/9QwXldICsXiYuGReP63jHiFicVjmDMz2iVFLO9YmY=;
        b=ObfSQ1DImuLQ3sukd2nwJT0JJNhG2nGL7r/xloz6pTSQNkUyybCH2KJ8Qg/EZcXoEy
         2v2CqMkCauVujs5qmi43UUwOpTki60l4Imd94ZuWHquHhZ/OOs6SFS9TokLTeg4zN4bF
         Zbt8WPU5LU9UL1qpPliq8f6b3qq5rzljxBBtJM4kIHv4VKyHGrBtd71y7r1vmzzCCy10
         imujCdAw6Uo2BFGaAXBKzvR/aRtBAvlxgE1dGDS/B32n9P01nj01P5Xcohpi7mLNN3mI
         GDD0dE7JzVgYNOvIgA0sIB084vGD3TSm3UD+lxnxV9otvm/c2LToYwYGPTMEEkkAI4cT
         Djxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/9QwXldICsXiYuGReP63jHiFicVjmDMz2iVFLO9YmY=;
        b=K5JCAcvqEfjWCjhnArgLYnKMhem7jRc4cYx7j3ftTTyonQp/Uujt54uSdD1xcnRdEy
         Mv+XvJTDp7dD2dkDGkbrM2876aNOduvpSHBbBMEJdLighu3B8LzhKq87LB7HhFV42aZ2
         mYZjUNaiHdHQ47AHt7z4JzlafF/E35OB4xd/qZZGj78rynuuVMcOejLerEnh+67iLnVP
         9Df4RaVzVMblZUbp6C5jAkM/RU5hkAmqmXbAuaL1qoGNy4/NRNZY7FbmEvSrxaV27WMj
         7GaVPfK4AnpKvxImZEjw53pv1i2bAy0Sc+cjYsKnf85JLXnOZRwQAaDbU6dYqqeV10V7
         CfaA==
X-Gm-Message-State: AFqh2kqU7pd4o5Iq5s9cbRKxXPGtILw9RMRy2qZT1ggqJV/6XpR0KttP
        LdCzJgAfYu0nRawdYdzgUfUZtA==
X-Google-Smtp-Source: AMrXdXtfenCMHUw12ghDU67jIS7EmiiHA1JSZZL3oQOKOZfFhVRVQJoHBLHICOUvT19gwvOAqnee5g==
X-Received: by 2002:a05:6512:139c:b0:4b5:6ca8:255e with SMTP id p28-20020a056512139c00b004b56ca8255emr126000lfa.34.1671588333153;
        Tue, 20 Dec 2022 18:05:33 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:32 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 14/20] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
Date:   Wed, 21 Dec 2022 04:05:14 +0200
Message-Id: <20221221020520.1326964-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
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
 drivers/thermal/qcom/tsens-v1.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 6d1ea430f90b..b822a426066d 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -88,31 +88,6 @@ static int calibrate_v1(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_8976(struct tsens_priv *priv)
-{
-	u32 p1[11], p2[11];
-	u32 *qfprom_cdata;
-	int mode, ret;
-
-	ret = tsens_calibrate_common(priv);
-	if (!ret)
-		return 0;
-
-	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata))
-		return PTR_ERR(qfprom_cdata);
-
-	mode = tsens_read_calibration_legacy(priv, &tsens_8976_nvmem,
-					     p1, p2,
-					     qfprom_cdata, NULL);
-
-
-	compute_intercept_slope(priv, p1, p2, mode);
-	kfree(qfprom_cdata);
-
-	return 0;
-}
-
 /* v1.x: msm8956,8976,qcs404,405 */
 
 static struct tsens_features tsens_v1_feat = {
@@ -211,7 +186,7 @@ struct tsens_plat_data data_tsens_v1 = {
 
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
@@ -224,7 +199,7 @@ struct tsens_plat_data data_8956 = {
 
 static const struct tsens_ops ops_8976 = {
 	.init		= init_common,
-	.calibrate	= calibrate_8976,
+	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
-- 
2.35.1

