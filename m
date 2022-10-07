Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE05F80C1
	for <lists+linux-pm@lfdr.de>; Sat,  8 Oct 2022 00:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJGWX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Oct 2022 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJGWXW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2022 18:23:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482FD18C9
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2022 15:23:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so9133527wrr.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2022 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgD3kP0sSWca4YlP6hR+kz5HlaxlTP+KMXKfvr3kHec=;
        b=z63HRGkupvMD+4NoIkCzY3uaFYo3KuZmH3T8nJDC4ZochdKfAnbnWQdZnAGzkqABb3
         XjlyFEz/9uBVyhBH/ZN7x0P5/2YsPKxNipJwmw+vF5UCaAXGUJ1RhZhQfg62wFxjlFU6
         IYOHwfblWD2ksdNi3861EBVdnSbgYvfgUkWqpZtf6AQEotEYe21Fn/CJR6Sp5RJfKKlI
         gSWL6dQ969oP/m06Z07secgniiZiX8gYMIpe8OTZkNLjbwTtfYLbBJReC8tEqKKhUqte
         TISvk8Mp+iTDMNBhlaf0qTZWx4xEq3rSklP3ivDDY6Wu7SrIJPBdJh/fu5JDOCicsSSu
         +RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgD3kP0sSWca4YlP6hR+kz5HlaxlTP+KMXKfvr3kHec=;
        b=O6yLnJj37mmbucQuUlNFXtzW+7M6iVZXc8X0Wr1kCvdCxEtXuvK93cU9rePoCcm6lf
         RMTI1YSfOaPheE2AMmM6hl/HA2SoEx1HkmMlGbnnCG6uMUy4fvr7CEo3qb31AF2WP6k/
         SYF+1+pQz+iQuMR5l6ukWdh++ukjtpcESoEChlKwKf8At9GAoIh9OkUe9r1LNCK3jI39
         gRa+/IDyDPaPnCOWbK4KGIR+o7cQ10jLdwAJCOUEpmP6NU9Q1EzZea1TWJJ2wdGOh5CC
         9cVnGd0b+sTT5ZdOhxvo6W0GUx00E6e6G88Zlz6QoWS5sOuGZA+V3A6u6bnrndK3apkv
         5xcw==
X-Gm-Message-State: ACrzQf3u8QODjpze25MQtdKje3+eok1lbefukKnIipCfoMetMMDbKavP
        G82iZR/fZagY8RrZl5LMVwfbUg==
X-Google-Smtp-Source: AMsMyM7vQZ2ZelfYFnQ1aAbj9mX8p4kUIk0V07qM6lRdjM4l+jCcYtdp2gvBBx9dFie930EjaQ6ufA==
X-Received: by 2002:adf:ee88:0:b0:22e:330a:f741 with SMTP id b8-20020adfee88000000b0022e330af741mr4562322wro.199.1665181396846;
        Fri, 07 Oct 2022 15:23:16 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c34c500b003c409244bb0sm1115777wmq.6.2022.10.07.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:23:16 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        phone-devel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
Date:   Fri,  7 Oct 2022 23:22:03 +0100
Message-Id: <20221007222205.126190-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007222205.126190-1-caleb.connolly@linaro.org>
References: <20221007222205.126190-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../power/supply/qcom,pmi8998-charger.yaml    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
new file mode 100644
index 000000000000..277c47e048b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-charger
+      - qcom,pm660-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
+      - const: bat-ov
+      - const: wdog-bark
+      - const: usbin-icl-change
+
+  io-channels:
+    items:
+      - description: USB in current in uA
+      - description: USB in voltage in uV
+
+  io-channel-names:
+    items:
+      - const: usbin_i
+      - const: usbin_v
+
+  monitored-battery:
+    description: phandle to the simple-battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <4>;
+
+      charger@1000 {
+        compatible = "qcom,pmi8998-charger";
+        reg = <0x1000>;
+
+        interrupts = <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+        io-channels = <&pmi8998_rradc 3>,
+                      <&pmi8998_rradc 4>;
+        io-channel-names = "usbin_i",
+                           "usbin_v";
+
+        monitored-battery = <&battery>;
+      };
+    };
-- 
2.38.0

