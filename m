Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B2139968
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 19:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMS5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 13:57:00 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgAMS47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 13:56:59 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5PyX-1iqFPY1tHJ-001NIF; Mon, 13 Jan 2020 19:56:41 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 1/4] dt-bindings: Add Broadcom AVS RO thermal
Date:   Mon, 13 Jan 2020 19:56:15 +0100
Message-Id: <1578941778-23321-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:1LJ2j7244eYkHFAUHdWlluvFEyk8XYcN5PXA1gFB39CpNctCmlA
 tHCLseCL17seFiEhGPXjTI7fZAU2vjdjjeBTRZlZJvpWQ+F+NJTMqHI2cxDMDNpXt6WFSrd
 URaMI8WB9CPCul3CewrF8jkvLQHySlDVor7raLVMen5Ha8pSkw8cQjEN40X7Ra4vWt2W9B6
 1zVmC9h+RDBbMcfP5DvyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxivOdifFGE=:4XZSIRqIgLFn5Se3XfzOXO
 hn3JrVw+qNXKVs2QVvzasuUduBzxughpiGolGcmx1npMHd5NAzfbe4Qd4mAYJqhP0TKdVJHtP
 /SuG0KScUUYnPK7YhaoFMRJrMPRp4bFDPgKmAQUmj4e6aHXsGPkj+jPIkJ1qhzYilxcHICg3/
 1mOzcT+YwH6t3SsaGyn6jhWYepFEFrgKVKY0ixjGdx5TZAeosmmRmhmNOn5VykDa7bPBGfdJP
 biIyTC/I4f1Xe6MKXJHw3velSKsbw1EL87w2im5MR1sLfmCvUD1Z1Mqw5A0EJhkih4UZzrKfV
 Cpabq/EE8eID7wixqSmJPCuw7XXjsLTFZfxXGGwKJOyPZO/Xx7QQannAvEpcyyd3KM8vX1TXa
 v5T2bxB6Y09h6RZtlnNZ/HH/zXhHC7jJYctEgLKNTrZt/FQbXNHTqyGS9H7fBtFYlelTbG3sl
 rPMop7FuKlK/4b1nCkxkDljJGrQSP48sTh+UltzCX4iwK45IsO4O9NDKzd4HmQfelsMpgBEZr
 NHnaqIof5HPK2dQaj5nDt2fa0RR2GimNWj7lGXeWe1CYyX7gvYEEvoYx7EeaLZ2aBYFDAEikD
 AsGhm/fVxlez8MnY1SrjE750KaWbCjEtgSx37HHV3zJF8oa29LiGv6g5gU09o5vRBxJy37j8Q
 SFFX4V1ho6WrZkZg+5E1r7W0SEjg8OKnOYubgU/3cokER8yhifXcQg2aQiFhP0XmqkqM8EJ1B
 6ZKS/kHOwgufF1acrHlAVga/HvksHRRxNWavGJT0c3SgHjldJs1PLoNcXbUiOw4w/OsR7db/9
 qA7yl1CwrrnRqpnT+5oyv1v+obYwFypvKulQodJqIVRnG4qJqwbSOdgcTZ3xPDIjC7WjJZ/Hb
 S6iSRXBZuKM2O/mUwK/6lFzt1L7n3RxqOHk8n3ow4=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the BCM2711 doesn't have a AVS TMON block, the thermal information
must be retrieved from the AVS ring oscillator block. This block is part
of the AVS monitor which contains a bunch of raw sensors.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
new file mode 100644
index 0000000..98e7b57
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,avs-ro-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom AVS ring oscillator thermal
+
+maintainers:
+  - Stefan Wahren <wahrenst@gmx.net>
+
+description: |+
+  The thermal node should be the child of a syscon node with the
+  required property:
+
+  - compatible: Should be one of the following:
+                "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.txt
+
+properties:
+  compatible:
+    const: brcm,bcm2711-thermal
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+        avs-monitor@7d5d2000 {
+                compatible = "brcm,bcm2711-avs-monitor",
+                             "syscon", "simple-mfd";
+                reg = <0x7d5d2000 0xf00>;
+
+                thermal: thermal {
+                        compatible = "brcm,bcm2711-thermal";
+                        #thermal-sensor-cells = <0>;
+                };
+        };
+...
-- 
2.7.4

