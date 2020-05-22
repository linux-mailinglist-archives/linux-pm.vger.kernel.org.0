Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2815C1DE5DA
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgEVLq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 07:46:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38912 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729748AbgEVLqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 07:46:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590148014; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ioG91ONt67Thh3+++IhEIy7PrY5ruyU1b97zWmsYRzM=; b=aG7YxhTrByn1IwJKz+2vkAZFWhI76uXAdZkh+1iPVIdCBUjp/P2BqkYXmAi59jqEOINqh/gP
 2E6nNmC/NCi6jAhiYp/8ak3qpujcFmON5rjnKLP7+qFqCFFfccwfUDtGyY8hlHVjxWbkksE+
 xiKQ487T9iBWnxz1KUOrQdN+T3o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec7bbae.7f14944eb570-smtp-out-n01;
 Fri, 22 May 2020 11:46:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96367C43395; Fri, 22 May 2020 11:46:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DD86C433C6;
        Fri, 22 May 2020 11:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DD86C433C6
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
Subject: [PATCH v3 2/2] dt-bindings: thermal: tsens: Add cold interrupt support in yaml
Date:   Fri, 22 May 2020 17:16:26 +0530
Message-Id: <20200522114626.28834-3-manafm@codeaurora.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522114626.28834-1-manafm@codeaurora.org>
References: <20200522114626.28834-1-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cold interrupt support for tsens in yaml.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 2ddd39d96766..3592322fe172 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -52,12 +52,14 @@ properties:
     items:
       - description: Combined interrupt if upper or lower threshold crossed
       - description: Interrupt if critical threshold crossed
+      - description: Interrupt if cold threshold is crossed
 
   interrupt-names:
     minItems: 1
     items:
       - const: uplow
       - const: critical
+      - const: cold
 
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
@@ -174,4 +178,42 @@ examples:
            #qcom,sensors = <13>;
            #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 4 (for any platform containing v2.6+ of the TSENS IP)
+    //           (with thermal-zone):
+    tsens4: thermal-sensor@c265000 {
+           compatible = "qcom,sc7180-tsens", "qcom,tsens-v2";
+           reg = <0xc265000 0x1ff>,
+                 <0xc223000 0x1ff>;
+
+           interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 501 IRQ_TYPE_EDGE_RISING>;
+           interrupt-names = "uplow", "critical", "cold";
+
+           #qcom,sensors = <15>;
+           #thermal-sensor-cells = <1>;
+    };
+
+    thermal-zones {
+            cold_thermal: cold-thermal {
+                    polling-delay-passive = <0>;
+                    polling-delay = <0>;
+
+                    thermal-sensors = <&tsens4 128>;
+
+                    trips {
+                            cold-trip {
+                                    temperature = <1>;
+                                    hysteresis = <1>;
+                                    type = "passive";
+                            };
+                    };
+
+                    cooling-maps {
+                    };
+            };
+    };
 ...
-- 
2.26.2
