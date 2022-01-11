Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4227148B43E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jan 2022 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiAKRoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 12:44:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60790
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344029AbiAKRoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 12:44:20 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA9DD40019
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923059;
        bh=UwxCg/3JRxb+xIwzo2AXdt3q4ESk3LoFT4Bw/xZKpww=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=G/IWgjy8LnH2wcKp9OU1SQ9c5hSjINIppzT+uuEKR67jH94b6ZkUhwo7FO6xNssIH
         8BFlzL48Yvn19gFBbkXzS69yMB8rXEtwZcStPRgPP+FmKp9b0my7p87rRIgefW4NQc
         BftvFrsisDe95A2HT9OGyKsPyesqh9XT/OzL4kqdE3zjZUCZbKKLQkQ76CIsxe52et
         OIezSlx/GvPPOvcnkjioTAK83YaixJY2fLjsvmc2o1ziJs1KvpAhqiafUy4xM/d2qI
         DVaFoT1H1+X27AokujnBTTKucUlZdve3mE2bUjz/hC3LclK7OeRRz9yCP23b+n6UXf
         YTRnfa4RNOeMw==
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso13971484edd.14
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 09:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwxCg/3JRxb+xIwzo2AXdt3q4ESk3LoFT4Bw/xZKpww=;
        b=wLQP3IF/qXp6rujnnM/iPcLEwNe8rlumFPTVrL5tOn3oLzetEnIQDhZOpyjpLnMoOc
         uOiDKQBcI68nlu/WTTSl2KrSYC6zRRMkH6j5DCSsvEcGQIeK9lZCKM1i/lnS52ffKWjI
         3XPynatYrKRX9FvsjJKfoEPesSCYUZ6jJyyBZoUGWAlHOX9lK2Pz1SLBkceHaTs1FNh0
         3PscJBbqe+zdNv+pt53kRjRed4MnRyioCmdDSD2aAlxc6oaLwqbGn9z2aE838FFIEoDh
         DHpUFkAGaXmkx1NC8ePLC8mfbkKmFGDX3eJFgam9DnI5lxWH6ozRG44manFivQCQOTaR
         BcRA==
X-Gm-Message-State: AOAM531OdgDSyDsdii71VqRRQoJYyFRr+RG2HwCcKC7yCZoEPZH798pM
        KXWK3WQiVxeS1j/vHMR3iMOoZon7x9B++OQsKerhy8CB4ytdnKenyoKJWSVbv8pP66ep/qHDKW+
        1hDgQsDJxLxBFXARuTascHELzXnn3lReH6yEu
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr5463533edb.406.1641923059345;
        Tue, 11 Jan 2022 09:44:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsS0hDLRYk0r5JjweCUErlbNd0YkPquUINIsjfQ4os97kXEQhtnlMaSz1xWFtOEmAAPmTevg==
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr5463508edb.406.1641923059150;
        Tue, 11 Jan 2022 09:44:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g9sm3758657ejo.222.2022.01.11.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:44:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max14577: convert to dtschema
Date:   Tue, 11 Jan 2022 18:43:35 +0100
Message-Id: <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
schema format.  The existing bindings were defined in
../bindings/mfd/max14577.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/maxim,max14577.yaml | 84 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
new file mode 100644
index 000000000000..3978b48299de
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max14577.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management IC Charger
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX14577/MAX77836 MicroUSB
+  Integrated Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max14577.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max14577-charger
+      - maxim,max77836-charger
+
+  maxim,constant-uvolt:
+    description:
+      Battery Constant Voltage in uV
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 4000000
+    maximum: 4350000
+
+  maxim,eoc-uamp:
+    description: |
+      Current in uA for End-Of-Charge mode.
+      MAX14577: 50000-20000
+      MAX77836: 5000-100000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  maxim,fast-charge-uamp:
+    description: |
+      Current in uA for Fast Charge
+      MAX14577: 90000-950000
+      MAX77836: 45000-475000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  maxim,ovp-uvolt:
+    description:
+      OverVoltage Protection Threshold in uV; In an overvoltage condition, INT
+      asserts and charging stops.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [6000000, 6500000, 7000000, 7500000]
+
+required:
+  - compatible
+  - maxim,constant-uvolt
+  - maxim,eoc-uamp
+  - maxim,fast-charge-uamp
+  - maxim,ovp-uvolt
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max14577-charger
+    then:
+      properties:
+        maxim,eoc-uamp:
+          minimum: 50000
+          maximum: 200000
+        maxim,fast-charge-uamp:
+          minimum: 90000
+          maximum: 950000
+    else:
+      # max77836
+      properties:
+        maxim,eoc-uamp:
+          minimum: 5000
+          maximum: 100000
+        maxim,fast-charge-uamp:
+          minimum: 45000
+          maximum: 475000
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index d1f8f312f322..13e21c229c5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11681,6 +11681,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 F:	drivers/power/supply/max14577_charger.c
 F:	drivers/power/supply/max77693_charger.c
-- 
2.32.0

