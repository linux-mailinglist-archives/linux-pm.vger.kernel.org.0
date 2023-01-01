Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9905B65AB47
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjAATkp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAATkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE310A2
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f34so38853513lfv.10
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlcwXoa9Z1Zub33BGG0XBB+zLvZVGpO/Coytg4v1lJY=;
        b=SDqkxDlDL+GygwSeARvDRp57SXFiWrze7Y1D45ROj0ydxpgybJT87aIiDonEsVDkRs
         2pDlPlbz18w1BuuqLs31QhP0VGVOCkVMsu21sWM0UqBdhwJCX2etdBUFWBYEuF0WzlZW
         lWSopJVw2WRmqvnK4y/14eSbZ+bSFj12u7t72HNN++frkHnTqt7uF0ymaTZvfc9EGeiS
         3JgefkbmItiPSApDZ1Y+ZRFXeooWA4DI/5a6qFtoAAg9dU+KcfJvZVw2n01kmxmcxJFX
         NiGKBOL9HHj41+RPhN1afljQ+0mmrFQOA3MqhCLSrHa7XGeH08o9trJwJ1qFaETi71UO
         Ir5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlcwXoa9Z1Zub33BGG0XBB+zLvZVGpO/Coytg4v1lJY=;
        b=xE7H7+aGbfSLZmSGE0TrZZho4RPcGzlaGopznxaHMZy9H+lD+km68yVq7sRW1EZ+++
         KO17RzaelE7vUe4HoDR3cx9sGW/vpztGhWfEvHLaY2pbEd4Tpcui9OVzQTg1o8T6o/+h
         gqLqreGGxhlMoW316ar572am87P7SlvycArAdeVrosr3wODLYQmxFFQqDrnkf/x1JNZ9
         jWjlevevo/ipJjh9DYdrsISiojVSSTsABp8W++U5/B+3qUoAYMdSOXQFdPiA9XUB3Qam
         SjRj939LN04YDbhbCCneFEyHQ8ksJZOcVenukKRY+bhD6ixi7BRZMy7+1uWFytFvAGin
         qpjA==
X-Gm-Message-State: AFqh2krQJ4Pk2PEHwIk3wPY2OgIHMGESSIyhEpsCUkLYS3VSfu1qAMgS
        bGXM7xHavq1+jO0fl2mTn+XnDw==
X-Google-Smtp-Source: AMrXdXvV6q1pi6fVP69X0degnRtUtgfPef8Z4BiP2r24SThja+jtExZwCox096GQWwYjJV7PsgNH9w==
X-Received: by 2002:a05:6512:21c6:b0:4b5:83b8:2c49 with SMTP id d6-20020a05651221c600b004b583b82c49mr10173890lft.1.1672602040577;
        Sun, 01 Jan 2023 11:40:40 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.39
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
Subject: [PATCH v6 05/20] thermal/drivers/tsens: Drop msm8976-specific defines
Date:   Sun,  1 Jan 2023 21:40:19 +0200
Message-Id: <20230101194034.831222-6-dmitry.baryshkov@linaro.org>
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

Drop msm8976-specific defines, which duplicate generic ones.

Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 96ef12d47bff..a7f53966156b 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -78,11 +78,6 @@
 
 #define MSM8976_CAL_SEL_MASK	0x3
 
-#define MSM8976_CAL_DEGC_PT1	30
-#define MSM8976_CAL_DEGC_PT2	120
-#define MSM8976_SLOPE_FACTOR	1000
-#define MSM8976_SLOPE_DEFAULT	3200
-
 /* eeprom layout data for qcs404/405 (v1) */
 #define BASE0_MASK	0x000007f8
 #define BASE1_MASK	0x0007f800
@@ -160,8 +155,8 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
 	priv->sensor[10].slope = 3286;
 
 	for (i = 0; i < priv->num_sensors; i++) {
-		priv->sensor[i].offset = (p1[i] * MSM8976_SLOPE_FACTOR) -
-				(MSM8976_CAL_DEGC_PT1 *
+		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
+				(CAL_DEGC_PT1 *
 				priv->sensor[i].slope);
 	}
 }
-- 
2.39.0

