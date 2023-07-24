Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40B175F948
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGXOGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjGXOGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 10:06:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC26E68
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so6663796e87.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207592; x=1690812392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTt190u0N1QwFWjCGHfNmz94BW1FFHJ667WVLMixbQo=;
        b=YflNF4JeqKJOOYkPKdweX3AKX3Dj+oDxY2cAiglm2INxV29+L65XBhiJGvlkuy899d
         lgSvFSPfonbL8raC/aYqflD4OXMawzgl5c5ayipIiEoMXIEMXovxSvLmDEbC2hIImwUi
         rMywvKQdn/qifgks8YrNKoLA6AWC+WiKZS2KQIW3Xa6C9m9is2Ifeo4QSoNSTpHSPC6P
         TYIRqM5fhGmvRjcwlsW5ksR+g748tnV1INSS6r8GqyBgC/RmL1DAMSky5xjwhhnKWXNN
         W4V4hHFwhvv9U8UifApJrKR/QWGTqcka85f7H6is10g3iDmR/LRvcXXw/eAupVgvqv3O
         NvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207592; x=1690812392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTt190u0N1QwFWjCGHfNmz94BW1FFHJ667WVLMixbQo=;
        b=X6Hlty7Dn4DvKFN9W3/ct4bvVNGE/OFvUuUq3q5nJ2LEG9Av2qu339215Vcuel/5ek
         pKzxQKSioTDBZVDhSiWFBVfT1BRSXBWJ3lcwEKkQBie4Z7bqbL1GCJvTtOKWIjUnQ5wU
         hNOLzFDYaTtMoWxhBwzyHtE+Bd3pYcxVZZCUtabXbvJ8dBkUcpJMm6e177gbU3cD+sKg
         bzWeXd9MrIP4WCicyg1fyDRet7nDZKlLRGriiVcuYg2WnCppA2F6cnhaEhX9hRIlqV2D
         l/3qXmxFLsdb7PGbjKohEanJknY+Za+LHfHicw8DtA6P2EjhT5HTG1QE7MZeCKtR05rW
         /BrA==
X-Gm-Message-State: ABy/qLaR3LP2XTooInuSytY/e+Ljj02rSBXuWa0sN/sOKBBJuOrpsxM6
        9Q0ZiKL1dc/IeTl0YQS8Lm1q0w==
X-Google-Smtp-Source: APBJJlEI3BkCxU10QyQEkNAGKeUYGBwiRIzkzZ3D8zGjegNpAsd0KLogDUB0XImlPlGh0wcALLnrxA==
X-Received: by 2002:a05:6512:159e:b0:4f8:5d94:2e46 with SMTP id bp30-20020a056512159e00b004f85d942e46mr6116933lfb.48.1690207592658;
        Mon, 24 Jul 2023 07:06:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:28 +0200
Subject: [PATCH v2 2/7] dt-bindings: interconnect: qcom: qcm2290: Remove
 RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-2-e33d5acbf3bd@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=3374;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4IKYVXKoFRbdt7TXl365xA5N1whhHztEPaI9QjYU2W0=;
 b=6yXyfTiFUJbCcWuVqdfnJ19U5BslUWuU3B7OmHi8G/ePYCMhjeHYAC8q0r0v8Ov//f8Mky7VN
 loEFR58AKHUBj8RETkX+NSJKJx3a/drBEp+WBgFBjuyEFJkFhjyMGIT
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

After the recent reshuffling, bus clocks are no longer exposed as RPM
clocks. Remove the old description.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml        | 42 ----------------------
 1 file changed, 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
index df89f390a9b0..b6c15314c5c5 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -26,16 +26,6 @@ properties:
       - qcom,qcm2290-cnoc
       - qcom,qcm2290-snoc
 
-  clock-names:
-    items:
-      - const: bus
-      - const: bus_a
-
-  clocks:
-    items:
-      - description: Bus Clock
-      - description: Bus A Clock
-
 # Child node's properties
 patternProperties:
   '^interconnect-[a-z0-9]+$':
@@ -54,28 +44,14 @@ patternProperties:
           - qcom,qcm2290-mmrt-virt
           - qcom,qcm2290-mmnrt-virt
 
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
     required:
       - compatible
-      - clock-names
-      - clocks
 
     unevaluatedProperties: false
 
 required:
   - compatible
   - reg
-  - clock-names
-  - clocks
 
 unevaluatedProperties: false
 
@@ -87,32 +63,20 @@ examples:
         compatible = "qcom,qcm2290-snoc";
         reg = <0x01880000 0x60200>;
         #interconnect-cells = <1>;
-        clock-names = "bus", "bus_a";
-        clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-                 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 
         qup_virt: interconnect-qup {
             compatible = "qcom,qcm2290-qup-virt";
             #interconnect-cells = <1>;
-            clock-names = "bus", "bus_a";
-            clocks = <&rpmcc RPM_SMD_QUP_CLK>,
-                     <&rpmcc RPM_SMD_QUP_A_CLK>;
         };
 
         mmnrt_virt: interconnect-mmnrt {
             compatible = "qcom,qcm2290-mmnrt-virt";
             #interconnect-cells = <1>;
-            clock-names = "bus", "bus_a";
-            clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
-                     <&rpmcc RPM_SMD_MMNRT_A_CLK>;
         };
 
         mmrt_virt: interconnect-mmrt {
             compatible = "qcom,qcm2290-mmrt-virt";
             #interconnect-cells = <1>;
-            clock-names = "bus", "bus_a";
-            clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
-                     <&rpmcc RPM_SMD_MMRT_A_CLK>;
         };
     };
 
@@ -120,16 +84,10 @@ examples:
         compatible = "qcom,qcm2290-cnoc";
         reg = <0x01900000 0x8200>;
         #interconnect-cells = <1>;
-        clock-names = "bus", "bus_a";
-        clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
-                 <&rpmcc RPM_SMD_CNOC_A_CLK>;
     };
 
     bimc: interconnect@4480000 {
         compatible = "qcom,qcm2290-bimc";
         reg = <0x04480000 0x80000>;
         #interconnect-cells = <1>;
-        clock-names = "bus", "bus_a";
-        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
     };

-- 
2.41.0

