Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEE3AF4DE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhFUSXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFUSXO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:23:14 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47AC0D9439;
        Mon, 21 Jun 2021 11:10:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 71BF03ED53;
        Mon, 21 Jun 2021 20:10:20 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v6 5/5] dt-bindings: soc: qcom: spm: Document SDM660 and MSM8998 compatibles
Date:   Mon, 21 Jun 2021 20:10:16 +0200
Message-Id: <20210621181016.365009-6-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
References: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver was updated to add SAW2 v4.1 support for new SoCs: document
the new compatibles.
---
 .../bindings/soc/qcom/qcom,spm.yaml           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
index 4aaa319b2932..a1dffde9b168 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -17,6 +17,11 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sdm660-gold-saw2-v4.1-l2
+      - qcom,sdm660-silver-saw2-v4.1-l2
+      - qcom,msm8998-silver-saw2-v4.1-l2
+      - qcom,msm8998-gold-saw2-v4.1-l2
+      - qcom,msm8998-silver-saw2-v4.1-l2
       - qcom,msm8974-saw2-v2.1-cpu
       - qcom,apq8084-saw2-v2.1-cpu
       - qcom,apq8064-saw2-v1.1-cpu
@@ -33,6 +38,8 @@ additionalProperties: false
 
 examples:
   - |
+
+    /* Example 1: SoC using SAW2 and kpss-acc-v2 CPUIdle */
     cpus {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -52,4 +59,19 @@ examples:
         reg = <0xf9089000 0x1000>;
     };
 
+  - |
+
+    /* Example 2: New-gen multi cluster SoC using SAW only for L2;
+     * This does not require any cpuidle driver, nor any cpu phandle.
+     */
+    power-controller@17812000 {
+        compatible = "qcom,msm8998-gold-saw2-v4.1-l2", "qcom,saw2";
+        reg = <0x17812000 0x1000>;
+    };
+
+    power-controller@17912000 {
+        compatible = "qcom,msm8998-silver-saw2-v4.1-l2", "qcom,saw2";
+        reg = <0x17912000 0x1000>;
+    };
+
 ...
-- 
2.32.0

