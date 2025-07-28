Return-Path: <linux-pm+bounces-31499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85863B13FC2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C7E189D7ED
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188927585D;
	Mon, 28 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXtEQuAI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C033274671;
	Mon, 28 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719404; cv=none; b=jI1BKVSqiqJFthlcpHqEu28tM/krHLVIfXwNL1ZHPcsc0ZnPL/VKHwYA78vQebhTB+7MCYL+RICFyNe8d1ogWntZQCU1UffSIXR0nnWDkYBDwl113i0qYEwPGKjOqkD0IKBL+I8n8IiMxe3MYvLJ1VWcCN0EP6choYKCMRcnVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719404; c=relaxed/simple;
	bh=ZE6HU12iEkvhDV9mvwsai+f5VRwHR7zOe8PgiNQHjOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfK/kbv2ofwY56HrNJqoC6vhvDtqejW9mkoy1HrMbcw+5/fgDCbf+8+0K/65a7NeoyTA7GfFCtkZLMiFZ16EXoI6RKSSTpCMuMjp5/8dwL/Elrf20LI2mkhsVfYq9lq1I8Wm0WSjD1XqSgXYU7De3yZMe0fZd8E5rD+VeGH/NU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXtEQuAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40143C4CEE7;
	Mon, 28 Jul 2025 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719404;
	bh=ZE6HU12iEkvhDV9mvwsai+f5VRwHR7zOe8PgiNQHjOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pXtEQuAIqUh1vt9VVb4mvk+VIMAj/PFJ3WkgoU41mzAdudUO1t5g1ESoMMDNcRSnE
	 48suLMrCeRDDMrOGRFeOa4QtbFgAouyU+7zKhylxckSlc04Jl0GUKrV/W90OEeHx7F
	 GAliVBqIuz/r/id/3AcgS7BbBECKhFc2rzY2lKqg5igvbJLtDjahbVP5PBa0/9wOwD
	 u3xCljZjaMGGI65J81VlymOzjBdEBoQ6v4Mic7r/srVQn78Nko0ij9Y5BNh7zFh8sO
	 XJqg32O71FF4wxpbjfnU/4oVX9jrMl28NTnwnuJ6V0vCtGemkOW4ykla06X4XA/XHF
	 w9FIQ6scVCXTQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:03 +0200
Subject: [PATCH RFC 03/24] dt-bindings: clock: qcom,gpucc: Merge in
 sm8450-gpucc.yaml
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-3-09c2480fe3e6@oss.qualcomm.com>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Douglas Anderson <dianders@chromium.org>, Vinod Koul <vkoul@kernel.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Andy Gross <andy.gross@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=6066;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=2xn3CtiSIOEqXJR8P6M4M8nQxjynek5IIzMtuhgtJro=;
 b=QdtX+bqzwtoxs4/Oh9rlSrSnY3h88pMy92LV526sBLSeSWs0D3dNq1jtSl4wLcLMGKZpwdDl5
 MK9/Qv8ieBdCCEqwpApZnuipHvYlSGlyy8q1u7rxQ1BvEeDLFAf6/pv
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The only difference is the requirement of clock-names, and only for
legacy reasons.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 42 +++++++++++-
 .../bindings/clock/qcom,sm8450-gpucc.yaml          | 75 ----------------------
 2 files changed, 39 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 4cdff6161bf0b17526cc62b67d9c95086240fe46..5053d71f918bb28c504746f68e782ca719051f63 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -9,37 +9,55 @@ title: Qualcomm Graphics Clock & Reset Controller
 maintainers:
   - Taniya Das <quic_tdas@quicinc.com>
   - Imran Shaik <quic_imrashai@quicinc.com>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
   domains on Qualcomm SoCs.
 
   See also::
-    include/dt-bindings/clock/qcom,gpucc-sdm845.h
+      include/dt-bindings/clock/qcom,milos-gpucc.h
     include/dt-bindings/clock/qcom,gpucc-sa8775p.h
     include/dt-bindings/clock/qcom,gpucc-sc7180.h
     include/dt-bindings/clock/qcom,gpucc-sc7280.h
     include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
+    include/dt-bindings/clock/qcom,gpucc-sdm845.h
     include/dt-bindings/clock/qcom,gpucc-sm6350.h
     include/dt-bindings/clock/qcom,gpucc-sm8150.h
     include/dt-bindings/clock/qcom,gpucc-sm8250.h
     include/dt-bindings/clock/qcom,gpucc-sm8350.h
     include/dt-bindings/clock/qcom,qcs8300-gpucc.h
