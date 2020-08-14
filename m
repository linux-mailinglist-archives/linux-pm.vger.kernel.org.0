Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010D3244ACB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHNNmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgHNNmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61736C061384;
        Fri, 14 Aug 2020 06:42:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so6854768edb.1;
        Fri, 14 Aug 2020 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1za5GysOPtWQWJ7AUT6812STRUOq3UcNXr5lCeanqY=;
        b=As6zWn+lPgGK3H5ouPqVtJISYiJHkGaSP0kZgo2tzD2ckwBRA2wjKeTRD8SWHFvsBq
         au/4tzWcqFBOdux4Iph663HiXld6/YRFz8RhqUYVy2d2E6KAG0fm5ivr0kP/EDyWV6Kh
         xcKO7z0auD2OY97WcYgqHeo+69uSmppRswCeFWD9JMwCvvr0Dc9xx4oR3qy/yLFJxY//
         6K/jnolLRKdQr7WkluFA+BzAZfLzYvVWcpgZnWSezeXxPnKXclHMqJfsyutSggLXDLla
         0Z2jzQMyilnVjH/BAGAEYkdjMYrRax9URc1ZDotI7VziKPPEf9wbHgzVOSFBbYYIvF1w
         QJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1za5GysOPtWQWJ7AUT6812STRUOq3UcNXr5lCeanqY=;
        b=l9GcM05NsA0HSFVlLlNcPRJgM1KRYvJzzOGWeTTl5MjKfP9T6fJ28vidcN9SrVpD0e
         IK3LnKKXkZVeHv1mVNwevFa+0/ICYsag2NchNdKf6KScijax0CCYCrQ2fgotHOnT4t5K
         X4ZjmC9h6B+TlogtUoCDPkcvJ8wNOu6n5S75J8sjEy9TPrBvzlRHD2+YZyQFiOvW27tN
         WIMY0H025Z6PJ1EepH5bSBEDOcdOCikHBrMek1he1IRO5HIonZ7sUovZpqx6vOUXEXAz
         f9c1u/0jq8YbGkMtMWksC+NQxFZAA6ZRALHa8ZlwbRwWXMTBUREGXtQgUtIh8C+1e647
         qfag==
X-Gm-Message-State: AOAM532osppnIWGaFwr53VPzdi4Zqq8BpzEX9RduTb0WPG76CkR/ELC/
        RyfWa8TeRxvgw6xybqGhPDA=
X-Google-Smtp-Source: ABdhPJx2k4MG7iEdVDeslT347UjBp7bBF1b+NBY5vchoCRwvt/GaIrHGb9TuxYB1CjKzALDpeMrufw==
X-Received: by 2002:a50:ee0a:: with SMTP id g10mr2172023eds.289.1597412554058;
        Fri, 14 Aug 2020 06:42:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Fri, 14 Aug 2020 15:41:22 +0200
Message-Id: <20200814134123.14566-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

