Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0426588DB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiL2DBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiL2DBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:14 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123571262D
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt23so9256432lfb.5
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQC77o1FQ6x+sO5i53MSeUlSerRJ/SnuijWB6BEfiO4=;
        b=O4kAzByERa1OqR2Q0xmjHCgMPp+eb8F5mJDTq4E6YnAYFR1Tg1rwjtWiO+yN7IaSXH
         6C87t6weOE/K0CN/S4MaCYT9ZFnn1neDGZjnEngL+T5qtUKe2xR4+W7a3+toSXXVwfYe
         sXG/Ss4VLma6910CvTNwK1E9F2rHHAzsCYHUPYxOB3eL9WfHh51ecQ/aMuCQ8p/mOCN3
         +oF41J+q7VpQlLD3tHvegwREzMTPHCWS3gNE6kw+1UWZ7oUGXQyrrnYNeB4tqQm8QuxR
         Kiv8TH+zWRCRAT4x2ToD2oSuEWuhWJNDl9Wd+CDWE7TfiOWLswogGiUJlYHadBoVf1g1
         65Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQC77o1FQ6x+sO5i53MSeUlSerRJ/SnuijWB6BEfiO4=;
        b=gEuKkWhpZWBkcWMWRBarYY8ccwzmWGi62SG4qpJvgDozgjbaIlUdKTcnoOqCsfZYed
         CjZgxSKFrvXrdOELTkawtN3bM2rU+Dxm9DhyAHoYI1Zxu+DGp7DielxU709dJ1enAV+b
         9bK9389Z3B1jPTgHYW9ObnSTh12X9pZkINKg9uF6NU3TMRBoV5SonGis4wAfHqY+C5GE
         vp4Fu1b6UH8KjzWqv0gWEfsESiOoA92KfJy6w74zN+n3Ou9nU8eqNWN6cF0u04yw8J1E
         Of0zWf64o9ZqtIcwg0ZofL+Mu3VzWZvpzBHRvgNpdeNYyQ9Zi8eVg6U4B6hwmvjegaVg
         xfCw==
X-Gm-Message-State: AFqh2koUHsNnlSjtkkzAafl+Kv7CQ4WlnHx9JqXE81vUblktMWRlGCK1
        KBCzTEFZE7XCZ1O+ePP1wkW9QA==
X-Google-Smtp-Source: AMrXdXtrUrIMpv6pzh7a6gjmuGJFEyKjFSyrIofk4EQv0sGYW35xSE3OCcjNy6i16nSO8fXBxYVC3Q==
X-Received: by 2002:ac2:5f49:0:b0:4b6:ebbc:3d3a with SMTP id 9-20020ac25f49000000b004b6ebbc3d3amr7074162lfz.53.1672282869294;
        Wed, 28 Dec 2022 19:01:09 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:08 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 02/20] dt-bindings: thermal: tsens: support per-sensor calibration cells
Date:   Thu, 29 Dec 2022 05:00:48 +0200
Message-Id: <20221229030106.3303205-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow specifying the exact calibration mode and calibration data as nvmem
cells, rather than specifying just a single calibration data blob.

Note, unlike the vendor kernel the calibration data uses hw_ids rather
than software sensor indices (to match actual tsens usage in
thermal zones).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 95 +++++++++++++++++--
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f3660af0b3bf..4bb689f4602d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -81,18 +81,63 @@ properties:
     maxItems: 2
 
   nvmem-cells:
-    minItems: 1
-    maxItems: 2
-    description:
-      Reference to an nvmem node for the calibration data
+    oneOf:
+      - minItems: 1
+        maxItems: 2
+        description:
+          Reference to an nvmem node for the calibration data
+      - minItems: 5
+        maxItems: 35
+        description: |
+          Reference to nvmem cells for the calibration mode, two calibration
+          bases and two cells per each sensor
 
   nvmem-cell-names:
-    minItems: 1
-    items:
-      - const: calib
-      - enum:
-          - calib_backup
-          - calib_sel
+    oneOf:
+      - minItems: 1
+        items:
+          - const: calib
+          - enum:
+              - calib_backup
+              - calib_sel
+      - minItems: 5
+        items:
+          enum:
+            - mode
+            - base1
+            - base2
+            - s0_p1
+            - s0_p2
+            - s1_p1
+            - s1_p2
+            - s2_p1
+            - s2_p2
+            - s3_p1
+            - s3_p2
+            - s4_p1
+            - s4_p2
+            - s5_p1
+            - s5_p2
+            - s6_p1
+            - s6_p2
+            - s7_p1
+            - s7_p2
+            - s8_p1
+            - s8_p2
+            - s9_p1
+            - s9_p2
+            - s10_p1
+            - s10_p2
+            - s11_p1
+            - s11_p2
+            - s12_p1
+            - s12_p2
+            - s13_p1
+            - s13_p2
+            - s14_p1
+            - s14_p2
+            - s15_p1
+            - s15_p2
 
   "#qcom,sensors":
     description:
@@ -221,6 +266,36 @@ examples:
           };
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 1 (new calbiration data: for pre v1 IP):
+    thermal-sensor@900000 {
+        compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
+        reg = <0x4a9000 0x1000>, /* TM */
+              <0x4a8000 0x1000>; /* SROT */
+
+        nvmem-cells = <&tsens_mode>,
+                      <&tsens_base1>, <&tsens_base2>,
+                      <&tsens_s0_p1>, <&tsens_s0_p2>,
+                      <&tsens_s1_p1>, <&tsens_s1_p2>,
+                      <&tsens_s2_p1>, <&tsens_s2_p2>,
+                      <&tsens_s4_p1>, <&tsens_s4_p2>,
+                      <&tsens_s5_p1>, <&tsens_s5_p2>;
+        nvmem-cell-names = "mode",
+                           "base1", "base2",
+                           "s0_p1", "s0_p2",
+                           "s1_p1", "s1_p2",
+                           "s2_p1", "s2_p2",
+                           "s4_p1", "s4_p2",
+                           "s5_p1", "s5_p2";
+
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <5>;
+        #thermal-sensor-cells = <1>;
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.39.0

