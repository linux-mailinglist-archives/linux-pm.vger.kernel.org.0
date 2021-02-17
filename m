Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D811C31E3B3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhBRA6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhBRA5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F553C061793;
        Wed, 17 Feb 2021 16:56:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v62so202008wmg.4;
        Wed, 17 Feb 2021 16:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbAtmngJcoRtVkkTfCt86J63bTJUyPzZLgd9pZucK4Y=;
        b=ass2qxDcbeIA9eIfp08XDT3ZOBLHdjzw0Fkup8mi9b9LjcZbt86LAKTHy5tXxZhn/F
         RbBbYPMA0PzUKAl7WZNqB98/agFpqqS9MSqTiDN/2YlAji18WeZcc4etT7J8o9M4m0SK
         vJ51P3lsG7YhSE0Togfsu8UOqh3A3Nsw2amQNMC0OcmcNDT+tIJmk25KDXImu2aR/t74
         O4eqv3FZi+8zpfIBYEmacYX2bhIHiAXihvtVbBw7aMia7y1BFZQqnssDOnHXE8+4AmVD
         CNmZZL5MhAqrV0JnQ3HV012zumC56VFtv3s5ixpMYBseC5T4a243VdVoVqkgh7exUVmV
         rezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbAtmngJcoRtVkkTfCt86J63bTJUyPzZLgd9pZucK4Y=;
        b=gmNBHXtNqhiivKlnmtSSHIljfjws+5b5ZEkpRcsH/t1vKFJQkOqdRmP7wgjMSCMm2a
         3FwkosGBo0t7xpmbK4bb5uDUbJyTy8oYNu0GgfSHJ/vndBS5rTj0kw6Be/HJNdMON7gx
         szpX2dJYaTYJE5IV/ldspXnvVucmzTztcnIMeC9yrQdT9art+pf2d087zzUU7sxAT+jJ
         i+8+PVNjvSFL+3GobweA5UTIjvkDSr4PfL69DaqCTyTFIR6YDqTipeCrrOYmnbzmMF/y
         menJYIK0pyIGpk2mksNWocw75hReKoZphfyoOcst9T5mpe6qd0TzZF1IN08NJVrSFTRJ
         T/5Q==
X-Gm-Message-State: AOAM532mNUb2zweEhYlgFkS8driXN3X/5HjRDhcvS3aNZTeKXECxFYRa
        PyVu2izURZQI4VmDNZmjMJU=
X-Google-Smtp-Source: ABdhPJzcfjII2lIRJwShx661DIFDEBIpBgbbbyu28VX0KMITZsNvQ2+f6744NPJhNdrNNqBd1+4/MQ==
X-Received: by 2002:a1c:4903:: with SMTP id w3mr1198909wma.143.1613609794824;
        Wed, 17 Feb 2021 16:56:34 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:34 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Wed, 17 Feb 2021 20:40:10 +0100
Message-Id: <20210217194011.22649-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
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
2.30.0

