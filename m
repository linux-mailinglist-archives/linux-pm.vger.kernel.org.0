Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94517BD8D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCFNEE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 08:04:04 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36166 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCFNEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 08:04:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C07838030795;
        Fri,  6 Mar 2020 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9IZ3E-PxsihJ; Fri,  6 Mar 2020 16:03:56 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: power: reset: Replace SYSCON reboot-mode legacy bindings with YAML-based one
Date:   Fri, 6 Mar 2020 16:03:39 +0300
In-Reply-To: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130401.C07838030795@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Modern device tree bindings are supposed to be created as YAML-files
in accordance with dt-schema. This commit replaces SYSCON reboot-mode
legacy bare text bindings with YAML file. As before the bindings file
states that the corresponding dts node is supposed to be compatible
"syscon-reboot-mode" device and necessarily have an offset property
to determine which register from the regmap is supposed to keep the
mode on reboot.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 .../power/reset/syscon-reboot-mode.txt        | 35 ------------
 .../power/reset/syscon-reboot-mode.yaml       | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
deleted file mode 100644
index f7ce1d8af04a..000000000000
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-SYSCON reboot mode driver
-
-This driver gets reboot mode magic value form reboot-mode driver
-and stores it in a SYSCON mapped register. Then the bootloader
-can read it and take different action according to the magic
-value stored.
-
-This DT node should be represented as a sub-node of a "syscon", "simple-mfd"
-node.
-
-Required properties:
-- compatible: should be "syscon-reboot-mode"
-- offset: offset in the register map for the storage register (in bytes)
-
-Optional property:
-- mask: bits mask of the bits in the register to store the reboot mode magic value,
-  default set to 0xffffffff if missing.
-
-The rest of the properties should follow the generic reboot-mode description
-found in reboot-mode.txt
-
-Example:
-	pmu: pmu@20004000 {
-		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
-		reg = <0x20004000 0x100>;
-
-		reboot-mode {
-			compatible = "syscon-reboot-mode";
-			offset = <0x40>;
-			mode-normal = <BOOT_NORMAL>;
-			mode-recovery = <BOOT_RECOVERY>;
-			mode-bootloader = <BOOT_FASTBOOT>;
-			mode-loader = <BOOT_BL_DOWNLOAD>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
new file mode 100644
index 000000000000..e09bb07b1abb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/syscon-reboot-mode.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SYSCON reboot mode driver
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  This driver gets reboot mode magic value from reboot-mode driver
+  and stores it in a SYSCON mapped register. Then the bootloader
+  can read it and take different action according to the magic
+  value stored. The SYSCON mapped register is retrieved from the
+  parental dt-node plus the offset. So the SYSCON reboot-mode node
+  should be represented as a sub-node of a "syscon", "simple-mfd" node.
+
+properties:
+  compatible:
+    const: syscon-reboot-mode
+
+  mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Update only the register bits defined by the mask (32 bit).
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the mode register (in bytes).
+
+patternProperties:
+  "^mode-.+":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Vendor-specific mode value written to the mode register.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - offset
+
+examples:
+  - |
+    #include <dt-bindings/soc/rockchip,boot-mode.h>
+
+    reboot-mode {
+      compatible = "syscon-reboot-mode";
+      offset = <0x40>;
+      mode-normal = <BOOT_NORMAL>;
+      mode-recovery = <BOOT_RECOVERY>;
+      mode-bootloader = <BOOT_FASTBOOT>;
+      mode-loader = <BOOT_BL_DOWNLOAD>;
+    };
+...
-- 
2.25.1

