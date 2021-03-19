Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D26342457
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCSSP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCSSPk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819AC06174A;
        Fri, 19 Mar 2021 11:15:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z1so11867994edb.8;
        Fri, 19 Mar 2021 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=uAXbunQs0IIo7RMIgCpl9apRy37+bfYnY5A1Irx8atReGVDdY0xuNMKnEyjptYlvES
         FJY0+YLBAXaEg+3GmBcpEm8HpaNogfn6ftLPgxLH3Ij6knXe5tBDx9OFuky3tMPp9pdW
         /tx45fTD4dmZpcJJudf6RhhTgpldipdc1+MFKm8LO76ACkn/f8D7hQC0l36jAQDavvuZ
         UT/BXeCP0RB+lvnk4AWu9QnJz7stP4Aver3196x25u9B163i8qZQkiSLT0GK6n+Bdy4t
         LO6OyxTl6ir2WUIAxWWYyZpj4xXEcqqLLgrmKHVx2H0UC1EWn9XxWNjc5qimra6N2dhY
         BAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=UNA1ornbzfVf5pmL+f33AXV2byYBpXLaB7+Ek2eJVvfDyaVayz43p9af407e357jVG
         nX8ivo+qrp6txjb7NjDGhGZYH1zE+8MwFg7jFB/xmUbQzcZVJm3JzWn12Ityt8g2Cb4G
         gQl9XwEXp2Lo2y64ksj2ZayKGbP7WVFfmF4anUzNh+/mB2+WShXEvs0XQqHeArq+1gkZ
         gXj+BCdsaZP3OBqShFp+wuheTU/WD7tmxZrjqKtGukvFg5CrQq3oIPJHExTVSloWR84Z
         Ju2RQsYPMHBlQsV2FQ+MTTuN2zp2H7/lTAvgWiL9Qy9tPCRaR8ocfflmjLyFNYu6D9KS
         Pl4g==
X-Gm-Message-State: AOAM530bRB4MqJVhoOZt3vjFMyu3PL2h+B7zYsRiZVDwuRUl6VV259Rx
        Gy5VJXjSe35rsw2hYfUDE+k=
X-Google-Smtp-Source: ABdhPJzUYSLf+jXHmuJZU5JUVzU+n458KVkjtywbDejWnb+o4W/7QJVWGfmgFRL0T4F+pV0ngKCzuw==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr11227411edb.304.1616177738220;
        Fri, 19 Mar 2021 11:15:38 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 9/9] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Fri, 19 Mar 2021 19:15:12 +0100
Message-Id: <20210319181512.7757-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..1785b1c75a3c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: msm9860 TSENS based
+        items:
+          - enum:
+              - qcom,ipq8064-tsens
+
       - description: v0.1 of TSENS
         items:
           - enum:
@@ -73,7 +78,9 @@ properties:
     maxItems: 2
     items:
       - const: calib
-      - const: calib_sel
+      - enum:
+          - calib_backup
+          - calib_sel
 
   "#qcom,sensors":
     description:
@@ -88,12 +95,20 @@ properties:
       Number of cells required to uniquely identify the thermal sensors. Since
       we have multiple sensors this is set to 1
 
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+  - "#qcom,sensors"
+
 allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8064-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
@@ -114,17 +129,42 @@ allOf:
         interrupt-names:
           minItems: 2
 
-required:
-  - compatible
-  - reg
-  - "#qcom,sensors"
-  - interrupts
-  - interrupt-names
-  - "#thermal-sensor-cells"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,tsens-v0_1
+              - qcom,tsens-v1
+              - qcom,tsens-v2
+
+    then:
+      required:
+        - reg
 
 additionalProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example msm9860 based SoC (ipq8064):
+    gcc: clock-controller {
+
+           /* ... */
+
+           tsens: thermal-sensor {
+                compatible = "qcom,ipq8064-tsens";
+
+                 nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+                 nvmem-cell-names = "calib", "calib_backup";
+                 interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+                 interrupt-names = "uplow";
+
+                 #qcom,sensors = <11>;
+                 #thermal-sensor-cells = <1>;
+          };
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.30.2

