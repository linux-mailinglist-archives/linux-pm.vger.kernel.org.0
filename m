Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882BE6B09A1
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjCHNp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 08:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCHNpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 08:45:04 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF52783155;
        Wed,  8 Mar 2023 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QNpLZI4QGEZ9zqfRRjnmcl5vwu4v8kej+ev70a+XED0=; b=SyaCWLH2ORjanRgmjXv6D/tSNe
        TfRo3R2m6mFA7hKf9l1/en7q2z+9PTR8EUGm2lIlISCbz3muLDFIjzmMpn/TiStKhUu5aPke7hHHV
        0UQ6UIZx7RbB4mhSbgemHNl0VQErACEvNbCc5YGuDGW9cU69XIO7icDr7oo3LgPyNPtL4TvPSsjWG
        h925CixOJNmQKFq/sQlyc6C2iHhMYUNHJwtVp7CBnT/0tHtp76M2vrRomBGy457yzrByaAYjLOlkQ
        TdNyvP6cMVJvToHfqtiC1n5RCxFYgGBelchgt9lU2JBCj9ZDTMtipwURXJYz7ETmgpT2JzFqPBfzQ
        HGnoFAFg==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pZta4-00FDCA-PP; Wed, 08 Mar 2023 14:11:44 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v2 6/6] thermal: qcom: tsens-v0_1: Add MSM8909 data
Date:   Wed,  8 Mar 2023 14:10:41 +0100
Message-Id: <20230308131041.124482-7-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308131041.124482-1-stephan.gerhold@kernkonzept.com>
References: <20230308131041.124482-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block. Like
MDM9607 it uses a non-standard default slope value of 3000 [1] and needs
per-sensor "correction factors" to workaround issues with the factory
calibration [2].

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-09100-8x09.0/arch/arm/boot/dts/qcom/msm8909.dtsi#L476
[2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/6df022c6d0c2c1b4a5a6c2124dba4d57910c0911

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Change in v2:
  - Rewrite on top of per-sensor nvmem cell changes that landed in 6.3
---
 drivers/thermal/qcom/tsens-v0_1.c | 32 ++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +++
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 9d264dafcd7c..7865165863c6 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -207,6 +207,23 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+static int __init init_8909(struct tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_sensors; ++i)
+		priv->sensor[i].slope = 3000;
+
+	priv->sensor[1].p1_calib_offset = -10;
+	priv->sensor[1].p2_calib_offset = -6;
+	priv->sensor[3].p1_calib_offset = -9;
+	priv->sensor[3].p2_calib_offset = -9;
+	priv->sensor[4].p1_calib_offset = -8;
+	priv->sensor[4].p2_calib_offset = -10;
+
+	return init_common(priv);
+}
+
 static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
@@ -243,7 +260,7 @@ static int __init init_9607(struct tsens_priv *priv)
 	return init_common(priv);
 }
 
-/* v0.1: 8916, 8939, 8974, 9607 */
+/* v0.1: 8909, 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -298,6 +315,19 @@ static const struct tsens_ops ops_v0_1 = {
 	.get_temp	= get_temp_common,
 };
 
+static const struct tsens_ops ops_8909 = {
+	.init		= init_8909,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8909 = {
+	.num_sensors	= 5,
+	.ops		= &ops_8909,
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 32d2907f76e5..a04179247b34 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1109,6 +1109,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
+	}, {
+		.compatible = "qcom,msm8909-tsens",
+		.data = &data_8909,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 880be6be5c3f..c88287dede96 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -639,7 +639,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
-- 
2.30.2

