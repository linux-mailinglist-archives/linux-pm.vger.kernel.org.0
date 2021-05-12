Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC137B5B8
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhELGQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 02:16:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53424 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELGQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 02:16:28 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2021 23:15:21 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 May 2021 23:15:18 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 May 2021 11:44:40 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id E013F4F44; Wed, 12 May 2021 11:44:38 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V4 5/5] dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml
Date:   Wed, 12 May 2021 11:44:13 +0530
Message-Id: <1620800053-26405-6-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert qcom PON binding from .txt to .yaml format.

Signed-off-by: satya priya <skakit@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V2:
 - As per Rob's comments, converted the main PON binding and added in V2.
   Dropped example here to have one full example in qcom,pm8941-pwrkey.yaml

Changes in V3:
 - As per Sebastian's comments, added allOf to refer reboot-mode.yaml and
   used unevaluatedProperties = false. Added maxItems for reg.

Changes in V4:
 - Added the example back. Removed it in qcom,pm8941-pwrkey.yaml

 .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 -------------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  | 80 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
deleted file mode 100644
index 0c0dc3a..0000000
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Qualcomm PON Device
-
-The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
-and resin along with the Android reboot-mode.
-
-This DT node has pwrkey and resin as sub nodes.
-
-Required Properties:
--compatible: Must be one of:
-	"qcom,pm8916-pon"
-	"qcom,pms405-pon"
-	"qcom,pm8998-pon"
-
--reg: Specifies the physical address of the pon register
-
-Optional subnode:
--pwrkey: Specifies the subnode pwrkey and should follow the
- qcom,pm8941-pwrkey.txt description.
--resin: Specifies the subnode resin and should follow the
- qcom,pm8xxx-pwrkey.txt description.
-
-The rest of the properties should follow the generic reboot-mode description
-found in reboot-mode.txt
-
-Example:
-
-	pon@800 {
-		compatible = "qcom,pm8916-pon";
-
-		reg = <0x800>;
-		mode-bootloader = <0x2>;
-		mode-recovery = <0x1>;
-
-		pwrkey {
-			compatible = "qcom,pm8941-pwrkey";
-			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
-			linux,code = <KEY_POWER>;
-		};
-
-		resin {
-			compatible = "qcom,pm8941-resin";
-			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
-			linux,code = <KEY_VOLUMEDOWN>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
new file mode 100644
index 0000000..353f155
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/qcom,pon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PON Device
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
+  and resin along with the Android reboot-mode.
+
+  This DT node has pwrkey and resin as sub nodes.
+
+allOf:
+  - $ref: reboot-mode.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8916-pon
+      - qcom,pms405-pon
+      - qcom,pm8998-pon
+
+  reg:
+    maxItems: 1
+
+  pwrkey:
+    type: object
+    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
+
+  resin:
+    type: object
+    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
+
+required:
+  - compatible
+  - reg
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

