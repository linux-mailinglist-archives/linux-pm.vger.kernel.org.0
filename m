Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA33652B30
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLUCFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiLUCF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C911FCD6
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o6so16485060lfi.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1LIXR7d86uJ/gnCpxil12fsOW7FOzRsHJjZeJ/HkoI=;
        b=HclVv+REr5NwIaoMuw1d8bLAAnbTRhDeUjQ0HE26weyUXPjJVl2hOpUO5nOiichZAX
         DqB/t/nobzJhVUx36dAqpF6Wa7Jg8e0VYqcOV//56o6+5S5XXKLZMi+vCroW30harIkr
         Lq3INCadKctkV8UaSWzAyTbO+T4POeXuwUX5f2A9c9TmLEi7uvXIT3sov1ADpFd7HgSe
         lTHK6ywPzm2o50B4+qwVReuTTwCwY/pSHNQ5rrEBBj/9MD9AhBlcADEboMnaj0KKnM0W
         FIDLAr8wd+BLXtCBs49o4FFruN0GREMMIKjrWy1VXksDUtkxpUfOioktTDGJA6/MsSHA
         kotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1LIXR7d86uJ/gnCpxil12fsOW7FOzRsHJjZeJ/HkoI=;
        b=s288y8Lawwhk+g+pSbZILV0ItS3co3t8Ygsf25ra5xUx7tFErZ97pIpK9CGCHaIW0F
         XcoMeCQ0yV2indczkdnsXfLT+gmjppVreKnn43eayiIW77xB8AD0HKIpPDd8uvPcPOub
         vW8jt6PuHdCV6y+3dtwVj/fCzYqvQ/LBWurThivkHwk0cEQTmC5gV+BryWnZ8gDdPeug
         rg1fYjjlzUSI4pGPUi3G382sWi1qgyJMoJOLmSOZ+GihA/WRUsPBnruq+33ElHTL3qFu
         z2IqMBt/ULgWcc9fYenUdv3nYZrFFJX15VgnBMWpZHFqwDYsLvjyEmJP5zJ3FjzjGeXF
         AwYA==
X-Gm-Message-State: AFqh2kpzOjuwptpXjbnm3n9FOdlsn8BcKPWZZjmuD9T1kORNhifRV93T
        6MHp6RCb1HdqPNNDOaraiKeGig==
X-Google-Smtp-Source: AMrXdXvHLDrGA5CuxP2uiBuwfcBRcNhtNAs4l/Dkbyb5wqobzQz8lLk3UhliocDMNtevVFZGKP5TnQ==
X-Received: by 2002:a19:6b08:0:b0:4b6:edef:183b with SMTP id d8-20020a196b08000000b004b6edef183bmr44599lfa.11.1671588325794;
        Tue, 20 Dec 2022 18:05:25 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:25 -0800 (PST)
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
Subject: [PATCH v4 05/20] thermal/drivers/tsens: Drop msm8976-specific defines
Date:   Wed, 21 Dec 2022 04:05:05 +0200
Message-Id: <20221221020520.1326964-6-dmitry.baryshkov@linaro.org>
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
2.35.1

