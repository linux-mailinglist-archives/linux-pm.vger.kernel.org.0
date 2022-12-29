Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C66588F9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiL2DBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiL2DBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE913DFA
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt23so9256803lfb.5
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otU7+taAT1gaqY+K87YTze62BlL5D4+uBfLQQXiIsAw=;
        b=soiDSOcX6IqlOBzdq2ng1vEL9NiNS4dfCFtoq6PFWdxySXhyWKY/q1BNulJIK1Lf+E
         1/Ra8tHrqmOSr0/vMRW6RtdJwzX/hothxrq/GGK2UlBgjLQHAMKuEPvwpZ/IlmyrQmhF
         SyjJfqLvdtHOTVWrbRt9em5hSXPd1TnQzDTjJ4CfIlja9A2pWZ3c2vhjMzSQLSdSxZIc
         g426XVPBAiHX2yuHtDKxWNcuNneJrTbWwWC4lGzDQHqHUb/4HYlUoQTzRqfCDmw+Ro7Z
         k+inNMSOTIlDLbCDzLG5i4Ge9advYO5Qy4I0xSx87UFiMTNsh3nxhtNhs6oxQfuen5V8
         RTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otU7+taAT1gaqY+K87YTze62BlL5D4+uBfLQQXiIsAw=;
        b=FELrO0baiNmmq3v9Znw34Kl1wYamD02WkaL3AJUq7eC13zxb7gKtEtqeVjUk1OQ87M
         OBhAVe5CnccfSfXoCFWJNOg5K2MjPl7js85QFrTJDuZCTH2sahaeh28jMJEejRiS2fpv
         /ZKJM8YyBKlyx3BSlet9VCyPY/1bEL9EcYpAr/hBZwT5SfLHuSc8JSwHlJfswqB7b1S0
         TZPZIOA1ArhVF2TnbMAeHYFmip05z6esuX5mxCWtOy02dT7YYqsLgE8k5sAz2aaKS7mb
         NMHC4bFfFHFfhbYZFAKOn1KG9GAAmVD9q4Zg5jyqqyeV6yqvTJnYuKVzFOuOrLOmIErN
         CdPg==
X-Gm-Message-State: AFqh2kqa6CFI/PB+GYFt+KDLoN5FNk7XxoJg9PdxeSjmN9hdi0OGdSuw
        08qMelDnLf022G0EX2WNao2VCg==
X-Google-Smtp-Source: AMrXdXsudjtNm2hIJlA6+ZkQb1C2yTi59sfthxHbwWsBBAWluIGwwLbyvIAHonGdpzjkIpPPZn3Dxg==
X-Received: by 2002:a05:6512:2255:b0:4a4:68b8:c2ad with SMTP id i21-20020a056512225500b004a468b8c2admr8392239lfu.4.1672282879578;
        Wed, 28 Dec 2022 19:01:19 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:18 -0800 (PST)
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
Subject: [PATCH v5 14/20] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
Date:   Thu, 29 Dec 2022 05:01:00 +0200
Message-Id: <20221229030106.3303205-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
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
2.39.0

