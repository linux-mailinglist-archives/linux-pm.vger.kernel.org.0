Return-Path: <linux-pm+bounces-36282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7106DBE464B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AA8542B98
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72896350D68;
	Thu, 16 Oct 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8BF5JLG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C034F489
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630329; cv=none; b=XjxTrTrOFMVSxf+ZP+vpr0vyeVUDZJtI1sPdfW/VcjVM9/e+oPSOSfUNR6ja4QJi8IHWA5zQwT3I/SyyeGAgzsuh1LlbLj0rJ9HoRKTaqv1R8EeCG3wSwAmuo2hIARZ+9TWJF+thZkhLwVtDfjDCRZRSFEbRkc9twtzUcvdNoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630329; c=relaxed/simple;
	bh=EEsquKkEeBg70sExu6NBhMPgtI1d6LaAxzWYM2RtBsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQOjDxiurptl+fbZSqhdu0RJAk0Ew0drM+aUztxEQOn97gRTCbJ87qxeTx61N5aXNh0e9uD0LAiUO1JkNTVym9pdIaMzCHiUX7fvQ9Ds5F6nhSAUpwPm1zncGd5vcSwN6vpAPMIRlGQVPw7M89H+mwf9SnuibCb1zBM6vWJZZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8BF5JLG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2e0513433bso131052166b.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630325; x=1761235125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=Y8BF5JLGQdy2JlNx7sQH4tIZzRe4qTu/9sUTMSESdWKcTWhhpBxpWNpL7yuB4vlPEN
         RzsfEDLLgWjb8zZTK4hvvIO+nrZGGYz2WXTKCIbMEtyYKxSuPHh+X8l+CBJyGidcJoWV
         pDtQ4YxaYyy5zq5sSpoz/j6PWIXTSWNPxhMfnNNPb4S0v99l+jugV53p3RKzbRa+hf6z
         kw9msFoWi7CfiFU7IyB8wL4CEQ9SXeWWc4lmb+J/ri4F/tUcl1e6S7ow1c6YOXKc4vvF
         Gf7NrK+p9WJJTMCRlMeBRcA4jRrtIwhftVJ2tmjqgfVdAJPS/2tKryeQA4q34zD2nDf0
         NmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630325; x=1761235125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=FvCt+zZ4BjlMOCs6Oxi0luaHSAUuxRK9esLUVHHCAb+ouCQvuZ+8rH0gTYi5tspZsa
         XSi4GxziPRfQCsdc4eTcVGxhxin6qFJI6Ny8CTX4ZTLjH/ats4RR6Q5+IXDGaHfmdPYc
         YGsKXWZwSnmUeH+rvgdQUIIdzMiGbQBnQF9dZ7mN2cEX8cK0ygINXPG6b78AUgQvTPoA
         mZlOJWhYUMtZ7AjGdblBjJMzdDkcJVnQccXxs5vwVBTQHyeeMx+266fSfj7OPMvy2Sef
         8G6xz9iELrsLF8mvLLdBf03TeggPsZjX+NTby+cr6klYFgkxaRmljJeKNUlMhTURHwab
         7OwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaswzfeAavFrq+/PvPAKV6h2mU5MplPqBpOkArs4Wyslwm7WlpFQQRiknrHETa3g9hidi7K81p8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9ySDs0YyizLy31c2SfbzMCSJps0e+3ct1U3zR/nJSq3GXbEI
	rSKZQ4BaIPzYBVrZe+8LtkLAyScLhNqJ0nbKE440+2QSCvci4HuNjTpwfc635Jqo9cA=
X-Gm-Gg: ASbGncvZ0GDOlko0AoXYR075rf/bkQ4q9AP9406kszat0DqtiLccY3wTQT1U9E/Ekts
	kA3nuqQki28RxITON1yJo8Kz6ar51vn/ezhUOOghjmPmSLbxbvPtmpP+B6bveMU//PmoZe82Yzj
	HcUBhE/TfHsMWKEJiit0At23upgJrAIkHGqzX4hPyxEBNuVxD3nX1l5xe3bU144EaeM5S9uGqjc
	1a/BZFVkXa5KhZqTX4Gf3hECMfVmHr65r81NUg/kCAiqbpvFRE6Dzn24EML3YPI8lqb1DXhwcme
	D6FD0+l8tXbMbO6aMKLcuRUPcAULbzVvvKDzsKP8B5NrpcQTPRWjIxslLaEH49Ie6vyHHLFmAN4
	syr4lLC2xhOrk1ZbPvmJuNnEBVEOd71dmnISJqqfJQRYDZcdWemFZ1Ja+sc3NW59z3z2EFHANmt
	kHISm3XS89pP59GqZCmYirtwq7BcYQ/sANZ/ZWAXHBLJCx/W6oLDn/h9uvp4m/Xj4vT8wtqTM=
X-Google-Smtp-Source: AGHT+IGMnDfjfOzAoSs5yqEhzRvyTEgvB4V8vlEt+WcTbrwh6jjeesT23Hol4E5oowOHUJe3KnWaFA==
X-Received: by 2002:a17:907:1b21:b0:b3f:c562:fae9 with SMTP id a640c23a62f3a-b6475703a96mr48316366b.53.1760630325277;
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:37 +0100
Subject: [PATCH v3 04/10] pmdomain: samsung: plug potential memleak during
 probe
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
mark as fix, as this isn't a pure simplification
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b4b7b4c5739c1aba 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{ },
 };
 
-static const char *exynos_get_domain_name(struct device_node *node)
+static const char *exynos_get_domain_name(struct device *dev,
+					  struct device_node *node)
 {
 	const char *name;
 
 	if (of_property_read_string(node, "label", &name) < 0)
 		name = kbasename(node->full_name);
-	return kstrdup_const(name, GFP_KERNEL);
+	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
 static int exynos_pd_probe(struct platform_device *pdev)
@@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
-	pd->pd.name = exynos_get_domain_name(np);
+	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;
 
 	pd->base = of_iomap(np, 0);
-	if (!pd->base) {
-		kfree_const(pd->pd.name);
+	if (!pd->base)
 		return -ENODEV;
-	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;

-- 
2.51.0.788.g6d19910ace-goog


