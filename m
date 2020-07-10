Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8D21ACA7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 03:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGJB5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 21:57:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22398 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgGJB5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Jul 2020 21:57:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594346244; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=u8uz0uMN/xy7PGwmfxG8bfDIz484M6eYVSKAENLu8us=; b=BK9YEJ8O/XnAFBSrsjbVLDKtvN37s0/LAlYIGVBLT+V8Bj62cPLd7iiI0VQwAg88vQevMR/e
 qVgCYt9cKJzZLuyAgwK66OJP5zb9Q2jrZlyXTWm352IGALsj3GlaxsdNe8kVi0Pi/k1lWRdY
 /mE2ouEmZMet1d/vSxFvMBwdXKk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f07caf3bca1ed3155803d09 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 01:57:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D4D0C43395; Fri, 10 Jul 2020 01:57:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5B6DC43391;
        Fri, 10 Jul 2020 01:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5B6DC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 2/6] dt-bindings: interconnect: Add property to set BCM TCS wait behavior
Date:   Thu,  9 Jul 2020 18:56:48 -0700
Message-Id: <20200710015652.19206-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200710015652.19206-1-mdtipton@codeaurora.org>
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add "qcom,tcs-wait" property to set which TCS should wait for completion
when triggering.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index 5971fc1df08d..f0c3d6b01831 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -21,6 +21,16 @@ properties:
     enum:
       - qcom,bcm-voter
 
+  qcom,tcs-wait:
+    description: |
+      Optional mask of which TCSs (Triggered Command Sets) wait for completion
+      upon triggering. In most cases, it's necessary to wait in both the AMC
+      and WAKE sets to ensure resources are available before use. If a specific
+      RSC and its use cases can ensure sufficient delay by other means, then
+      this can be overridden to reduce latencies.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: QCOM_ICC_TAG_ACTIVE_ONLY
+
 required:
   - compatible
 
@@ -39,7 +49,10 @@ examples:
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

