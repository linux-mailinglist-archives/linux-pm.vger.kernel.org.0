Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434B789DAA
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjH0LvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjH0Lum (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131119F
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500b6456c7eso500911e87.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137035; x=1693741835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QilGo2cKamjRbsFJs2rg0xLXZ8zR1vTxwGMlWkCLlFo=;
        b=T3P5AiTSCX5RpK2R7xLe4ZbH1tME377lor7YXPNjC37fGtWJ42KlLewwjr3UR8eOe3
         vaOulIUgywNvYz+S2wDShhlr9zuwHf3YX67eS53ANzPaLtLZw3JpPWCiGkOxSsSdUYL8
         DH3xgHHbkOpN/aGTBLkWYhBJjbe/OSFfAGqXrVmgyoCWCoCTZ0dQ6njvMAcTVAHnaoIh
         1cMuuWyZ71ljeJpS7cGHAwImSaj234j1zg1sAoGkG5GEbv4ejifkSaGvExs6Tc45Mryy
         iuaqZM5JKS3yEAXGAWUTi+kp7LLqPuRkX3nCeGXExGHysPGrXqdlbuj6mra5ZPdWWsoi
         B8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137035; x=1693741835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QilGo2cKamjRbsFJs2rg0xLXZ8zR1vTxwGMlWkCLlFo=;
        b=B1sdbXvwWCSFWo0honIsE9WDQCC3KEBWiJGXsg3WSqvEOnv3ru5thamGd3NxEgPvd4
         wNydXBW8R1A/Ii/XPtHYAbYOb0awGe5dS1DOZ0WemzDYawqVI3Kec9AhgRcEbkSO3tZU
         izlLynFK0Pa8sn26soFrYEHIyLwQSS5EDcHy0cAilxBKCeeuUGIiIah5i/gFc3rSo3dX
         BHTfogREIMjMr0vC7E3KP8xdR9vQNesDQsMPoTQ7Z6ZZ+D6iuUblRNaRA2eL5qL6ZuSH
         g5V9TC6yG4SvuhB8EKwq4/5WYabUdnugtGBvrgZg5Kqrj9nC32TpsIvvIbNLfwRCZ+IW
         IFTA==
X-Gm-Message-State: AOJu0YxLWJZlw9dYxvU33xLy8C0xRMtS1eq3NjvEZJyHOEG3CjKfWzaB
        CXvystOd/htTfu8h5ZQCntkDSw==
X-Google-Smtp-Source: AGHT+IGl5MduPxL5W7j/gTGahht78xN2EIeyQS3zhPxoOY8LmpHwOTWvx0qvJjWqBjoJyWAzfxkDFw==
X-Received: by 2002:ac2:4a6e:0:b0:4fb:9e1a:e592 with SMTP id q14-20020ac24a6e000000b004fb9e1ae592mr14393826lfp.4.1693137035473;
        Sun, 27 Aug 2023 04:50:35 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:34 -0700 (PDT)
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
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/23] dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
Date:   Sun, 27 Aug 2023 14:50:11 +0300
Message-Id: <20230827115033.935089-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

