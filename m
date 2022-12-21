Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE52652B3F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiLUCFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiLUCFb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07E1FCF6
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so21395203lfb.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8V/Buc6oo2svqQs4bKfvvLZCMHlCzEmULQ8sDxAW8g=;
        b=WBrsrnQGNMU70Bch/jsQeIvUfBeODew72Zw+gWa5YHlNg86oslkeBj2FOGFSmvo7Yj
         Rkb86rD+qWIU1gOSQzE93nihA6kF/RLW3l+rbV9zNPbm58j6/md+3i99fOeVscVLaBNY
         m+3slxRk8yQKpl5T7OeQ0dFOyQDuB4UsyTpY45amHkNNBeZdNdWtR2yf5r7RnNLrEiCt
         Wb2RWJ+LgYFYBtQ4TS3LaMfQXMv5WbqwB81Ngi98AmZNGhXZFjSLj9PtKk4BFJ7G/Q3p
         QDIdeqxF0IMos8HhF1NjGmP2oskcgZWQfVKlYV4qUUl3pD+IpZ1akBwBKZOuNGxgUAd0
         Tm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8V/Buc6oo2svqQs4bKfvvLZCMHlCzEmULQ8sDxAW8g=;
        b=3yV4GG1SxIksIvT3JiW556DnLJX8NkEfmF05d7Q4joEoLiUY18bTo4B2nGmUQE9nwC
         c0ZLS7xPfSZzq5jm7MBMAHis72Ry6hk/As3qHWj1I/IhnBnJhZc4H6d8fmOjDJ2PkaXR
         HaYAhh1ohiyOMoDn3SrI1svaKeWy7sB4UTnYed6WVOg52HEvH3A6+YxG/+yF9sv9QqnP
         FXsk73yZHbl5MZSVozP/rT82rqp3mAOTbIHx2ef6j7PxPNeg7FbFntlvKKjYQLsoKDyF
         aiKywUUMuJB4mTxjUABcvDoFh30Rl4IJ9ZwKkDQ68FHhim2iBeOLlu7oVEMZzuqQ7Id5
         L8jw==
X-Gm-Message-State: AFqh2krbk7Mv5rBg1HNvWBdBK7A5vLXBmp+RX2LEFGd+EYKkuAMZaNE6
        AcAgnP32gx9BpUobC6oasXLI7A==
X-Google-Smtp-Source: AMrXdXvEUY39j5qaHX11vhY3UPeRstTWDj7AelJ2YuHu1KWVWuWHIs+HF9FQyfrSNTFCDAFjowgxlw==
X-Received: by 2002:ac2:4c8e:0:b0:4b6:ee97:36d2 with SMTP id d14-20020ac24c8e000000b004b6ee9736d2mr1138468lfl.40.1671588328108;
        Tue, 20 Dec 2022 18:05:28 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:27 -0800 (PST)
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
        devicetree@vger.kernel.org
Subject: [PATCH v4 08/20] thermal/drivers/tsens: fix slope values for msm8939
Date:   Wed, 21 Dec 2022 04:05:08 +0200
Message-Id: <20221221020520.1326964-9-dmitry.baryshkov@linaro.org>
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

According to the vendor kernels (msm-3.10, 3.14 and 3.18), msm8939
uses non-standard slope values for calibrating the sensors. Fill them
accordingly.

Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 57ac23f9d9b7..be173220a939 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -534,6 +534,20 @@ static int calibrate_9607(struct tsens_priv *priv)
 	return 0;
 }
 
+static int __init init_8939(struct tsens_priv *priv) {
+	priv->sensor[0].slope = 2911;
+	priv->sensor[1].slope = 2789;
+	priv->sensor[2].slope = 2906;
+	priv->sensor[3].slope = 2763;
+	priv->sensor[4].slope = 2922;
+	priv->sensor[5].slope = 2867;
+	priv->sensor[6].slope = 2833;
+	priv->sensor[7].slope = 2838;
+	priv->sensor[8].slope = 2840;
+
+	return init_common(priv);
+}
+
 /* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
@@ -599,7 +613,7 @@ struct tsens_plat_data data_8916 = {
 };
 
 static const struct tsens_ops ops_8939 = {
-	.init		= init_common,
+	.init		= init_8939,
 	.calibrate	= calibrate_8939,
 	.get_temp	= get_temp_common,
 };
-- 
2.35.1

