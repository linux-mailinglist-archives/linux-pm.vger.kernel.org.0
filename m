Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABAB5119B8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiD0M5n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiD0M5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 08:57:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FC4B416
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:54:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y19so2505190ljd.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CD6s+CKM0qw483KM9f77QNJM9WemRPJ6px/m7jRW/JI=;
        b=JqSGjqzr+hLzEjeT8lRdBlb+lQbIBMJk3Djd7jAaByG5X0CnnndLP2ekAHxEyrn1uO
         9+0wZT+vD2gcFiG8ON3U/jBvcN8uu+Si74EzQNzwq/lvJMX0okn+NvA7OFPgcwQeVMdS
         6AZunO/0y38ceCcIovCShPqcanNOMn7jGF2LiY7Wu3HRK1mssM50Wi896+SRgiKjlxQM
         jnJmrug1qfF8uscs5+y8Vk9Zi7c1bwp5S07x+UucjqzJ1rPK3VH+vCwPhCP/DReLXhr0
         VwbUBrnFG4kxTLGGCezvsT98Ek880HH+CIPhp6en01L2LtnSkTm3O6BiNU28b5ngQvXa
         AMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CD6s+CKM0qw483KM9f77QNJM9WemRPJ6px/m7jRW/JI=;
        b=yJutcV0NfPylcTvhCN+hagFcNB6+U+kZUMCPZxCr4NecgF0mIYBMgysoFo1wEStXG0
         ZpHCUR1FJeRzVkSZ+PcxuJGBUTmUU+qpoy3tmSLRcShMlipH2fnoSBq+NWBweYOdvvgi
         Je2BnzK8zD5gfrLcwmLvb49wN4cUEL2kY2wcWv7yn8ydsc38m2YvIF2aF1y7QItRtv82
         ABvIybX3iaKHOKu9kDVad/iYhzi94kfSOYNNfmwt/SHK75d2y9ZEfltoU/PtAZmkwZv8
         6VnVB3F24qS9/t5BAKUEX0LNr6xwiAAnQ/j+clRkDN0Ja8J0uMFriFDyc58L/5pZ9syl
         IWwg==
X-Gm-Message-State: AOAM533FixkOwe7i+GXUF3c+8MpvK+K/qBhAgrqdgfo+DwC87N9K24Z+
        +QQhAhskEph60XtfaWn9QeSHOg==
X-Google-Smtp-Source: ABdhPJyUxaSp9cwghU8x3E1eI7nUbeicLMufXu7FXUagMLiRmRhwtqKcQoEEZWJTTvlJeWZomS4qIQ==
X-Received: by 2002:a2e:bf25:0:b0:247:d216:43fc with SMTP id c37-20020a2ebf25000000b00247d21643fcmr17916153ljr.520.1651064067761;
        Wed, 27 Apr 2022 05:54:27 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e94c9000000b0024b4c2a1346sm1827445ljh.123.2022.04.27.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:54:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_tdas@quicinc.com
Subject: [PATCH v5 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens to the child node
Date:   Wed, 27 Apr 2022 15:54:23 +0300
Message-Id: <20220427125423.3166138-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427125423.3166138-1-dmitry.baryshkov@linaro.org>
References: <20220427125423.3166138-1-dmitry.baryshkov@linaro.org>
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

Split tsens properties to the child node of the gcc. This follows the
lead of ipq8064 (which also uses a separate node for tsens) and makes
device tree closer to other platforms, where tsens is a completely
separate device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 49 +++++++++----------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index bd7b04c75e50..3a8bb5a5b37f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -23,47 +23,42 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,gcc-apq8064
-      - qcom,gcc-msm8960
-
-  nvmem-cells:
-    minItems: 1
-    maxItems: 2
-    description:
-      Qualcomm TSENS (thermal sensor device) on some devices can
-      be part of GCC and hence the TSENS properties can also be part
-      of the GCC/clock-controller node.
-      For more details on the TSENS properties please refer
-      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
-
-  nvmem-cell-names:
-    minItems: 1
     items:
-      - const: calib
-      - const: calib_backup
+      - enum:
+          - qcom,gcc-apq8064
+          - qcom,gcc-msm8960
+      - const: syscon
+
+  thermal-sensor:
+    type: object
 
-  '#thermal-sensor-cells':
-    const: 1
+    allOf:
+      - $ref: /schemas/thermal/qcom-tsens.yaml#
 
 required:
   - compatible
-  - nvmem-cells
-  - nvmem-cell-names
-  - '#thermal-sensor-cells'
 
 unevaluatedProperties: false
 
 examples:
   - |
     clock-controller@900000 {
-      compatible = "qcom,gcc-apq8064";
+      compatible = "qcom,gcc-apq8064", "syscon";
       reg = <0x00900000 0x4000>;
-      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-      nvmem-cell-names = "calib", "calib_backup";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      #thermal-sensor-cells = <1>;
+
+      thermal-sensor {
+        compatible = "qcom,msm8960-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <0 178 4>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+      };
     };
 ...
-- 
2.35.1

