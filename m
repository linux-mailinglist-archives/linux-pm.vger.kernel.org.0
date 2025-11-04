Return-Path: <linux-pm+bounces-37387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80FC32CCB
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6533BD465
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200092DC786;
	Tue,  4 Nov 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksc5G5fH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DA20E005;
	Tue,  4 Nov 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284702; cv=none; b=PBxGSqOGn1jwl8AEw61iWHBy/lIt5zGvyN9qsrMA+GW+JYN/Qkt+JifgW97T3ztslqqASWhFRLT47o8UZoLWL5EAGs1ThxS53FFBvRHvu7yqc9MFUKt2FUw8aiRE/n3DYnqtUOtG89BerFkD2GrjsQ/B5gsrqEO6H9GuVXWRLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284702; c=relaxed/simple;
	bh=/xhKybbecTiSm/9DfMA32unYZrLIzaUJVbixU7B+0fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGfvpxnbdnonwaET4xCDnoG5dN+QO2OPh34XBv6Zb7TNHMfhs0u67vPA4ym5FBUPQ4kwiXlYH53r+wb3HA2FPt4MHQA9EjlDnXQHBUzg2FE+VR9j6jDO1i67NMXK3TzYYy2JTN1N/iFuuiAVj/bCxr1HMAO44bn6E254UX5yCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksc5G5fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF0C4CEF8;
	Tue,  4 Nov 2025 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284701;
	bh=/xhKybbecTiSm/9DfMA32unYZrLIzaUJVbixU7B+0fQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ksc5G5fHtiITSaOkmtiloIlz2ocK8roi8xK4ML5uGRbQ/SrXI48CLlxxElkacCw3c
	 2RBW40PVRG/pQHpBsbFdMaD4Y7uShD+WtfGtmqclCQvMvA9Kr9//rzlNM0zBi3YSwI
	 PALZ46vFN8UefHfNHL56bpFlKzA903pvLRpFJGC7S1ADkCayj4FhgNy2jEgYjPVyYl
	 toAiGIAUCXdN1z8yYYBiovah+9L/0y8z2uaPjDVNvOclwIs+giNyyiH7WsUMjSkUJh
	 /6WXtL1e0HHbsTByvhMSFYRqv6RS2Kg7YQmXxzCl83YiNXQ84FxbaESxmHvF5NbC3z
	 lms03dlAeX2aQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 04 Nov 2025 20:31:08 +0100
Subject: [PATCH 3/5] dt-bindings: clock: qcom: Allow MXC on SC8280XP CAMCC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-topic-8280_mxc-v1-3-df545af0ef94@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
In-Reply-To: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=2183;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=zqcYKrnQPhcxo+aAVk0kdsbTb8Ggki6b27IS28yZZY8=;
 b=3Hw/VmsnN5uwldEKckjmagWMWbozGq0rMIMpNsRYk+lRconpFDFRa9B4H4t0wSGJW6czdPiEH
 mTYMyihZ7jvCaALsZdzu5xVLmQrVHG+cHfB8Rf5iy77QbI6h5gw9I7m
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Move the SC8280XP camera clock controller to the 8450 binding, as their
actual characteristics happen to be closer to that one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,sa8775p-camcc.yaml       | 13 -------------
 .../devicetree/bindings/clock/qcom,sm8450-camcc.yaml        |  2 ++
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
index f42ccb6627a3..83d891caa658 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
@@ -17,14 +17,12 @@ description: |
   See also:
     include/dt-bindings/clock/qcom,qcs8300-camcc.h
     include/dt-bindings/clock/qcom,sa8775p-camcc.h
-    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
 
 properties:
   compatible:
     enum:
       - qcom,qcs8300-camcc
       - qcom,sa8775p-camcc
-      - qcom,sc8280xp-camcc
 
   clocks:
     items:
@@ -48,17 +46,6 @@ required:
   - power-domains
   - '#power-domain-cells'
 
-allOf:
-  - $ref: qcom,gcc.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: qcom,sc8280xp-camcc
-    then:
-      required:
-        - required-opps
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index c1e06f39431e..7ae245dc4dda 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -18,10 +18,12 @@ description: |
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
     include/dt-bindings/clock/qcom,sm8650-camcc.h
+    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
 
 properties:
   compatible:
     enum:
+      - qcom,sc8280xp-camcc
       - qcom,sm8450-camcc
       - qcom,sm8475-camcc
       - qcom,sm8550-camcc

-- 
2.51.2


