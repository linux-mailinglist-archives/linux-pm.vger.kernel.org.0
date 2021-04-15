Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98053608C9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhDOMEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhDOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19822C061756
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:00 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eomtPt55X/hEHI+ND4aIkR564+Sr7wa3Dhy0Julipz4=;
        b=qiFv1+oUJVY2wO76EZhMjyA0y84lCVPrsHJXePPwGmNbPshcG7/XfmOOz5FqEggHbwVbDZ
        oIKLFnZFOzf1G/chaLWa1pr4ZKraSx4Xulj/dwrGFy8YR1psbxTYJQN/E+LytFkrWnk2iK
        iqsnCbGkV/bQa/wt6xoMlIxlcvo+yhRYcUpSt50u//CVttbgXPX1ZSNK0iNPA+ZfINf4Da
        NstmdMdtA2/cGr/Cr47vZi0QJcbp0ISB1jlqdRbVuaupnmFwhY1NrA7MJjidvQN37FSikg
        mC4j8xCNg4BlUg1lYXfngGmmgrFSVRfiAuLAJpRemkccWtJ8SDWb7hI/mI/V2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eomtPt55X/hEHI+ND4aIkR564+Sr7wa3Dhy0Julipz4=;
        b=t0ZNduVmQCsD9u7eYKIJeVaLIRctc5kQQ+pFap0+fVZQxos6ynIDJ3InoOyNS2AyHIyqzw
        wxMSwoHhouEy8JAg==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: tsens: Document ipq8064
 bindings
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210404144823.31867-10-ansuelsmth@gmail.com>
References: <20210404144823.31867-10-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161848823642.29796.1638383881353230504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     33edf3a534d5b54cc7dd763fef1899c75b5b7e49
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//33edf3a534d5b54cc7dd763fef1899c75b5b7e49
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 16:48:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

dt-bindings: thermal: tsens: Document ipq8064 bindings

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210404144823.31867-10-ansuelsmth@gmail.com
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 55 +++++--
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index fbd03cd..b7a832f 100644
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
@@ -75,7 +80,9 @@ properties:
     maxItems: 2
     items:
       - const: calib
-      - const: calib_sel
+      - enum:
+          - calib_backup
+          - calib_sel
 
   "#qcom,sensors":
     description:
@@ -90,12 +97,19 @@ properties:
       Number of cells required to uniquely identify the thermal sensors. Since
       we have multiple sensors this is set to 1
 
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+  - "#qcom,sensors"
 allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8064-tsens
               - qcom,mdm9607-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
@@ -117,19 +131,44 @@ allOf:
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
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
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
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
     tsens1: thermal-sensor@900000 {
            compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
