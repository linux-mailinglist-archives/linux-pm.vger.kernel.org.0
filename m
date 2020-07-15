Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2C22180A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGOWps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGOWpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB73C061755;
        Wed, 15 Jul 2020 15:45:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so4698342wrw.5;
        Wed, 15 Jul 2020 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouNkdpPb5LfjBppsBgr8ZNpXkvCcGxxnoBprAfZ1JeY=;
        b=WkvYi7XiWtbYrL8OIwO2ySAi4bbVdFrqWaPKgt5mr4TGslG/hzJxVYYaWz9txApQ2G
         KnqfvOZCslX9mwQ/bUvGwxlNHZ9wRnmCGTs5E/17oOCj68pQEyh9JcTKC9BU52BZfHAG
         Y8KeeQiVPfxRVqIQwDmY47UUPn/XdmSAFgOtxuQnVWWbKBU7b5G8k9OLhlwCMpPzCrt7
         b/uRn1/bjetlBVzSU+3D3CLWoVKgXX1hBpl1J9en1lt3k7aAiKSd+J+uraFiDFdhIKZ8
         DJISwqzbfafpPfrQcmb/iCpmljmU9tYClz4wPUlrCF/UhPNEREH0KH3EoYS+F/ypbTl8
         EGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouNkdpPb5LfjBppsBgr8ZNpXkvCcGxxnoBprAfZ1JeY=;
        b=g22vMvQ/Rvso1k4ijFf5iYY+1ZLDT1ZgCG8Hi4hno0sv0JsvMfXI9IsTxb3ntrHWFu
         XWGFy4IWAcRqVY6Dxyli3u67KY8rUYj1SShDA1a/fi9ixW4WfKM4NDLXvoRj1gb4HPFT
         IqkdFIxZYUyLcGqqykM1I4LG0AWXPdD9EuYdj1xJmGUV335TaUr59FXw6gujFCVFsO1c
         WN7rW6DS0V2sUt1ZtQhmCUs3zcybewujjw+/9jrvFfY5ayNkocUIolVN/FNkX7jVZ/n7
         Y7bgb1OPwH53qcggKIwdA/5oNxYwlaDmQ/+C7FWKTi+sjRMYZ8Ya3eZLTHM2UKyswUZh
         bvLA==
X-Gm-Message-State: AOAM531crwCIZ2WZuj5cPfngOUe57y/x49pkNq3JI24Wuzf2VA/XTxxG
        UVhyBm8ebRXduxgIHxFV2eQ=
X-Google-Smtp-Source: ABdhPJyHK36hRpG+DsS7IJV19gbkMKsXNP3bpxDwfjN74paH23yKdgo2TfAZiJ1Jl0Do2oDteSp8Zg==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr1898881wrw.386.1594853141525;
        Wed, 15 Jul 2020 15:45:41 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:40 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 4/7] dt-bindings: thermal: tsens: document ipq8064 bindings
Date:   Thu, 16 Jul 2020 00:44:59 +0200
Message-Id: <20200715224503.30462-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
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

