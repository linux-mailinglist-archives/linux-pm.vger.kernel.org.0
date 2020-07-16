Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA82219EB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGPC2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgGPC2d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA0C08C5CE;
        Wed, 15 Jul 2020 19:28:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so5220944wrp.7;
        Wed, 15 Jul 2020 19:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouNkdpPb5LfjBppsBgr8ZNpXkvCcGxxnoBprAfZ1JeY=;
        b=NUJwbD4b48yA748qorNGk8mt5nsIXUHIyHpnoxmWIRinCZ6FBETMVRSD5gIOnZXEOY
         rUcPq0zdodgSZqMsuqBjJmjqp9UrpaVHylgzNzhuQUEXSjQotQyiV9JZxRNWIvtLVKUV
         TOI14l3xGid7fvxKeqdHAFAUt4oW6PKTld7qK0XbbR2JcYQCbedypAyHFVcbXXSHM7af
         jp2mmvD7UPZ/lRE/i8jHCTN3REzZKfKanAKNrSbXa9a7mEVFaVPQn7mFDcLaw1mamx3C
         GqNN0LQGptOCrP4ug3au79t+bmzl3W47PfBS5eectliigSNqGF1hzUQrYCU9zlH0qf2C
         h27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouNkdpPb5LfjBppsBgr8ZNpXkvCcGxxnoBprAfZ1JeY=;
        b=i/RpcnzeOD3+j1GKhCHQyBCvaXOgUp4Pucay7T2P8OBwJQJrzkchf8GKZWu4GL8k7P
         9hPUzl5qPS2X0DYWyg4aZPwchDTbMDr7fRZ9aM3h+MOAgeyiU/YzwR3tmGKI2XIody6y
         /EC8xbVQ9/PhvWyYMZ0P09GQ+QcUcOTLal3nFM1k03Yvj3sv8b5o0eiURAyu9mpIX/J8
         YGTl327Z0A5GBiEiKnAa+OX4ZEYC9JH2nEn4WcfeshvH11YQbUqlwMdkJ0iKw7Qonm29
         VvlxbyWf5uPqE006h3z+YmbS63+sPX39j5jrFDX7nt7slqIjHHfYzVfU0j0Di9JU7c2c
         mPnA==
X-Gm-Message-State: AOAM5339bpPsPEK4KBjHKijl/saMKnq04WWljjdH/wuTCPL6Qr6+R6tC
        HCP73nBOGMZpFpX5L2zrCEU=
X-Google-Smtp-Source: ABdhPJysNLgbJu3gRayL8Us7KD5d8xyX0ogQIzyEFvTbZesH0MDVoIytceedClvHrEbThBKzWZfvSQ==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr2536857wrr.211.1594866511110;
        Wed, 15 Jul 2020 19:28:31 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 4/7] dt-bindings: thermal: tsens: document ipq8064 bindings
Date:   Thu, 16 Jul 2020 04:28:13 +0200
Message-Id: <20200716022817.30439-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for ipq8064 SoCs tsens.
ipq8064 use the same gcc regs and is set as a child of the qcom gcc.

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

