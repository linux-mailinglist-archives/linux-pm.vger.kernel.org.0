Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7975F950
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGXOGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGXOGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 10:06:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695EAE63
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fdd7d09576so6553924e87.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207596; x=1690812396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5ybfHwoTLEsF2HJ7gEF4OXahwoucOAlv28KgkIosC4=;
        b=tXTQr2ipXh107BGTOvLuqTs6WomqShU2NidfbZfehxffpgCOZruifcTEZj6aMzUEMB
         FyophO7nqOz8eQKNXpjpx+g1eVNVB8GpRt849EUvsDbrn7DXkoSiv4JeDsHb/cgY6wn4
         lDgc6SrnNcJjuD92K9Bfa5vg5AbTQBSwgQSrc914hrpQusvsqpDpb2WqfDDBV9M42uvy
         PEkARF+PUbibDt7LG3l14HdYZy4FGdAWM6QWRTU5SiHrZl1cpufa3d5LypRonov0cKrL
         s0gWH54TJz7+BtpQ141/CVUeoVixSPLTK4W1foOMlGa7lwVN0MwOpEpj9Hb6itt0XgYe
         o2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207596; x=1690812396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5ybfHwoTLEsF2HJ7gEF4OXahwoucOAlv28KgkIosC4=;
        b=GnXts6kA+sduGsitGfqb2CSyRcE4YxX7gnKZW7zZjSIObVY83OmzPun2Rjzybu5pEV
         ZWjg/V0J5D64ZxoI1ugwEqiB2ZFj+TfAllvuXSQ35zxWLxR+RmpLojsv0K2KVGw5trBg
         eYgoVTGlDVkQuCflpTxWkNhoHOAPE+nvL0fh7y5yHiyEQUqxXNV6v96k9JOUdu8sl+W2
         pK/YkMbrjea2npeTOu8mDmKJVSIjMPm71auSdyGEGtDhLa6iLe8BzcAws9Y6IJTPWUtm
         Y7RB083FjsS6HcfIBvMHTknCLF0tMPfYrVEcxJOx2STpFIVhXSLBgyTwBlwyRHCQFOtI
         Ro8Q==
X-Gm-Message-State: ABy/qLYl8NRPDUQkLEiKq8PG+LLOekr00FVMl8lT4gHwE9jW/JE0cr9c
        M7SyFfF1dw1GR91nHlhT8K/zOw==
X-Google-Smtp-Source: APBJJlGuAOcAJDTDk0OfqaR/2a1nzMKFikIZ6uTU11SkGNTVJrmv4zOgYvtQzElTGjzgRV/mxlHQ6Q==
X-Received: by 2002:a05:6512:3d03:b0:4fd:faa3:2352 with SMTP id d3-20020a0565123d0300b004fdfaa32352mr1767588lfv.14.1690207596749;
        Mon, 24 Jul 2023 07:06:36 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:31 +0200
Subject: [PATCH v2 5/7] dt-bindings: interconnect: qcom: Fix and separate
 out MSM8939
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-5-e33d5acbf3bd@linaro.org>
References: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=4771;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZYvomGjfNr+knHyhMvnChz906g3MEfi9xFtU+L7sn+I=;
 b=pjrl1vIHwHk67L4VYGhjPC+HC7jLpIUyzPC+ptPLvzfgFYmqYsPvgt/SSJtzP9zVAX4VmWd9a
 XtLtydpvlQ/DPQHdm6vU6JFqm9VPM3RP/P+AY2NdKPu3LupddhvpVdx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Separate out MSM8939 icc bindings from the common file and fix the
clocks description by removing the wrong internal RPM bus clock
representation that we've been carrying for years.

This was the final one, so also retire the shared file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8939.yaml        | 74 ++++++++++++++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 49 --------------
 2 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
new file mode 100644
index 000000000000..fd15ab5014fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8939 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8939 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8939-bimc
+      - qcom,msm8939-pcnoc
+      - qcom,msm8939-snoc
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    $ref: qcom,rpm-common.yaml#
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    allOf:
+      - $ref: qcom,rpm-common.yaml#
+
+    properties:
+      compatible:
+        const: qcom,msm8939-snoc-mm
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@580000 {
+        compatible = "qcom,msm8939-snoc";
+        reg = <0x00580000 0x14000>;
+        #interconnect-cells = <1>;
+    };
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,msm8939-bimc";
+        reg = <0x00400000 0x62000>;
+        #interconnect-cells = <1>;
+
+          snoc_mm: interconnect-snoc {
+              compatible = "qcom,msm8939-snoc-mm";
+              #interconnect-cells = <1>;
+          };
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 3e1bcbbdb532..72856b1c4210 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -23,9 +23,6 @@ properties:
       - qcom,msm8916-bimc
       - qcom,msm8916-pcnoc
       - qcom,msm8916-snoc
-      - qcom,msm8939-bimc
-      - qcom,msm8939-pcnoc
-      - qcom,msm8939-snoc
       - qcom,qcs404-bimc
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
@@ -48,38 +45,6 @@ properties:
   power-domains:
     maxItems: 1
 
-# Child node's properties
-patternProperties:
-  '^interconnect-[a-z0-9]+$':
-    type: object
-    additionalProperties: false
-    description:
-      snoc-mm is a child of snoc, sharing snoc's register address space.
-
-    properties:
-      compatible:
-        enum:
-          - qcom,msm8939-snoc-mm
-
-      '#interconnect-cells':
-        const: 1
-
-      clock-names:
-        items:
-          - const: bus
-          - const: bus_a
-
-      clocks:
-        items:
-          - description: Bus Clock
-          - description: Bus A Clock
-
-    required:
-      - compatible
-      - '#interconnect-cells'
-      - clock-names
-      - clocks
-
 required:
   - compatible
   - reg
@@ -98,9 +63,6 @@ allOf:
               - qcom,msm8916-bimc
               - qcom,msm8916-pcnoc
               - qcom,msm8916-snoc
-              - qcom,msm8939-bimc
-              - qcom,msm8939-pcnoc
-              - qcom,msm8939-snoc
               - qcom,qcs404-bimc
               - qcom,qcs404-pcnoc
               - qcom,qcs404-snoc
@@ -117,17 +79,6 @@ allOf:
             - description: Bus Clock
             - description: Bus A Clock
 
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,msm8939-snoc
-    then:
-      patternProperties:
-        '^interconnect-[a-z0-9]+$': false
-
 examples:
   - |
       #include <dt-bindings/clock/qcom,rpmcc.h>

-- 
2.41.0

