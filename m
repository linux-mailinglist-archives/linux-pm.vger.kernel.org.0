Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089176BADD7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCOKkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCOKkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 06:40:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1381B336;
        Wed, 15 Mar 2023 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description;
        bh=J9jyIwtij/bPl4Pi7w2P39EJANKV8puNK30EtS4YUUM=; b=J5/qXGmvxesezJucEBRHka7kP2
        69mo7dSkx5shgMEPgVftwBNGVhlBz5TWRYneSRWWxTpxTzEGC7AuCDV2eOYyiLMFRC9DQMJnXO2As
        t1e/wnmAoP7CMT1rsPJzDiNb26WCr+lvA6DVkhQg1Dw5zNWcZshorbWC5oEn3Ye+IIGhuSpwmXoau
        kyPg006m9le2fFLx7FvtcgWGE6bsuGrSricOB15tMl/RRE76k0rDXYKTQofbnkJ16sMpOZZz9GfVx
        VXNouVhrePPpvREvgKCPGQmn0PqBTmqGrYfPAlkJV6u2Y1XTAYtsNGSD43TIxkoc2sxxmDpSaXnA4
        4pXBn99g==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pcOYQ-00GsYJ-Kv; Wed, 15 Mar 2023 11:40:22 +0100
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
Subject: [PATCH v3 1/6] thermal: qcom: tsens: Drop unused legacy structs
Date:   Wed, 15 Mar 2023 11:39:45 +0100
Message-Id: <20230315103950.2679317-2-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
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

The old single-cell parsing code was removed for MSM8939, MDM9607 and
MSM8976 but for some reason the structs defining the bit positions etc
were kept around (unused). Drop them now.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 51d78b8b1beb ("thermal/drivers/tsens: Drop single-cell code for mdm9607")
Fixes: dfadb4599ab0 ("thermal/drivers/tsens: Drop single-cell code for msm8939")
Fixes: 3a908971f7cb ("thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v3: None
Changes in v2: New patch
---
 drivers/thermal/qcom/tsens-v0_1.c | 36 -------------------------------
 drivers/thermal/qcom/tsens-v1.c   | 22 -------------------
 2 files changed, 58 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89c6f39a3ae..106d26076e3f 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -39,26 +39,6 @@ struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8939_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 12, 0 },
-	.invalid = { 12, 2 },
-	.base = { { 0, 0 }, { 1, 24 } },
-	.sp = {
-		{ { 12, 3 },  { 12, 9 } },
-		{ { 12, 15 }, { 12, 21 } },
-		{ { 12, 27 }, { 13, 1 } },
-		{ { 13, 7 },  { 13, 13 } },
-		{ { 13, 19 }, { 13, 25 } },
-		{ { 0, 8 },   { 0, 14 } },
-		{ { 0, 20 },  { 0, 26 } },
-		{ { 1, 0 },   { 1, 6 } },
-		{ { 1, 12 },  { 1, 18 } },
-	},
-};
-
 struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
@@ -103,22 +83,6 @@ struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_9607_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 2, 20 },
-	.invalid = { 2, 22 },
-	.base = { { 0, 0 }, { 2, 12 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 0 },  { 2, 6 } },
-	},
-};
-
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	u32 p1[5], p2[5];
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index b822a426066d..51322430f1fe 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -42,28 +42,6 @@ struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8976_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 4, 0 },
-	.invalid = { 4, 2 },
-	.base = { { 0, 0 }, { 2, 8 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 8 },  { 2, 14 } },
-		{ { 2, 20 }, { 2, 26 } },
-		{ { 3, 0 },  { 3, 6 } },
-		{ { 3, 12 }, { 3, 18 } },
-		{ { 4, 2 },  { 4, 9 } },
-		{ { 4, 14 }, { 4, 21 } },
-		{ { 4, 26 }, { 5, 1 } },
-	},
-};
-
 static int calibrate_v1(struct tsens_priv *priv)
 {
 	u32 p1[10], p2[10];
-- 
2.30.2

