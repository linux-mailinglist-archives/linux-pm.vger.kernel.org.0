Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B121ACB7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 03:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgGJB5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 21:57:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61278 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbgGJB5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 21:57:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594346265; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SxG9DUI8j6W7xcfFy8jWpjO+nuVORHIu2LMKU2ZnaKw=; b=KzPvRoIA2utEgcrkscq50+dHeHXdGTpqwR54KJN+P0WBIryniLIKAB2PZYd8Q9wkLBOopJag
 cUK80HLdz1MAV5r8sTQ0WmHqk1wu9Mk+IL6nEB2R2QizMuvUm7ii9OK+gDLtrEtC3Rj0Nzb5
 eMxZoeU0CAEB7lb3bakpGRgTunA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f07caf39f03943e5ca7ec86 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 01:57:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E7F6C4339C; Fri, 10 Jul 2020 01:57:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36455C433CA;
        Fri, 10 Jul 2020 01:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36455C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 1/6] dt-bindings: interconnect: Add generic qcom bindings
Date:   Thu,  9 Jul 2020 18:56:47 -0700
Message-Id: <20200710015652.19206-2-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200710015652.19206-1-mdtipton@codeaurora.org>
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
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

