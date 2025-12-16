Return-Path: <linux-pm+bounces-39609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D2CC08E8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B003017381
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195F29ACF6;
	Tue, 16 Dec 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Li0WyGTi"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F9A59;
	Tue, 16 Dec 2025 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850591; cv=none; b=UPKGEssu2itAHGd86T0qqPxxqfWtl8mCIvUMmT/ZjMnT7PnT5gQbAmoZp5rbEELJh5u8v72IonSFDDQp+UQmJyK2Rz0wIzi1BU71neiC5ue8v8+OIlE3TNU27PoCs/PpR1S8UhKDfDZmXlAd5E3wvtBmi3GwxyFHG1uIVSVPPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850591; c=relaxed/simple;
	bh=0uikCfen/M7ul2A9nGFiRto3pqY9jv/BdC6ugaZH33k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2AZMZgjZj71kyV5mAt7xSklqmQ4vbfsachSoDxoULK+N+mfy0L6+Wk7lSC00ZQpgSyOkS64fCu1Aq2IfTut06pcUqKYZ4g1w0qYiVhU4UgKIwMjIMjyOQrsqrBC2syBhuq84gX7mQdqIfo7ZOORN9UDOak5QSDv1y4ZKkRaGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Li0WyGTi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=EB3+lUrYjXdHLb6lVc83k/KDwbQO/1iZ6Sq6de5B41Y=;
	b=Li0WyGTi2cbBBX1G6SOMtBibyLzKPQjZkjKiaBmjKWr766cczANSt+EGPrdVsu
	dNiCHtItot1V28+h32ONX/RsCOfyn0HuTS3RVN8F6nLdPv0iciVcR2sIBnxLRDP7
	Dzaz5a+FdH2M2wd+vnEbsJZw2nO68wSjgmSu7PuLVSpIA=
Received: from [192.168.10.1] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXUu97vUBpOmJ5Ag--.29S3;
	Tue, 16 Dec 2025 10:01:36 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Tue, 16 Dec 2025 10:00:35 +0800
Subject: [PATCH v2 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal
 sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-patchv2-k1-thermal-v1-1-d4b31fe9c904@163.com>
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
In-Reply-To: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765850492; l=2596;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=0uikCfen/M7ul2A9nGFiRto3pqY9jv/BdC6ugaZH33k=;
 b=dlAx+dseeSycqN1YujmmvjrGBobHVCrErX4V5EYL9bsUTWEK7Qx1eiR4Y7x79LUKpROIm2yW0
 O2+u/kpUMpJDsVw5DYEF/yhKKcc6OrUIJmzKQ2upx/EQBV4QFqzdIRl
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:_____wDXUu97vUBpOmJ5Ag--.29S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1UXF1rKFWrGw1UZr4DXFb_yoW5Jr4fpF
	4fGr93Grs7uF17Xw4Sqr1kCa1Fgan5AF1UXrn2gw1Fyrn0gFyaqwnFkr1UZa48Cry7Zay5
	ZF4Uury2k3WDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pikwI9UUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC5AH5iGlAvYG0mwAA3u

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
index 0000000000000000000000000000000000000000..328101a7f08361424d77bb5ac68667a6e7d5d398
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


