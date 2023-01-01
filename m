Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A065AB3C
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAATkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjAATkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AB109F
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so38888217lfb.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2R1E7FKbzS0tXOIRc1V3iJlpTV21XWEY+jRsfjYJ6o=;
        b=InWyEUrJzk066ProOnMp49Vz9975UdgJFUUbYW+HKON5Z5DxI/MqCgC5aT9BY9/Q5o
         XEvxAK7g6EbBlk/pbW+PhvVdwz2Zes5ipROhsTy8Cc9FQ6vnTngi1rEWF54P3X/CnTQ9
         56RHmeSXIpdvP0E3kGVHMCxwsOGu75Ym6XpGRfe4YDOqj8ChWtAuov7AgDl93cer3cYv
         xQt01gK4kqO0sqrFYZz84dGU2cmzmQxBCpWiSxR1H1BO6srs5S3hqxonDctBffaKYtuq
         3zav8/ZIB371UQ4TQ/JAQj3sTrCpElxpbeE/r0veENowiFx/WolRXbDfKS7CAHgm5bAS
         RGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2R1E7FKbzS0tXOIRc1V3iJlpTV21XWEY+jRsfjYJ6o=;
        b=Ji8qlo59VhFutjD/TgDrJqCasP8beUttbIN12sgW0rb+kE2u9NgVXuWpKKp8lrNS5s
         vEzlPHV2A+3H9fMj28+PqULtC/Rvr83NYGVM3zFQ0fkrAkRxaTH36Qbk2tdJVUDVV9LR
         wUZy/XtMlSjF9kfv3oW+2fpIqPWnmL3KKOtr4brLZUc8gYgHxCaBVu9SecyeyWi1t2Pd
         2/UamOYkXGnIKDwdUVT1n4dXHjMxxqxxn8121i8TMZHwV3oynN3olYJ8ottVJJ22FTDl
         6jEsevIhkVf8HOJBG77T0oohQc6kt2tD+L0J5rik4ocHLe52Xrx929XPY4SfPO56a2G3
         80jg==
X-Gm-Message-State: AFqh2ko3fYmt+kVxIr66Tkeekgq4kyE8xTs45SBrjaNP/T9TaxfgkOPO
        /hL4AYAO1uxzYuzbcWyO8DFDlw==
X-Google-Smtp-Source: AMrXdXvHOiLE8gu/Jk1Zqwmj0Vpx+502enLW0ksTiN+oCaSvNF5lp5Pd2QyGBv1pAlLjo2F8x5GM+Q==
X-Received: by 2002:a05:6512:22c3:b0:4b5:76a2:8ad4 with SMTP id g3-20020a05651222c300b004b576a28ad4mr12009564lfu.0.1672602037889;
        Sun, 01 Jan 2023 11:40:37 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:37 -0800 (PST)
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
Subject: [PATCH v6 02/20] dt-bindings: thermal: tsens: support per-sensor calibration cells
Date:   Sun,  1 Jan 2023 21:40:16 +0200
Message-Id: <20230101194034.831222-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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
 .../bindings/thermal/qcom-tsens.yaml          | 94 +++++++++++++++++--
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f3660af0b3bf..878e1d1bf6c5 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -81,18 +81,62 @@ properties:
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
+          - const: mode
+          - const: base1
+          - const: base2
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
+          - pattern: '^s[0-9]+_p1$'
+          - pattern: '^s[0-9]+_p2$'
 
   "#qcom,sensors":
     description:
@@ -221,6 +265,36 @@ examples:
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

