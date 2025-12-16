Return-Path: <linux-pm+bounces-39613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5942ECC0981
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 815493016994
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE82DEA8E;
	Tue, 16 Dec 2025 02:19:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from silergymicro.com (unknown [218.94.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46212D876B;
	Tue, 16 Dec 2025 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.94.11.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851551; cv=none; b=mpQguSw3FzIxae/lNXMIKBGQ0PhsizVIYAd9X3bB7rJEhyaqny5G1Y9MLO4E2Z6Ham5I6RsqCqoSooWb5eqhvCBkGs80ohilbl02DBZLY48OLxJWs7tEFJQUa8hWPJ2pKzKGlImaGF8KszkVDGaDUYl3ZJOBKd9qXrpd/DWU5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851551; c=relaxed/simple;
	bh=9H+VDimC5IXUHJH5X0LMUgSNb8desz75tnC1hAYFa9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oY7WhgorwV5KcVQ30aysu5OuCsK5VE5XcbjKXfoCBtYx6T9tPfKYmyFRHByLQI9faYDIig61BSDbBm3d5EFFjunms6l8r2VA5h66wqq2mMuIKkebXx6pAQ8pzR2G79984V9tjfbEul9HQnKr7XW1nQVGshpegp2PrXPvVMoVZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com; spf=none smtp.mailfrom=silergymicro.com; arc=none smtp.client-ip=218.94.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=silergymicro.com
Received: from getian-VirtualBox.. (unknown [10.2.25.100])
 by mail.silergymicro.com (Postfix) with ESMTPA id 6FD37182DA808;
 Tue, 16 Dec 2025 10:19:03 +0800 (CST)
From: "tian.ge" <tian.ge@silergymicro.com>
To: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lei.zhang@silergycorp.com,
 frank.fan@silergymicro.com, "tian.ge" <tian.ge@silergymicro.com>
Subject: [PATCH] dt-bindings: power: supply: Add Silergy SY6974B charger
Date: Tue, 16 Dec 2025 10:18:51 +0800
Message-Id: <20251216021851.654957-1-tian.ge@silergymicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TraceID: 1765851543pvM8C

Add bindings for the Silergy SY6974B I2C controlled charger.

Signed-off-by: tian.ge <tian.ge@silergymicro.com>
---
 .../power/supply/silergy,sy6974b.yaml         | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/silergy,sy6974b.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/silergy,sy6974b.yaml b/Documentation/devicetree/bindings/power/supply/silergy,sy6974b.yaml
new file mode 100644
index 000000000000..91ad05939c58
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/silergy,sy6974b.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025 Silergy Semiconductor Technology Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/silergy,sy6974b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silergy SY6974B 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Tian Ge <tian.ge@silergymicro.com>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: silergy,sy6974b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sy,charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      maximum charging current (in mA).
+      Range: 0 ~ 3000 mA, step: 60 mA
+
+  sy,precharge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      maximum charge current during precharge phase (in mA).
+      Range: 60 ~ 780 mA, step: 60 mA
+
+  sy,termination-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      charge will be terminated when current in constant-voltage phase
+      drops below this value (in mA).
+      Range: 60 ~ 960 mA, step: 60 mA
+
+  sy,regulation-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      maximum charging voltage (in mV).
+      Range: 3856 ~ 4624 mV, step: 32 mV
+
+  sy,minimum-sys-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      when battery is charging and it is below minimum system voltage,
+      the system will be regulated above minimum-sys-voltage setting (in mV).
+      Allowed values: 2600, 2800, 3000, 3200, 3400, 3500, 3600, 3700 mV
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - sy,charge-current
+  - sy,precharge-current
+  - sy,termination-current
+  - sy,regulation-voltage
+  - sy,minimum-sys-voltage
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6b {
+        compatible = "silergy,sy6974b";
+        reg = <0x6b>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <64 IRQ_TYPE_EDGE_FALLING>;
+
+        sy,charge-current = <3000>;		/* 3000 mA */
+        sy,precharge-current = <500>;		/* 500 mA */
+        sy,termination-current = <300>;		/* 300 mA */
+        sy,regulation-voltage = <4480>;		/* 4480 mV */
+        sy,minimum-sys-voltage = <3500>;	/* 3500 mV */
+      };
+    };
-- 
2.34.1

