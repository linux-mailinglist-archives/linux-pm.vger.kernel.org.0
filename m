Return-Path: <linux-pm+bounces-17132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABB9C0C38
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5A1C22574
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1D217914;
	Thu,  7 Nov 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fr4rBFPJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29936217329;
	Thu,  7 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998985; cv=none; b=VPADbFJLND/7Oiij6mSI++PqGrFQWjbUhvlOJYkLqekw5joHe64rWUG/2n5x3iX0qX4Kn7P1/SiQJYq2ZEtUwkuC/pPxxIg9STAk4R4M8liQN0Hr5NvvO4ABi3vdrCXoXV0xizhh3StuObrlPBFdbKMwxquT0uW8AZc5i1TUfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998985; c=relaxed/simple;
	bh=A0fmQDK8m7oxJnEMI+GXPI0MVrZif3Z38lQBRjITpDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfyC+geR28BCYxfDQcx3MTAmPrZVz5QayagSrFPRNUbYgBexqzHWQQq24wS73Q7U1Zjb/85LXO51SUeGw0b3VM970yQlsspojRf9DY2UDbBSgTJiyH86Kp+OkedbqdVd5Jc9PlEYg1Bu7L4wFbVww9YbsGRBqd/sOvAoi7dc3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fr4rBFPJ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id 5A980E45C6;
	Thu,  7 Nov 2024 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze6/FwJGlwoZIH5QX0UZSFz6K9jP+T7IzTY3dKemhXQ=;
	b=fr4rBFPJyaJ39C6eKeHzqJYWQZcg1QcvIwIIJ+xPoRLXwsPk4wqbq6uYBZnadM50yyzvSA
	PebDREFNaKPp/T7Fw0aQBqJin30nnE2lwcNF58eA4ICXk0/Vsp95cNolPRPTTveLO3foZm
	oKgprRA1xqjhQ8amfrXZkEc7L7r8jYM8oMC0e1NRGIPVC/s8GiJzIYiTohpH0473pF0SYm
	6m8mn7P20jD4nny4dnjcPK9spuU6X0ZGfMx9ufht/i3v07F1VjSbYMZibg1mEhrmBkEjBG
	dz3XFVoIsdKwcqY9lyJ9EzrGh4RnbHJdzIH/uwTtzuaCbUEcdKqv2s3ibjn9Xg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:44 +0100
Subject: [PATCH v3 03/14] dt-bindings: pinctrl: qcom,pmic-mpp: Add PM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-3-6ddc5acd978b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=1273;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=A0fmQDK8m7oxJnEMI+GXPI0MVrZif3Z38lQBRjITpDA=;
 b=hhnjY8odk06rK1S61Z5megT38z31/ktCL9JcthBjdVSCIwiwWoJN6K/+R59Z5o8wOslRgsYp6
 se+VChFqUY2AOV4i+2DeRZrIqjV3o85b0lr7jln2J63M5LLJxAHATNz
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the Device Tree binding for PM8937 MPPs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 43146709e2044d9dead08a6786b98672ef766629..9364ae05f3e68f3a2f4dd78ba3c0f94b3ccc3c51 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,pm8226-mpp
               - qcom,pm8841-mpp
               - qcom,pm8916-mpp
+              - qcom,pm8937-mpp
               - qcom,pm8941-mpp
               - qcom,pm8950-mpp
               - qcom,pmi8950-mpp
@@ -92,6 +93,7 @@ $defs:
           this subnode.  Valid pins are
                  - mpp1-mpp4 for pm8841
                  - mpp1-mpp4 for pm8916
+                 - mpp1-mpp4 for pm8937
                  - mpp1-mpp8 for pm8941
                  - mpp1-mpp4 for pm8950
                  - mpp1-mpp4 for pmi8950

-- 
2.47.0


