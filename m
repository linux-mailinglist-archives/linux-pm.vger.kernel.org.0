Return-Path: <linux-pm+bounces-19051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1F9ED437
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500201889098
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2E201002;
	Wed, 11 Dec 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tsQSFK/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E181FF1D1;
	Wed, 11 Dec 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939962; cv=none; b=HlLSo8I9eNqdxarIZ0RM3FBAzxysisDqqUTcC/XmRscQMOfKKpgleB08Z8fx2xuRmlIvSA8uV5Frv4fR9MYvAwrEE+RfmYnItJrNMeQx6uSxFCXTP5jRqzPm2q89jUO0iBn8bSkKUrE9NKPnzZIr6ejR2vbod7fFZ6xG/SkSKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939962; c=relaxed/simple;
	bh=nC/6B+AiD7x+c7OE7+G7e1enP5dQ8/O/fmP4XWnpiRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEK17FVUeJ/Av2Nk/EgNcL/lXdF6zcPNcXx/u258oG9WTSreniUbDmW6dKur2mEShy6DGXdBMct0gOFBIvXM0aYC+A0qXLzSu48yQmMh9A+B7+TS6tQYw3flrLC66CsMgRK9yakQa5jTiY2MgqqSynZTwYhK1sGjS01EwzVB7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tsQSFK/J; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2319.nat.pool.telekom.hu [37.76.35.25])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4955FE482B;
	Wed, 11 Dec 2024 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1733939958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kwYWwU4ZgME90LqS10gEkiS5e7P29TBeHupCmtlZ9M=;
	b=tsQSFK/JAeek00DjJdqbAQSMGz+3FDGBuK2tNQqCWe3HIeBmZv52NOb7Be+K+C2qI+sKUB
	Xt5Jxrcnic3BZcFKSZsUvBCZRgsMnADxUSx9a01AKVC2w0GeFas72hzlxVt310ViPVN+nA
	0baYPfAQ1YlRqohdddmqrwRiatv4gLNYMHFrmkF4yD3bRACeWZCYrKEtnQwNWVZonOEp2s
	RBIXRNz70iiGYr0J/MoX3wLr0eaUAhPl1QCHDPQjaOCjcEgWYD0xhEVwZdudXKWMBMOxT1
	NsvllYdhLMcIsBpCZE4xNn6twyeS0NCHifqSj5jYvRkW/Pgfm7NykPN08el0ZA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 11 Dec 2024 18:59:09 +0100
Subject: [PATCH v8 5/8] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-msm8917-v8-5-197acc042036@mainlining.org>
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
In-Reply-To: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939948; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=nC/6B+AiD7x+c7OE7+G7e1enP5dQ8/O/fmP4XWnpiRw=;
 b=ggv8SocKtiac8bAVSKCJafeEIWa6QwWHMKufEL3+bnCtS5GQzthX/bty1eu+EV6j00bTpK+87
 FKHdeb+TO3IDIZKC8gM7BD2RT6JwocOcnwnwwCOuglgBbbAuWcvKj7k
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
2.47.1


