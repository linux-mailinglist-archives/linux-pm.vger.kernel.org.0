Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391613581DA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhDHLcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:32:25 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40502 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 07:32:24 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Apr 2021 04:32:13 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Apr 2021 04:32:10 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Apr 2021 17:01:39 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 8AB2D4F01; Thu,  8 Apr 2021 17:01:38 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml
Date:   Thu,  8 Apr 2021 17:01:08 +0530
Message-Id: <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert qcom PON binding from .txt to .yaml format.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
Changes in V2:
 - As per Rob's comments, converted the main PON binding and added in V2.

 .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 ----------------------
 .../devicetree/bindings/power/reset/qcom,pon.yaml  | 41 ++++++++++++++++++
 2 files changed, 41 insertions(+), 49 deletions(-)
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
index 0000000..40eea5f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -0,0 +1,41 @@
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
+properties:
+  compatible:
+    enum:
+      - qcom,pm8916-pon
+      - qcom,pms405-pon
+      - qcom,pm8998-pon
+
+  reg:
+    description: Specifies the physical address of the pon register
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
+additionalProperties: true
+...
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

