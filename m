Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59625C960
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgICTWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 15:22:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56869 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729206AbgICTWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 15:22:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599160934; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qLLtxNHJYrYCngVI61j10KgSkzJBI9yW9H6Se+IKbwg=; b=ZqV168JGS2Jt7Ru+1+4KgZg2ipSpUXLfh2WfDZVx0O7dkvJACR3GjsCufQkKMdKSZNskvadQ
 LiO+/D8o4+eiMxV3A/Yxhvsy9C2w0XSI/rwpIbgH7Z22GdaTIRKzHgV0z3WO1fx9lOyz7C0N
 0jM5YBhxwphYQARPWutZvHt7bTk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f51426532925f96e1dc8bd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 19:22:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2407AC4339C; Thu,  3 Sep 2020 19:22:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48570C433C8;
        Thu,  3 Sep 2020 19:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48570C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/6] dt-bindings: interconnect: Add property to set BCM TCS wait behavior
Date:   Thu,  3 Sep 2020 12:21:46 -0700
Message-Id: <20200903192149.30385-4-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200903192149.30385-1-mdtipton@codeaurora.org>
References: <20200903192149.30385-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add "qcom,tcs-wait" property to set which TCS should wait for completion
when triggering.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index 5971fc1df08d..e23df4836c6f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -21,6 +21,23 @@ properties:
     enum:
       - qcom,bcm-voter
 
+  qcom,tcs-wait:
+    description: |
+      Optional mask of which TCSs (Triggered Command Sets) wait for completion
+      upon triggering. If not specified, then the AMC and WAKE sets wait for
+      completion. The mask bits are available in the QCOM_ICC_TAG_* defines.
+
+      The AMC TCS is triggered immediately when icc_set_bw() is called. The
+      WAKE/SLEEP TCSs are triggered when the RSC transitions between active and
+      sleep modes.
+
+      In most cases, it's necessary to wait in both the AMC and WAKE sets to
+      ensure resources are available before use. If a specific RSC and its use
+      cases can ensure sufficient delay by other means, then this can be
+      overridden to reduce latencies.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
 
@@ -39,7 +56,10 @@ examples:
   # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
   - |
 
+    #include <dt-bindings/interconnect/qcom,icc.h>
+
     disp_bcm_voter: bcm_voter {
         compatible = "qcom,bcm-voter";
+        qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
     };
 ...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

