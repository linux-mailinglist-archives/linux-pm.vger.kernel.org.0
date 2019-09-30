Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B76C212D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfI3NDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:03:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35743 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbfI3NDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:03:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so11256868wrt.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaeByO83iTaTnQiZnsElO9I64wWUuESKRkcaE0MZFTM=;
        b=c6n7wHhaZnEhyBQrEdkjmzzkiW6SU1CVO6Ud+3FdyzVI9//HukNrUOdIzXBZkvNXTd
         pnobXczROyD4WcmyXn5bb7vt1iceOj+j0pTTk6n7WaCfv6wuaRgztqBlQOSOi7IxhMda
         KdC1NDv8S4JegV1fNIImPpOlKYp2iNX9sYjRQZhCe0C9p/+67ltHNt8tK3YJL87h3kNJ
         /89Pqgj46GvHXpJn6lWfgdyJku816eoibV0cxlfn/tNH7zMkWU4Z6AmZtxWSgU8RFleD
         lUuKqk9SC9tpSA1RH0/aX+1/ssTjaY3zrGYcM+5WhoYDfKXbxewPtLN+YxhqrPtrr8eO
         h+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaeByO83iTaTnQiZnsElO9I64wWUuESKRkcaE0MZFTM=;
        b=sxOH+dnHTMJJ2fG+SzK8gkFbDA1ZBt3BDzrCUM2ayeKG3h0MkPAVkIBwLMkvsZQUos
         flM2wPUVxJ3Xyp0cLk4YzuKZK5dqF0MPHZabeCfuo59jGXFgV3uXiHtafSvU9cHNGHhe
         P5tTRcja9DUc/qgU0kJcPykq3kP7M2fCawNNkJ0VZXnWnQ+mR4CbzfHFoC3khM9rJdSr
         u4LZ7RiJ4gUayTfQdk2aCcKX0cSk9niftaHKkBnK1N1Syg0FIIr9qPwaPqZxOUTBECvm
         jCJTfexui765hm7VsF/xuvsOmqXn/B9lWf0gffYHRYJPSGGAzJE3CsFnYA657Xws2pYU
         U3wg==
X-Gm-Message-State: APjAAAXNf331oz7PVLy5d8pD1Z6Akmy/2thmy+aEUHHx0aKh+t7ctsNp
        ziF8XytNiilp0VOc8Za2+UKpCg==
X-Google-Smtp-Source: APXvYqzK3aL6w5Mfi/jzOhvUA0i7pUBArI/dJPqVdOMu7CNg51nfovbDb0ynfDpqTf2NNQELSMaQrA==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr13254878wru.384.1569848581033;
        Mon, 30 Sep 2019 06:03:01 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:03:00 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date:   Mon, 30 Sep 2019 15:02:43 +0200
Message-Id: <20190930130246.4860-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930130246.4860-1-brgl@bgdev.pl>
References: <20190930130246.4860-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for max77650 regulator module to yaml.

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

