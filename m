Return-Path: <linux-pm+bounces-36010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FCBD6921
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8B1E4FDA3B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C730AD06;
	Mon, 13 Oct 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHzsRC1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B2309EEC;
	Mon, 13 Oct 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392695; cv=none; b=NJ0ob067Y3xHW9gjXzsloMjSTL0SA/Dy2nsvNqbnmO1b6azFRxgQAQ14nnjnd1z8b4tbmWd1Hb3rw/X1MO6N6vL7nf/WFyEgoRayKeTs1osPgwFY1vHuSU8reqLbZyZQJExpZlZTEa1jIana331ubyOmIRWaEbdrqIzaU86VoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392695; c=relaxed/simple;
	bh=VHncSqJ4t/EK/+D2CNoYoxfnRqS1UOHPeyFflWTFuwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3cylXYnbEmA3vfhf6MJzt1Ivbh9HUhKVS/h4NGCGB0ezBDaA6/sipF5cFaNu1mTA5/5uu+kNsQRW9Rz5R2CBpB2apL9wMIW9HW2Wq2NeiGsXmbuYd7M2GZWIl8OKtx9pR2KNEWzARYc+78Y/mRK+D+wWk7a0VMC20GWT8p+VSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHzsRC1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86733C2BCAF;
	Mon, 13 Oct 2025 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760392694;
	bh=VHncSqJ4t/EK/+D2CNoYoxfnRqS1UOHPeyFflWTFuwo=;
	h=From:To:Cc:Subject:Date:From;
	b=aHzsRC1UynMiJlRGaqWrSaJpyrgNJjP1Wpp/je+9YuVEx+6g5m47fQCibEzAzW4Em
	 +D54X8S+NYnKtRksomFW9RHOzRaFjCUikQ/TEHAPt6XBQgdM125ALpeRml1bnilkwx
	 vUDw568I2IuVVY3veB9eFaPjegcLyP5mIe9Pzc0Mr75iABP6TmFsUC4OWyFQHnj6cE
	 tTyPKu+63HV+U4nWHuXcLuIGqXTCclAS3W2RWPURE5kzYes//S3y3+LgwLZVwq0pRQ
	 qug4GWZBUwNivkIV6YppLNMMYQGzUujDU1xFyKFM2MQHNvlWGrnfv6cfNtkBaQOBzr
	 sUGCaUL92Nnig==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Convert brcm,sr-thermal to DT schema
Date: Mon, 13 Oct 2025 16:58:09 -0500
Message-ID: <20251013215810.783006-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the brcm,sr-thermal binding to DT schema format. It's a
straight-forward conversion. "polling-delay", "thermal-sensors", and
"temperature" all apply to the thermal zones, not the sensor node.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/thermal/brcm,sr-thermal.txt      | 105 ---------------
 .../bindings/thermal/brcm,sr-thermal.yaml     | 121 ++++++++++++++++++
 2 files changed, 121 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
deleted file mode 100644
index 3ab330219d45..000000000000
--- a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
+++ /dev/null
@@ -1,105 +0,0 @@
-* Broadcom Stingray Thermal
-
-This binding describes thermal sensors that is part of Stingray SoCs.
-
-Required properties:
-- compatible : Must be "brcm,sr-thermal"
-- reg : Memory where tmon data will be available.
-- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
-                  Each bit represents single TMON source.
-- #thermal-sensor-cells : Thermal sensor phandler
-- polling-delay: Max number of milliseconds to wait between polls.
-- thermal-sensors: A list of thermal sensor phandles and specifier.
-                   specifier value is tmon ID and it should be
-                   in correspond with brcm,tmon-mask.
-- temperature: trip temperature threshold in millicelsius.
-
-Example:
-	tmons {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x8f100000 0x100>;
-
-		tmon: tmon@0 {
-			compatible = "brcm,sr-thermal";
-			reg = <0x0 0x40>;
-			brcm,tmon-mask = <0x3f>;
-			#thermal-sensor-cells = <1>;
-		};
-	};
-
-	thermal-zones {
-		ihost0_thermal: ihost0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 0>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-		ihost1_thermal: ihost1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 1>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-		ihost2_thermal: ihost2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 2>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-		ihost3_thermal: ihost3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 3>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-		crmu_thermal: crmu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 4>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-		nitro_thermal: nitro-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <1000>;
-			thermal-sensors = <&tmon 5>;
-			trips {
-				cpu-crit {
-					temperature = <105000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.yaml
new file mode 100644
index 000000000000..576a627cd599
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,sr-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Stingray Thermal Sensors
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: brcm,sr-thermal
+
+  reg:
+    maxItems: 1
+
+  brcm,tmon-mask:
+    description:
+      A one-cell bit mask of valid TMON sources. Each bit represents a single
+      TMON source.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - brcm,tmon-mask
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon: thermal-sensor@0 {
+        compatible = "brcm,sr-thermal";
+        reg = <0x0 0x40>;
+        brcm,tmon-mask = <0x3f>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    thermal-zones {
+      ihost0_thermal: ihost0-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 0>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+      ihost1_thermal: ihost1-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 1>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+      ihost2_thermal: ihost2-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 2>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+      ihost3_thermal: ihost3-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 3>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+      crmu_thermal: crmu-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 4>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+      nitro_thermal: nitro-thermal {
+        polling-delay-passive = <0>;
+        polling-delay = <1000>;
+        thermal-sensors = <&tmon 5>;
+        trips {
+          cpu-crit {
+            temperature = <105000>;
+            hysteresis = <0>;
+            type = "critical";
+          };
+        };
+      };
+    };
-- 
2.51.0


