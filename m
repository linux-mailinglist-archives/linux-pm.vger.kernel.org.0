Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25681C9F30
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEGXjB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 19:39:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39398 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGXjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 19:39:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6F2BB80307C1;
        Thu,  7 May 2020 23:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bnS3sKmVLYcq; Fri,  8 May 2020 02:38:54 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: power: reset: Convert syscon-reboot-mode to DT schema
Date:   Fri, 8 May 2020 02:38:44 +0300
Message-ID: <20200507233846.11548-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
 <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Modern device tree bindings are supposed to be created as YAML-files
in accordance with dt-schema. This commit replaces SYSCON reboot-mode
legacy bare text bindings with YAML file. As before the bindings file
states that the corresponding dts node is supposed to be compatible
"syscon-reboot-mode" device and necessarily have an offset property
to determine which register from the regmap is supposed to keep the
mode on reboot.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org
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
index 000000000000..9b1ffceefe3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
+    description: Update only the register bits defined by the mask (32 bit)
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the mode register (in bytes)
+
+patternProperties:
+  "^mode-.+":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Vendor-specific mode value written to the mode register
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

