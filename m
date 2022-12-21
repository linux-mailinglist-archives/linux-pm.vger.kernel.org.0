Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293F652B4A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiLUCFq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiLUCFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BD1F9EF
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so21377352lfz.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbww+IqG9GctHbEU9KIuyB6Vi/2pULzTX7OLKgs1wwk=;
        b=crJzRtwgAE87DUY0ezKOhJ/YGD5rDb61yWuXNDjwJs7WGV0sZyex8ss9BVIU+IWHm6
         vvjMaWB1aqkqqUeOJwPyEpPOBdq4Po8td6CWn0FEL41od/2yZV/UQxfeP06YGvzGEwti
         KZkPEzf9fetD0392Ge3QuNJ1vt0tRQnA2DpK5LeEmQT9g/lQYtxUC5BbHczBjLFs/hAa
         VbNOsUCgsRN5QekcJd6e8UyXg9TUWesZlFudj+abn75ckEkyt0rvtQTZ9iRYiGS95GVk
         S4wwEjkKLcK8Fkf3p8LO4AYnk7LUwzUN5e4ZiO+hW4pQenCrMbLdlBw8mIKUaDWV5s+1
         8JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbww+IqG9GctHbEU9KIuyB6Vi/2pULzTX7OLKgs1wwk=;
        b=x9w3Hh4LlrzYkuGwnbuhi/IYpaIh4l4irY23aoJFHAPXYTXkZT5N+yG4z5MjTfAbCe
         vqdInS1lhJQkG0uZdIGefFcL6wQVNh6eDHXRtOsTRpL7n2PysYvOVcjdrAYd8SZ7iXKq
         rc3IaQtqYT8MFcZOHclWAt/y5r8T06phok8pLNeL8DLShwHUH7PFwJ7iavplCSjq6NXY
         QMXD5Wq0LdLVIy3rcLpmPpL+EMSPzncSk3XgK7dQO7ZcuXl/ve+mr6dEFctQ8qdu2BOr
         9wLIGo9QVuPbZlTrk1K0ZQEH/TsKWw6io82y1xQ2Sx2JhqqpArgnex8Tay/6lKxFUqwF
         ZN7w==
X-Gm-Message-State: AFqh2kqwu9yrFPjumTAIpnnYeYE2mtqL0RHxIoBtQCmXxfXOzo3sFoFe
        2afPqH17YcGVt7jtsC2mw+IBMA==
X-Google-Smtp-Source: AMrXdXtJiQEDtE5EIstQmwoZitxcGRBiWJfzn2dnViwsysUtefTWrMOqpaAjx/QaInD8cWcKocDabw==
X-Received: by 2002:a05:6512:539:b0:4c5:64ed:df06 with SMTP id o25-20020a056512053900b004c564eddf06mr53711lfc.27.1671588331574;
        Tue, 20 Dec 2022 18:05:31 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:31 -0800 (PST)
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
Subject: [PATCH v4 12/20] thermal/drivers/tsens: Drop single-cell code for mdm9607
Date:   Wed, 21 Dec 2022 04:05:12 +0200
Message-Id: <20221221020520.1326964-13-dmitry.baryshkov@linaro.org>
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
index 6b8f7cb7ab9d..d3f46f44c1e1 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -266,30 +266,6 @@ static int calibrate_8974(struct tsens_priv *priv)
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
@@ -353,6 +329,12 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
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
@@ -396,15 +378,9 @@ struct tsens_plat_data data_8974 = {
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

