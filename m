Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D643DA804
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhG2P4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 11:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbhG2P4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 11:56:36 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCEC061765;
        Thu, 29 Jul 2021 08:56:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 71232200C7;
        Thu, 29 Jul 2021 17:56:28 +0200 (CEST)
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
        stephan@gerhold.net, robh@kernel.org, bartosz.dudziak@snejp.pl,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v8 5/5] dt-bindings: soc: qcom: spm: Document SDM660 and MSM8998 compatibles
Date:   Thu, 29 Jul 2021 17:56:09 +0200
Message-Id: <20210729155609.608159-6-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
References: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver was updated to add SAW2 v4.1 support for new SoCs: document
the new compatibles.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/soc/qcom/qcom,spm.yaml           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
index 507216100e3f..d68c002527fa 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -18,6 +18,10 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sdm660-gold-saw2-v4.1-l2
+          - qcom,sdm660-silver-saw2-v4.1-l2
+          - qcom,msm8998-gold-saw2-v4.1-l2
+          - qcom,msm8998-silver-saw2-v4.1-l2
           - qcom,msm8226-saw2-v2.1-cpu
           - qcom,msm8974-saw2-v2.1-cpu
           - qcom,apq8084-saw2-v2.1-cpu
@@ -36,6 +40,8 @@ additionalProperties: false
 
 examples:
   - |
+
+    /* Example 1: SoC using SAW2 and kpss-acc-v2 CPUIdle */
     cpus {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -55,4 +61,20 @@ examples:
         reg = <0xf9089000 0x1000>;
     };
 
+  - |
+
+    /*
+     * Example 2: New-gen multi cluster SoC using SAW only for L2;
+     * This does not require any cpuidle driver, nor any cpu phandle.
+     */
+    power-manager@17812000 {
+        compatible = "qcom,msm8998-gold-saw2-v4.1-l2", "qcom,saw2";
+        reg = <0x17812000 0x1000>;
+    };
+
+    power-manager@17912000 {
+        compatible = "qcom,msm8998-silver-saw2-v4.1-l2", "qcom,saw2";
+        reg = <0x17912000 0x1000>;
+    };
+
 ...
-- 
2.32.0

