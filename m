Return-Path: <linux-pm+bounces-31500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1501B13FC8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C1189D771
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEFF274B4C;
	Mon, 28 Jul 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWlcSo/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09221274671;
	Mon, 28 Jul 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719413; cv=none; b=ioEJmDcVlO13QzlYp3wHG+8ryY6cYW29bOJWx2dDC4TGOGiaC1x5tbUlMRkDyIFuyH87e4x3ngy621N6yhe2wLxjDX6QCT+Y+2JdKiau3LbaUGtZJ0F27OAf9KxleYS0dpRCVirMPR2oMascPEeqKYWgN3FTc9snTBuPhm8wLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719413; c=relaxed/simple;
	bh=U9RDj2CgZnV8vHBJc6KMnpJWxXKLgi+Nnh+CeEWSb48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sa9yNE2QkZJIoozNyOh5TKY60ODWTOaWDbgoWlE/vjACEBeAo1/VReUI4b6fLF5FbKhNecQFW2M70kncZ9t0qL33k4zGKMus7EiNdgpndNM7AnpXbK8qayqt0cIiZ/Fz+62y+3zanJai7tcpp8IbE0jlE9FOK9xBMCmaFiJLKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWlcSo/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C65C4CEEF;
	Mon, 28 Jul 2025 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719412;
	bh=U9RDj2CgZnV8vHBJc6KMnpJWxXKLgi+Nnh+CeEWSb48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lWlcSo/OIJgc/QTmBaB5+A/EV2xsaZ87ZNOA4rrJ6ZEuhw6vVCEqCTZxBATaW8cCC
	 qJHeIEXH7Ee5foHg13AmZPnBl2+8TB1zgPo4iyAt0nbHB4PSacBFM4Om15RjUfbLT+
	 mya9z1O28qRQLo03xSTMbh88h0CGx+xN7XEOeS8M7l8S5EhliCK+46fawjbzqRXs3+
	 zt7el8tc7+uEn7w2Z4Kl6gIvyDSy/B3IPschcsQmz/4+e5n/QMEKEMvKV7tw/HUW2T
	 xFA5fld8hJr2iEp/2kAmT5XvG0Zq+NdBvq+suH1L/wSMqf55fjb5kOmlEKfpuq1pv/
	 EPNmhii5YaRFw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:04 +0200
Subject: [PATCH RFC 04/24] dt-bindings: clock: qcom,gpucc: Describe actual
 power domain plumbing
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-4-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=3745;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=cIw2kmLuyqooARzvgDD/0MnQw0CE1z3LqmnoyLPyPq0=;
 b=RKxfyz83BWC3Sk/gVoRKnKHt6v0MaEirvo+J+DaHny4eLUhTv0VhbeQSY8prs/w2IfSeUlLp8
 chiLsSrMHFFCB8kjQWyQT8LZe1MdLTshFaXkYvYwgmk4M3/15SHYqIN
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

GPU_CC is always powered from the VDD_CX rail.

On platforms with a split MX rail (MX_A/C for ALWAYS/COLLAPSIBLE), both
are required. Otherwise, the common MX rail powers part of the logic,
including the PLLs.

Extend the current requirements to make sure the hardware is powered
adequately and the votes are released when no longer necessary.

Skiping "Fixes" as it would apply to NUM_PLATFORMS commits..

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 68 +++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 5053d71f918bb28c504746f68e782ca719051f63..1a6f8889db35296b59973c90b8133abfed75baaf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -72,7 +72,10 @@ properties:
       - const: gcc_gpu_gpll0_div_clk_src
 
   power-domains:
-    maxItems: 1
+    description:
+      Power domains required for the clock controller to operate
+    minItems: 2
+    maxItems: 4
 
   vdd-gfx-supply:
     description: Regulator supply for the VDD_GFX pads
@@ -80,6 +83,7 @@ properties:
 required:
   - compatible
   - clocks
+  - power-domains
   - '#power-domain-cells'
 
 # Require that power-domains and vdd-gfx-supply are not both present
@@ -91,6 +95,62 @@ not:
 allOf:
   - $ref: qcom,gcc.yaml#
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,qcs8300-gpucc
+            - qcom,sa8775p-gpucc
+            - qcom,sar2130p-gpucc
+            - qcom,sc8280xp-gpucc
+            - qcom,sm8350-gpucc
+            - qcom,sm8450-gpucc
+            - qcom,sm8475-gpucc
+            - qcom,sm8550-gpucc
+            - qcom,sm8650-gpucc
+            - qcom,x1e80100-gpucc
+            - qcom,x1p42100-gpucc
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+            - description: GFX power domain
+            - description: MX_COLLAPSIBLE power domain
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,milos-gpucc
+            - qcom,sc7180-gpucc
+            - qcom,sc7280-gpucc
+            - qcom,sc8180x-gpucc
+            - qcom,sdm845-gpucc
+            - qcom,sm8150-gpucc
+            - qcom,sm8250-gpucc
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+            - description: GFX power domain
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm4450-gpucc
+            - qcom,sm6350-gpucc
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+
   - if:
       properties:
         compatible:
@@ -116,6 +176,8 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
     clock-controller@5090000 {
       compatible = "qcom,sdm845-gpucc";
       reg = <0x05090000 0x9000>;
@@ -128,5 +190,9 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+
+      power-domains = <&rpmhpd SDM845_CX>,
+                      <&rpmhpd SDM845_MX>,
+                      <&rpmhpd SDM845_GFX>;
     };
 ...

-- 
2.50.1


