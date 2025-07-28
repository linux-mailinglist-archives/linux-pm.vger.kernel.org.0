Return-Path: <linux-pm+bounces-31501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4051B13FCD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD413BD9DF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA25274FCA;
	Mon, 28 Jul 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiwlUAFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54B270540;
	Mon, 28 Jul 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719420; cv=none; b=Lk1xn7DCc03J4ywq6OuWTSGnzeqndgWf0lEEo0Phscb3F2pTe+1XOZHhhUOx0f+FdKwFimln3KzuiydFQE1xTJE0XjxgzxbuDYMK3EnLN/FPexwtPMbGFNEnpGCYu7/kpgDV1WOxdaoOYokcBJl2zkD7WIFSOL8bT2JvTKfcb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719420; c=relaxed/simple;
	bh=SIFuAxmXSln4uElc7R6L6j7uNnFn6YYkVGW+yg7esek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYA7smRTzIqurqUEsbmuFRcWFWYN0NNsBzods8PzlLeCZthGGLluphaB4x4h/0tG7Lbf8D1VKhbKsmimpKcUiJ0qCQJFJpEGjajmF+eNBBVekbXyqmY6QynkqVH1ezfGkQwshhZhIdENvs9uYvK2n70Y5SNSNzMw3A/p0IIzamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiwlUAFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9EBC4CEEF;
	Mon, 28 Jul 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719420;
	bh=SIFuAxmXSln4uElc7R6L6j7uNnFn6YYkVGW+yg7esek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UiwlUAFkUt/WBFTcVFsiK4xIRDQJA8q8gJT2SYoL1uwxmbdKM0F0ULelLz2MeyBZF
	 24I+F/runDfubBMn9Bolzf1vi5Wbtfso2uEWvhtWoNd5pepRvzU2PSGsJvwuhHyudx
	 ynKqpJij76+Cx/QNAeusgx8zfDaEkxtjZ4tt/Qx0vjs1MOFZfrw23LITejia0VaCQh
	 zZRrPKRuhTzzTwdA8go0aDLfzL+GyXmJDIiYH57EOwwQzRrYhEKTR367lhU3dk2c/i
	 U6PCYLaBgFlzebj/dSEatVz4L2G8ojY9PYa7tAsAxgb+KRfx796sqUjokSpp0nr+8w
	 NAb5Uz7JqbLHQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:05 +0200
Subject: [PATCH RFC 05/24] dt-bindings: clock: qcom,gpucc: Sort out SA8540P
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-5-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=3257;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=dMghhu8fbblddXWqqxKXk/yMMHr9vc8g40jkXnB5Ljw=;
 b=eKooxj5MSRVct0YbY6MC0XeaY4MOA2giXOnmLz+zOeiZiETwdU/6/v0AMm3n5nSBGpH1UCxN/
 gEH7KWBU2UEBFkFIR7XTiaiK45IWifs7LKDuyMKdbnr5DMQqzTDXetJ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The platform in question is a close cousin of SC8280XP, most notably
lacking an on-SoC VDD_GFX rail, substituting it with an external
regulator.

The GPU_CC block was previously believed to only require a handle to
some form of VDD_GFX, but that's now known not to be enough.

Introduce a new compatible, using the SC8280XP fallback, to constrain
a different number of power-domains and remove the pd-regulator
exclusivity check, as it no longer applies.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 65 +++++++++++++---------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 1a6f8889db35296b59973c90b8133abfed75baaf..3beb8f2c3d7a1b3f820c6452fc4000e6cfa14070 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -37,27 +37,31 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,milos-gpucc
-      - qcom,qcs8300-gpucc
-      - qcom,sa8775p-gpucc
-      - qcom,sar2130p-gpucc
-      - qcom,sc7180-gpucc
-      - qcom,sc7280-gpucc
-      - qcom,sc8180x-gpucc
-      - qcom,sc8280xp-gpucc
-      - qcom,sdm845-gpucc
-      - qcom,sm4450-gpucc
-      - qcom,sm6350-gpucc
-      - qcom,sm8150-gpucc
-      - qcom,sm8250-gpucc
-      - qcom,sm8350-gpucc
-      - qcom,sm8450-gpucc
-      - qcom,sm8475-gpucc
-      - qcom,sm8550-gpucc
-      - qcom,sm8650-gpucc
-      - qcom,x1e80100-gpucc
-      - qcom,x1p42100-gpucc
+    oneOf:
+      - enum:
+          - qcom,milos-gpucc
+          - qcom,qcs8300-gpucc
+          - qcom,sa8775p-gpucc
+          - qcom,sar2130p-gpucc
+          - qcom,sc7180-gpucc
+          - qcom,sc7280-gpucc
+          - qcom,sc8180x-gpucc
+          - qcom,sc8280xp-gpucc
+          - qcom,sdm845-gpucc
+          - qcom,sm4450-gpucc
+          - qcom,sm6350-gpucc
+          - qcom,sm8150-gpucc
+          - qcom,sm8250-gpucc
+          - qcom,sm8350-gpucc
+          - qcom,sm8450-gpucc
+          - qcom,sm8475-gpucc
+          - qcom,sm8550-gpucc
+          - qcom,sm8650-gpucc
+          - qcom,x1e80100-gpucc
+          - qcom,x1p42100-gpucc
+      - items:
+          - const: qcom,sa8540p-gpucc
+          - const: qcom,sc8280xp-gpucc
 
   clocks:
     items:
@@ -86,12 +90,6 @@ required:
   - power-domains
   - '#power-domain-cells'
 
-# Require that power-domains and vdd-gfx-supply are not both present
-not:
-  required:
-    - power-domains
-    - vdd-gfx-supply
-
 allOf:
   - $ref: qcom,gcc.yaml#
 
@@ -151,6 +149,19 @@ allOf:
             - description: CX power domain
             - description: MX power domain
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sa8540p-gpucc
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+            - description: MX_COLLAPSIBLE power domain
+
   - if:
       properties:
         compatible:

-- 
2.50.1


