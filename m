Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D8479244
	for <lists+linux-pm@lfdr.de>; Fri, 17 Dec 2021 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhLQRAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Dec 2021 12:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhLQRAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Dec 2021 12:00:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF11C061574;
        Fri, 17 Dec 2021 09:00:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i22so5202000wrb.13;
        Fri, 17 Dec 2021 09:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc3L6UZb2PlxIKElhEsWA3ODR+UpWpdweZ/Uoj8yWwQ=;
        b=fwDOzYC/sWl5QtrxXoQth1fa95jl6X9D1qcVZCrvvEIB2KjIHBjBhHf/eYKmwRb4XT
         QRWiLhsEbFgDAhkxZerrUWA+rN4VK/nKEopQTACpSJ1yKJ5sKI3TMLG5eooUHKXPGEIR
         byeWn6S1JB0RIdJxDvhbBFRgkhIp4/sy2985q+dg538Gv2GHEVN20ak85SP/g2JVdsZ4
         dTov/vyURhM/5UweAb1nXKdwAc27qFR3cglne7aGCAyOlG9QeaKKAHAOKHJVraUL2unu
         /7wLAodQvztDIYKdrgFBEbuc2U6PwR6I259WknAlzClRMpo0pxmk7gtZDfgylNdjWbEv
         yZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc3L6UZb2PlxIKElhEsWA3ODR+UpWpdweZ/Uoj8yWwQ=;
        b=vCca8nkEzUBI2l/PzAa32R6EGVgmLdTB6UjBZKbgPT+xoNMkEG5OoCACuJe8byRHRI
         ePC9PFLZMEJbKlLCxFLVRdy0nvAmcjprRz4GGAbL1cEbLcBokMTjbBRndIO+1msI0YYX
         TlKR7o9ljY+iicPym481gkfq1yljNI83SeusFDz2+NyqVoHYi6BW2TCXUdrtTg1m2VBE
         iMa69iH7gi8POBPofkktbx4qOOO3COrqrQPpm4IsInXub06p2WDC07BcTSGhIfl5ZNXj
         tXe4xt5+3nFgRv7QlBLrcjKlufrmBpSEy6uO0dsXDHTIQiQSgnUtMpvzLQwVcdaeivEY
         7xig==
X-Gm-Message-State: AOAM5317B4gCJJ/BcauRL/dFRvTDWXx3NZoHLhwITlc/Y596z5EEVui3
        qXZ3cbF+CLO+y9+uXQ09qQLHsTfSRMYOfA==
X-Google-Smtp-Source: ABdhPJwS5A17zqJaQoBIDjwEgR1u8org3CVR58fuDxDO4Q94QseLAVHuAhrgxtAQmB41x4uc/xPA5Q==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr3183862wru.156.1639760445254;
        Fri, 17 Dec 2021 09:00:45 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id j3sm2644232wro.22.2021.12.17.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:00:44 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: power: reset: gpio-restart: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:00:42 +0100
Message-Id: <20211217170042.2740058-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the GPIO restart bindings from the free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/power/reset/gpio-restart.txt     | 54 ------------
 .../bindings/power/reset/gpio-restart.yaml    | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.txt b/Documentation/devicetree/bindings/power/reset/gpio-restart.txt
