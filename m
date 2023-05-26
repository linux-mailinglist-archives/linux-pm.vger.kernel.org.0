Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E9712F18
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjEZVom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243360AbjEZVol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 17:44:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93CE66
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 14:44:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so12901175e9.3
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685137457; x=1687729457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQig366/jBhqB0GKlP90bhSQeKtAdVThJviX57QVuzo=;
        b=GqqB+sScNNlirRPUAkMdLPgOr8ZSmvhL3WaNlzL9sr81Gc+ZmYt6F9+WDhnJIiUoC1
         +AZxzJKi18IARz3vpaCAfIxMYKlSqzktBmSDejIgN8kEZKTsAaVrDqRCl2qBFOm8IfiB
         T1FHsiYSl/t/sWAFj3pzdx+UYfrDZs3S9L/TtOMnI9Nf75jpMAreSjncASGn0m3iZaJV
         QMp4I8IqFqw3ojRnE9508DkqTst/RzpwamiianGIEeDzxb0Z5l0idM/aMlB9lR769LQi
         WbZOd34pzavDdjqbCU8MXhqT2ldON8cUYmxz1PeJBpts/XT/LubdCuU3NdxPdMfSPiSq
         0+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685137457; x=1687729457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQig366/jBhqB0GKlP90bhSQeKtAdVThJviX57QVuzo=;
        b=lCFaeydzqaBXw0kPty4ZYi7O01RUgFkYvPT8g6vNKubr31AocluFiPU1zl97dBaY1P
         8UIN0remfIhMyZ4Z+7sdCzCxbAmfR5B3We6o7RjQt4OtReNqOqeo3cyelgPS/CUTW59J
         jIKFrqugk1hqXsqr/KEFJxAasEsPvJi320wwJVA9w78DXPXhoXQJlRhSbb/m0UcPN8WJ
         sgdfh1m2SbnkCxBEi1Zl6eDyerQhSbaTEHeBD1JPGW5R/d5Jjf28dfDrs+hCghIsUACR
         RzDoIcG2aVa1oZ2F0D79m+WmsKOEIhc+hQ/sxmeiX2M7Rxux6IgPuxV0ZAdqos6yy9cQ
         zkHw==
X-Gm-Message-State: AC+VfDz4TqICl9FLqICwcH15X9svO1UfytihVF3OXSoXgrw7vxaJAe3U
        QKSAoXYqcQM+VZ9yjfMkKoR6PQ==
X-Google-Smtp-Source: ACHHUZ7h3ze38uNx8CP1FlGfdmsTvmvnk8NL6hQfU3V8kyEEc3kHJA4I8cL0kOwUlazThb1E1WO85w==
X-Received: by 2002:a7b:c40a:0:b0:3f5:db0f:4a74 with SMTP id k10-20020a7bc40a000000b003f5db0f4a74mr2566993wmi.21.1685137456731;
        Fri, 26 May 2023 14:44:16 -0700 (PDT)
Received: from lion.localdomain (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id d16-20020adff850000000b0030903d44dbcsm6138905wrq.33.2023.05.26.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 14:44:16 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
Date:   Fri, 26 May 2023 22:44:14 +0100
Subject: [PATCH v9 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add bindings for smb2 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-pmi8998-charger-v9-1-cd7f6d03c0ab@linaro.org>
References: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
In-Reply-To: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Hsbae7MIMMJm4YVccghxQsFvZJgVUArxdt1L5EgFpNI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBkcSguId0NfgKyPkuXxKLZi3MUjGnQTXHL6uV6I
 lVXLqkqAFSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZHEoLgAKCRAFgzErGV9k
 thEjD/wLojVhviXN72wSdBV6tKLzWjorT1cAPwTWsCmF4JJ+PXo28ZcBtaeiPebBbhi/tgzmtMA
 AVLopdBvXQ7no/vKbgx3ekyadTEsWmsdKJFHAThQpB1Q3k+yeDxMv3JQqWt0nv57Iz57c7HNARF
 u+hku1KmKhs50E9rSpCQgyUlEU8hOgzyQddTf1kDD98iYq1RA9diutCu6lbElhK2iCWbN1o4xDh
 ZVXyhKmdi/c9ca3jAjNslYfoTTgbVS5Z/rUf8VeNUnuWfnqbCl6F/w95x6lo1+nZs5ElPrQNU4M
 ZKGZRyriQUTAa31hdmfjgaLgaHdB5VDNVIkkvhO0pD+uqUYq1qVZ5Icx/JwblJi45UrXtV3vLUc
 BzX7DnXLUT0WddjL1OB3/TsZ4CAA9MdXBZF9jKTUiwoQstCjjtWIh46tdJmKOeugiLpdtVQ+Uoh
 qBkDnx58llupK/r/zbfnPD2fLS/W0HiKbU8xOgqOwEzDr+1wKyIfqaZIe/vkjupwyxzzRGvOEZM
 o8uuA/DleCuH61DjwtISxVT5AcjnK/ExPIkj5q61YJSqGxo/xAVOt7+dedzyodQ18jo40XRdNEo
 3PVOdPUlIV2uDazQTMgg1XoZOtt9aUuKRKGX7opwH4egLNfJx4b9FjfvcjX0VpPFRTg8bOw5eWs
 +sPWXvCM9KGNVTw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  1 +
 .../power/supply/qcom,pmi8998-charger.yaml         | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 36de335a33aa..44590dc112be 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -133,6 +133,7 @@ patternProperties:
     oneOf:
       - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
       - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
+      - $ref: /schemas/power/supply/qcom,pmi8998-charger.yaml#
 
   "gpio@[0-9a-f]+$":
     type: object
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
2.40.1

