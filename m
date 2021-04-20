Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6152936614B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhDTVBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 17:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTVBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 17:01:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A66C06174A;
        Tue, 20 Apr 2021 14:01:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y4so23389663lfl.10;
        Tue, 20 Apr 2021 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcS56E4kbrULlZyjFsBlGguafcIfvRte0D+DoCJ4c5o=;
        b=tvfIlErdNmcKa4/IYfKK72K5fJWXQCREp95+Lp9FCgma1hvM2K2VNgdyXVSw/wHdeX
         cut6vQofWuqgJ/Wg4VVzMklGJyZnDMol3baeLn+Qz3/oQKubMs6CyCFy9sZu+SqWjF80
         XdaC18g3OVygPrzXsPSPYmPAs3pISi2Z6CfbaF+p3fPSRHgbTeinic4HrjTB7o8oQuRv
         mc5olDBeL4z4MQxq50JKA2T4mT3vZSVlY+oJsTUGl/yQP3wjAme4FUaprQuHu9qhSGAt
         pVCB6epBjfmy9587j5X3thhMOfhai8l3bxDMG/AUqgLnb3vcB5E/1I4u2ItRZT6vN3w1
         fAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcS56E4kbrULlZyjFsBlGguafcIfvRte0D+DoCJ4c5o=;
        b=eJuGEc+xQioCK7EnYSEupWJsBPYYnBf8zJIk1/4rskoUfO1q8PdxvRMxkc1j3lTM5h
         J/w3WKdbnS/dKeFJ6CL2kWDICEmSKl66/183nIkLxqTLMgJh+5P4JQc7mhqs0FT2K4lS
         AhcHJ2bwZbJQj/vbIGZ/icxUqK/upPWRj7DVGAvRetUmONh/CnmjpGWfGyRmxYbcCcrk
         33RKZxL9u2n9W/KQVtV6DCs12F4FNTnHZWEww/ISePzmtEQHJfDZLd0BchOEUhmnZHwe
         0qYWSR+1Xj4obdVsqj8MhMAOyCzCAcSNfBUQ+PAgfAbr5RiN+Mt3Kr9+2uK3A8ngN4Mw
         qnew==
X-Gm-Message-State: AOAM532Cmdl6BN99EcfGaJTVTC0sFqayfPuyCy24EI3/NREfxyqCqLqB
        g85Ka6zLbYDt1YxClpTSVio=
X-Google-Smtp-Source: ABdhPJwlYyBPbx1yuhYTnsjKS2wZteAbIvsyd/TXYY/D3ZJ/2VCVSHmLx6bp+/hbFd7cxvYuAgVWCg==
X-Received: by 2002:ac2:57db:: with SMTP id k27mr4515384lfo.304.1618952471350;
        Tue, 20 Apr 2021 14:01:11 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n8sm7594lfe.285.2021.04.20.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:01:10 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: thermal: brcm,ns-thermal: convert to the json-schema
Date:   Tue, 20 Apr 2021 23:01:04 +0200
Message-Id: <20210420210104.10555-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210415111655.4273-1-zajec5@gmail.com>
References: <20210415111655.4273-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add maxItems to the reg property
---
 .../bindings/thermal/brcm,ns-thermal.txt      | 37 ------------
 .../bindings/thermal/brcm,ns-thermal.yaml     | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
deleted file mode 100644
index 68e047170039..000000000000
--- a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Broadcom Northstar Thermal
-
-This binding describes thermal sensor that is part of Northstar's DMU (Device
-Management Unit).
-
-Required properties:
-- compatible : Must be "brcm,ns-thermal"
-- reg : iomem address range of PVTMON registers
-- #thermal-sensor-cells : Should be <0>
-
-Example:
-
-thermal: thermal@1800c2c0 {
-	compatible = "brcm,ns-thermal";
-	reg = <0x1800c2c0 0x10>;
-	#thermal-sensor-cells = <0>;
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <0>;
-		polling-delay = <1000>;
-		coefficients = <(-556) 418000>;
-		thermal-sensors = <&thermal>;
-
-		trips {
-			cpu-crit {
-				temperature	= <125000>;
-				hysteresis	= <0>;
-				type		= "critical";
-			};
-		};
-
-		cooling-maps {
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
new file mode 100644
index 000000000000..fdeb333e010d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,ns-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar Thermal
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  Thermal sensor that is part of Northstar's DMU (Device Management Unit).
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: brcm,ns-thermal
+
+  reg:
+    description: PVTMON registers range
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+unevaluatedProperties: false
+
+required:
+  - reg
+
+examples:
+  - |
+    thermal: thermal@1800c2c0 {
+        compatible = "brcm,ns-thermal";
+        reg = <0x1800c2c0 0x10>;
+        #thermal-sensor-cells = <0>;
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive = <0>;
+            polling-delay = <1000>;
+            coefficients = <(-556) 418000>;
+            thermal-sensors = <&thermal>;
+
+            trips {
+                cpu-crit {
+                    temperature = <125000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+            };
+
+            cooling-maps {
+            };
+        };
+    };
-- 
2.26.2

