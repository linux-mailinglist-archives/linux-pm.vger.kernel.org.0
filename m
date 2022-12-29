Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3432F6588F6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiL2DBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiL2DBV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA513DF9
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m6so15526593lfj.11
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic31fMG7ujfaKO2qUrY+ZPMHyXpn2xzjXgAqSzwYmrU=;
        b=VY+MDugTOt9wQyAMuq55q3JOzHqSo3LgGY648d/9OuhxiI5IzT46m1dSDICQRubLU2
         ckQFYdHKkyAf3t7LxsPZls0uz2l6tJciROyQNYbeWsJJZ8BXwBWweGgboaKhMqLyGegu
         CTg4E6mG57zg0xNIVVoXqbSJkor7gqE2lBIQWPHjLP+b+GpwSRFbCH3YAM2BqC9frUUD
         SbaU9xoPCrc7zwV8hfRGWXL26eStIVITdigNYq+jjgLWjsDYeO5dgP0XtwLP8k+cUd/h
         cQBllebZ7I/haE0r+0Y08KFm70Xgvsv06a30kqn/mfhngoeZ21EpwKE/JrT/870ZPmoQ
         pchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic31fMG7ujfaKO2qUrY+ZPMHyXpn2xzjXgAqSzwYmrU=;
        b=Jc/5Scujv3FWQo6Ta8GyHEwaFznIZHmH11ICf+GWnr+QCdGH8SRjukCw00R14FpBS+
         09fujzb9Gr2HLinG27Qzt797c7wA762blfiXgmBaUWjIoJKsVfvWUDfjK6DL0S5BTx9R
         Xo+jTckGcDemJsmMrnXBH2Wl/94Sxu8hPG6M9LU+FCni6xtn5E0B3GZpvEQnWI0CC7A9
         8RQU1p8IGo/2aJFpHlwyYeqA4vNfMpYV6GjvsNRq6Ua3VsfxKBovbMOqiwLPU6iDhirg
         W09mi6dWxpBdsXOUgfxfZRd61SzSO5gb/GuhJR5ZB5sl/LtH2Vj9R1Ek4nQqbJHLB9eB
         lHsw==
X-Gm-Message-State: AFqh2kpmIB3CM8TQj1pxFLKWezTBDjQTVCR3LEsvbZTjdgfeG2lWuOKk
        4f3YQpXtRhz3dpbfNz0iVTEmCg==
X-Google-Smtp-Source: AMrXdXunXIL2hDL8yZL8qn6r+1xgXtJSgnN7gJXFddcjuDsRfl0wgvuOee9o20YbedCDVFdta55bIQ==
X-Received: by 2002:a05:6512:ac1:b0:4b5:9dc4:e785 with SMTP id n1-20020a0565120ac100b004b59dc4e785mr8392430lfu.45.1672282877742;
        Wed, 28 Dec 2022 19:01:17 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:17 -0800 (PST)
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
Subject: [PATCH v5 12/20] thermal/drivers/tsens: Drop single-cell code for mdm9607
Date:   Thu, 29 Dec 2022 05:00:58 +0200
Message-Id: <20221229030106.3303205-13-dmitry.baryshkov@linaro.org>
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

There is no dtsi file for mdm9607 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on mdm9607.

Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 38 ++++++-------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index f8b50bf14190..9488416b568c 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -267,30 +267,6 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_9607(struct tsens_priv *priv)
-{
-	u32 p1[5], p2[5];
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
-	mode = tsens_read_calibration_legacy(priv, &tsens_9607_nvmem,
-					     p1, p2,
-					     qfprom_cdata, NULL);
-
-	compute_intercept_slope(priv, p1, p2, mode);
-	kfree(qfprom_cdata);
-
-	return 0;
-}
-
 static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
@@ -355,6 +331,12 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
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
@@ -398,15 +380,9 @@ struct tsens_plat_data data_8974 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
-static const struct tsens_ops ops_9607 = {
-	.init		= init_common,
-	.calibrate	= calibrate_9607,
-	.get_temp	= get_temp_common,
-};
-
 struct tsens_plat_data data_9607 = {
 	.num_sensors	= 5,
-	.ops		= &ops_9607,
+	.ops		= &ops_v0_1,
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
-- 
2.39.0

