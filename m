Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3C234FB2
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 05:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHADdA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 23:33:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51734 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgHADc7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 23:32:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252779; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SxG9DUI8j6W7xcfFy8jWpjO+nuVORHIu2LMKU2ZnaKw=; b=wQXHpDdyoGVdkbezW2LKhYCb9dRmy0W8ulejPbqKByY4lKjJWgY4FYNIt7Zq7Cty2lC6cm2x
 9x9Aa4CZJBVa05iKaKFtSf4ZokYEMpjE9UfcTjrawahCMAIbf5MTCNI0Jmiqn2A1ccxM0E0H
 5AYlD0MPfKOaeUBx+4x08r+zaE0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f24e24ad2bd131f6884af13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2AEAC4339C; Sat,  1 Aug 2020 03:32:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABDF9C433C6;
        Sat,  1 Aug 2020 03:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABDF9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 1/6] dt-bindings: interconnect: Add generic qcom bindings
Date:   Fri, 31 Jul 2020 20:32:10 -0700
Message-Id: <20200801033215.1440-2-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200801033215.1440-1-mdtipton@codeaurora.org>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add generic qcom interconnect bindings that are common across platforms. In
particular, these include QCOM_ICC_TAG_* macros that clients can use when
calling icc_set_tag().

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/icc-rpmh.h        | 18 ++------------
 include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 903d25e61984..cb736b745e1a 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
 
+#include <dt-bindings/interconnect/qcom,icc.h>
+
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
 
@@ -44,22 +46,6 @@ struct bcm_db {
 #define MAX_BCM_PER_NODE	3
 #define MAX_VCD			10
 
-/*
- * The AMC bucket denotes constraints that are applied to hardware when
- * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
- * when the execution environment transitions between active and low power mode.
- */
-#define QCOM_ICC_BUCKET_AMC		0
-#define QCOM_ICC_BUCKET_WAKE		1
-#define QCOM_ICC_BUCKET_SLEEP		2
-#define QCOM_ICC_NUM_BUCKETS		3
-#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
-#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
-#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
-#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
-#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
-					 QCOM_ICC_TAG_SLEEP)
-
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
new file mode 100644
index 000000000000..cd34f36daaaa
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,icc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
+
+/*
+ * The AMC bucket denotes constraints that are applied to hardware when
+ * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
+ * when the execution environment transitions between active and low power mode.
+ */
+#define QCOM_ICC_BUCKET_AMC		0
+#define QCOM_ICC_BUCKET_WAKE		1
+#define QCOM_ICC_BUCKET_SLEEP		2
+#define QCOM_ICC_NUM_BUCKETS		3
+
+#define QCOM_ICC_TAG_AMC		(1 << QCOM_ICC_BUCKET_AMC)
+#define QCOM_ICC_TAG_WAKE		(1 << QCOM_ICC_BUCKET_WAKE)
+#define QCOM_ICC_TAG_SLEEP		(1 << QCOM_ICC_BUCKET_SLEEP)
+#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
+#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
+					 QCOM_ICC_TAG_SLEEP)
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

