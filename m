Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7D67F1F9
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jan 2023 00:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjA0XFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 18:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjA0XFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 18:05:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FC7375F
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 15:05:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so2201652wms.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqwMmYjC0dFtZeRAWk2Olug2QMDHtx6nG0vcXJrQXG4=;
        b=vhnyz36GmjI3i9iki/+P8lFMMsRiiCB4iYuTca1NWzlWseng5ZjkP6yKVj+qcHUivP
         Ty4xlkVEKB+lh6VdT1bTZ3ak5zpj/LnilQlWAm2Sun42htU2Ws8cDl04ol/LYjGQY64E
         nb5zBUcbD03SgkdtNS1phBxIN39W92HEL7px/In7PYs077RzwcdPUWsltp1Z4bKc8AFq
         /wv1w7OhczHdebgaABqI4+iHWbaGTDHgJ/3KpKk4PTzClbTtnQAbOVnMH/tgJOrtijgB
         BwSyBWA1C+E+WCwilJOLcYmJXkVEgB3i9NCVuqO3tTyjFhdJkkS2/pDNhaTt/woTTSUa
         T8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqwMmYjC0dFtZeRAWk2Olug2QMDHtx6nG0vcXJrQXG4=;
        b=Bt0wAmA1BOGCmjjWVnNnk2wOiq6IHXZo0hAnCSVTKeLK5M/LLhlCsVM1C3LlCNMBWb
         7gnIGqfVLZIIXxp1SaRQbI1+pqDFVJoMkB57NUghva4j/Wacx0ITdp4qxISxdOj2EJd1
         MyNE4/Ekni2m4QskhluhtdfvdANF7kXnECTwHDpmpVqKOopMTevU3PlfkCAWrYBw/Z3M
         p5UmlEV0AHljNj+TvNV62UKfzd0qss7OoHzq4sSzS4IG2VSLThwhJArDaU3N1qUoRCou
         29LElF/Tk4/fxOtKqWaH/D6nsiSu3sDqnmKVLQG5khTKE6ptEA1WYvAsvZ9udYMdvseS
         PxGQ==
X-Gm-Message-State: AO0yUKWUUNdWFzgO/8uZDSBV5dlwPg5VG4TFnUqs7Ml7+LSr16T0lGU6
        vLpMyMylwvrUI6Bjjyu4Q0t9YA==
X-Google-Smtp-Source: AK7set8JnqreRtXSQJRQJz4sCnWMynTv6v7RwqUxSxuFo7iTkUriG60xhMgzRwKI8iHoTvQRJ5A/kQ==
X-Received: by 2002:a7b:c7ce:0:b0:3dc:42d2:aeee with SMTP id z14-20020a7bc7ce000000b003dc42d2aeeemr2324613wmk.25.1674860709362;
        Fri, 27 Jan 2023 15:05:09 -0800 (PST)
Received: from lion.. (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm10447206wmb.47.2023.01.27.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:05:08 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 2/2] dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
Date:   Fri, 27 Jan 2023 23:05:06 +0000
Message-Id: <20230127230506.3140297-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127230506.3140297-1-caleb.connolly@linaro.org>
References: <20230127230506.3140297-1-caleb.connolly@linaro.org>
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
2.39.0

