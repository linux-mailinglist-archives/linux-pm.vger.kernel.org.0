Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94034641AF8
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLDF73 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLDF7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14831A3BA
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so13728333lfi.7
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRYmmsGMtCh0vhHBz8nWsTEotdKXt8fxYlhjfd0exgU=;
        b=peVCkE3DdjqcVO1tUaP9rclRyzDN0GbWm/q52ALPIjkMcDWUIIc2P22ACypqszzibm
         os7MtPHFBZg+c2ZZ/lsIgZhGEhu9VBZXQM+5nEwNC/+28eEb7npMmeFbZRg/1yKxSaQ9
         8wNYGNBtbtQ5OB0qa1JFLdg7MUCv2ktPqZTw0sFiiSWkVp44gtz3nnOGHpOXxUfuHw27
         Uu4aYyrqy868Eo72BWleN1Ig3Tq7WkZjy3s3+JWq3NikJvBc1bknBancbL4GNZL/hqrq
         m5kl8NPwj9Yf26DtlwkN3gLww5BtP17W7PapgWlMlke1JYt5mh2CiReN7nyIdZQ6zKZm
         8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRYmmsGMtCh0vhHBz8nWsTEotdKXt8fxYlhjfd0exgU=;
        b=kY9/Sanh1uve3+RkLgCyqc65PjvBckV236fM4MNo8Ik3QxvsdcVKJWy+38f+/4naTo
         vk4q3KWua8rLUk8SmUa5rM6+xT42Q1gLtTa4YtiY2mIpj3sjbgecG1wbaS6xhZrf/3AU
         L/nYBc3CA+eDuZ0nbAjuYqiB/skdLY3PL/g2bh0lZKcSgy6sGv5jXACjpJTlX60mhTMx
         /eifut//sxWforIloFOuLYFWwiaz1GzHnN8Z71IKRgl2Eyo01jdrWt6hxY5hwjGq3FdW
         E/BcVpPvIW2iXfwITufn4nt8Evx8MFxcC+y7OTwfgyIyi3ij1Z2eIT4HXPDtd6eV0hSw
         Hq6w==
X-Gm-Message-State: ANoB5pmUWpBZnhx+biCtMV1wZGJG4HWhPycNeqeJINT0er/VsrpnEd7g
        9pd9Gh7JEl7jrDb6+JFpWO1slw==
X-Google-Smtp-Source: AA0mqf5Y8p+JYOdEWQQIUa7N4IVAmDK266RGyUlyTyCpKPSeHpg00ttomLuNkbOkW2emeiywHDN8pw==
X-Received: by 2002:a05:6512:104e:b0:4b5:604a:5b24 with SMTP id c14-20020a056512104e00b004b5604a5b24mr1454242lfb.550.1670133558164;
        Sat, 03 Dec 2022 21:59:18 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:17 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 09/15] thermal/drivers/tsens: Drop single-cell code for mdm9607
Date:   Sun,  4 Dec 2022 07:59:03 +0200
Message-Id: <20221204055909.1351895-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 95 +------------------------------
 1 file changed, 1 insertion(+), 94 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a273a0643053..c84abe9b4299 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -133,39 +133,6 @@
 
 #define BIT_APPEND		0x3
 
-/* eeprom layout data for mdm9607 */
-#define MDM9607_BASE0_MASK	0x000000ff
-#define MDM9607_BASE1_MASK	0x000ff000
-#define MDM9607_BASE0_SHIFT	0
-#define MDM9607_BASE1_SHIFT	12
-
-#define MDM9607_S0_P1_MASK	0x00003f00
-#define MDM9607_S1_P1_MASK	0x03f00000
-#define MDM9607_S2_P1_MASK	0x0000003f
-#define MDM9607_S3_P1_MASK	0x0003f000
-#define MDM9607_S4_P1_MASK	0x0000003f
-
-#define MDM9607_S0_P2_MASK	0x000fc000
-#define MDM9607_S1_P2_MASK	0xfc000000
-#define MDM9607_S2_P2_MASK	0x00000fc0
-#define MDM9607_S3_P2_MASK	0x00fc0000
-#define MDM9607_S4_P2_MASK	0x00000fc0
-
-#define MDM9607_S0_P1_SHIFT	8
-#define MDM9607_S1_P1_SHIFT	20
-#define MDM9607_S2_P1_SHIFT	0
-#define MDM9607_S3_P1_SHIFT	12
-#define MDM9607_S4_P1_SHIFT	0
-
-#define MDM9607_S0_P2_SHIFT	14
-#define MDM9607_S1_P2_SHIFT	26
-#define MDM9607_S2_P2_SHIFT	6
-#define MDM9607_S3_P2_SHIFT	18
-#define MDM9607_S4_P2_SHIFT	6
-
-#define MDM9607_CAL_SEL_MASK	0x00700000
-#define MDM9607_CAL_SEL_SHIFT	20
-
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -363,60 +330,6 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_9607(struct tsens_priv *priv)
-{
-	int base, i;
-	u32 p1[5], p2[5];
-	int mode = 0;
-	u32 *qfprom_cdata;
-	int ret;
-
-	ret = tsens_calibrate_common(priv);
-	if (!ret)
-		return 0;
-
-	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata))
-		return PTR_ERR(qfprom_cdata);
-
-	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = ((base + p1[i]) << 2);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
-
-	compute_intercept_slope(priv, p1, p2, mode);
-	kfree(qfprom_cdata);
-
-	return 0;
-}
-
 /* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
@@ -506,15 +419,9 @@ struct tsens_plat_data data_8974 = {
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
2.35.1

