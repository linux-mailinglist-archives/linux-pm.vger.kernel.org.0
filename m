Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CF4B64B8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Feb 2022 08:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiBOHsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Feb 2022 02:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiBOHsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Feb 2022 02:48:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFB8CD8A
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 23:48:32 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59BF93F1CA
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644911311;
        bh=PCf70YVth7bcFf8EDZJN3LQUIrjFpZ/338y6P3yBpn8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pDwvSGYuoXBhE+4CoEa9fcossyRKSdh675G4Altfe3Eh//JmcP26iRYmt7TxATa1V
         Vdl2WWLyycxN1V47uiEDzHBxP6QSzPYeRMZ0jGWsMX0cakaKgR4DEU2bvSZEGAXhP5
         gecOmFPkDDjX7f/G/MzB4+B2N/e9NGXv4laPQ4F9ArVYXT9I3ueHLtQOD7HwrbGY02
         f32Uiwuii/d/YNvc00tlY87zHHeWZSyOGlK7cWATrxNgNgaJbnyG5cuvlEA0bLiPXn
         NMOJGCuY95ZsJYWyna7vVS7cX4H37gKF1XowRiI1qadMkHEdF4AGRtIfpducqPRrsD
         h2jzNR1ARZnrA==
Received: by mail-ej1-f72.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo1857040ejc.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 23:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCf70YVth7bcFf8EDZJN3LQUIrjFpZ/338y6P3yBpn8=;
        b=H0lPJQsgOEwrCm30t0BXAosTfFeyAh3Ffwltsd12HG43mFZVdedXGWG+A5Ncr8LUBe
         hmGopEL4gwYRKyaim31g0RoIZNS7KqwOSL5DGp6I1L4VQRka1HklpN9dkIYl0PotDv8e
         L9TIkv/u4Gchr0pfEdS//c3JXPchyD7I7lqRyl8Ae4FVw9l5pFuVs+MC0u0Yt/BUCkqd
         TbffOcoJ1QEwqy8lK49C+cgYuL5CxR7ylzr9KPjEu7Yq8YkxjhxFt6Wr82zdroyqcTVY
         OkukPV+aak3dUlfbVrPyO6T85Gkxu2D3FdiypUFWqFFt5iau70tonY2SkRqMcI/v+D7g
         qrkQ==
X-Gm-Message-State: AOAM533il43KcMjeJ3rpnk1f0VvZ0pW7Vet5Z/66JhWcUbjMxilXarXs
        SU+pf9psSvhxA0fSEaWs2ZwDxC9h7+vtlEPLBv9oZuBqWk5VjGQKBInb9B4zPNN8Z8uCJ8zdwJ3
        hB+BT3waOxaBMPQInuYNnLclFd5TXKEHut8dc
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr2632668edd.408.1644911310988;
        Mon, 14 Feb 2022 23:48:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjA4JYQ8o9D7zS7jjGhffwT5jaCTnlhkKPCeK2D7NzlmdPJoCPLLsNchqxE5tBAaZ5zCk6qQ==
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr2632657edd.408.1644911310850;
        Mon, 14 Feb 2022 23:48:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c29sm1188357ejj.149.2022.02.14.23.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:48:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 1/3] dt-bindings: power: supply: maxim,max14577: convert to dtschema
Date:   Tue, 15 Feb 2022 08:47:57 +0100
Message-Id: <20220215074759.29402-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
schema format.  The existing bindings were defined in
../bindings/mfd/max14577.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
index f7eabdf93867..dbce6642e127 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11840,6 +11840,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 F:	drivers/power/supply/max14577_charger.c
 F:	drivers/power/supply/max77693_charger.c
-- 
2.32.0