+    include/dt-bindings/clock/qcom,sar2130p-gpucc.h
+    include/dt-bindings/clock/qcom,sm4450-gpucc.h
+    include/dt-bindings/clock/qcom,sm8450-gpucc.h
+    include/dt-bindings/clock/qcom,sm8550-gpucc.h
+    include/dt-bindings/reset/qcom,sm8450-gpucc.h
+    include/dt-bindings/reset/qcom,sm8650-gpucc.h
+    include/dt-bindings/reset/qcom,x1e80100-gpucc.h
 
 properties:
   compatible:
     enum:
+      - qcom,milos-gpucc
       - qcom,qcs8300-gpucc
-      - qcom,sdm845-gpucc
       - qcom,sa8775p-gpucc
+      - qcom,sar2130p-gpucc
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
       - qcom,sc8180x-gpucc
       - qcom,sc8280xp-gpucc
+      - qcom,sdm845-gpucc
+      - qcom,sm4450-gpucc
       - qcom,sm6350-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
       - qcom,sm8350-gpucc
+      - qcom,sm8450-gpucc
+      - qcom,sm8475-gpucc
+      - qcom,sm8550-gpucc
+      - qcom,sm8650-gpucc
+      - qcom,x1e80100-gpucc
+      - qcom,x1p42100-gpucc
 
   clocks:
     items:
@@ -62,7 +80,6 @@ properties:
 required:
   - compatible
   - clocks
-  - clock-names
   - '#power-domain-cells'
 
 # Require that power-domains and vdd-gfx-supply are not both present
@@ -74,6 +91,25 @@ not:
 allOf:
   - $ref: qcom,gcc.yaml#
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,qcs8300-gpucc
+            - qcom,sdm845-gpucc
+            - qcom,sa8775p-gpucc
+            - qcom,sc7180-gpucc
+            - qcom,sc7280-gpucc
+            - qcom,sc8180x-gpucc
+            - qcom,sc8280xp-gpucc
+            - qcom,sm6350-gpucc
+            - qcom,sm8150-gpucc
+            - qcom,sm8250-gpucc
+            - qcom,sm8350-gpucc
+    then:
+      required:
+        - clock-names
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
deleted file mode 100644
index 44380f6f81368339c2b264bde4d8ad9a23baca72..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ /dev/null
@@ -1,75 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sm8450-gpucc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Graphics Clock & Reset Controller on SM8450
-
-maintainers:
-  - Konrad Dybcio <konradybcio@kernel.org>
-
-description: |
-  Qualcomm graphics clock control module provides the clocks, resets and power
-  domains on Qualcomm SoCs.
-
-  See also::
-    include/dt-bindings/clock/qcom,milos-gpucc.h
-    include/dt-bindings/clock/qcom,sar2130p-gpucc.h
-    include/dt-bindings/clock/qcom,sm4450-gpucc.h
-    include/dt-bindings/clock/qcom,sm8450-gpucc.h
-    include/dt-bindings/clock/qcom,sm8550-gpucc.h
-    include/dt-bindings/reset/qcom,sm8450-gpucc.h
-    include/dt-bindings/reset/qcom,sm8650-gpucc.h
-    include/dt-bindings/reset/qcom,x1e80100-gpucc.h
-
-properties:
-  compatible:
-    enum:
-      - qcom,milos-gpucc
-      - qcom,sar2130p-gpucc
-      - qcom,sm4450-gpucc
-      - qcom,sm8450-gpucc
-      - qcom,sm8475-gpucc
-      - qcom,sm8550-gpucc
-      - qcom,sm8650-gpucc
-      - qcom,x1e80100-gpucc
-      - qcom,x1p42100-gpucc
-
-  clocks:
-    items:
-      - description: Board XO source
-      - description: GPLL0 main branch source
-      - description: GPLL0 div branch source
-
-required:
-  - compatible
-  - clocks
-  - '#power-domain-cells'
-
-allOf:
-  - $ref: qcom,gcc.yaml#
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        clock-controller@3d90000 {
-            compatible = "qcom,sm8450-gpucc";
-            reg = <0 0x03d90000 0 0xa000>;
-            clocks = <&rpmhcc RPMH_CXO_CLK>,
-                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
-                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
-            #clock-cells = <1>;
-            #reset-cells = <1>;
-            #power-domain-cells = <1>;
-        };
-    };
-...

-- 
2.50.1


