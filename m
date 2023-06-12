Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEC72B771
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjFLFjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjFLFj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7AE73
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f642a24555so4544384e87.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548365; x=1689140365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie3JO8CZXhE1zFeG17UDNEd3HgBOEPkrNja1n95d20o=;
        b=d1FMaQVl/IPYQ4/s+v240NLK0h3A+WZwj13cXYx/38rdH/IdKNSJ9PQPqQ1KRaMdy6
         xxfTg7S745/dsOAbfiHF7Ykjx2RQv377tyWYd0liXnwkdu/FMauTeUh+mmSLd2plgD9N
         wXK++k/8YitboVA69BLWm0tnfEyhBXneebgcPwX91AHWRXf7JI8M4BQVIJNL9LVpk52G
         fvNcXWhayjh65jn9rXN0B0wvWGiQj59kg4zpRXEAf1zIkhpvqbnyOYssCel8X+O+1ouB
         Y5Pox/sQMl2eSfwcay1gQB/AYUyKm5AtgCip4ZZJvjoz1E4xt6KZYdgM4rnsB6pkw/vn
         HPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548365; x=1689140365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie3JO8CZXhE1zFeG17UDNEd3HgBOEPkrNja1n95d20o=;
        b=DnzucXlzM8blFGYln5fEBuvcXbNNtB46i0IN+4c0cMxkpXogPr1XMekhD1obU41S+q
         8b0WnOT4444c99fAcsAqXgZwwzplau3qOBF5x6F4AaMj7hSh6PUFJvUdCxuTDwmT5IoF
         L8JVtU+2LwGS8f/51bY+E76QwM/nlD0DZYwwyEE0ARvjzx4qSVUqLg6RALZb42LU7PG9
         lnJx89fNBJOUKaffxgyTPrIo2vDicgY55PXrF/H1Z7FuhRMM8iNNjhMRwD8Pg7UnALwC
         KoCLuxxeO9D4g93PiugzPEmCjUsbHwIgfKssSACifUg6m4ZK063SR7A4GOQb49Xv7Dai
         FV9w==
X-Gm-Message-State: AC+VfDx06m14TE6Md1m/s9q0BX0qPKqP7lpeAIx/wdhmq2Bf9lakk9Lz
        wUCMSKrwPidxotLCJrdaXUjQGg==
X-Google-Smtp-Source: ACHHUZ516kKUn6b1fekH4G/Gnj9kFxtlDoXwMpeX+bx7lhmwwGONEYmuNGzeirc+5+Q3+KjLlJ9BGA==
X-Received: by 2002:a19:914e:0:b0:4f4:deee:efaf with SMTP id y14-20020a19914e000000b004f4deeeefafmr3226962lfj.4.1686548365625;
        Sun, 11 Jun 2023 22:39:25 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:25 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 02/18] dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
Date:   Mon, 12 Jun 2023 08:39:06 +0300
Message-Id: <20230612053922.3284394-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt | 58 -------------------
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    | 22 +++++--
 2 files changed, 16 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
 rename Documentation/devicetree/bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (68%)

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
similarity index 68%
rename from Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
rename to Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index 20c8cd38ff0d..a016242367b9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -1,18 +1,26 @@
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
+
 
 properties:
   compatible:
@@ -34,8 +42,10 @@ properties:
       - const: qcom,saw2
 
   reg:
-    description: Base address and size of the SPM register region
-    maxItems: 1
+    items:
+      - description: Base address and size of the SPM register region
+      - description: Base address and size of the alias register region
+    minItems: 1
 
 required:
   - compatible
-- 
2.39.2

