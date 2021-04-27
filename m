Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4036CBEC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhD0TpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhD0TpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:15 -0400
Date:   Tue, 27 Apr 2021 19:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSPSvl4s8y5p+yfLlW7jlTNJjnmAovQ5DqhkURonC3Q=;
        b=cvoOew6uC/y+zG0Lab3lkFdlnXTtPtVWg+iYb+u9GHGtqGGfI7IrQZSjKDJdAlKW86+7fj
        9uU3EDDoCfg4ezsyo0TEm1G/4L6xaGTTjUJp6czJrYA8Ujwco8sgAjkVcRGPs8eHzw8sAF
        z5CCphoWfi9S0H0pJqshKEHnHsqwQuFPSevELuf6EqHFJ06ZHEQ3SAxarsxPAU/mV+KfWC
        1vcSasoQ6M56MvgFmG7HRrnYW1o5wiUi9ydQ/rVbLb3ifFMSq48H+VoNbUzzM0AKND1Ql3
        bxf4hi2sg2464ttwClCNFX4cUS4wKaHyUCEu0evxDPL0fX5rT8jSEr2j9RXiXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSPSvl4s8y5p+yfLlW7jlTNJjnmAovQ5DqhkURonC3Q=;
        b=/Kg8xQ6m2f89bhX9Ay/q6f0dw+hO+H/F1Z5MWk9GOoaSRmd/IbWqVfIo+WYTwV0M5HLnp4
        Hf2uX8bqhGLJv9Cw==
From:   thermal-bot for =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: brcm,ns-thermal:
 Convert to the json-schema
Cc:     rafal@milecki.pl, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420210104.10555-1-zajec5@gmail.com>
References: <20210420210104.10555-1-zajec5@gmail.com>
MIME-Version: 1.0
Message-ID: <161955267091.29796.2618446813971655267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     08e9fdfbb2248e93bbfaeb9cde284776085466cd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//08e9fdfbb2248e93bbfaeb9cde284776085466cd
Author:        Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
AuthorDate:    Tue, 20 Apr 2021 23:01:04 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 21 Apr 2021 20:42:48 +02:00

dt-bindings: thermal: brcm,ns-thermal: Convert to the json-schema

This helps validating DTS files.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420210104.10555-1-zajec5@gmail.com
---
 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt  | 37 +----
 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml | 60 +++++++-
 2 files changed, 60 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal=
.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal=
.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt b/=
Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
deleted file mode 100644
index 68e0471..0000000
--- a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Broadcom Northstar Thermal
-
-This binding describes thermal sensor that is part of Northstar's DMU (Device
-Management Unit).
-
-Required properties:
-- compatible : Must be "brcm,ns-thermal"
-- reg : iomem address range of PVTMON registers
-- #thermal-sensor-cells : Should be <0>
-
-Example:
-
-thermal: thermal@1800c2c0 {
-	compatible =3D "brcm,ns-thermal";
-	reg =3D <0x1800c2c0 0x10>;
-	#thermal-sensor-cells =3D <0>;
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive =3D <0>;
-		polling-delay =3D <1000>;
-		coefficients =3D <(-556) 418000>;
-		thermal-sensors =3D <&thermal>;
-
-		trips {
-			cpu-crit {
-				temperature	=3D <125000>;
-				hysteresis	=3D <0>;
-				type		=3D "critical";
-			};
-		};
-
-		cooling-maps {
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml b=
/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
new file mode 100644
index 0000000..fdeb333
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,ns-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar Thermal
+
+maintainers:
+  - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
+
+description:
+  Thermal sensor that is part of Northstar's DMU (Device Management Unit).
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: brcm,ns-thermal
+
+  reg:
+    description: PVTMON registers range
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+unevaluatedProperties: false
+
+required:
+  - reg
+
+examples:
+  - |
+    thermal: thermal@1800c2c0 {
+        compatible =3D "brcm,ns-thermal";
+        reg =3D <0x1800c2c0 0x10>;
+        #thermal-sensor-cells =3D <0>;
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive =3D <0>;
+            polling-delay =3D <1000>;
+            coefficients =3D <(-556) 418000>;
+            thermal-sensors =3D <&thermal>;
+
+            trips {
+                cpu-crit {
+                    temperature =3D <125000>;
+                    hysteresis =3D <0>;
+                    type =3D "critical";
+                };
+            };
+
+            cooling-maps {
+            };
+        };
+    };
