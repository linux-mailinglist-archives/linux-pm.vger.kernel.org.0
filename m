Return-Path: <linux-pm+bounces-31050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F1B09CBF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2EC1885AC7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BC26A0FD;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnTxQqD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD9230D35;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824293; cv=none; b=Zupf6v2gxxywyh+fBF5CzbRlMJ3a2xiftJqxkbdg7kyNH91v7b/w3C8QXEXfJfzp9uV3bUHYBobbq8SQBwx6nmpKftgDl8BpJk2QRGzUPHR9/0prXvB5OkgQQnc/FR/m/0oHPnwZwFKxwHLwRg7c50J+PZwagGbG4U4Qc/FTdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824293; c=relaxed/simple;
	bh=F8qIKBf/Y+7w6Mrjy5Qh3Zs7+NqM+E+DJCh6vhK0yg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+nhZvwLPpPUkg+EXzm06I06WLBp/iyyfAd9ELoK21lSB36mnmWuLIs1IKvUlPhFJ3CDMWwmTcRWA/zGOB+DAjGM8Q2O6UZhWISnPM5pYyqjyrUH1AFy4h35AFmNsQUmWoHAwDIiSuXHFT5+jSK3B3DPkjGOn1WRBIJF7wXIs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnTxQqD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A04DC4CEF0;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752824293;
	bh=F8qIKBf/Y+7w6Mrjy5Qh3Zs7+NqM+E+DJCh6vhK0yg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gnTxQqD9Bn4MJsOu4ekVHwQC8r9sXP/1W1q+iILqSYprKlWuRAcKsnBj6LQxInfrQ
	 6fnNNtWl2f454t6DeIQTKgXI0jYwI5zgn5oRNF5KjytASa7PlFvNMlZbGhYh+fezJI
	 28w2Ff9fJqgegNbnEFoWlWxANrz9ihZvyCn4NpYQtPOsX4MUQAIALDa9K+FtjU2l5d
	 PwNXcGT5l/ehVH9dH2T6uJJ7dB7BTLihvcsOXYi6GWaNjbi8TzKMYvrOmu7UQ1ik/8
	 OGMmS+VNFUd7kSAhILo8AkgwZkjS2MfFBWGd+34YKO8EuOqL9MUxw8GZ7LJffGM8oe
	 2rEqfLe3m31hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08472C83F34;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 18 Jul 2025 11:38:03 +0400
Subject: [PATCH v14 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-ipq5018-tsens-v14-1-28d8a2472418@outlook.com>
References: <20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com>
In-Reply-To: <20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752824290; l=1548;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=N7b74cdo1JSNQJiBtizyhIJQsUtwECsbNozKY9HUsoQ=;
 b=CO6LksY2VIBLgRhDrZEuvg4ZEP/NQNwULQa6+XfO1yHoTPA70QUp4VHkeopfCluOUSiSZn8qn
 n+5Z8BT7epgCmC6FCpe7so5sg1HS/Mu3T8c8PJwItOYxjz94mNDH4yj
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
and, as such, must deviates from the standard v1 init routine in the
driver as this version of tsens needs to be explicitly reset and enabled
in the driver.

So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.

Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..3cf16f6734fcfee20735d3da2cfb0f708a11bca4 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -36,10 +36,15 @@ properties:
               - qcom,msm8974-tsens
           - const: qcom,tsens-v0_1
 
+      - description:
+          v1 of TSENS without RPM which requires to be explicitly reset
+          and enabled in the driver.
+        enum:
+          - qcom,ipq5018-tsens
+
       - description: v1 of TSENS
         items:
           - enum:
-              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens

-- 
2.50.1



