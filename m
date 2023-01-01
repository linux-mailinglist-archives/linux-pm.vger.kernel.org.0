Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E565AB63
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjAATlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAATkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE87FFC
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so38891221lfa.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvBs74YfpWC4BlnlrgIGPtcDViBoUL8HTEcoEwvCBA8=;
        b=H5B7N3z5HmbvnUAap8b+0J9g19cmjTXFDe7f80d/0ogLbfCPP/mph6SISOuV/8zP9D
         vyVIbiLA1HqpeoyNuuTRqfTMQMKO6lqjA3+/Ya3qySMaFxbujQry3h/gWCKgcFdijhQt
         4RyFMLZBM7rh7sEhXm/FK9CEN75Em2FIJX+aMbsWJgrPEpIn+D2IfGqgWm0Q4tXUKu/I
         Rji3QvECGDbOMh75rGWj4VeeD3yORX3gfbvOXFWXG9nJJWeWXhuP1YUYNj5vk3f9kASS
         Gj2FrAnwJyG2TvsScH1d9EkEFGtcEvfTbV669mIkjkbXc0/uZWvNAYkviKLvnGpE0Vx5
         USWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvBs74YfpWC4BlnlrgIGPtcDViBoUL8HTEcoEwvCBA8=;
        b=OLzlECUIKXCpOKEa34OJtPLQ02MeMGr0tP8tFYWp5orIrtlY5GTtgbkqtW1+/9ipIs
         RfvVqUq9khQBG7FllK1ghD01tH90vpEaX/a2FIuJ4smF0gHJCsFrVGW5/2Ipb0KVwh6m
         3Rc1CYkUO+5XzNTH4aL+MtgmrUJYosMqzMp6FoH276M/5okWZcwKmPf4c6eGwe9xQaNv
         EdYeMcrHLrJkLUxfq0h/8/b4WOXjI7k7OTBqnWx8ZhO/99J5N3HqJ57QFL756OuTHaJj
         Lkv7RGBCypHYkMTQxyaX1pU4k2eDMtc4Y5rWF/DSZ/7XipbG/xI5zTF543NtcsNDaNHC
         BgNA==
X-Gm-Message-State: AFqh2ko6rCDpnwZNASBXQOvzXZ6JFL5IOSGODPFyOadGNtBGhqLd+5Sf
        0/NxNaxg7/Bd8HgG8w4qaKRWyw==
X-Google-Smtp-Source: AMrXdXue3QJH27rRQHt1kNxFyvrmcDGwWgd5top/bBUbSdiiizljPqJMh73IKaKZiEBzf+cd85HAQA==
X-Received: by 2002:a05:6512:3f16:b0:4ca:f97f:4a21 with SMTP id y22-20020a0565123f1600b004caf97f4a21mr9460201lfa.37.1672602048431;
        Sun, 01 Jan 2023 11:40:48 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:47 -0800 (PST)
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
Subject: [PATCH v6 14/20] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
Date:   Sun,  1 Jan 2023 21:40:28 +0200
Message-Id: <20230101194034.831222-15-dmitry.baryshkov@linaro.org>
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

There is no dtsi file for msm8976 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on msm8976.

Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

