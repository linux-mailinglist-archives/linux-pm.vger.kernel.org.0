Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623B7C94C4
	for <lists+linux-pm@lfdr.de>; Sat, 14 Oct 2023 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNNim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Oct 2023 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjJNNil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Oct 2023 09:38:41 -0400
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F71C9;
        Sat, 14 Oct 2023 06:38:37 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id C72B11C071D;
        Sat, 14 Oct 2023 15:38:33 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from fluffy-mammal.fritz.box (dslb-088-078-204-065.088.078.pools.vodafone-ip.de [88.78.204.65])
        by srv01.abscue.de (Postfix) with ESMTPSA id 42FFF1C071C;
        Sat, 14 Oct 2023 15:38:33 +0200 (CEST)
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
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
Date:   Sat, 14 Oct 2023 15:38:21 +0200
Message-Id: <20231014133823.14088-2-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231014133823.14088-1-otto.pflueger@abscue.de>
References: <20231014133823.14088-1-otto.pflueger@abscue.de>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml | 81 ++++++++++---------
 include/dt-bindings/power/qcom-rpmpd.h        | 21 +++++
 2 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 53886f02d98a..d38c762e1280 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -15,43 +15,50 @@ description:
 
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
-      - qcom,sm7150-rpmhpd
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
+          - qcom,sm7150-rpmhpd
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
2.39.2
