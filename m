Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB87DA610
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407966AbfJQHMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 03:12:47 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44632 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407970AbfJQHMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 03:12:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id z9so987847wrl.11
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0xe4FV0YX22NO6I3XU+3Y8zPnld2K+UQnu+8AFIWtw=;
        b=MQ1lZeNLhK1v35h5GBrVyrfS3o+FpzpiwUZFY+/nQUc8DMZRWC1HFjF/WkkxIy2/fO
         E2lBgJcNi75C159GTkooUVaGTMWLzuvvSTJbe0mquS8qSxTsn5tTImupeKx0IeaZ3Dbm
         v21aC79ALMER6MdH6aNzlmWHDJvS1om0lpBw3ntecQnjmXfZ1W1fP5RMaxj1MX0j0dKx
         wOdp1GirtV0Tx2YhNj7dSmxvi9lRWahd++Awy/l07tVXOSiktKHSPVzgioTkxp4CjWdo
         08xmPG+RhK5JmTR6HZGrF6HWk5oa6/30FraJfjORzP9J66TPxcBX+QtYKAAv56jqp+aD
         tpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0xe4FV0YX22NO6I3XU+3Y8zPnld2K+UQnu+8AFIWtw=;
        b=Nw/xOAvskxFx9iDtjBR/2ygdscbtad7ZOuwW6cbTIxyNj+gqnX8oYHpCRE5Mcoqajg
         ke1RpmnHLTEQlx9XwBO5LvSsEARqq+aByEtYZaqlnzUYPCJio10QOxCNzlTw3RpTiHaG
         62DVNQqF9HZU1trEF1rs1kHKgt96DqC0Nv7xvU0cGs3xRAryVoG8mf60nnV8BHLWsO0S
         ZCHnMPMmeUgbA3WF44CGQOoA52PSuAIadTthG8iDw4wuO8jgP9yNZsGGCC1u/3vxjSj1
         o/x++F5Xn2YMQbiiBI3ddcGEC7aUFHwNcjAiBXnOm9kpat9cMYYPodThybXTXvTmMbfA
         7CGQ==
X-Gm-Message-State: APjAAAVAH16FQ8yTCXZncc+effSUPvEcOouc4zN28v77L9SYqDTmm/1A
        ycpn7P8BMt+adoRThWuMHLEZAQ==
X-Google-Smtp-Source: APXvYqxuNydySVjKyAR1uZqIgM8g7VpD/F9Gd+CR3TNU1mKhx151sENGB6uo4noCfeKX+vy/ie2vHg==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr1680954wrq.374.1571296363695;
        Thu, 17 Oct 2019 00:12:43 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n22sm1156689wmk.19.2019.10.17.00.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 00:12:43 -0700 (PDT)
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
Subject: [PATCH v3 3/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date:   Thu, 17 Oct 2019 09:12:31 +0200
Message-Id: <20191017071234.8719-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017071234.8719-1-brgl@bgdev.pl>
References: <20191017071234.8719-1-brgl@bgdev.pl>
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
 .../bindings/regulator/max77650-regulator.txt | 41 -------------------
 .../regulator/max77650-regulator.yaml         | 31 ++++++++++++++
 2 files changed, 31 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
deleted file mode 100644
index f1cbe813c30f..000000000000
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
+++ /dev/null
@@ -1,41 +0,0 @@
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
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
new file mode 100644
index 000000000000..a8770742836d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -0,0 +1,31 @@
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
-- 
2.23.0

