Return-Path: <linux-pm+bounces-28454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B97AD4FE6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8ED3A401C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7123AB86;
	Wed, 11 Jun 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVEMPM1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52241C69;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634409; cv=none; b=Wottc1tv29Dpqn46O8lPyJBLUQAOkRZspJHNL/he9NmUb8Gt2wqyQPoAQ2y5BswOshVhqEFO/tujliJ+GZRUyDW8ABDPvZCBVEC5bN+Lj7R0w4AdUfXxaOdp6KFspXsRXP83RZS7bcmKZwCC0vM8yaedkTp3SLXYc2tXKe/aQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634409; c=relaxed/simple;
	bh=tNva/wal8+pzgbVVJObgRAKljanokSBTcRFs03EX+oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9ORHFD9UQ5q9jwcWl9en9zZGYZaEZ9T57MYrIkxhHNA0/8cGunqKMm4bSXC3wPKhRPo1Ns6a8yvpANejm0F/NckUqpklnzqF2gnqfvTU/vx9Q2RiwsVhDHTIwNkcGgjwFAj4TqffWCTHREFbEEDR1TsPWh/VZgBnFCM3R86YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVEMPM1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80EB0C4CEF1;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634408;
	bh=tNva/wal8+pzgbVVJObgRAKljanokSBTcRFs03EX+oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RVEMPM1uuqzF2XP1L0vmnGR71lBqo6LDjqJ9lwCYz6SRJlrRnAQ8/iTXMbPjncFAh
	 9Z8waWvCfkqmd8xBNkPB9WTF5Vgd5+UDd6UChC4hvm8Uv+1jtacHEwUE+YXdQ+mt27
	 DsZ6tj2DDSUin0T0NCIo7q4/GETgYQo2yzQ+jLpdLYELsmyhQz4c6gCwq2M28X1z/v
	 Gboh10gnv2pUCiQ5CmoSrJXNjavX8DRVdpywEm1YvZj+U/Ib2GcDB/V2UyPgUyOCuJ
	 o6m03ftDOm81CmV6MKtVn0kzeB8p5rxGuit5UChAiTKHuqI8NxVizDMhlrvLjxBFEI
	 IsZIQz5cUxCpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B23C71133;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 11 Jun 2025 13:33:21 +0400
Subject: [PATCH v12 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ipq5018-tsens-v12-1-a61374a5517d@outlook.com>
References: <20250611-ipq5018-tsens-v12-0-a61374a5517d@outlook.com>
In-Reply-To: <20250611-ipq5018-tsens-v12-0-a61374a5517d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749634406; l=1481;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=RrfwkZTGbLqY30+ytKz/HO9wG4uq1c9Mr1ofBKoxP4E=;
 b=uSS6oEbXYaZWYfPMJ4LGi4HC6UK87th9GkY7K38TmPHbR6RzIbPWARIZ7g8oR6a3Dwi+3iw+2
 VHUhy1UEGlBA3MHCwL3aMK5Q9V3EgFBZJpPUo4aVi+LnlTLkApEdp20
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



