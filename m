Return-Path: <linux-pm+bounces-17991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CAF9D6C24
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DFFB213C5
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9901AE00E;
	Sat, 23 Nov 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Lwyyc3sE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184151ADFF8;
	Sat, 23 Nov 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403633; cv=none; b=bYaFCpQYsqUKYbeTNkAgL6G3pnVe8GoLHqpl/hhk3j2INOd7iE1eCSbQLgssbkPXxW0WvPOGJkKlpujWP4Q7OtQel0sdoEN5IShi4b29IYAKH7p1PTlQ2RcpQn0yIBjL0Dqrix/IKObHoDM3OmlCX3IUyNtfqUIIP5N8+dq9TWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403633; c=relaxed/simple;
	bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8aLPZCfunC2O8Ewv0aXpeKOSBPARyeZK6/GZTd7DI/gYTdzAOsfmTcFWlIhbxSKB6achlrPrriKJFvrKfAKo9laTRjZy2/cZKbNf+7CIpRhrZIJrN92t5oRHVwFdV5bMgeSu1edNmKqZ3dyAWSVvQRy94o60jpHHdl8M+pkvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Lwyyc3sE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.149.162] (254C22A6.nat.pool.telekom.hu [37.76.34.166])
	by mail.mainlining.org (Postfix) with ESMTPSA id F2C4BE4809;
	Sat, 23 Nov 2024 23:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1732403626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Y4yxwqnDss/PAt3TvJTQZaFUiFNkqCyH+WUzWqZ+0=;
	b=Lwyyc3sEUmM8uvq7SSdfmG7lYrvM6s1/2UavsOgW7G4iMRDSRvE+716OXLIsB/6RHumbRc
	MuZ4YI74acEBc/AXlzlik3XvF/wC3YL+3/BfVoa0Q5ZMXQY12i0DdzfLpbBKJR2CmJpIlh
	8EwJBomV0hLAt2l3Pd6txiWJb1h+RpDhmJU23gNSXjayHP6QpEg0rF9/EuwF0xIHITn4s/
	X5lkysR+U59e7ICmvpFCSWyMgDtbK/q28mPKf83doWFB4OIRPhN2weUWwrDd6cm7upTJoa
	oIOP3yFVnigQ1liDtJ6wp5WBKZGAh9oEp1veAAGLsYiQ+RYA9MfNIa3CDr9ABg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 24 Nov 2024 00:13:23 +0100
Subject: [PATCH v7 5/8] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-msm8917-v7-5-612729834656@mainlining.org>
References: <20241124-msm8917-v7-0-612729834656@mainlining.org>
In-Reply-To: <20241124-msm8917-v7-0-612729834656@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732403617; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oSFXD5koz0bnImj9AwyYkdxZ8tPIPU4UsWyonhEengo=;
 b=FkJC7sdzHCpxFOJWcU0KRFqYezyynh6qJ+w6N6dEFsu7Yhiawu27txVWYxDypxzGIlE+sLvHd
 YY+amgVFT1pAU9QeYsl2lAp//WlnaV4rgcoyKMN7m8sr1PeGtG1ZKhN
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


