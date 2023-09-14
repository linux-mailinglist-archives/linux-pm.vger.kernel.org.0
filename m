Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E660D79FC5B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjINGz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjINGz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 02:55:26 -0400
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99074CD8;
        Wed, 13 Sep 2023 23:55:21 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id DAC631C0119;
        Thu, 14 Sep 2023 08:55:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on abscue.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=4.0.0
Received: from fluffy-mammal.fritz.box (dslb-092-072-000-199.092.072.pools.vodafone-ip.de [92.72.0.199])
        by srv01.abscue.de (Postfix) with ESMTPSA id 716A91C3D97;
        Thu, 14 Sep 2023 08:55:18 +0200 (CEST)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v3 1/3] dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
Date:   Thu, 14 Sep 2023 08:54:21 +0200
Message-Id: <20230914065422.5452-2-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914065422.5452-1-otto.pflueger@abscue.de>
References: <20230914065422.5452-1-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSM8917, MSM8937 and QM215 SoCs have VDDCX and VDDMX power domains
controlled in voltage level mode. Define the MSM8937 and QM215 power
domains as aliases because these SoCs are similar to MSM8917 and may
share some parts of the device tree.

Also add the compatibles for these SoCs to the documentation, with
qcom,msm8937-rpmpd using qcom,msm8917-rpmpd as a fallback compatible
because there are no known differences. QM215 is not compatible with
these because it uses different regulators.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml | 79 ++++++++++---------
 include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
 2 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 9b03c41d3604..65ebe7866d7e 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -15,42 +15,49 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,mdm9607-rpmpd
-      - qcom,msm8226-rpmpd
-      - qcom,msm8909-rpmpd
-      - qcom,msm8916-rpmpd
-      - qcom,msm8939-rpmpd
-      - qcom,msm8953-rpmpd
-      - qcom,msm8976-rpmpd
-      - qcom,msm8994-rpmpd
-      - qcom,msm8996-rpmpd
-      - qcom,msm8998-rpmpd
-      - qcom,qcm2290-rpmpd
-      - qcom,qcs404-rpmpd
-      - qcom,qdu1000-rpmhpd
-      - qcom,sa8155p-rpmhpd
-      - qcom,sa8540p-rpmhpd
-      - qcom,sa8775p-rpmhpd
-      - qcom,sdm660-rpmpd
-      - qcom,sc7180-rpmhpd
-      - qcom,sc7280-rpmhpd
-      - qcom,sc8180x-rpmhpd
-      - qcom,sc8280xp-rpmhpd
-      - qcom,sdm670-rpmhpd
-      - qcom,sdm845-rpmhpd
-      - qcom,sdx55-rpmhpd
-      - qcom,sdx65-rpmhpd
-      - qcom,sdx75-rpmhpd
-      - qcom,sm6115-rpmpd
-      - qcom,sm6125-rpmpd
-      - qcom,sm6350-rpmhpd
-      - qcom,sm6375-rpmpd
-      - qcom,sm8150-rpmhpd
-      - qcom,sm8250-rpmhpd
-      - qcom,sm8350-rpmhpd
-      - qcom,sm8450-rpmhpd
-      - qcom,sm8550-rpmhpd
+    oneOf:
+      - enum:
+          - qcom,mdm9607-rpmpd
+          - qcom,msm8226-rpmpd
+          - qcom,msm8909-rpmpd
+          - qcom,msm8916-rpmpd
+          - qcom,msm8917-rpmpd
+          - qcom,msm8939-rpmpd
+          - qcom,msm8953-rpmpd
+          - qcom,msm8976-rpmpd
+          - qcom,msm8994-rpmpd
+          - qcom,msm8996-rpmpd
+          - qcom,msm8998-rpmpd
+          - qcom,qcm2290-rpmpd
+          - qcom,qcs404-rpmpd
+          - qcom,qdu1000-rpmhpd
+          - qcom,qm215-rpmpd
+          - qcom,sa8155p-rpmhpd
+          - qcom,sa8540p-rpmhpd
+          - qcom,sa8775p-rpmhpd
+          - qcom,sc7180-rpmhpd
+          - qcom,sc7280-rpmhpd
+          - qcom,sc8180x-rpmhpd
+          - qcom,sc8280xp-rpmhpd
+          - qcom,sdm660-rpmpd
+          - qcom,sdm670-rpmhpd
+          - qcom,sdm845-rpmhpd
+          - qcom,sdx55-rpmhpd
+          - qcom,sdx65-rpmhpd
+          - qcom,sdx75-rpmhpd
+          - qcom,sm6115-rpmpd
+          - qcom,sm6125-rpmpd
+          - qcom,sm6350-rpmhpd
+          - qcom,sm6375-rpmpd
+          - qcom,sm8150-rpmhpd
+          - qcom,sm8250-rpmhpd
+          - qcom,sm8350-rpmhpd
+          - qcom,sm8450-rpmhpd
+          - qcom,sm8550-rpmhpd
+      - items:
+          - enum:
+              - qcom,msm8937-rpmpd
+          - const: qcom,msm8917-rpmpd
 
   '#power-domain-cells':
     const: 1
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 83be996cb5eb..7f4e2983a4c5 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -278,6 +278,27 @@
 #define MSM8909_VDDMX		MSM8916_VDDMX
 #define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
 
+/* MSM8917 Power Domain Indexes */
+#define MSM8917_VDDCX		0
+#define MSM8917_VDDCX_AO	1
+#define MSM8917_VDDCX_VFL	2
+#define MSM8917_VDDMX		3
+#define MSM8917_VDDMX_AO	4
+
+/* MSM8937 Power Domain Indexes */
+#define MSM8937_VDDCX		MSM8917_VDDCX
+#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
+#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
+#define MSM8937_VDDMX		MSM8917_VDDMX
+#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
+
+/* QM215 Power Domain Indexes */
+#define QM215_VDDCX		MSM8917_VDDCX
+#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
+#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
+#define QM215_VDDMX		MSM8917_VDDMX
+#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
+
 /* MSM8953 Power Domain Indexes */
 #define MSM8953_VDDMD		0
 #define MSM8953_VDDMD_AO	1
-- 
2.39.1
