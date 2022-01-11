Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784948B477
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbiAKRvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:51:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33022
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344730AbiAKRvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:51:00 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 412F94001E
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923459;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BG5MMDR2bAihcm4OOdL4rab+l0NQKyV6Q1SPDQvR7e/qldEx/wZMRzB/ecFtHNB/Z
         vHv+GcZSKNXpGr2eeKN0xpHrmw7FjdE/lCJSJfWunvvFOqaSXA4xB8jUZPR7QTL6Ta
         Xm96q/Z/j2KqNMEwYw/IlwVnMotnCsw50w92BtMGnCGgLBJc6H2p+i3FOxko6QT+pZ
         7RPDSDUgsK81b7Ra/tKx0C1QW19+nFWHI65S90ofpSj8lm0WwhuZTS3pjG7+fnxwxa
         eY80Xid44D0QvK/6SaX5BLx9xVU+q+nO/JgxyHE5ZGh8R89jW618z4E3l1djyPhww/
         qXryabjp/8T5A==
Received: by mail-ed1-f70.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so13893346edd.13
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        b=uwyVukAPZ529LxyN5ThTAtDaQPnjvYKvu8w/4X4fFkbS9kDI+3kYjIVpUvA99EyKEQ
         XhGZTGXBFZe1Ygk3RN2d0lJzPRxVfX+YOxLBUxvJ0ZwM8P2e2akLilXv3XZg1KS3A9HV
         6p9CEYKxYCocDnFA1SEesvjabDSuTpTdoji72KsEG2+22Nd/jyhCSVEuLi7TrMn2fSjl
         WnNRhmT+9S+LxzHHjHtTl5FBf3Sj0TBHDiyYdyAiGViRrQbhRHg6wXR3u5T7px2RA5d4
         mAlUu99+szqzjvarP0UA2GfFnYG1cpbxMYsObIN351EOOeVee/yJY6U+snkoh+x3vvWh
         3Siw==
X-Gm-Message-State: AOAM533bYD+aeQ4Lsb8wZQPu2M9JwGnl1excv0JzPapOOLoIdngwiYXg
        6x74xHWeIs14Qs+JQgNXdPVcm0iOA5xoxpABy/SDXJ8F+wQvN/mV0ZiIbXw5DetsZthqVwDgelK
        QwI3VvcOrc5LOEHZB5TFTwuewLhu7PxCB+G0j
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr4240217edb.95.1641923458807;
        Tue, 11 Jan 2022 09:50:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx9wwlVpoawVqU0Ge74rjEjab/82+gkGE3u88EenodQl8wnd5r337GQ7qDD/V4AqiEEq2YTQ==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr4240194edb.95.1641923458503;
        Tue, 11 Jan 2022 09:50:58 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:50:57 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: leds: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:14 +0100
Message-Id: <20220111175017.223966-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/leds/maxim,max77693.yaml b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
new file mode 100644
index 000000000000..86a0005cf156
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC LEDs
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  There are two LED outputs available - FLED1 and FLED2. Each of them can
+  control a separate LED or they can be connected together to double the
+  maximum current for a single connected LED. One LED is represented by one
+  child node.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77693-led
+
+  maxim,boost-mode:
+    description:
+      In boost mode the device can produce up to 1.2A of total current on both
+      outputs. The maximum current on each output is reduced to 625mA then. If
+      not enabled explicitly, boost setting defaults to LEDS_BOOST_FIXED in
+      case both current sources are used.
+      See LEDS_BOOST_* in include/dt-bindings/leds/common.h.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  maxim,boost-mvout:
+    description: |
+      Output voltage of the boost module in millivolts.
+      Valid values: 3300 - 5500, step by 25 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3300
+    maximum: 5500
+    default: 3300
+
+  maxim,mvsys-min:
+    description: |
+      Low input voltage level in millivolts. Flash is not fired if chip
+      estimates that system voltage could drop below this level due to flash
+      power consumption.
+      Valid values: 2400 - 3400, step by 33 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2400
+    maximum: 3400
+    default: 2400
+
+patternProperties:
+  "^([a-z]+-)?led[01]?$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      led-sources:
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
+
+      led-max-microamp:
+        description: |
+          Valid values for a LED connected to one FLED output:
+            15625 - 250000, step by 15625 (rounded down)
+          Valid values for a LED connected to both FLED outputs:
+            15625 - 500000, step by 15625 (rounded down)
+
+      flash-max-microamp:
+        description: |
+          Valid values for a single LED connected to one FLED output
+          (boost mode must be turned off):
+            15625 - 1000000, step by 15625 (rounded down)
+          Valid values for a single LED connected to both FLED outputs:
+            15625 - 1250000, step by 15625 (rounded down)
+          Valid values for two LEDs case:
+            15625 - 625000, step by 15625 (rounded down)
+
+      flash-max-timeout-us:
+        description: |
+          Valid values: 62500 - 1000000, step by 62500 (rounded down)
+        minimum: 62500
+        maximum: 1000000
+
+    required:
+      - flash-max-microamp
+      - flash-max-timeout-us
+      - led-max-microamp
+      - led-sources
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.32.0