deleted file mode 100644
index af3701bc15c4..000000000000
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Drive a GPIO line that can be used to restart the system from a restart
-handler.
-
-This binding supports level and edge triggered reset.  At driver load
-time, the driver will request the given gpio line and install a restart
-handler. If the optional properties 'open-source' is not found, the GPIO line
-will be driven in the inactive state.  Otherwise its not driven until
-the restart is initiated.
-
-When the system is restarted, the restart handler will be invoked in
-priority order.  The gpio is configured as an output, and driven active,
-triggering a level triggered reset condition. This will also cause an
-inactive->active edge condition, triggering positive edge triggered
-reset. After a delay specified by active-delay, the GPIO is set to
-inactive, thus causing an active->inactive edge, triggering negative edge
-triggered reset. After a delay specified by inactive-delay, the GPIO
-is driven active again.  After a delay specified by wait-delay, the
-restart handler completes allowing other restart handlers to be attempted.
-
-Required properties:
-- compatible : should be "gpio-restart".
-- gpios : The GPIO to set high/low, see "gpios property" in
-  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
-  low to reset the board set it to "Active Low", otherwise set
-  gpio to "Active High".
-
-Optional properties:
-- open-source : Treat the GPIO as being open source and defer driving
-  it to when the restart is initiated.  If this optional property is not
-  specified, the GPIO is initialized as an output in its inactive state.
-- priority : A priority ranging from 0 to 255 (default 128) according to
-  the following guidelines:
-	0:	Restart handler of last resort, with limited restart
-		capabilities
-	128:	Default restart handler; use if no other restart handler is
-		expected to be available, and/or if restart functionality is
-		sufficient to restart the entire system
-	255:	Highest priority restart handler, will preempt all other
-		restart handlers
-- active-delay: Delay (default 100) to wait after driving gpio active [ms]
-- inactive-delay: Delay (default 100) to wait after driving gpio inactive [ms]
-- wait-delay: Delay (default 3000) to wait after completing restart
-  sequence [ms]
-
-Examples:
-
-gpio-restart {
-	compatible = "gpio-restart";
-	gpios = <&gpio 4 0>;
-	priority = <128>;
-	active-delay = <100>;
-	inactive-delay = <100>;
-	wait-delay = <3000>;
-};
diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
new file mode 100644
index 000000000000..3dd22220cb5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/gpio-restart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO controlled reset
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: >
+  Drive a GPIO line that can be used to restart the system from a restart handler.
+
+  This binding supports level and edge triggered reset.  At driver load time, the driver will
+  request the given gpio line and install a restart handler. If the optional properties
+  'open-source' is not found, the GPIO line will be driven in the inactive state.  Otherwise its
+  not driven until the restart is initiated.
+
+  When the system is restarted, the restart handler will be invoked in priority order.  The GPIO
+  is configured as an output, and driven active, triggering a level triggered reset condition.
+  This will also cause an inactive->active edge condition, triggering positive edge triggered
+  reset. After a delay specified by active-delay, the GPIO is set to inactive, thus causing an
+  active->inactive edge, triggering negative edge triggered reset. After a delay specified by
+  inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
+  restart handler completes allowing other restart handlers to be attempted.
+
+properties:
+  compatible:
+    const: gpio-restart
+
+  gpios:
+    description: The GPIO to set high/low, see "gpios property" in
+      Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be low to reset the board
+      set it to "Active Low", otherwise set GPIO to "Active High".
+
+  open-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Treat the GPIO as being open source and defer driving it to when the restart is
+      initiated.  If this optional property is not specified, the GPIO is initialized as an output
+      in its inactive state.
+
+  priority:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      A priority ranging from 0 to 255 (default 128) according to the following guidelines:
+
+        0:   Restart handler of last resort, with limited restart capabilities.
+        128: Default restart handler; use if no other restart handler is expected to be available,
+             and/or if restart functionality is sufficient to restart the entire system.
+        255: Highest priority restart handler, will preempt all other restart handlers.
+    minimum: 0
+    maximum: 255
+    default: 128
+
+  active-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay (default 100) to wait after driving gpio active [ms]
+    default: 100
+
+  inactive-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay (default 100) to wait after driving gpio inactive [ms]
+    default: 100
+
+  wait-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay (default 3000) to wait after completing restart sequence [ms]
+    default: 100
+
+additionalProperties: false
+
+required:
+  - compatible
+  - gpios
+
+examples:
+  - |
+    gpio-restart {
+      compatible = "gpio-restart";
+      gpios = <&gpio 4 0>;
+      priority = <128>;
+      active-delay = <100>;
+      inactive-delay = <100>;
+      wait-delay = <3000>;
+    };
-- 
2.34.1

