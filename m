Return-Path: <linux-pm+bounces-37386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEECC32D19
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15F44FB38E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389D2DA74D;
	Tue,  4 Nov 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/9Rsgq+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8A28C87D;
	Tue,  4 Nov 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284694; cv=none; b=JQndnAj3f4207jU3S57tEbxgRsdnAxFQtuhrao1uz+SwyNaSUdM/9tVuCC5Dz5Ul3h+kIjCpRHJSyr1L/YBXXgTJ8h6h7pqd2puGER2ei9Yp8eb0q/BK1V+7Zq/7OMDr/qraEPNBeLzjsMyA2ZweyivHhG8fBn7X881iMxXsJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284694; c=relaxed/simple;
	bh=06lo+Vx/fRJIyaJWrJ7kTyn1mJC7ngVbwSmnvQvPPWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLhlfhr3jNTeqeMBioAm8TztulAKCo0TQ7aQiRLJHBMkof/o8yJoiCjQP7aj/huo1KjLmsgdnls83OW1cjaNGSGXqqVk1PRc3Re3FZeX2nVt8U434vXFTDti2UH3/gOquoLjRDYp/LiVrt8qSozM7ALpgsV0rLWbVPcp6Km4Ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/9Rsgq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F61C4CEF8;
	Tue,  4 Nov 2025 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284694;
	bh=06lo+Vx/fRJIyaJWrJ7kTyn1mJC7ngVbwSmnvQvPPWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k/9Rsgq+EkYRV2/keIN6PuSwcLP5UcNvkfp1zc0qivqsk3r26MqaKH1Jih9Msm9kW
	 FBRLPY4HiO+j7KCvY1+Mkg4Ifra0ont+Nq7a7K7UMmKw4aVZJJGkAMTJ8ikx/2b1QW
	 aCfqpKlDf84w1GqHog57AM/Sg9KY0ELIbPYQvKn6o9/iyBlqz2yIK6MGAYpsfhMMDE
	 ITuuE05GvM8bgao7jH7AgfBSWOQLFA22UCudEBJ6qkTeu+8SL3c6C6KeHdzwrjqEGd
	 j7sLq1W77XCP570WaCtzzKy9ICf0tx8HwUAr9kp0fEkOi8ZhFtRleA9nbTTa1sSfTX
	 G+plK8opS0I0w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 04 Nov 2025 20:31:07 +0100
Subject: [PATCH 2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP
 power desc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-topic-8280_mxc-v1-2-df545af0ef94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=1139;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=xuLAatTf2rSWHytgtZmyFgEZ8ilgXkJY2sJDkaFQC7M=;
 b=XtrsRlBCq5jA1tsMlD9VI10f3YVUMAFn07UNufVK0B28REZwWRDPCuAXn/wijWbGMnHDKGpau
 NGF447gjYcLC/44uk7OZqIwi78f/oWDizlOzu0ojDllZqnqxEFSnSKK
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The power requirements for the CDSP instances on SC8280XP aren't fully
described, with only one of the three present. Fix that.

Fixes: ee651cd1e944 ("dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
index 96d53baf6e00..5dbda3a55047 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -91,9 +91,13 @@ allOf:
         power-domains:
           items:
             - description: NSP power domain
+            - description: CX power domain
+            - description: MXC power domain
         power-domain-names:
           items:
             - const: nsp
+            - const: cx
+            - const: mxc
 
 unevaluatedProperties: false
 

-- 
2.51.2


