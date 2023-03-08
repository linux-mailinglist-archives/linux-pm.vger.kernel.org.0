Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD016B09AB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 14:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCHNpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 08:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHNp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 08:45:28 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421836FED;
        Wed,  8 Mar 2023 05:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Jbb5zE7352YGahYLzfXn/4p2SZJUSC3i928Y3dKd0k=; b=Zn+ZY53L6fRYPptsJxv0Gwv051
        dg/9G4u1rq74FLkA4Y0D10IUoPgygp8asJH+V3oKb6RDua7bHGdItmbJLxw8QNWwpkqWpn8zZrqZY
        8P7IAg9ohiuOAFibVFVqprRnfqNeFo7RBhw3bl/pE9O6WwRYkWdCobJQWfOUSSRzpCH5hGWf2vl/U
        V1KnVFP2IJQT5eVGM3W3PkaS4J2PNHatx5PnkwqizFogLPjwOT7+7Xv9M+jKglsAnnKTD/n046FeT
        qd8mrtDTb6UkeGGpLXPU6zqs6uhlJYsTgzue6SHnCjUI06BrkVVMCznNXSbXDRUmv14VHfuAcJlNj
        NeqzF1+A==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pZtZu-00FDCA-NE; Wed, 08 Mar 2023 14:11:34 +0100
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
Subject: [PATCH v2 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope values
Date:   Wed,  8 Mar 2023 14:10:37 +0100
Message-Id: <20230308131041.124482-3-stephan.gerhold@kernkonzept.com>
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

According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
a non-standard slope value of 3000 (instead of 3200) for all sensors.
Fill it properly similar to the 8939 code added recently.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875

Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v2: New patch
---
 drivers/thermal/qcom/tsens-v0_1.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 106d26076e3f..72d08e2337aa 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -222,6 +222,16 @@ static int __init init_8939(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int __init init_9607(struct tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_sensors; ++i)
+		priv->sensor[i].slope = 3000;
+
+	return init_common(priv);
+}
+
 /* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
@@ -320,9 +330,15 @@ struct tsens_plat_data data_8974 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
+static const struct tsens_ops ops_9607 = {
+	.init		= init_9607,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
 struct tsens_plat_data data_9607 = {
 	.num_sensors	= 5,
-	.ops		= &ops_v0_1,
+	.ops		= &ops_9607,
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
-- 
2.30.2

