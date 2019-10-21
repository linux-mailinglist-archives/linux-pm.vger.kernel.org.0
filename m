Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82404DEC9C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfJUMol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:44:41 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46247 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfJUMoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 08:44:39 -0400
Received: by mail-wr1-f49.google.com with SMTP id n15so3018289wrw.13
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=az5Qk9HV+xwHSQgQsE7jPUxX1AeC/LW+c8v20q7G+To=;
        b=Yn2N3y3TuMvAi4XTRPu4kdvgMY/oy9tYbogJ5rt8gHn60GNFokeWPQsFaOPsv2e4JE
         hLL4Z2ZUJDpFho0Voth3CJ565u+qhPNkTkwk1Yg2KKG+JcmnwuA2IbBI/4/7MyYITUAa
         8xi6COny3LVcsSizEx9+drR7rX6cCve9/xLIpLdpmFcIU+GspciFTGJS4reOLGP6buSi
         W3OTHBhupUI6RmNiIgX3N2Ko71rgkKgJR0s2QzWjHYBotStGpFwOpFLnJSDsN1kLyBTP
         AZxyaNGUSV7bG5VUj9NqmkF4HZFPdQKe9TKGELeTusQOGzNPtEuhIwaWwawoBNEdFWA+
         tCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=az5Qk9HV+xwHSQgQsE7jPUxX1AeC/LW+c8v20q7G+To=;
        b=ojy5Dfl5dSk9K5Xg2X8CyJN4Sm4wGM83klBAVEQ1LoZD5Sk711LrZ0QttaZ2k51lOr
         ycFqqCW14Zhp3JUAOE78yzoLLyvXKTb9a1I5eaIikV2kEs+ffvlXsyJrqcPRVFPHzX8k
         8D3EGCRfZLrciat3wX+4sXzPODbZ/HQqVuPDC7PiMpupg0XYYwyrl6gTj+qq7tDWX7Y5
         4D0lcyw8h5E4a1iTca6KbSAWUMxgggFhqKzlWD8gWpdAaAzSNFezQov4G9uNxSgW7I0I
         PpKc/f2ck2Efb6KrWmq8ap2DqqJZMMeR5mJ7xYGl/SGyMuSU2oYZHYcljmUimU9YK9v0
         2a6A==
X-Gm-Message-State: APjAAAUF3NXWkCdviDABo5eE0J04E2PscytV0u+pQseBKZkbZNVr9J6R
        UqdFjKT7X+T4mDLdQyV96W9a+w==
X-Google-Smtp-Source: APXvYqwTjMGgIWlEorxrxqhBE9HmBj2vfdY8HwuDzMcoG9+YkQTIR233SwrwQ64xJsk6pkFesXsoAw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr16074645wro.85.1571661876038;
        Mon, 21 Oct 2019 05:44:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a17sm10216150wmb.8.2019.10.21.05.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:44:35 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date:   Mon, 21 Oct 2019 14:44:24 +0200
Message-Id: <20191021124428.2541-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021124428.2541-1-brgl@bgdev.pl>
References: <20191021124428.2541-1-brgl@bgdev.pl>
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
index 000000000000..7d724159f890
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
+  see Documentation/devicetree/bindings/mfd/max77650.yaml.
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

