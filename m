Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979F1C2131
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfI3NDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:03:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36416 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbfI3NDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:03:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so12663457wmc.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DR4CDnm3HTSMvdcyXG+EIsMWYn8dMZO45Sjl5iJv4rQ=;
        b=GvXqzILM9azRuelBX+Vp16FuNpt0fcz09jJ5TkxweZg1F7ov/f1651OAHsomRxzEFD
         b3Q9518E8FvJPXkf4F9KH0f2hMgvsDiMUh8Eqv5W6o40wP675jbqq0qdF9uNITdSKZdE
         K3CLTBXGeb0mZIsXwkMw1+TrFZzV7nkcc2PA1rfwUqDX1ig/rD/CtYYigTvNbmD2r0JU
         UlvTePVLEkqHzvwihDbUKypHGAzb0U+kysa1mqjvQs9TO8lUH5rquzdKnkBX4CRTqguz
         W3RKO0CEK+Qo/AMA+kYsOC4uAL7tLlZ7hof3T7D0YggAjH9j72L+zkXfKomupQ0xPVa8
         2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DR4CDnm3HTSMvdcyXG+EIsMWYn8dMZO45Sjl5iJv4rQ=;
        b=ic/EYR7Ofo5qdG/qKvUstwqgOTiR+hu1o1ZICu4WCMuxDaqNpdZljDbpV3hSjv4wb0
         GdoeaI9Yy0y/Lj1wnSyIexySiNbbdZIlDJNCGzwbWieY4FNNlWdOH85I0JDhWSYWWp64
         zbaNNviww8XtuVmBlLSU6Z8nlPaJqvS9S1MNSUl+H6zvcHXr/+A4ykHgX6OmFuzIEK1W
         6kLOtclTgVqdihYD9CobMlB1s4w4Xph0jm8fci8j7dR0KR01BfzC4QT2k+H+ppEDLtnJ
         kd9xPL/4b7aLDzQAp9RO5tJpktCLqEbHRvXq9vfyQt/g1XRolOXOzuEo+lIaeziX/DXy
         DLsg==
X-Gm-Message-State: APjAAAWB8uzhIv5AII7kFFbtFg1slpAFWAp6mcHGO6sd7ethqfeKqF/3
        tzWIATawkbr2/ONcZsSxhaPnnQ==
X-Google-Smtp-Source: APXvYqw0BOhWPRLaP5niJ1EkkWvknXRhMFnLxGCU011zli4EszA5IdJdxFEl/d2oAkC227tFIQSadQ==
X-Received: by 2002:a05:600c:20c4:: with SMTP id y4mr15454070wmm.87.1569848579871;
        Mon, 30 Sep 2019 06:02:59 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:02:59 -0700 (PDT)
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
Subject: [PATCH 2/6] dt-bindings: input: max77650: convert the binding document to yaml
Date:   Mon, 30 Sep 2019 15:02:42 +0200
Message-Id: <20190930130246.4860-3-brgl@bgdev.pl>
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

Convert the binding document for max77650 onkey module to yaml.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/input/max77650-onkey.txt         | 27 +-----------
 .../bindings/input/max77650-onkey.yaml        | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
index 477dc74f452a..a691fc49f1ea 100644
--- a/Documentation/devicetree/bindings/input/max77650-onkey.txt
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -1,26 +1 @@
-Onkey driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The onkey controller is represented as a sub-node of the PMIC node on
-the device tree.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-onkey".
-
-Optional properties:
-- linux,code:		The key-code to be reported when the key is pressed.
-			Defaults to KEY_POWER.
-- maxim,onkey-slide:	The system's button is a slide switch, not the default
-			push button.
-
-Example:
---------
-
-	onkey {
-		compatible = "maxim,max77650-onkey";
-		linux,code = <KEY_END>;
-		maxim,onkey-slide;
-	};
+This file has been moved to max77650-onkey.yaml.
diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.yaml b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
new file mode 100644
index 000000000000..eb2f8609bae2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/max77650-onkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.yaml.
+
+  The onkey controller is represented as a sub-node of the PMIC node on
+  the device tree.
+
+properties:
+  compatible:
+    const: maxim,max77650-onkey
+
+  linux,code:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The key-code to be reported when the key is pressed. Defaults
+      to KEY_POWER.
+
+  maxim,onkey-slide:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The system's button is a slide switch, not the default push button.
+
+required:
+  - compatible
+
+examples:
+  - |
+    onkey {
+        compatible = "maxim,max77650-onkey";
+        linux,code = <KEY_END>;
+        maxim,onkey-slide;
+    };
-- 
2.23.0

