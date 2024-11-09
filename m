Return-Path: <linux-pm+bounces-17259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9299C2C96
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7396282004
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA9199FA9;
	Sat,  9 Nov 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="AjeukKo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7119925F;
	Sat,  9 Nov 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154106; cv=none; b=qTUXo3Bcx1hQjsfQtZxm4gNwmblrg+c06+GsbyNCDXPrvTNt4OaLpmqyuKWG41GWeLMi5R1oQ1l+3Y6BRzi1D6s9FenrAIKO/VzXNbEwIH8090o+Lg2R908o+oH9FKMagzFJVV2F9lW9b/CuRhTcNUWC8ReKxccIvEbfeAULOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154106; c=relaxed/simple;
	bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzZimKK0A2x5/ZXC2ItOcBCRicfhyhFd9yDaBW0Hs/Z0RdM5W6Lade1mvjDeTednDArfnmYGnT4YdvRBXdGJlOufatRnkaLxOSwGyfi14LNHJQGlEUltqYjiQEhu4V9tPnU/UPP1d/vMLCdLcHvzjKa2MeqXw7J4uuYiHvxahqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=AjeukKo8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C229A.nat.pool.telekom.hu [37.76.34.154])
	by mail.mainlining.org (Postfix) with ESMTPSA id DA416E45C8;
	Sat,  9 Nov 2024 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731154103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Y4yxwqnDss/PAt3TvJTQZaFUiFNkqCyH+WUzWqZ+0=;
	b=AjeukKo8ZaGdvOttiS70Zg2Z6JhSz9juxl+MpbfRzsR/jApz7GgnSdY9d/17cLrbn/FyeC
	fJ8bqbwPzQ/s5sw7EuQeRejUJ215Viu12+2QK6pNdr801nk8eQxWf84qa9xt1OYkvkNeC5
	QooLORF8LQpcsmUBjg0xY5wTJyQ5Aq/BJczQvwxM59Zt2mhsN/+2CjjBvVMnMZSiV87pbo
	e8LIehInYWTRPpj8IIhXG3vuddn3V9QljqpJiylXH8w3xcgnjUr4FQt82bxUpuofRi3Jue
	bB+mzjp8R+0VDJVDIxIbDlx38fjpg7naM6BNaG4kvZ5B2e6aNsZUv04fSGaV6Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 09 Nov 2024 13:08:09 +0100
Subject: [PATCH v4 07/10] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-msm8917-v4-7-8be9904792ab@mainlining.org>
References: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
In-Reply-To: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731154089; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
 b=as90N8yKeQfy6SKqpGuQpR20GPyoGCWPCYgek8vfT7c75FHV3FOIGlt7mzsQIbLSVIvDHdA5B
 bd9ElBtMXOeDQojXX7ti/6n54yP2XPZn3vvfgUljYoVR+RBhXML1Xd8
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


