Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831A365F6E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhDTSfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhDTSeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92102C06138B;
        Tue, 20 Apr 2021 11:34:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so59796741ejc.4;
        Tue, 20 Apr 2021 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7h2yhzf5rJ0AJdlIXPMvLZF9eZ+jtPp29EnOmIYbU=;
        b=oKWLl9k0s7WTJasrDiDiAxKaZzVOW4BwfeeHeegWvS5lhoAyu71WNwbvZnxM/16GQD
         Pyix+a1HY9AUESgF0zPeRFZQfCSkYtMmv0hEqOel51zdqLfIFPxruajDiAZQ/YOqf6eb
         z7W8hsZR+NcVREh2l6JM0x27BPc9+FwqtJTQvoqwIF5nVitTE5LN9uSvw4Bz/s83v2NU
         Cj8GzUNhJ9WZLN2YoO/JuIc6feN8Hglh9oAR+g5jGb/YpXXttSyPz8kAz1vbOgxEk3sw
         qTvwBP6Ms0/hEzdSEOgmYQW6DYX3qPANNA/WuyfmM4VyTj1WEzBkUkvUTTNc8zhT4Tf0
         so5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7h2yhzf5rJ0AJdlIXPMvLZF9eZ+jtPp29EnOmIYbU=;
        b=folzH3lbQqfRQYguDaInjB+8ZgJwDggMDR0EWNDWe8irH3PC2UE7TcrDnbvO+1VBAI
         UNgCw/prX33H//NbhGbjS9y3zT4w7aLXVtHF+ZP+w1jI3bS5oK7D0fwc2N4mBT4Mvc5V
         1o/LpO1BagT3athvdCKXRuxeSZPcGChojhTTAHnHtJfSOIRtUXgD4lgcBDUausnyI4Mh
         9jDa/HVLZbXboAfV21zRmox6Xs8wGVKPwcaGxrqXNC2LuiW09QVqZ5pe0nH6RL2s6y/R
         vWfrBiCijDtql9IvlpDF1pSDgmohev+M7vQ2imdGDS2HL6ONF+M7bzwsz5C0fmBYeW2Z
         HeyQ==
X-Gm-Message-State: AOAM5320tssxivPlv1YGfJNjZwPsPA2uN0KMLhwg2wTqId/fztpl5yED
        HWzOKGi3FgACbj2LhHMLkXc=
X-Google-Smtp-Source: ABdhPJwv33CLEGrYqkVhLcx/Zsnzo17NjXob6cnEp3+3K39m61LeH+SiigeB+XdpgiNkkvWZCufheQ==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr28992621ejc.47.1618943655052;
        Tue, 20 Apr 2021 11:34:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 9/9] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Tue, 20 Apr 2021 20:33:43 +0200
Message-Id: <20210420183343.2272-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
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
index d7be931b4..2e762596b 100644
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
@@ -70,7 +75,9 @@ properties:
     maxItems: 2
     items:
       - const: calib
-      - const: calib_sel
+      - enum:
+          - calib_backup
+          - calib_sel
 
   "#qcom,sensors":
     description:
@@ -85,12 +92,20 @@ properties:
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
@@ -111,17 +126,42 @@ allOf:
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

