Return-Path: <linux-pm+bounces-41064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B9D39C88
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBB9300A34E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669B24DFF9;
	Mon, 19 Jan 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IIWKKCo6"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5342580F3;
	Mon, 19 Jan 2026 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790580; cv=none; b=AZB9PU/rNMjbsuKQzWrCpzntFb3sIA6Fmg4xQ92LDAjTYQfsQ7vBrQfFEe5m2DT0KJdLZuNm3NnRRknG563rji3hs9L0wJ7f8cJ1rqhF9FKKZeBODXqbE9vIskWdT+1vwWNgjbIhPfa0Ed+v5foczZbBTTRL91W417RLubkb540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790580; c=relaxed/simple;
	bh=3ztmZaenK0lc3nmImMGXP5hUoSi2aOxTwUupSvl11KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/V+GMv/ZbF6quVLpwcUyYmmhq20F74OqL33BiDJCq5WuiGXnwhC4PoaB4TTBoSfrp0qu1QQwqW1xyJ/fNT6DD73PwCb9uMZ1jeDZ+hN9BR8w7HqcThQWh6zekazyul2L0N46ajNiN+j+jR84i5kv6eDDA47rz5EGIdp1ScDypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IIWKKCo6; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=mlZGLU46CRb7flP89rQHjZQQSh0AEfus5GV+G+N+ph8=;
	b=IIWKKCo6rQYW5SmylIknon35T4tIV2e5RIE65NT3mZYTa7tTveTHZUy0IhCwxd
	8hLs222jpEUI74OL3djp+7vjVrEn0t91HRYbinzefA9+Fnau+gmBlv7MBUAbu7pO
	ZgqnJ8RFLY0hliH45Vu73XcxPZQpudkGO65voFuARSB2U=
Received: from [113.54.162.98] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXQfnSmW1pNwHHLg--.6S3;
	Mon, 19 Jan 2026 10:41:28 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Mon, 19 Jan 2026 10:41:21 +0800
Subject: [PATCH v3 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal
 sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-patchv2-k1-thermal-v3-1-3d82c9ebe8a4@163.com>
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
In-Reply-To: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Shuwei Wu <shuweiwoo@163.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768790485; l=2540;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=3ztmZaenK0lc3nmImMGXP5hUoSi2aOxTwUupSvl11KI=;
 b=eLypNYqwxce4KFMsoNCvb/ScSvrZe1MlmmfIfNKhIkKPuGNyjlD57/JH7cpyMTLCUJtm5PW4B
 UG7F0xvhRwgDs7GKTGlG8UsmBNoKhV9OPyI8wW+BdvhsZobYofR7M46
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PygvCgAXQfnSmW1pNwHHLg--.6S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1UXF1rKFWrGw1UZr4DXFb_yoW8KFy8pF
	4fGr93Grn7uF17Xw4Sqr1kCa1Fga1rAF1UXrn2gwnYyrn0gFyaqrnFkr1UZa48Cry7Xay5
	ZF4Uury2k3WDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pikwI9UUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC4xpS4Gltmdp8owAA3T

Document the SpacemiT K1 Thermal Sensor, which supports
monitoring temperatures for five zones: soc, package, gpu, cluster0,
and cluster1.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
---
Changes in v2:
- Rename binding file to spacemit,k1-tsensor.yaml and update compatible
---
 .../bindings/thermal/spacemit,k1-tsensor.yaml      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml b/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
new file mode 100644
index 000000000000..328101a7f083
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/spacemit,k1-tsensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 Thermal Sensor
+
+description:
+  The SpacemiT K1 Thermal Sensor monitors the temperature of the SoC
+  using multiple internal sensors (e.g., soc, package, gpu, clusters).
+
+maintainers:
+  - Shuwei Wu <shuweiwoo@163.com>
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-tsensor
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock for thermal sensor
+      - description: Bus clock for thermal sensor
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for the thermal sensor
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      The first cell indicates the sensor ID.
+      0 = soc
+      1 = package
+      2 = gpu
+      3 = cluster0
+      4 = cluster1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    thermal@d4018000 {
+        compatible = "spacemit,k1-tsensor";
+        reg = <0xd4018000 0x100>;
+        clocks = <&syscon_apbc CLK_TSEN>,
+                 <&syscon_apbc CLK_TSEN_BUS>;
+        clock-names = "core", "bus";
+        interrupts = <61>;
+        resets = <&syscon_apbc RESET_TSEN>;
+        #thermal-sensor-cells = <1>;
+    };

-- 
2.52.0


