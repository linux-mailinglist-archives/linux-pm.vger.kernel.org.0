Return-Path: <linux-pm+bounces-13776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1F96EFB6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DED1F22B22
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4311CBE80;
	Fri,  6 Sep 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="PdJQYn8C"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3641CB15E;
	Fri,  6 Sep 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615492; cv=none; b=AEuXrl19wjowa6tYWTMxFMh9WCA8i/9CuxfbEBPQ6VohPgV/Eegu2YrxDRiCn4awLujup9+KMPCSO0gjCd2OLdwAG8Ca1UorqaJmp5I8weyLNu7Xn8EPNTnKKjl07bSBFFzd1Fsf8n8vqVZyG4YLxvDC3GxzPn2bQ2Datgd2MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615492; c=relaxed/simple;
	bh=++EX8L3T0fb27IBq01egQ1+aBL8pwXaa6GpbpNpE0Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6ylcJnoG+NfWmiNIcH4Lr8BGqVgJKFa7k+Uc3+GnB5U5/i4vmHscrBsKb5epFEX+mn4mCZY6kcOXFUevWtsK+WWBh15mdce7O4TJxSB1DFFBmD/VyzHC/ZWENmZbKgdrkyDu26IgL8bpRpvWIEQ9Zx8MH+aTMCP2H9c+VYYQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=PdJQYn8C; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id D5E1178A07;
	Fri,  6 Sep 2024 17:38:07 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn D5E1178A07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615489;
	bh=m8dxvhMC6YUlGGu5mJJ8C2gZHWhyqRgNP3I24IzqQ6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdJQYn8C9lujRQHKpzNHQWRkSJufh/rYtMcxEXrSrDhQlWv6WTC+c1RplrRJTOj68
	 duz7c/GpZ9/jV96+4ujkVJDe50TOzoK4X5G2NjLrutUj34ZhymWaKYU/mrvMLHfJMD
	 Oj/TvaWE+gGs4Eilj+ylCKUtnudfd0IYu91ulLMg=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH 8/9] dt-bindings: Add documentation for Photonicat PMU
Date: Fri,  6 Sep 2024 17:36:29 +0800
Message-ID: <20240906093630.2428329-9-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for Photonicat PMU MFD, LEDs,
hardware monitor, power off, power supply, real-time clock watchdog.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 .../hwmon/ariaboard,photonicat-pmu-hwmon.yaml |  40 +++++++
 .../leds/ariaboard,photonicat-pmu-leds.yaml   |  41 +++++++
 .../mfd/ariaboard,photonicat-pmu.yaml         | 107 ++++++++++++++++++
 .../ariaboard,photonicat-pmu-poweroff.yaml    |  34 ++++++
 .../ariaboard,photonicat-pmu-supply.yaml      |  55 +++++++++
 .../rtc/ariaboard,photonicat-pmu-rtc.yaml     |  37 ++++++
 .../ariaboard,photonicat-pmu-watchdog.yaml    |  37 ++++++
 7 files changed, 351 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/ariaboard,photonicat-pmu-supply.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/ariaboard,photonicat-pmu-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/ariaboard,photonicat-pmu-watchdog.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
