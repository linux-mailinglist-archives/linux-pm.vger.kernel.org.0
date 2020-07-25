Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF622D93A
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGYSOk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgGYSOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC917C08C5C0;
        Sat, 25 Jul 2020 11:14:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so9255785edv.6;
        Sat, 25 Jul 2020 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKnDklCAGiv58g9Foc3TqRLdzVf3EoGTeteiTkp0kag=;
        b=GJ07DrBgtpG7LTpUn3MU6eIPgrRISBw/2GM5Mfq3Ksb8dre5YamuMV+ffjsAT8bNgn
         u3QU/d46eVHhq3bXl291YVu0rJhU8nDXL/MUuAuA1lI8pK2G0DI/RpbYHU15gMMFJjee
         Fyahnj9dxmIqG1lu9/JF3D89bQA/tB5ZdOsDKXn7K8e/TkB7/RldxNoAjvq1l63VIRAy
         weepThoEd/B4QKsqunh+bV7WQRbNkywP7IJ/VC95uz4bzuHGif9CKAyEMLLbRKnnCRQH
         G9x9b6FzmXP2gfWUnF7pQipZdIXuTC8ZQcxN0tt9lF8MhVgBxkvtDgjVJ8S1m0utS2NT
         XPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKnDklCAGiv58g9Foc3TqRLdzVf3EoGTeteiTkp0kag=;
        b=rUSvvzNIn/kEOblbfIozxSr4RU9K2IhIo/hyMKfSVrWJNorN9dmFJ6lOPUcZICQInR
         qT9g2o3eLQr24q6eCtqWWLpntAK9gQVSgP0uATN4H7et1W2goienP1LJLvwLam6mi0Un
         9GXqav6+d1OuAFBjPgjcZwK0qhtG8flPlWAL3TqKU5/bK020XwG5uHTNGVVopGR0d0mm
         xT9PussQISpUHbbGA7Ojvb2Ojmh81HhGwhDjZZiFK7kZ3t69jSUlBsM63ctXoMjDj8ME
         O/CZZfErAUFPqp+A6Hmcs8nA3dhZOAU3KgrF1TENsJjEBVnyV2v/Y6ukhIySeWXNfN/7
         VcNA==
X-Gm-Message-State: AOAM5316rVuKhDFkTJLobCU47izU7bg7ZPsywFPoa4WM2AAbDLJzjLyg
        4PAPz+r72sHt9jFdvs3rYww=
X-Google-Smtp-Source: ABdhPJymEfznei5ky/ny1Kg/HlDVR3Y7dGzAt4QmgjnqZoY6VY8yrVuGLMPB0Cu++anysV35CSTZCg==
X-Received: by 2002:aa7:c655:: with SMTP id z21mr14407787edr.330.1595700878430;
        Sat, 25 Jul 2020 11:14:38 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 7/7] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Sat, 25 Jul 2020 20:14:03 +0200
Message-Id: <20200725181404.18951-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 50 ++++++++++++++++---
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d7be931b42d2..9d480e3943a2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: msm9860 TSENS based
+        items:
+          - enum:
+            - qcom,ipq8064-tsens
+
       - description: v0.1 of TSENS
         items:
           - enum:
@@ -85,12 +90,18 @@ properties:
       Number of cells required to uniquely identify the thermal sensors. Since
       we have multiple sensors this is set to 1
 
+required:
+  - compatible
+  - interrupts
+  - "#thermal-sensor-cells"
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
@@ -111,17 +122,42 @@ allOf:
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
+        - interrupt-names
+        - "#qcom,sensors"
 
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
+                 nvmem-cells = <&tsens_calib>, <&tsens_calsel>;
+                 nvmem-cell-names = "calib", "calib_sel";
+                 interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+
+                 #thermal-sensor-cells = <1>;
+          };
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.27.0

