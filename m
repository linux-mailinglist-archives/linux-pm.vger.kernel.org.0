Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416AA300731
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbhAVP0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbhAVO6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:58:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6159C0617AB;
        Fri, 22 Jan 2021 06:56:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o10so6838214wmc.1;
        Fri, 22 Jan 2021 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7EH7hNQ0zHbFUPaZhxibjy/gRki2XnmNMbonXYtYOI=;
        b=sIESIdpSd7hwu8Ko1MbUFAXvXE1SUmmw12lygBcnZviJN/KjPQWGg75jvFEolD5wLa
         MJIMJFW02nLX6CBEj0mh7lK+FQuiwAKMMbDfxuWw4Rna/CueS44ZYsKAcBVQ9iRpIAFj
         WJO+By6WHksqkavTUVbHimMas+yOwaJ0xGGg/JJrit2KzefnbEHwmxSad9we9EAL2CgE
         hy06PZ3n6kAsfKO5jO5h7aENu/1m+81xuRs16S+M47NDU/iQWJ9TfxoGyzFO1WhK99ug
         QGxM6z4NgvmeB+nKguIn2Zi5OdrxseKZimBYhLRt06MlB74fh+FjhsLAi5zMuEqRyxkD
         XZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7EH7hNQ0zHbFUPaZhxibjy/gRki2XnmNMbonXYtYOI=;
        b=YPHEKCNE+snLftdPyw3bMss1xciOweiX7XOPN3S9SNrqwjbESPtyrApWHDcUf+Nt0m
         I7dOH59IiusPSjOd7Fh+AssOydHRLUqhmfwVpZQQTwoy3I9O4XuD2gIoCcmYMeDmXXth
         VWZ4D+xAUrRcH0oc5+XsLRjnoXvqjbUdSCHIOCJ8aOuxDzm+OijGArVGMe+vT8KL+ZYY
         GqJNkm1TqLZw0CHo2L2AKZlOP3gdSinbThEph94Cs106GW4EfpZavILA5IhXTA2edP3g
         b2Gr0ooGzZ0r9aT2s4PgLazypkC7LNzrBKKF/SniPwBVwLlVKFZvuUQ22jg5h1usbWTr
         tZSQ==
X-Gm-Message-State: AOAM531vVVGLPTSa6bHCz2+n9HN6TWWYvJ3Grg+5sji0PDf6idq74fwo
        UguygfJBPAivLWuyS/f9ufQ=
X-Google-Smtp-Source: ABdhPJznkSwyqoo2U/wWDUkykiCgx3b/7Y3zWLXo7VtZ8AeRrIMPIYsLaxuveBRIMEmKsp/3rAEh6w==
X-Received: by 2002:a1c:1f83:: with SMTP id f125mr4415561wmf.82.1611327381526;
        Fri, 22 Jan 2021 06:56:21 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:20 -0800 (PST)
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
Subject: [PATCH v9 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Fri, 22 Jan 2021 15:55:57 +0100
Message-Id: <20210122145558.4982-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
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
2.29.2

