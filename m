Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9766AD7B32
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbfJOQXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:23:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbfJOQXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:23:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so21547829wmd.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5B5AkAQGi4DNKyHv7fhvAOLB86h889/P7BfszQY5c4=;
        b=eZOy7J2IO2HWDqq09vENTThSZi5vPpMlD7l5AKRvV+cYtbJ1ZcMswyrzdSm86HC42s
         jJyPjN99mftKfl1KK53lNJPl9dDdXq90BMed/I6d7tdIJHLtcYu5eNzFnvN+uXE7i+lD
         YqQ9kHqlp5eh97O/cqk5jL/bJ8Y2qanAgPRhOhZIwmG9QrIUZLJlsb7tiddKDdMpKeTf
         ks0ISe77XXkeGFPrXoq+BxHN+bEgRhkL5KdKbNey2Gls8+QUQVjZwnH0LntE1w56TTPj
         eZJ2xQ+d/sRURoZ/MZ+ls7i378TmmHLD0Fg8Q2Ef40Lf1trRCIepaVAPSYLHvjH7b5Xa
         kIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5B5AkAQGi4DNKyHv7fhvAOLB86h889/P7BfszQY5c4=;
        b=s/5gsUCrn7EXwi2/qpKXBXQYQ86Vbj0cv6TnuxbEYwVX0lOoF6V2MUPAi2+6G3ZjH2
         vFPUclO6OUTc3xvLzV1Tt6M3cC/pKmg3wulCj6DfYCJ8N5qfiGLfvOxlPQhgMYB0fywE
         c8rrLgbrQevgveb2fwivwmUggPZTX9tMrkHzZlz24/agEpzP/PTr6UeFSZJ+qR8YkPiR
         aqXBdwUMmpGMuclP4v7X+teXtLAx3fP0n8h8+Yir9N6KgXiTCPfNNrlZSbFtCZL5LiCJ
         whUESl4z5stMbibPPG28gzDCMn6vuyKO/RJu6ws2dN/MQim4dF6Vq1R98vHCZBt6o7Et
         beDA==
X-Gm-Message-State: APjAAAVP1vE6IbJTshpWS4SPk1QJ3jLCpzOPI+qWGtIGADoZQqtgpU/A
        aHScucYlDJlLdlfXmIp+YwGpaQ==
X-Google-Smtp-Source: APXvYqyHK5TFwV9xIejPU5dtBpGW5WxVyh8AU6LufLjB7nMCfCxfgYwQacJucrroFYP9OyvU2koHMg==
X-Received: by 2002:a1c:7219:: with SMTP id n25mr19497225wmc.33.1571156590048;
        Tue, 15 Oct 2019 09:23:10 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date:   Tue, 15 Oct 2019 18:22:57 +0200
Message-Id: <20191015162300.22024-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162300.22024-1-brgl@bgdev.pl>
References: <20191015162300.22024-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for MAX77650 regulator module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 42 +--------------
 .../regulator/max77650-regulator.yaml         | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
index f1cbe813c30f..39686610589c 100644
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -1,41 +1 @@
-Regulator driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The regulator controller is represented as a sub-node of the PMIC node
-on the device tree.
-
-The device has a single LDO regulator and a SIMO buck-boost regulator with
-three independent power rails.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-regulator"
-
-Each rail must be instantiated under the regulators subnode of the top PMIC
-node. Up to four regulators can be defined. For standard regulator properties
-refer to Documentation/devicetree/bindings/regulator/regulator.txt.
-
-Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
-
-Example:
---------
-
-	regulators {
-		compatible = "maxim,max77650-regulator";
-
-		max77650_ldo: regulator@0 {
-			regulator-compatible = "ldo";
-			regulator-name = "max77650-ldo";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <2937500>;
-		};
-
-		max77650_sbb0: regulator@1 {
-			regulator-compatible = "sbb0";
-			regulator-name = "max77650-sbb0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1587500>;
-		};
-	};
+This file has been moved to max77650-regulator.yaml.
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
new file mode 100644
index 000000000000..c0d986948ac8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  The device has a single LDO regulator and a SIMO buck-boost regulator with
+  three independent power rails.
+
+properties:
+  compatible:
+    const: maxim,max77650-regulator
+
+patternProperties:
+  "^regulator@[0-3]$":
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+
+examples:
+  - |
+    regulators {
+        compatible = "maxim,max77650-regulator";
+
+        max77650_ldo: regulator@0 {
+            regulator-compatible = "ldo";
+            regulator-name = "max77650-ldo";
+            regulator-min-microvolt = <1350000>;
+            regulator-max-microvolt = <2937500>;
+        };
+
+        max77650_sbb0: regulator@1 {
+            regulator-compatible = "sbb0";
+            regulator-name = "max77650-sbb0";
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1587500>;
+        };
+    };
-- 
2.23.0

