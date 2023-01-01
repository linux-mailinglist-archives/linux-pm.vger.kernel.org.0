Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D082065AB5D
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjAATlD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjAATkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316FD9C
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 1so38879660lfz.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic31fMG7ujfaKO2qUrY+ZPMHyXpn2xzjXgAqSzwYmrU=;
        b=j4Ansk434Cvyy6VUVHqPhjvuKEufxrjUsfHPCRkjeoP0TCCXSX5y+rlx2UDPV+E8nn
         Z0l6TeK6OnVnBx+4T4XzZBbErffosG+MKd1Xhvc9+LLT+CC8SB2CVX6SKvQEOKuwxe/h
         f4oA82ilO+ekD4We/rctOzq90RcIOUVwqObPKB1EQVclcCr9afrTqw+VlbPh/Qu3ZrrY
         QI3OXiQj5nzAq8tXOqX7QqxXWnFt77AkoYuEoXu5SNYQA2j1ZtaDioy68jPxga1NeDVK
         dwQjfx6W+DBrsZ4VW6Ooc4PBL85oUzypNFJzc68f1yx9Qyi891efugxYwsAgLFPBfLp/
         vQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic31fMG7ujfaKO2qUrY+ZPMHyXpn2xzjXgAqSzwYmrU=;
        b=oHtX0P/NBMI518PxqcVPX1fpeo++xLCoZ6NnYxIV7U/8CJyy7N2gvTT3kAtPO8n0KO
         /50gyGbeve/w/1j9Lpi6uaR+axSsnjxoNUO2Vjyk5++NpcR7gmer+plQx3WLRz5Jruoc
         ZCv/seKr8l3jCM8cMGUoavrqGyAIp+YdUVIH7wf/5Y0zrZbrWj0HychpJr6ArVmvfbPO
         SZw7vO2JF5DSI9MUDuOT0Gh2Ze19cbnSMzPn3+PclBNmMfPVHOX7miGxzngFr7qkUXjT
         ooZzHV2840hGZjmg+1c3vGCp6oik8wfCpwqfaVFDUDweCUh3jRgrX053Gt8OzyYoqzkj
         kX6Q==
X-Gm-Message-State: AFqh2kp3FiEDjwUKyAeRmAW38P5mDrau6ymBve27k0VqCXsFfgEZ5ELQ
        eFU2FJWGTvrx2vCm3ucbLp8JmQ==
X-Google-Smtp-Source: AMrXdXvfC4NLVIogW3uOyLNGTP7y+bTTjFwqJN4CZTvV5lmGW2BoHHkR2jlFLLfqGepuXyK0goGcPQ==
X-Received: by 2002:a05:6512:31d6:b0:4b5:7817:419d with SMTP id j22-20020a05651231d600b004b57817419dmr12657322lfe.41.1672602046207;
        Sun, 01 Jan 2023 11:40:46 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:45 -0800 (PST)
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
Subject: [PATCH v6 12/20] thermal/drivers/tsens: Drop single-cell code for mdm9607
Date:   Sun,  1 Jan 2023 21:40:26 +0200
Message-Id: <20230101194034.831222-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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

