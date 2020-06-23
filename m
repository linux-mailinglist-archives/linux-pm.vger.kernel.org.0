Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26320486F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 06:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgFWEGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 00:06:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18026 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbgFWEGB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 00:06:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592885160; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8fgyorfpK/VFkEZLYoMBhJ8V5MCNVB2/DTEqyisSt14=; b=QH6+RY1rsOJf56LQI7X1ohyhhCg4E1MP12hUqQlcvGxBdtiuAO0xqKALPE7oNAkSPywfiNCs
 bAFzKgIsK6NuV7xzxwcyhqMqh19ekh+a9orVOp2KxeZZafnHhaAlLKk+pFrADI1rIRUc+9lS
 LSOcGD3Xi7NfFImFbTo1bl6WlKE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ef17f89c76a4e7a2abcd71f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 04:05:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F11F5C433A0; Tue, 23 Jun 2020 04:05:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 238E2C4339C;
        Tue, 23 Jun 2020 04:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 238E2C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 2/2] interconnect: qcom: Don't redefine bucket/tag macros
Date:   Mon, 22 Jun 2020 21:05:15 -0700
Message-Id: <20200623040515.23317-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200623040515.23317-1-mdtipton@codeaurora.org>
References: <20200623040515.23317-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace internal bucket/tag macros with those defined in dt-bindings.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/icc-rpmh.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

