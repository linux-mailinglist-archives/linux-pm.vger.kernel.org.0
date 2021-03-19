Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BE3411BC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhCSAxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhCSAxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:53:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F56C06174A;
        Thu, 18 Mar 2021 17:53:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k10so6912282ejg.0;
        Thu, 18 Mar 2021 17:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=HfVgopGoETyq/qL91s46wIh+DPOYwlenzABf9SnprD/fPcZDwBJr/erbz2wJCHxPjf
         B2NuP6K1rNjWefJkzymM/3V6aEGeL15usMaiuNowsbuY99umQf6jw7hXi4OcBm8bCHki
         He0VBb7uPgnsWKmC1OLidSVRYzkT6IAy2V4sSeqk8agWhCsU43BybkyonRJ9Vd2R2Spy
         EEcczaCaGD7nnQRin07ma5REaxrUZ/EkSinRgaDTbocCQ9nVM2ywRvAZ9qQ+rirPbaeq
         Ijjrd4zQ7wmA1XcpIuJPee9bsy5earsCgM2aTiFoxJ+AI1BOM+hGh+j76aRmq4uYZGKP
         BP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=ID174VNhRKncsMfqXMN3OlFxFkTpLmdE8yZVo2h1wsWX+EJ4hBQZnFxkg36Dkpsu3Y
         msJziWnNx25qNKgIDnD3ioOkeVoYkWF/XxHZuzZGs/IenQo6HYDZNe1IvaTBbuo2slmI
         PNfblCy6Sw+Zx8ewqy/am1VbUK5mHiDdPhrwNjUEDCyQU17KtMQZ6t7WoEFN5RFyT+Zn
         9snra+PVLl8TEXNGsWsa/+PZXkfuLLMcdTU7PjuTdvnaEOhYU5oa8ytHyJblrzqw837/
         JaJ4KDt7gmi97p1ol14aZsS0REtrFn8Itr0uHL2cFyhTbwOTHUgQBdPHBlok2o57c01S
         j+2Q==
X-Gm-Message-State: AOAM532BfPVrVJAbuF/TO5qTr3WGB59VBpS7QbHnrtvBdRazUHokvk9r
        n94po+oMMtRLnwTWg/0os4A=
X-Google-Smtp-Source: ABdhPJyRp77kRe/bUrg00EgV0RbYbBbnjm25fQkgj9cvvya1zbaw+FdG0oFO5Xc+VlmduMkyytZLLQ==
X-Received: by 2002:a17:907:77d4:: with SMTP id kz20mr1455770ejc.93.1616115183180;
        Thu, 18 Mar 2021 17:53:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:53:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 9/9] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Fri, 19 Mar 2021 01:52:27 +0100
Message-Id: <20210319005228.1250-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
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

