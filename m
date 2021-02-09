Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994BA3157C3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 21:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhBIUgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 15:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhBIUd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 15:33:58 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A84C06121E;
        Tue,  9 Feb 2021 11:54:05 -0800 (PST)
Received: from localhost.localdomain (abac187.neoplus.adsl.tpnet.pl [83.6.166.187])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 9F5B61FABC;
        Tue,  9 Feb 2021 20:54:02 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: qcom: tsens-v1: Add MSM8992 support
Date:   Tue,  9 Feb 2021 20:53:46 +0100
Message-Id: <20210209195346.457803-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209195346.457803-1-konrad.dybcio@somainline.org>
References: <20210209195346.457803-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8992 is more or less a cut-down MSM8994, so it only
makes sense that TSENS support only requires a few lines
on top of the bigger brother's code.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/thermal/qcom-tsens.yaml          |  1 +
 drivers/thermal/qcom/tsens-v1.c               | 25 +++++++++++++++++++
 drivers/thermal/qcom/tsens.c                  |  3 +++
 drivers/thermal/qcom/tsens.h                  |  2 +-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f194e914a62e..c69b8727a09c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -31,6 +31,7 @@ properties:
         items:
           - enum:
               - qcom,msm8976-tsens
+              - qcom,msm8992-tsens
               - qcom,msm8994-tsens
               - qcom,qcs404-tsens
           - const: qcom,tsens-v1
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 2127b6edd1ae..a470b24ae720 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -541,6 +541,17 @@ static int calibrate_8994(struct tsens_priv *priv)
 		base1[i] = base1[0];
 	}
 
+	/* 8992 features less sensors and remaps some */
+	if (priv->num_sensors == 13) {
+		p[6] = p[7];
+		p[7] = p[9];
+		p[8] = p[10];
+		p[9] = p[11];
+		p[10] = p[12];
+		p[11] = p[13];
+		p[12] = p[14];
+	}
+
 	compute_intercept_slope_8994(priv, base0, base1, p, mode);
 	kfree(calib0);
 	kfree(calib1);
@@ -642,6 +653,20 @@ struct tsens_plat_data data_8976 = {
 	.fields		= tsens_v1_regfields,
 };
 
+static const struct tsens_ops ops_8992 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8994,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8992 = {
+	.num_sensors	= 13,
+	.ops		= &ops_8992,
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 7, 9, 10, 11, 12, 13, 14 },
+	.feat		= &tsens_v1_feat,
+	.fields	= tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8994 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8994,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 96d17afe3460..1c2e9bebc7c0 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -903,6 +903,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
+	}, {
+		.compatible = "qcom,msm8992-tsens",
+		.data = &data_8992,
 	}, {
 		.compatible = "qcom,msm8994-tsens",
 		.data = &data_8994,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dfbff7f6442c..2548edaa36ec 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -588,7 +588,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8916, data_8939, data_8974;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976, data_8994;
+extern struct tsens_plat_data data_tsens_v1, data_8976, data_8992, data_8994;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_tsens_v2;
-- 
2.30.0

