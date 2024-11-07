Return-Path: <linux-pm+bounces-17137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C39C0C5C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555401F22F3C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE5219C9C;
	Thu,  7 Nov 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BpnqCnfK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811D218943;
	Thu,  7 Nov 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998992; cv=none; b=FMTHOAc88y0/8bt4qOT2Biw0dN0eymQ58peboG2rQBbMD+++bDiazxnEVnDAV2HBukXsiZLFCNoCnXqn8IFrhIBdv0kuZBrPbMkUKRnsjejK77h6NSqO8qRIBZAu6PZZMru+l4y85PsEAlFQjYWZO1Vz1j8XLSHtQY4Y4UulMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998992; c=relaxed/simple;
	bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blwodvHpEIYAN4/8dU53Ca/IndAWdWhbUuLHV27GpB83Cl78tVT3rMIPr2N+p7wFylLtQln2Fb/M0rSZJU1n4K8NyObMufFrEr9l3zkX3+C+7k9LKifSqDcv7K53YUZzTBR/OmRT6UfvwvPseWesyn1NuA1ijj6LDbeH1gAKPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BpnqCnfK; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8F22EE45C6;
	Thu,  7 Nov 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Y4yxwqnDss/PAt3TvJTQZaFUiFNkqCyH+WUzWqZ+0=;
	b=BpnqCnfK6paMF8VZfQRRstEiqTuNScpMIG+3G++5XW5BrMctDBkggFEewyZ/BgZq/IF0d1
	sMqPF//On8YSIJQn5ZEV3oMfcp+Wc0HX6V4+u05kTFFd+vD9a3sjyvjvVGxzP6V2jxwgne
	BDnfVYOgibAncBmXyCvYJ89yLLrHUpDdo8bMa/cfm1h5YRnCK7LI0kFf08sBQ3Yk2/i6Wm
	SeF7ur38iUAFXruhHaxIUX5Q0eQoJz1WR1WNAzUXFFBBPAykIOdpT1cI+6LTI9ui1gVVlQ
	VLTZc55/awDuslj/d1qBA06JYThR3IBpftx3ZdxqXMEHF9MMqHY1FTHoH7hpHw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:52 +0100
Subject: [PATCH v3 11/14] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-11-6ddc5acd978b@mainlining.org>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
 b=axyFfUUUmlynf287+B+lJntJQpFF7gZ61q6QZ+h1SpZFBfKAWEfcIvyn6otQLPh4MfXuI+oye
 HZPjM6djw1hBU/qH1KsfK8EF76KMUPXFFZVrwFNu7vCm+H2AkaE4wZf
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the QFPROM block found on MSM8917.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae46611c722effeaaf014a0caf76e4a..4d81f98ed37a3a12f01d444dbfa77badcc09c22d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,ipq9574-qfprom
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8917-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom

-- 
2.47.0


