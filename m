Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A42677410
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAWCbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 21:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjAWCbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 21:31:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E81632E
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l8so7955252wms.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6x76P4bBPMIkrXistg2yMPreC8P2/MDiRGxUtJSBFg=;
        b=COMbrgdhVa38nDBvC0FO3nt9NCLrWd+fEXiypk+oRdb5sKdkHaDr1SSE6xDghkIOrf
         TRNADUGEJieAOMhqhUn5rxN+o1Ec3m9Ua+jGlg5KNXrbbWU9uREtiRM3UPLtRliMrTs9
         D4AZ6I7GV+luduOzfuGBU2m4LRqjj50CE+o87ghAruLpRe+dOTusJ3Lw99511u4bsDHQ
         wmrQTEivGx4UjZw7+Sp5D6/BxixvW88c1ttIZ++BPSybh9jUZsL/wKEYhvw9wtV/+o1s
         HzW8IoewgN95yTJpjcaZ/oYmn30Pq5xTIOzvhEzzFa7jAKB6yX8IF8TsICiC9l2x9tKg
         snSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6x76P4bBPMIkrXistg2yMPreC8P2/MDiRGxUtJSBFg=;
        b=Frnn7cJg6T5G8Ei6+Mg+duna7nlZYxBfdE4b4tTwSGiPFIT0AL5raCpcx1RJ4vDqGI
         IW+AnLNJM/fG0dVwdmIdagfJbz+zPR7h0Dzkghbpe4MafL8ZbEIDQC2i7nD8twKCYXj+
         3w1tm+2yerhP3mP3lZj17RQLAkU3nLJNEmMpwzcjOMqKkDBvRsfvhTIq0E0OK/f31mNh
         MZRz08Mf/lh6Gs1duzgCiDX6khJg5ROPfAX/nouSjfZ4sC4N7IRv7vPydntT6rrl+gBy
         LvapVtR6Lj4Vwjvmlrx4w+12JjCaZKk9XV8c5vCbJIXSQZH0EubBwD+J7pYA7OzV6JgG
         FQDQ==
X-Gm-Message-State: AFqh2koKqK0sFcf1dtFsmCm7vLUdNKhJNg058MUX9rZcWec2dQ03RgEz
        65j/mE55ZusXECXozj8IvzEPOg==
X-Google-Smtp-Source: AMrXdXsjy51DXhZboLHdnZnAXdZrvh7oqPNZKA7OzP9X+CGrPBHk02u7TTaGgnMuUzRfcXg0qgAzNw==
X-Received: by 2002:a05:600c:3c94:b0:3da:f2b:d7a0 with SMTP id bg20-20020a05600c3c9400b003da0f2bd7a0mr22102913wmb.31.1674441091393;
        Sun, 22 Jan 2023 18:31:31 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm18672703wrp.58.2023.01.22.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:31:31 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v4 1/6] dt-bindings: clock: msm8939: Move msm8939 to a distinct yaml file
Date:   Mon, 23 Jan 2023 02:31:22 +0000
Message-Id: <20230123023127.1186619-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
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

The MSM8939 has two DSI controllers as opposed to the MSM8916 which has
one. As a consequence we need to document some additional clocks provided
by the MSM8939 GCC which are not provided by MSM8916.

Move the declaration of the MSM8939 super-set of clocks to an MSM8939
specific yaml file.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/clock/qcom,gcc-msm8916.yaml      |  7 +-
 .../bindings/clock/qcom,gcc-msm8939.yaml      | 87 +++++++++++++++++++
 2 files changed, 89 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
index ad84c0f7680be..016d310be3c83 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/qcom,gcc-msm8916.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller on MSM8916 and MSM8939
+title: Qualcomm Global Clock & Reset Controller on MSM8916.
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
@@ -12,19 +12,16 @@ maintainers:
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
-  domains on MSM8916 or MSM8939.
+  domains on MSM8916.
 
   See also::
     include/dt-bindings/clock/qcom,gcc-msm8916.h
-    include/dt-bindings/clock/qcom,gcc-msm8939.h
     include/dt-bindings/reset/qcom,gcc-msm8916.h
-    include/dt-bindings/reset/qcom,gcc-msm8939.h
 
 properties:
   compatible:
     enum:
       - qcom,gcc-msm8916
-      - qcom,gcc-msm8939
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.yaml
new file mode 100644
index 0000000000000..92a811d6ad97b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8939.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-msm8939.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on MSM8939.
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on MSM8939.
+
+  See also::
+    include/dt-bindings/clock/qcom,gcc-msm8939.h
+    include/dt-bindings/reset/qcom,gcc-msm8939.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,gcc-msm8939
+
+  clocks:
+    items:
+      - description: XO source
+      - description: Sleep clock source
+      - description: DSI phy instance 0 dsi clock
+      - description: DSI phy instance 0 byte clock
+      - description: DSI phy instance 1 dsi clock
+      - description: DSI phy instance 1 byte clock
+      - description: External MCLK clock
+      - description: External Primary I2S clock
+      - description: External Secondary I2S clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sleep_clk
+      - const: dsi0pll
+      - const: dsi0pllbyte
+      - const: dsi1pll
+      - const: dsi1pllbyte
+      - const: ext_mclk
+      - const: ext_pri_i2s
+      - const: ext_sec_i2s
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpm.h>
+    clock-controller@1800000 {
+      compatible = "qcom,gcc-msm8939";
+      reg = <0x01800000 0x80000>;
+      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+               <&sleep_clk>,
+               <&dsi_phy0 1>,
+               <&dsi_phy0 0>,
+               <&dsi_phy1 1>,
+               <&dsi_phy1 0>,
+               <0>,
+               <0>,
+               <0>;
+      clock-names = "xo",
+                    "sleep_clk",
+                    "dsi0pll",
+                    "dsi0pllbyte",
+                    "dsi1pll",
+                    "dsi1pllbyte",
+                    "ext_mclk",
+                    "ext_pri_i2s",
+                    "ext_sec_i2s";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
-- 
2.38.1

