Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF748B47B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbiAKRvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:51:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54120
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344754AbiAKRvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:51:02 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D34B405F2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923461;
        bh=kbLoQxnt4voM3VUH+Yi44nd1ZrFyriuSpnp8itMYMGk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HOje+syrI5aTbeRR/PP/GrSwYnpQk4yj1aW5+VjwuOTdsB18zy1afXFRSJfkei//v
         6PGoSMMkCDklz1KNhBegzint1W/anQ4krQcU/pqwr7cjHmLz76ZJo1WG4M9OZF9WKn
         y7qxspgsPXg4/OQhmXqB8Z3lq5mo9P4XGy2fM67AGNyUSg7kTgcry3HC3aoMc7AjY3
         TTfpcnKUTCUPdHtmdIOJGqDA5MW/MS00dD6QKyOi9/Zz7wzcObG7k/qdQbnaHHWmsj
         RMj6aLScBavO6e3Q6H/EpE6eeFvU6ga3Mgal0fmE+T0k9/aK73QRD6sLz62Ubmwg1r
         I/P8a968d0DwQ==
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso13988656edd.16
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbLoQxnt4voM3VUH+Yi44nd1ZrFyriuSpnp8itMYMGk=;
        b=1tgXxz/Ma9PHVRidyYzEJ7d8jxE3LPswhVdYfAw3pWTB7cDO8ujNhZyGgwXFbb8ptY
         MjjzJBunJ82+4Nh1iDGgBoVoJWrzOj2mLKU3MgywZVEmtlexltMqNZSqHCJpAXby3j4d
         PDwgo+R7/KFe1MA0MgIJTsWxWLGZtXti1Z9+v1kkkRw2hqPc1ndnjpOGgfgzVly5VDA4
         UcPClVc2Y3phwXbgud/kh3wH2TQNV2dEZA599ykXegImVDZM6BvnK7A3aZyKOZtpvsEc
         SZu/MAVlM/082moM9jKdb6kA/yacUaI5AVpyaqgUexWzD33DEdR7eLcI7ea2bLbN2iD1
         yDeQ==
X-Gm-Message-State: AOAM533I4pfsqMzlNynlhVWSmRnb9IOdnCUo3stABjB+6qX4YcoghckN
        DzhRxeg/5aQZ00+x9Ef59jDXSlnF7Tr1UAfnCCUXJIcvk+IA+HCr7n91hfrWmWIFhk94uppcp9p
        Gkrb7cLV7uw8aq2Bgl2LCYwUFInkUVC4BFmEZ
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr5385815edc.285.1641923460234;
        Tue, 11 Jan 2022 09:51:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGoi7rwv7h3DqMi1xIc0ME7EWIpmE0crWbGW94+J4maRho3HvgHFARa19XOpGWJyhmc042tw==
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr5385799edc.285.1641923460054;
        Tue, 11 Jan 2022 09:51:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:50:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:15 +0100
Message-Id: <20220111175017.223966-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Charger bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/maxim,max77693.yaml | 70 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
new file mode 100644
index 000000000000..a21dc1a8890f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC Charger
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77693-charger
+
+  maxim,constant-microvolt:
+    description: |
+      Battery constant voltage in uV. The charger will operate in fast
+      charge constant current mode till battery voltage reaches this level.
+      Then the charger will switch to fast charge constant voltage mode.
+      Also vsys (system voltage) will be set to this value when DC power is
+      supplied but charger is not enabled.
+      Valid values: 3650000 - 4400000, step by 25000 (rounded down)
+    minimum: 3650000
+    maximum: 4400000
+    default: 4200000
+
+  maxim,min-system-microvolt:
+    description: |
+      Minimal system voltage in uV.
+    enum: [3000000, 3100000, 3200000, 3300000, 3400000, 3500000,
+           3600000, 3700000]
+    default: 3600000
+
+  maxim,thermal-regulation-celsius:
+    description: |
+      Temperature in Celsius for entering high temperature charging mode.
+      If die temperature exceeds this value the charging current will be
+      reduced by 105 mA/Celsius.
+    enum: [70, 85, 100, 115]
+    default: 100
+
+  maxim,battery-overcurrent-microamp:
+    description: |
+      Overcurrent protection threshold in uA (current from battery to
+      system).
+      Valid values: 2000000 - 3500000, step by 250000 (rounded down)
+    minimum: 2000000
+    maximum: 3500000
+    default: 3500000
+
+  maxim,charge-input-threshold-microvolt:
+    description: |
+      Threshold voltage in uV for triggering input voltage regulation loop.
+      If input voltage decreases below this value, the input current will
+      be reduced to reach the threshold voltage.
+    enum: [4300000, 4700000, 4800000, 4900000]
+    default: 4300000
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index b5e4f14f6768..ead08768fb78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11681,6 +11681,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 F:	drivers/power/supply/max14577_charger.c
 F:	drivers/power/supply/max77693_charger.c
 
-- 
2.32.0

