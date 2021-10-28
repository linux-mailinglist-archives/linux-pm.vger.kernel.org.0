Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D502F43E6A1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1QyG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 12:54:06 -0400
Received: from ixit.cz ([94.230.151.217]:42626 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhJ1Qx4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 12:53:56 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B162520064;
        Thu, 28 Oct 2021 18:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635439886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKp1ql47JL+USXsrEy5E93P0OLiPl1As1GzW+P8vLKs=;
        b=uyq7h/BDMOH5QW//nPOGAvS/NMZhEYHk71/kw5bXiA4EGLNubvHeuDYy+r3otIaFMgcOOM
        mM2YFm3oJhwze1taF4gTQ15lpeNcjgFIOiBcK1MdYJTGjKzAcZ6FkJ4DdXAzvGsYAvETum
        idcT8etsuhZTot60Zi7ndjxiefBhBIc=
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: power: reset: gpio-poweroff: Convert txt bindings to yaml
Date:   Thu, 28 Oct 2021 18:50:08 +0200
Message-Id: <20211028165009.76641-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert power-off action connected to the GPIO documentation to the YAML syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v3:
 - incorporated Sebastian notes
v2:
 - remove driver specific note about WARN_ON

 .../bindings/power/reset/gpio-poweroff.txt    | 41 -------------
 .../bindings/power/reset/gpio-poweroff.yaml   | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
deleted file mode 100644
index 3e56c1b34a4c..000000000000
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Driver a GPIO line that can be used to turn the power off.
-
-The driver supports both level triggered and edge triggered power off.
-At driver load time, the driver will request the given gpio line and
-install a handler to power off the system. If the optional properties
-'input' is not found, the GPIO line will be driven in the inactive
-state. Otherwise its configured as an input.
-
-When the power-off handler is called, the gpio is configured as an
-output, and drive active, so triggering a level triggered power off
-condition. This will also cause an inactive->active edge condition, so
-triggering positive edge triggered power off. After a delay of 100ms,
-the GPIO is set to inactive, thus causing an active->inactive edge,
-triggering negative edge triggered power off. After another 100ms
-delay the GPIO is driver active again. If the power is still on and
-the CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
-
-Required properties:
-- compatible : should be "gpio-poweroff".
-- gpios : The GPIO to set high/low, see "gpios property" in
-  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
-  low to power down the board set it to "Active Low", otherwise set
-  gpio to "Active High".
-
-Optional properties:
-- input : Initially configure the GPIO line as an input. Only reconfigure
-  it to an output when the power-off handler is called. If this optional
-  property is not specified, the GPIO is initialized as an output in its
-  inactive state.
-- active-delay-ms: Delay (default 100) to wait after driving gpio active
-- inactive-delay-ms: Delay (default 100) to wait after driving gpio inactive
-- timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
-              specified, 3000 ms is used.
-
-Examples:
-
-gpio-poweroff {
-	compatible = "gpio-poweroff";
-	gpios = <&gpio 4 0>;
-	timeout-ms = <3000>;
-};
diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
new file mode 100644
index 000000000000..45d66c775115
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/gpio-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO controlled power off
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: >
+  System power off support via a GPIO line. When a shutdown is
+  executed the operating system is expected to switch the GPIO
+  from inactive to active. After a delay (active-delay-ms) it
+  is expected to be switched back to inactive. After another
+  delay (inactive-delay-ms) it is configured as active again.
+  Finally the operating system assumes the power off failed if
+  the system is still running after waiting some time (timeout-ms).
+
+properties:
+  compatible:
+    const: gpio-poweroff
+
+  gpios:
+    maxItems: 1
+
+  input:
+    type: boolean
+    description: >
+      Initially configure the GPIO line as an input. Only reconfigure
+      it to an output when the power-off sequence is initiated. If this optional
+      property is not specified, the GPIO is initialized as an output in its inactive state.
+
+  active-delay-ms:
+    default: 100
+    description: Delay to wait after driving gpio active
+
+  inactive-delay-ms:
+    default: 100
+    description: Delay to wait after driving gpio inactive
+
+  timeout-ms:
+    default: 3000
+    description: Time to wait before assuming the power off sequence failed.
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio-poweroff {
+        compatible = "gpio-poweroff";
+        gpios = <&gpio 4 0>;
+        timeout-ms = <3000>;
+    };
-- 
2.33.0

