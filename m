Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17293DA7FA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhG2P4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbhG2P4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 11:56:35 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CDC0613D3;
        Thu, 29 Jul 2021 08:56:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3FE2F2004C;
        Thu, 29 Jul 2021 17:56:27 +0200 (CEST)
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
Subject: [PATCH v8 2/5] dt-bindings: soc: qcom: Add devicetree binding for QCOM SPM
Date:   Thu, 29 Jul 2021 17:56:06 +0200
Message-Id: <20210729155609.608159-3-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
References: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree binding for Qualcomm Subsystem Power Manager (SPM).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/soc/qcom/qcom,spm.yaml           | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
new file mode 100644
index 000000000000..507216100e3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,spm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Subsystem Power Manager binding
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes the Qualcomm Subsystem Power Manager, used to control
+  the peripheral logic surrounding the application cores in Qualcomm platforms.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,msm8226-saw2-v2.1-cpu
+          - qcom,msm8974-saw2-v2.1-cpu
+          - qcom,apq8084-saw2-v2.1-cpu
+          - qcom,apq8064-saw2-v1.1-cpu
+      - const: qcom,saw2
+
+  reg:
+    description: Base address and size of the SPM register region
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    cpus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpu@0 {
+            compatible = "qcom,kryo";
+            device_type = "cpu";
+            enable-method = "qcom,kpss-acc-v2";
+            qcom,saw = <&saw0>;
+            reg = <0x0>;
+            operating-points-v2 = <&cpu_opp_table>;
+        };
+    };
+
+    saw0: power-manager@f9089000 {
+        compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
+        reg = <0xf9089000 0x1000>;
+    };
+
+...
-- 
2.32.0

