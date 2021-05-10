Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762F377CC3
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEJHDK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 03:03:10 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61793 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhEJHDJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 03:03:09 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2021 00:02:02 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 May 2021 00:02:00 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 May 2021 12:31:20 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id C99414EF1; Mon, 10 May 2021 12:31:19 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V3 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941 power key binding to yaml
Date:   Mon, 10 May 2021 12:31:03 +0530
Message-Id: <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert qcom pm8941 power key binding from .txt to .yaml format.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
Changes in V2:
 - Fixed bot errors, took reference from input.yaml for "linux,code"
 - Added one complete example for powerkey and resin, and referenced it
   in main PON binding.
 - Moved this patch to the end of the series.

Changes in V3:
 - Moved this patch before PON binding patch.
 - As per Rob's comments, added allOf at the beginning of binding.
   Added maxItems for interrupts.
 - Added 'unevaluatedProperties' instead of 'additionalProperties' as
   we are using allOf.
 
 .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
 .../bindings/input/qcom,pm8941-pwrkey.yaml         | 87 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
deleted file mode 100644
index 6cd08bc..0000000
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Qualcomm PM8941 PMIC Power Key
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,pm8941-pwrkey"
-		    "qcom,pm8941-resin"
-		    "qcom,pmk8350-pwrkey"
-		    "qcom,pmk8350-resin"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address of registers for block
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: key change interrupt; The format of the specifier is
-		    defined by the binding document describing the node's
-		    interrupt parent.
-
-- debounce:
-	Usage: optional
-	Value type: <u32>
-	Definition: time in microseconds that key must be pressed or released
-		    for state change interrupt to trigger.
-
-- bias-pull-up:
-	Usage: optional
-	Value type: <empty>
-	Definition: presence of this property indicates that the KPDPWR_N pin
-		    should be configured for pull up.
-
-- linux,code:
-	Usage: optional
-	Value type: <u32>
-	Definition: The input key-code associated with the power key.
-		    Use the linux event codes defined in
-		    include/dt-bindings/input/linux-event-codes.h
-		    When property is omitted KEY_POWER is assumed.
-
-EXAMPLE
-
-	pwrkey@800 {
-		compatible = "qcom,pm8941-pwrkey";
-		reg = <0x800>;
-		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_POWER>;
-	};
diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
new file mode 100644
index 0000000..0736fa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,pm8941-pwrkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8941 PMIC Power Key
+
+maintainers:
+  - Courtney Cavin <courtney.cavin@sonymobile.com>
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8941-pwrkey
+      - qcom,pm8941-resin
+      - qcom,pmk8350-pwrkey
+      - qcom,pmk8350-resin
+
+  interrupts:
+    maxItems: 1
+
+  debounce:
+    description: |
+          Time in microseconds that key must be pressed or
+          released for state change interrupt to trigger.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  bias-pull-up:
+    description: |
+           Presence of this property indicates that the KPDPWR_N
+           pin should be configured for pull up.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  linux,code:
+    description: |
+           The input key-code associated with the power key.
+           Use the linux event codes defined in
+           include/dt-bindings/input/linux-event-codes.h
+           When property is omitted KEY_POWER is assumed.
+
+required:
+  - compatible
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/interrupt-controller/irq.h>
+   #include <dt-bindings/input/linux-event-codes.h>
+   #include <dt-bindings/spmi/spmi.h>
+   spmi_bus: spmi@c440000 {
+     reg = <0x0c440000 0x1100>;
+     #address-cells = <2>;
+     #size-cells = <0>;
+     pmk8350: pmic@0 {
+       reg = <0x0 SPMI_USID>;
+       #address-cells = <1>;
+       #size-cells = <0>;
+       pmk8350_pon: pon_hlos@1300 {
+         reg = <0x1300>;
+         compatible = "qcom,pm8998-pon";
+
+         pwrkey {
+            compatible = "qcom,pm8941-pwrkey";
+            interrupts = < 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH >;
+            debounce = <15625>;
+            bias-pull-up;
+            linux,code = <KEY_POWER>;
+         };
+
+         resin {
+            compatible = "qcom,pm8941-resin";
+            interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+            debounce = <15625>;
+            bias-pull-up;
+            linux,code = <KEY_VOLUMEDOWN>;
+         };
+       };
+     };
+   };
+...
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

