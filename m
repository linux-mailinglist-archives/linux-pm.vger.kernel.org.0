Return-Path: <linux-pm+bounces-28528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B851BAD682E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 08:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB65B189F7AC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B71FBE83;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMp+zzKg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AC1E5B94;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710810; cv=none; b=OLOcqo/I8URk217WNtj4PL+dZv3/LHUtaJY7yP3hcWP1M+U+4tQ9BazXUoDpX7oz+ahdKnu400KwMW02pEYcCne75eSVE30JskI7ZZUbdsVgpydmS3lbpm6ZXDdrkVcYzBwK3OM1xKnuhHF3uCS7bl1vRiDxO5/RUd1TEdkg6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710810; c=relaxed/simple;
	bh=tNva/wal8+pzgbVVJObgRAKljanokSBTcRFs03EX+oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rieYiKc+0ct1igOsy9yWwYSbJDCuuzGSiX6mP0+faN5q9Dwo5XDT2q5zbquW8EgVpJqldtmEfZOIlCKx4cVK8frrukRJD6LLEYnGtpelTUPfP7+xzXN1SJyVXQrqA+xHRQoeLWK/0+08NTQPuiYAjZoIVa9mxEk9Ch8A/bRCvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMp+zzKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E7EEC4CEEB;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749710810;
	bh=tNva/wal8+pzgbVVJObgRAKljanokSBTcRFs03EX+oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XMp+zzKgCQ6o1waZgO/XSddX8wcLiW7g26I7jRxiraJIOpL3q3gbxiiC8kF6nSBZq
	 5QqoJawiO9shjCclW40jPNP2DmqQ2qRoE4Zv/Q7/ql95CYgGGEtVeglIoGb2OjtZon
	 XB6uKObPoQsjTTlAosNissmWMSVHaNU3sQT1mLt/2HuCVctD1C1ztY45Yr5V6JrG0H
	 rJrVIiMSkU3SqJ1+UXuVgSiWNivJrmvPU5jLGZ8Z37RmshsgxxRAM40farFIrqEvHf
	 yLGMFBHDy96jQJns3ZxdW89dpCNj4yMtb8ffbI+kMZd7mA87Jk/LR7lr9xgkKsrdFK
	 Ysxsy9Wva3a2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BADC71143;
	Thu, 12 Jun 2025 06:46:49 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 12 Jun 2025 10:46:13 +0400
Subject: [PATCH v13 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-ipq5018-tsens-v13-1-a210f3683240@outlook.com>
References: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
In-Reply-To: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
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
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749710807; l=1481;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=RrfwkZTGbLqY30+ytKz/HO9wG4uq1c9Mr1ofBKoxP4E=;
 b=JV4vzYOVMEIqr1xXu025PPhabPOfCtJ1SC7TXbHKhq0PCqcAu4KcyCyjyInoueJj9mJePaAwW
 0pYxKTEN0orAeImbzFYNwtkRK1F939eKoBNEtmtBbSqTmATjJnRu5iZ
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
2.49.0



