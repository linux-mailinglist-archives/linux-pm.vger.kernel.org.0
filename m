Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595AF5121C1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiD0Szi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiD0Sy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:54:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CE3E6E63
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg25so1644884wmb.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNAQFZYH/igEDPdHL3ir2IRYt88PXPn3Q8Z0llJsjqM=;
        b=CyKF3Gtrgmb7DChTG3HlP4rJaP76kaU7Pyy88pG48AITBWCw6zfeggSjVMMbPXvRU1
         p5ujHRua3cun+gOuyUcEyDcPN1zcFVtvGCJfFoXZfQtm9Kqgt/EJulxsuJfWOLv6j7uO
         6Eva9zTK70UGMX0wQLYHXDLwSVrOawg5AbtUZz/mlDOiU0lvphnI9Y8P3ZMuFsUoHAC3
         npJergekPUXVOIYURxpSS4jKX1MF6oFivsSRx4AyDdr7PdOhS4BvpE6nRBAUmqXZOYtT
         AppTN7aVR9FE0XYXTikyT7vGkMMTZMaCdsXVO6ddal3pBOXQaqEf+dqYOqv77s9dLOR2
         kBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNAQFZYH/igEDPdHL3ir2IRYt88PXPn3Q8Z0llJsjqM=;
        b=bHvI/r5sa7U+lsPr1fPTMrNGAHSerOZWprvnKA178DpgK3WOTVVB5G2Xv0mvsT5eks
         33B1a/WzD9+tiuSNm27eIN12qbE8OfyybJmkIn1/j0Ij4OKM5v+FihUAM4+6OoO27DZb
         6hUITS8dA1foSfsfbx3LpLuQZYdEvNM2hLjrxCn4FKAlwF7Sn3s9wH0sL/vKsCcxCiqM
         SmJengTcrJh4jcCkOJGMBHum/D7bJOd0PsdWU6ab5cVZziwe40DWIwK/rTR0KsDo7pAs
         fDbQSPrwVKa7Ng0f7zs/9FGbPt4D6MrhOdNEwNwWj2aqH0i9l40zqfQBN8njJTq1Gxkn
         JjUg==
X-Gm-Message-State: AOAM531bQp+ykUYMK10Wmp6OVmBNyjoU3rLTXA7AdYivQx/VZ8uFILzr
        KBAUZR/25kK/STs1n0CHePcxQQ==
X-Google-Smtp-Source: ABdhPJw3sVTSRGZWSYrRc79qfqdc3uTzShD8sEa4DX2AY7xFycIkSg4u3I0cKXiCbzqFYll7z/WcCA==
X-Received: by 2002:a05:600c:3b02:b0:393:e7d4:b660 with SMTP id m2-20020a05600c3b0200b00393e7d4b660mr18720272wms.183.1651084883538;
        Wed, 27 Apr 2022 11:41:23 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d64c3000000b0020aef267950sm1992798wri.49.2022.04.27.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:41:22 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 6/6] dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
Date:   Wed, 27 Apr 2022 19:40:31 +0100
Message-Id: <20220427184031.2569442-7-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427184031.2569442-1-caleb.connolly@linaro.org>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../power/supply/qcom,pmi8998-charger.yaml    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
new file mode 100644
index 000000000000..41b471713364
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -0,0 +1,83 @@
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
+    minItems: 4
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
2.36.0

