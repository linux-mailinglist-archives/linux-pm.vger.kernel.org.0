Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A66588E2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiL2DB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiL2DBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55F12A87
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so25930682lfb.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlcwXoa9Z1Zub33BGG0XBB+zLvZVGpO/Coytg4v1lJY=;
        b=DYFFS4SEYB9xvyg6s6bwK4NmjxACzFjZeEjygs7KiNoPN/1VztICgx9gtZHv4G+Qho
         ql7o57kVcvNmXN8uMpWYRNar4vs8YADFzw3yEExcrV0w0/1D7BRV5HYaiEb4QeEvXhm8
         Y0wxFx//gKPGeWi5zKcAFNBM/bypXAcHCh2Svod41yY9b1+kqrI1DQKAyb8U1x5aCyXH
         FniIJThs5YBqwdlj4Wn8kDZgjYvsrXw/4xFz4CqSP+OGVBwaFIeb4l4akiZtXTOq4OIZ
         qHg5RO0wgvXd9Ccf9R+N1zq0zKVH21rMGWconjmSJ4yl1JHfc+3O0Zt/4uD6etVLo2Q2
         L48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlcwXoa9Z1Zub33BGG0XBB+zLvZVGpO/Coytg4v1lJY=;
        b=DkKhwMJBaRxIM2HVRwAJBOUYclVBlImegVyuZ+Nhu3yw2pFyWaatE4R+CC2rC9/Y85
         T+PwlSmgsYPulN8pbOn4j1lqwUfxwolzZUAjb36AYh6AA/Vtpz6xKt6H1LNe5Z63ic08
         dxoC/w9XowVnAqbQVEGhgaU2QwhWrxjTdpF+O7mQFmItoX+ttaOlSrVtB7g9FZWpyeKk
         yt1ey6d3JTWSEBx20JYEYbdCpBKoeTmcglLHGAc46m/q2feQpNOU07/s+Q5ELI6lxZHA
         nw0yJq0OP1HOF1vlDJFSkT17ceDTWCFNKGd57QR0gizC6Gkw7YzkhfiW+nULrwAdP6oa
         ixAQ==
X-Gm-Message-State: AFqh2kqj+kF/Ql+mcFatXdMGHwuqXNBzG/HhaclDJNYRk7pzAyAtLCeJ
        lg+hwh3wwtEQkQQU4QC7TvwRCg==
X-Google-Smtp-Source: AMrXdXty0ToiRwuohIDaGeAram9uJXN0txOkrOEtuQ1Y38+A/B7QQJRiE/eDbTxUZI1cC2oW5pecjQ==
X-Received: by 2002:a05:6512:224e:b0:4cb:ea9:b0d7 with SMTP id i14-20020a056512224e00b004cb0ea9b0d7mr2348509lfu.9.1672282871859;
        Wed, 28 Dec 2022 19:01:11 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:11 -0800 (PST)
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
Subject: [PATCH v5 05/20] thermal/drivers/tsens: Drop msm8976-specific defines
Date:   Thu, 29 Dec 2022 05:00:51 +0200
Message-Id: <20221229030106.3303205-6-dmitry.baryshkov@linaro.org>
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

