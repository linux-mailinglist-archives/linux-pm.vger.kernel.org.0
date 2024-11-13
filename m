Return-Path: <linux-pm+bounces-17489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC89C7849
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C5B22DE2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF42040AD;
	Wed, 13 Nov 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CA0q+HMn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F2204012;
	Wed, 13 Nov 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510717; cv=none; b=kgXFbCQXBEtI2EyTPOYyrt68PltWJID5JcNLU87svhbrLGXuufu633+L+RhPTMoSqgYoywqvLLdJeYcScSIm5Ktlh94hLSVxuJwN3tYOOdMnS0cwgNOTJCsk9gTkNpkNS2hCRlSmSPhYFe2JymRWrjsHT487y/Gvq24yUWHIf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510717; c=relaxed/simple;
	bh=HpsJRRqcEB7ubb20AIGzwyE59bS3PSN7BTK6n02gdPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG8N2yOqoICm1hJkZOdA0B6FSwY006cp8J+4YtirNTabkpxUpMN+LKp+MWwmZIyZgIka5mZmY3K9gYB+LH15CQSqmo8W3QRBtpn9xn70RoVzNJ5y6z2FMpJ/o0yO0EVOhFyj4YzViy4zApV57ZTIF+/Be/3CwJMoPXeIk9p23/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CA0q+HMn; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C230F.nat.pool.telekom.hu [37.76.35.15])
	by mail.mainlining.org (Postfix) with ESMTPSA id A3914E45D0;
	Wed, 13 Nov 2024 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJVsYRZf77zXzY1oz4aX5qV6KoAi5dZCp6QEtJjBO5E=;
	b=CA0q+HMnhKFya6++mYh2T9jrP34oixI/4TeRCFeLU0+puIBsyE+rkArJXpudt26PG/Hra4
	dZeOgPF+eZteMb0ogdwxCc/Le+xP17RRTcPabcP7+YoYL2M/a8C0tRukYfd8BuSdEuxlak
	mCkviMK8O8e1f0vc2S0YUnmuDDPxTpinjzlj7280XHPBCh1FLYyiEJBNKNDkJUWWx2oY9K
	ElusUCV2qFlw1E3AMvc+gexw9A07/DCnyCZMIFlsfmGDXcCG5CZUsyZuiKb4yr5U1Fqx+X
	S9V91E99Z+TM/oe2Uk9rETUldbiBalSnaQDk7m5SXkcremZPwUZ1warB5KKE+A==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 13 Nov 2024 16:11:45 +0100
Subject: [PATCH v6 04/10] dt-bindings: thermal: tsens: Add MSM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731510705; l=935;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=HpsJRRqcEB7ubb20AIGzwyE59bS3PSN7BTK6n02gdPE=;
 b=k4bUXlCTDZ3BcmnK4zTBBazd7ta+SyItU49tPvYsyn1SmwgcviUmrw+mKNYrhCLz8hpGrxBtS
 vdbcRcsIlt8DtxUqxSHfMdaFnOB0Q04C2YLACH/Oy84PLRLEDEaYqPE
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the compatible string for tsens v1.4 block found in MSM8937.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc8195500a0e7bdd51952a558890b35935c..f51656b672030b12ea0405fd392af11056093be7 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens

-- 
2.47.0


