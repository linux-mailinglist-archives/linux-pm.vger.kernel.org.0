Return-Path: <linux-pm+bounces-17494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488BC9C75E9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EFD1F2227A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8395207217;
	Wed, 13 Nov 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="MXsXfuf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC92071E6;
	Wed, 13 Nov 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510724; cv=none; b=EdfhMbeFJUGQDNEQn1NMwQ8ztYWFORC8M0/gd29BqvEp2HW8EMP/U4kAgNMM0OmQ+LMxBmm5Rt+vtEeM8EuEKa0NBE0KVlQVmBdnWSW7Do/D12JJDWauslTmJCi0VGSGQ67aOB71U4z2pE/YnWQKIrNREy+ZARXgPRGXD+BnsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510724; c=relaxed/simple;
	bh=xiFBtHsOaU6w5QYdlsV5ffTJLBo8Uh6SeJeMP9eWLsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCN/DIkR7Ji5hYy/FkpYEeD20u3TWnDbTJ/4i3QoApPE62HZ3emBN5fjnBpyPa2dDGMcHSyCUiNXbrNQ26+Adq15vTgnqASq1Sd/B2pfQp/JzWR5C6LEaVacAoI0+uDt/ahwzsSuxRNFWgOdvrXHvhPJrXXOi7BO4n1VnfO5xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=MXsXfuf3; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C230F.nat.pool.telekom.hu [37.76.35.15])
	by mail.mainlining.org (Postfix) with ESMTPSA id 52409E44EA;
	Wed, 13 Nov 2024 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpHmUFBIqJF78XKlVouHZG9P31kndu81nFICPCCAgP0=;
	b=MXsXfuf3cFIdWFt4C2YGbnyzTSbjXV/T5LIiI96AQ5dcj07CIOWq8B1yXv7SVoBVMMesg2
	WdFWzfFBPiIKfUtspn7RvvYd2iLFtrbOe6+y7HcvpFcOK1molVzJf7KeSJnsZaGyt3kRew
	AWS9kBiuyUKIyBonyYh3fgu+zOl5/KZ7mtj4x2GGhKq4dLQfYy1+kEyKajmZtz9oUt+bpL
	px8wcfO+8Xoc+WW8E1T6nEa60/eRYORU6+JhomWHxkB+JQ0ODpv6p+4lSL6zRTj6txL9Pw
	MV4TbZVNygWWeGwpvY0Npz+HN0b9txUqDwql6bCySMlFQXGWHVkCm3HKF3Re4g==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 13 Nov 2024 16:11:50 +0100
Subject: [PATCH v6 09/10] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-msm8917-v6-9-c348fb599fef@mainlining.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
In-Reply-To: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731510705; l=1345;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=xiFBtHsOaU6w5QYdlsV5ffTJLBo8Uh6SeJeMP9eWLsQ=;
 b=rmreHIykKJ4X3J38GDviEt18osNnaovYpGS65drMLRV5EcfO+qS7cL3Zfy1GnEDmh5RD9+UXm
 UimRlK3yiu4A98X9CoSCAXdSCZpBp6/4jfX9sOvfl/r1vidw8QDRwuI
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Remi 5A (riva).
Add qcom,msm8917 for msm-id, board-id allow-list.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7c8c3a97506aa13a843d5e3408b247eae928a55c..0b4a8c8cdbf7d0b4191b1acdd10b9b83f2b09542 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -32,6 +32,7 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8917
         msm8939
         msm8953
         msm8956
@@ -252,6 +253,11 @@ properties:
               - yiming,uz801-v3
           - const: qcom,msm8916
 
+      - items:
+          - enum:
+              - xiaomi,riva
+          - const: qcom,msm8917
+
       - items:
           - enum:
               - motorola,potter
@@ -1177,6 +1183,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8917
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.47.0