new file mode 100644
index 000000000000..c9b1bab20c31
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ariaboard,photonicat-pmu-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU Hardware Monitor
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Board temperature sensor on the Photonicat PMU MCU
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-hwmon
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Label for hwmon device
+
+required:
+  - compatible
+  - label
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              hwmon {
+                  compatible = "ariaboard,photonicat-pmu-hwmon";
+                  label = "pcat_board";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml b/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
new file mode 100644
index 000000000000..6ccb0e691b09
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ariaboard,photonicat-pmu-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU LEDs
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  LEDs on the Photonicat PMU MCU
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-leds
+
+  label: true
+
+required:
+  - compatible
+  - label
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              leds-status {
+                  compatible = "ariaboard,photonicat-pmu-leds";
+                  label = "net-status";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml b/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
new file mode 100644
index 000000000000..df16d9507821
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ariaboard,photonicat-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ariaboard Photonicat PMU
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Driver for the Power Management MCU in the Ariaboard Photonicat,
+  which provides battery and charger power supply, real-time clock,
+  watchdog, hardware shutdown.
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu
+
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 115200
+    description: PMU Serial baudrate
+
+  local-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 127
+    default: 1
+    description: CPU board address
+
+  remote-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 127
+    default: 1
+    description: PMU board address
+
+  hwmon:
+    $ref: /schemas/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
+
+  poweroff:
+    $ref: /schemas/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
+
+  rtc:
+    $ref: /schemas/rtc/ariaboard,photonicat-pmu-rtc.yaml
+
+  watchdog:
+    $ref: /schemas/watchdog/ariaboard,photonicat-pmu-watchdog.yaml
+
+patternProperties:
+  '^leds-(status)':
+    $ref: /schemas/leds/ariaboard,photonicat-pmu-leds.yaml
+
+  '^supply-(battery|charger)$':
+    $ref: /schemas/power/supply/ariaboard,photonicat-pmu-supply.yaml
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          photonicat-pmu {
+              compatible = "ariaboard,photonicat-pmu";
+              current-speed = <115200>;
+              local-address = <1>;
+              remote-address = <1>;
+
+              supply-battery {
+                  compatible = "ariaboard,photonicat-pmu-supply";
+                  label = "battery";
+                  type = "battery";
+              };
+
+              supply-charger {
+                  compatible = "ariaboard,photonicat-pmu-supply";
+                  label = "charger";
+                  type = "charger";
+              };
+
+              hwmon {
+                  compatible = "ariaboard,photonicat-pmu-hwmon";
+                  label = "pcat_board";
+              };
+
+              leds-status {
+                  compatible = "ariaboard,photonicat-pmu-leds";
+                  label = "net-status";
+              };
+
+              poweroff {
+                  compatible = "ariaboard,photonicat-pmu-poweroff";
+              };
+
+              rtc {
+                  compatible = "ariaboard,photonicat-pmu-rtc";
+              };
+
+              watchdog {
+                  compatible = "ariaboard,photonicat-pmu-watchdog";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/power/reset/ariaboard,photonicat-pmu-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
new file mode 100644
index 000000000000..cfb6c043aa8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ariaboard,photonicat-pmu-poweroff.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/ariaboard,photonicat-pmu-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU Real-time clock
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Poweroff on the Photonicat PMU MCU
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-poweroff
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              poweroff {
+                  compatible = "ariaboard,photonicat-pmu-poweroff";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/power/supply/ariaboard,photonicat-pmu-supply.yaml b/Documentation/devicetree/bindings/power/supply/ariaboard,photonicat-pmu-supply.yaml
new file mode 100644
index 000000000000..73b1c3564c58
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ariaboard,photonicat-pmu-supply.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ariaboard,photonicat-pmu-supply.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU Power supply
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Power supply on the Photonicat PMU MCU
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-supply
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Label for power supply device
+
+  type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - battery
+      - charger
+    description: Photonicat power supply type
+
+  power-supplies: true
+  monitored-battery: true
+
+required:
+  - compatible
+  - label
+  - type
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              supply-charger {
+                  compatible = "ariaboard,photonicat-pmu-supply";
+                  label = "charger";
+                  type = "charger";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/rtc/ariaboard,photonicat-pmu-rtc.yaml b/Documentation/devicetree/bindings/rtc/ariaboard,photonicat-pmu-rtc.yaml
new file mode 100644
index 000000000000..05f3c3768dbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ariaboard,photonicat-pmu-rtc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ariaboard,photonicat-pmu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU Real-time clock
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Real-time clock on the Photonicat PMU MCU
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              rtc {
+                  compatible = "ariaboard,photonicat-pmu-rtc";
+              };
+          };
+      };
diff --git a/Documentation/devicetree/bindings/watchdog/ariaboard,photonicat-pmu-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/ariaboard,photonicat-pmu-watchdog.yaml
new file mode 100644
index 000000000000..91bc6adea9a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ariaboard,photonicat-pmu-watchdog.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/ariaboard,photonicat-pmu-watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Photonicat PMU Watchdog
+
+maintainers:
+  - Junhao Xie <bigfoot@classfun.cn>
+
+description:
+  Watchdog on the Photonicat PMU MCU
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: ariaboard,photonicat-pmu-watchdog
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      serial {
+          mcu {
+              compatible = "ariaboard,photonicat-pmu";
+
+              watchdog {
+                  compatible = "ariaboard,photonicat-pmu-watchdog";
+              };
+          };
+      };
-- 
2.46.0


