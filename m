Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF475C876
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGUNyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGUNyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 09:54:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3D273E
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 06:54:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b743161832so28685421fa.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947663; x=1690552463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmfN4SKKWgK9SW4qxPnUm0MpTFrsYug3xDM0d387yPI=;
        b=F83EroK6OBml0MUgVeu7s6BDBA2sDqis1LjO3BCG83C1QnRV576crNGuUGN8QEfEFs
         cA6gmQooMkR/UXjI4RrOksOoqgGlmFtx9+bZuByvnhqQ3Cow86wl3iRV2TYd5sgrsX7h
         94zQlXi3ObNnpJ2F/wLn7Z+uiuzJKY8CTS2mKzjSz/WDYxH5SuutdHfMuuCW8D72kqqY
         iVnMnkxxMGiMFjp4Z8T0brtjFelyTgY9Ic0gzbs88sNHaPkENAoenI02XCztPEr3IoEi
         YaH1YjRFD9JATxXZ3xjDY4uzSPvYkvAvgTv0tHlcDlyDjPj3BHH7yFsIkrk5rqj3vlzm
         grNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947663; x=1690552463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmfN4SKKWgK9SW4qxPnUm0MpTFrsYug3xDM0d387yPI=;
        b=Msx1yLIwZGzct+u0i7H0kokMZvT4kEMtELjJ3sIGOxzW1s+tPCSHrfYJ0AtVokXLYS
         jHBHPmYLNnQqt+afYrZHLb/DXgYsPFi+FD9FIM/CuNZPgXdi2058Zua/s1NXb+5II6Kj
         40sVdzbYUvto8Mw9ah8LyjSdxnw+XgM5C8oMnPDtlPC6JCvO3wzsUNG3vDFrtoCySHOX
         eojPzuPQw7qxR3Q9FwLP4/OZYQxeXNrbHxcxBHilMMFiohWxqpz0iuihjT4p4VVa5IHz
         lhJDn12wCvdgnuF49av428MKqlc698HnIEwZzpMMvdytWaFZ8xKiN8klDLYWD9y8WC8m
         WYDw==
X-Gm-Message-State: ABy/qLaEqUe6XbkUR/cyiA6aumMJMeVq47R7u6QLyN4XcxmOj6dPt2at
        1+FSxNVKTTHutwkTJpthntexKw==
X-Google-Smtp-Source: APBJJlEeCRdAr8ZuAcMFq9XoN7de/HE4jIYhsQ68vKch3Vx7KOpkJ4MlKcbdHlqCNZaALTvEoVh0YQ==
X-Received: by 2002:a2e:968e:0:b0:2b7:b9ca:3eda with SMTP id q14-20020a2e968e000000b002b7b9ca3edamr1808428lji.34.1689947663696;
        Fri, 21 Jul 2023 06:54:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id k21-20020a2e92d5000000b002b6ad323248sm953838ljh.10.2023.07.21.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:54:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 15:54:13 +0200
Subject: [PATCH 3/7] dt-bindings: interconnect: qcom: Fix and separate out
 MSM8916
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v1-3-93e2bc728fb7@linaro.org>
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689947656; l=4542;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rv/Btqa2ja+j05knCsIBBCAEjs5ZCyG116l9ptPC73c=;
 b=KBUDXhd297a2ySmSIc5WkgT3ReFiitE47DKx9LMZ3QeuCQelgVINMcJtrGsw1Sg7PhEC4BAZR
 kns54i10YIODIR5OxcZkKammUDkZnCk2ECDGcLLHVUOsULB8kJrAHEh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Separate out MSM8916 icc bindings and fix the clocks description by
removing the wrong internal RPM bus clock representation that we've
been carrying for years.

Replace the example in qcom,rpm.yaml with MSM8939 to keep it relevant
to the file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8916.yaml        | 52 ++++++++++++++++++++++
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 24 +++++-----
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
new file mode 100644
index 000000000000..49baf808c087
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8916.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8916 Network-On-Chip interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Qualcomm MSM8916 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8916-bimc
+      - qcom,msm8916-pcnoc
+      - qcom,msm8916-snoc
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
+        compatible = "qcom,msm8916-snoc";
+        reg = <0x00580000 0x14000>;
+        #interconnect-cells = <1>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,msm8916-pcnoc";
+        reg = <0x00500000 0x11000>;
+        #interconnect-cells = <1>;
+    };
+
+    bimc: interconnect@400000 {
+        compatible = "qcom,msm8916-bimc";
+        reg = <0x00400000 0x62000>;
+        #interconnect-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 4f95d512012a..788c5e88445a 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -20,9 +20,6 @@ properties:
 
   compatible:
     enum:
-      - qcom,msm8916-bimc
-      - qcom,msm8916-pcnoc
-      - qcom,msm8916-snoc
       - qcom,msm8939-bimc
       - qcom,msm8939-pcnoc
       - qcom,msm8939-snoc
@@ -109,9 +106,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,msm8916-bimc
-              - qcom,msm8916-pcnoc
-              - qcom,msm8916-snoc
               - qcom,msm8939-bimc
               - qcom,msm8939-pcnoc
               - qcom,msm8939-snoc
@@ -254,7 +248,7 @@ examples:
       #include <dt-bindings/clock/qcom,rpmcc.h>
 
       bimc: interconnect@400000 {
-              compatible = "qcom,msm8916-bimc";
+              compatible = "qcom,msm8939-bimc";
               reg = <0x00400000 0x62000>;
               #interconnect-cells = <1>;
               clock-names = "bus", "bus_a";
@@ -263,7 +257,7 @@ examples:
       };
 
       pcnoc: interconnect@500000 {
-              compatible = "qcom,msm8916-pcnoc";
+              compatible = "qcom,msm8939-pcnoc";
               reg = <0x00500000 0x11000>;
               #interconnect-cells = <1>;
               clock-names = "bus", "bus_a";
@@ -272,10 +266,18 @@ examples:
       };
 
       snoc: interconnect@580000 {
-              compatible = "qcom,msm8916-snoc";
-              reg = <0x00580000 0x14000>;
-              #interconnect-cells = <1>;
+              compatible = "qcom,msm8939-snoc";
+              reg = <0x00580000 0x14080>;
               clock-names = "bus", "bus_a";
               clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
                        <&rpmcc RPM_SMD_SNOC_A_CLK>;
+              #interconnect-cells = <1>;
+
+              snoc_mm: interconnect-snoc {
+                      compatible = "qcom,msm8939-snoc-mm";
+                      clock-names = "bus", "bus_a";
+                      clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
+                               <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
+                      #interconnect-cells = <1>;
+              };
       };

-- 
2.41.0

