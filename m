Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AEE5663ED
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiGEHX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGEHX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:23:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A526D8
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:23:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so10273031plx.7
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WnlHr6IrouPH/wdi+y79keal1VSMpfo6gBqx2QqUOA=;
        b=jMjoxFsd486oE3FC/1OV+TXoTPvyA0f/fVP8RlIjffVJgbQBQr88CGBCf9hFgVQ/h2
         gA+wnz587o/QbyFc8FFb24s1l8W2YG/cG3A7k+gW/RjYm18HlaRpbhgspDVH5N4iEvfb
         gTLNjidkg5gw+VC3V7IRxK/9ki9BYcNvM9SWFjOlOGRtz5Dh63JpMBxec23Zzrs7CMEi
         w6+iEZ2mHdcAZIuYKcBya5G4yZSzht9bM4hiXwiIqSZtIGL0ZLwwY5WxrofcVHwtKm6H
         dkt7jyuF1mEmF3FEdUP6+7RGKGAhBGrO5E44ojfyyGY1TG0cUDM51MaWAvP5nViMCEF3
         66dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WnlHr6IrouPH/wdi+y79keal1VSMpfo6gBqx2QqUOA=;
        b=HE3SzLXKvi1x+mSKaroGODW8HTg+E5Zk6Xb9hvQ8c5jKBUanFnJMUuBn4XJ3sMD8B9
         7/vjOXu6km9Wby0xl5dkV11ECq0WCeKO3bies1+NLf6z3Z6JNRqOr+lRp5fcI7IQji2G
         UZSUFR7j1UMItDecxueLPVIlB13L1HredHJSRx4m7Acl4XNK06VB5tJypfMufdutm/74
         MlzwhsgIL7/pSBeTblHqprceTE5KrTGW3Qz4O/DZDGHOEUy0Vp8kqnjsO8evASKVgBdr
         tv4G1d8loKHqs4woYvSk99Oa46CP5aTW8llUTZtrWDwKMwf8YOVDieibUvFkJvhIV1oM
         PXrw==
X-Gm-Message-State: AJIora/pzQl3CghL2cvufIkX17NETTf85iwdKkb+M6dlAyjxmaDCRbNk
        UTq1uS0bxrlRwM+lije1AdfvAw==
X-Google-Smtp-Source: AGRyM1u+GpdXwjY5NmoqHdiEAPlKAYAfxc5Zrx0kV6ITgrqKHF3jmKQ6UA9Azg8zTD3ISHYx2YNAhA==
X-Received: by 2002:a17:90a:5207:b0:1ee:dfa1:afa9 with SMTP id v7-20020a17090a520700b001eedfa1afa9mr39753660pjh.246.1657005834498;
        Tue, 05 Jul 2022 00:23:54 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0050dc76281f0sm22148016pfb.202.2022.07.05.00.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:23:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 2/5] interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
Date:   Tue,  5 Jul 2022 15:23:33 +0800
Message-Id: <20220705072336.742703-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705072336.742703-1-leo.yan@linaro.org>
References: <20220705072336.742703-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

since there have conflict between two headers icc-rpmh.h and icc-rpm.h,
the function qcom_icc_xlate_extended() is declared in icc-rpmh.h thus
it cannot be used by icc-rpm driver.

Move the function to a new common file icc-common.c so that allow it to
be called by multiple drivers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/Makefile     |  3 +++
 drivers/interconnect/qcom/icc-common.c | 34 ++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-common.h | 13 ++++++++++
 drivers/interconnect/qcom/icc-rpmh.c   | 26 +-------------------
 drivers/interconnect/qcom/icc-rpmh.h   |  1 -
 drivers/interconnect/qcom/sm8450.c     |  1 +
 6 files changed, 52 insertions(+), 26 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 120e279a7427..8e357528185d 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
+
+interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
 qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8939-objs			:= msm8939.o
diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
new file mode 100644
index 000000000000..0822ce207b5d
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "icc-common.h"
+
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+{
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	node = of_icc_xlate_onecell(spec, data);
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+	if (!ndata)
+		return ERR_PTR(-ENOMEM);
+
+	ndata->node = node;
+
+	if (spec->args_count == 2)
+		ndata->tag = spec->args[1];
+
+	if (spec->args_count > 2)
+		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
+
+	return ndata;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
new file mode 100644
index 000000000000..33bb2c38dff3
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
+#define __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
+
+#include <linux/interconnect-provider.h>
+
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
+
+#endif
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 8acc8e67a332..114bb8f64573 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 
 #include "bcm-voter.h"
+#include "icc-common.h"
 #include "icc-rpmh.h"
 
 /**
@@ -100,31 +101,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
-{
-	struct icc_node_data *ndata;
-	struct icc_node *node;
-
-	node = of_icc_xlate_onecell(spec, data);
-	if (IS_ERR(node))
-		return ERR_CAST(node);
-
-	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
-	if (!ndata)
-		return ERR_PTR(-ENOMEM);
-
-	ndata->node = node;
-
-	if (spec->args_count == 2)
-		ndata->tag = spec->args[1];
-
-	if (spec->args_count > 2)
-		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
-
-	return ndata;
-}
-EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
-
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index d29929461c17..04391c1ba465 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -131,7 +131,6 @@ struct qcom_icc_desc {
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 int qcom_icc_rpmh_probe(struct platform_device *pdev);
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 7e3d372b712f..e821fd0b2f66 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 
 #include "bcm-voter.h"
+#include "icc-common.h"
 #include "icc-rpmh.h"
 #include "sm8450.h"
 
-- 
2.25.1

