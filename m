Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1C72FA68
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjFNKWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbjFNKWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:22:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F211FC8
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso6624711fa.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738147; x=1689330147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGqdYljk/BXQOSadkDKenWACuVWkhdGMQVPkOQZa/PU=;
        b=iiwazeLR8igv9xFuMHoFoLI2OId5w/jSMbJG/DWsN3kqxWU1BDkqsOymYMTAY0KB8/
         zcdW8tjL2bxfXq5+wrUXhXsWWSloV/6Jp/WmGcA5x4vo2VW5cvQVjv1J5g8762o4r5PH
         79pQELwi4GBJqyvt0Ds52ufkL4uCOhbEJqyCA6zJOBJr60UUpgc03AiKyGfqkAiSmgSj
         ODmUMWZNTZcbY19bO4gxS0BzIefUgnb7c+K1na9HfmBHA6Ti4pwzY8ABAMK64O9hctOf
         3I5NVPR8VWu0V4Znvc25WxcmLkSqXRQuLLw3uWH9JPgtxQ9thbixfSNHxH+QHm4SI+5W
         LgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738147; x=1689330147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGqdYljk/BXQOSadkDKenWACuVWkhdGMQVPkOQZa/PU=;
        b=jyYvbXe0VbVLkivleMGtvJwH4vGCM4X0yPrSmS0OiXc4iSsujpywJ4PrR+M/cByPuP
         pA+qkywe9twpMfJtOtsXXBs6i+DxaB7zxXc5p/4KXRW1YGzAaG1VSMxv7DYUFM0sgM1k
         rOaGrXivT1eeBPb6GeTcH+lq77VybuJi5vnTLsShunowoab6rn9jHxQZ16BYzHYIzkKq
         zECoD0Nfgv50ApABHiwWUZhSJsnmvIvTo1uujTB/u/i9X1PO7MZBcHyC7zZo4+rKs4kQ
         J/6bbJssC6imRqaD/NjdZP67z/Itw4eUGEGQNK84ES/BiE13SkVn+3sFs/LTaPnpCwOh
         ZF3g==
X-Gm-Message-State: AC+VfDxSvJhadEdUz7f22+Elt3EfShok5+x19LFgH4M2FsywROZCznOS
        lUnO8t1c3htKFU+w2JyRQccJFw==
X-Google-Smtp-Source: ACHHUZ6y37TFtTr/+lOpYIuYHEYCQE+evMrk7CU3AT+KaJLUEQ1wBqS3SGkMNYDvJuLOWPTOv9Hs7Q==
X-Received: by 2002:a2e:84d7:0:b0:2a7:a393:a438 with SMTP id q23-20020a2e84d7000000b002a7a393a438mr5748256ljh.24.1686738147034;
        Wed, 14 Jun 2023 03:22:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:18 +0200
Subject: [PATCH v5 07/22] interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-7-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=5451;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ylF4JrhNb4QpLR63mLl/kyJvmecazdKn76bHZ9DX7ks=;
 b=SNwPY5zwZ31Y+j08qInd2HvsdnJyhvW87yLfkSoyt/YOGKoLFub3DKnq9bxIYc0zAg0G07YgJ
 KgvQfknKvhCBUhjXcZyj4OP+5F/64EeUWaVKOkoT3K3Iuptk21TNtI2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

smd-rpm.h is not very useful as-is and both files are always included
anyway.. Combine them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c |  1 -
 drivers/interconnect/qcom/icc-rpm.h |  5 +++++
 drivers/interconnect/qcom/msm8916.c |  1 -
 drivers/interconnect/qcom/msm8939.c |  1 -
 drivers/interconnect/qcom/msm8974.c |  2 +-
 drivers/interconnect/qcom/msm8996.c |  1 -
 drivers/interconnect/qcom/qcm2290.c |  1 -
 drivers/interconnect/qcom/qcs404.c  |  1 -
 drivers/interconnect/qcom/sdm660.c  |  1 -
 drivers/interconnect/qcom/smd-rpm.c |  2 +-
 drivers/interconnect/qcom/smd-rpm.h | 15 ---------------
 11 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 863e8ba1daa2..b8ecf9538ab9 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -14,7 +14,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include "smd-rpm.h"
 #include "icc-common.h"
 #include "icc-rpm.h"
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d2c04c400cad..9ec90e13bfbd 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/soc/qcom/smd-rpm.h>
+
 #include <dt-bindings/interconnect/qcom,icc.h>
 
 #define RPM_BUS_MASTER_REQ	0x73616d62
@@ -121,4 +123,7 @@ enum qos_mode {
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
 #endif
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 5c4ba2f37c8e..196b05879896 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -15,7 +15,6 @@
 
 #include <dt-bindings/interconnect/qcom,msm8916.h>
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index caf0aefad668..639566dce45a 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -16,7 +16,6 @@
 
 #include <dt-bindings/interconnect/qcom,msm8939.h>
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 1828deaca443..968162213d40 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -38,7 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "smd-rpm.h"
+#include "icc-rpm.h"
 
 enum {
 	MSM8974_BIMC_MAS_AMPSS_M0 = 1,
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 20340fb62fe6..1f7e88a37acd 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -18,7 +18,6 @@
 #include <dt-bindings/interconnect/qcom,msm8996.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 #include "msm8996.h"
 
 static const char * const mm_intf_clocks[] = {
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index a29cdb4fac03..cb636e67a5a4 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 
 enum {
 	QCM2290_MASTER_APPSS_PROC = 1,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index fae155344332..938283ddd0e3 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -13,7 +13,6 @@
 #include <linux/of_device.h>
 
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 7ffaf70d62d3..003fc7d110a7 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 
 enum {
 	SDM660_MASTER_IPA = 1,
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index dc8ff8d133a9..b0183262ba66 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
-#include "smd-rpm.h"
+#include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
 
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
deleted file mode 100644
index ca9d0327b8ac..000000000000
--- a/drivers/interconnect/qcom/smd-rpm.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019, Linaro Ltd.
- * Author: Georgi Djakov <georgi.djakov@linaro.org>
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
-#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
-
-#include <linux/soc/qcom/smd-rpm.h>
-
-bool qcom_icc_rpm_smd_available(void);
-int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
-
-#endif

-- 
2.41.0

