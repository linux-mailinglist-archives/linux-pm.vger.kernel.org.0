Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C873D3BA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFYUZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFYUZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:25:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3BFE52
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so636825e87.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724751; x=1690316751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2Nz0ILPn3EOKaQkWVWab6M25ZwY+ZxoTLvBh9FKz8o=;
        b=iHoYbuvZhuPZTnglBCNcuLHF79uhlqOvP7dE81aDEKrCplUjQC9DEw223eqOOZmfjL
         xWUwpB8FiJoARTkuofkj1DhMRqnMTXmntJuwlOBtNgR8g4J6CDSX/dwX0F4WUKDJOlYC
         diXD1lVDI5c72kzm8srv0/5aIzCwQsdMh0Auh039Zcw97ldndgE7YhsNj6cYRO09tqwS
         5vbBzndYhN0+EocERdet702eydlvA7WGcbN4iJ5tc7x5xwI9s7ObwjEa54BNJdGjbISX
         nepMXPsELwjzjoTf10LwcXW7WorBZN4Qy+q1oRLosRnryY+uSxLPg30DSIdrpSIQ3cIP
         GE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724751; x=1690316751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2Nz0ILPn3EOKaQkWVWab6M25ZwY+ZxoTLvBh9FKz8o=;
        b=Ac92NFldvXFT2g5FxbWwi3pKBA83/fQGkISD7kdGuIIs7DwJgX0BmDKCSJ+FzTR1AG
         ferAHgKQXdrcb20XdWTCSCAZsz9JvTP7qsOSNZQSzCInB63BCMhHayGI8+Ok+HKnpT9o
         R2N0Erz2hlQpalmG36t2mAMLJuEnjQQHCu92fslWLZvVq9bCQ7NQFwvlu/CePFJ9YqIX
         A0qLnwBrjjEod+IXTsb0qnklh1MSE/oD6If9oRKqbiF8cG33WCBtZzOhmebYGCTAINnS
         jLP/mkgKC8IA4r6e1nLmjcYKcNKwfxEb2i9l9aR6Pq1urKC86P5n8IJQLEvGpXKmNTTT
         i1Ow==
X-Gm-Message-State: AC+VfDx1c9rQkz2ZbHfk6T4zTrZbfJCqy+OIDfKe+qphrQrlnZT+y8f4
        kkuXJHlYbw3YpdncMJpC+961xQ==
X-Google-Smtp-Source: ACHHUZ6Mgbq0WTTe1FZF23x/VuJ9Cvbn9txxpD+uM9o8/8VD9zcT+uWuAd/VHmrMifKmSNOM293P3g==
X-Received: by 2002:a19:5e01:0:b0:4f6:45af:70b8 with SMTP id s1-20020a195e01000000b004f645af70b8mr14700353lfb.58.1687724750738;
        Sun, 25 Jun 2023 13:25:50 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:25:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 02/26] dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
Date:   Sun, 25 Jun 2023 23:25:23 +0300
Message-Id: <20230625202547.174647-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SPM / SAW2 device is described in two bindigns files:
arm/msm/qcom,saw2.txt and soc/qcom/qcom,spm.yaml. Merge the former into
the latter, adding detailed device node description. While we are at it,
also rename qcom,spm.yaml to qcom,saw2.yaml to follow the actual
compatible used for these devices.

The regulator property is retained as is. It will be changed in the
later patches.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt | 58 -------------------
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    | 26 +++++++--
 2 files changed, 20 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (64%)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
deleted file mode 100644
index c0e3c3a42bea..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-SPM AVS Wrapper 2 (SAW2)
-
-The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
-Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
-power-controller that transitions a piece of hardware (like a processor or
-subsystem) into and out of low power modes via a direct connection to
-the PMIC. It can also be wired up to interact with other processors in the
-system, notifying them when a low power state is entered or exited.
-
-Multiple revisions of the SAW hardware are supported using these Device Nodes.
-SAW2 revisions differ in the register offset and configuration data. Also, the
-same revision of the SAW in different SoCs may have different configuration
-data due the differences in hardware capabilities. Hence the SoC name, the
-version of the SAW hardware in that SoC and the distinction between cpu (big
-or Little) or cache, may be needed to uniquely identify the SAW register
-configuration and initialization data. The compatible string is used to
-indicate this parameter.
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Must have
-			"qcom,saw2"
-		    A more specific value could be one of:
-			"qcom,apq8064-saw2-v1.1-cpu"
-			"qcom,msm8226-saw2-v2.1-cpu"
-			"qcom,msm8974-saw2-v2.1-cpu"
-			"qcom,apq8084-saw2-v2.1-cpu"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first element specifies the base address and size of
-		    the register region. An optional second element specifies
-		    the base address and size of the alias register region.
-
-- regulator:
-	Usage: optional
-	Value type: boolean
-	Definition: Indicates that this SPM device acts as a regulator device
-			device for the core (CPU or Cache) the SPM is attached
-			to.
-
-Example 1:
-
-	power-controller@2099000 {
-		compatible = "qcom,saw2";
-		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-		regulator;
-	};
-
-Example 2:
-	saw0: power-controller@f9089000 {
-		compatible = "qcom,apq8084-saw2-v2.1-cpu", "qcom,saw2";
-		reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
similarity index 64%
rename from Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
rename to Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index 20c8cd38ff0d..84b3f01d590c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -1,18 +1,25 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/qcom/qcom,spm.yaml#
+$id: http://devicetree.org/schemas/soc/qcom/qcom,saw2.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Subsystem Power Manager
+title: Qualcomm Subsystem Power Manager / SPM AVS Wrapper 2 (SAW2)
 
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description: |
-  This binding describes the Qualcomm Subsystem Power Manager, used to control
-  the peripheral logic surrounding the application cores in Qualcomm platforms.
+  The Qualcomm Subsystem Power Manager is used to control the peripheral logic
+  surrounding the application cores in Qualcomm platforms.
+
+  The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
+  Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
+  power-controller that transitions a piece of hardware (like a processor or
+  subsystem) into and out of low power modes via a direct connection to
+  the PMIC. It can also be wired up to interact with other processors in the
+  system, notifying them when a low power state is entered or exited.
 
 properties:
   compatible:
@@ -34,8 +41,15 @@ properties:
       - const: qcom,saw2
 
   reg:
-    description: Base address and size of the SPM register region
-    maxItems: 1
+    items:
+      - description: Base address and size of the SPM register region
+      - description: Base address and size of the alias register region
+    minItems: 1
+
+  regulator:
+    type: boolean
+    description: Indicates that this SPM device acts as a regulator device
+      device for the core (CPU or Cache) the SPM is attached to.
 
 required:
   - compatible
-- 
2.39.2

