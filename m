Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734FC1D677F
	for <lists+linux-pm@lfdr.de>; Sun, 17 May 2020 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgEQKr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 May 2020 06:47:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35881 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727943AbgEQKr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2020 06:47:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589712446; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=q9iI9zh/lVW9wi2kuh1erK872V+tOBI5Kri0nX3QX1U=; b=OcifvWB5ZBt4Imo9Kw8k77itlEYztx2TPo+ZZSPhlUVqs3xVBuSWkHyJF3dkTD2uEKSWLBS/
 IZ0UxYGkgipcWXjpDdTwPsCX53/ljEq4idpYq7tHC6Ds0hO5KMlBFKIubUQAh+XhF0DoZspP
 WFaIE/aFvCswW7N/DOpAAHOGWHw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec1163e.7f453b6a4e30-smtp-out-n05;
 Sun, 17 May 2020 10:47:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 527B6C4478C; Sun, 17 May 2020 10:47:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A30F1C44791;
        Sun, 17 May 2020 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A30F1C44791
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt support in yaml
Date:   Sun, 17 May 2020 16:16:27 +0530
Message-Id: <20200517104627.29501-3-manafm@codeaurora.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517104627.29501-1-manafm@codeaurora.org>
References: <20200517104627.29501-1-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add zeroc interrupt support for tsens in yaml.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 2ddd39d96766..717b0dd967e2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -52,12 +52,14 @@ properties:
     items:
       - description: Combined interrupt if upper or lower threshold crossed
       - description: Interrupt if critical threshold crossed
+      - description: Interrupt if zeroC threshold is crossed
 
   interrupt-names:
     minItems: 1
     items:
       - const: uplow
       - const: critical
+      - const: zeroc
 
   nvmem-cells:
     minItems: 1
@@ -109,8 +111,10 @@ allOf:
       properties:
         interrupts:
           minItems: 2
+          maxItems: 3
         interrupt-names:
           minItems: 2
+          maxItems: 3
 
 required:
   - compatible
@@ -174,4 +178,21 @@ examples:
            #qcom,sensors = <13>;
            #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 4 (for any platform containing v2.6+ of the TSENS IP):
+    tsens4: thermal-sensor@c265000 {
+           compatible = "qcom,sc7180-tsens", "qcom,tsens-v2";
+           reg = <0xc265000 0x1ff>,
+                 <0xc223000 0x1ff>;
+
+           interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 501 IRQ_TYPE_EDGE_RISING>;
+           interrupt-names = "uplow", "critical", "zeroc";
+
+           #qcom,sensors = <15>;
+           #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.26.2
