Return-Path: <linux-pm+bounces-36288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB9BE468E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CF81A64C39
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFC36CE0F;
	Thu, 16 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFtD4zJB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88504369973
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630337; cv=none; b=AMWFQl29UNNFndMjmRnXIIWuOvayzb8LTgG178f8PMutWwfEMLUnoVxe/xInePU48rZVKBF1u5bz4jCMfgizBTCfWR67CSSMByILop64E1ZnVvzLfIPzJbHxU3nkSMdqmjO79JpxV+sSEtAd4zFhjYsol2yeNTQ56nzx0vKuzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630337; c=relaxed/simple;
	bh=/ffMxuodyntRU0TJwCLIfgdiy8tvJ3D6CLikLFYkO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr9bKWI5LhGqdbxtbOY57m0eBKw0TTYpKMPdNTWgUupTImxNzVo61Doyv1UYzMYKR4JWxWUykBjwVWKedk8VKuTAZOPCzRuBuzon/TpA2OrDVRjlTcuwb52+A9lM/55t+C+MAJHqY9rCq5YS4fA5QmhopcFtLMRzdxfhdgiu1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFtD4zJB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1773177a12.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630332; x=1761235132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DqQ6MoGys1zapyNUJpLRuxdOB+fSzbQVKEkSbvrKC4=;
        b=iFtD4zJBDE4EjW+2cTWPAgc02LwhOH+o7DOSuK2VA0Xggja7MlzamKSyHLdTYKpzOO
         aP2Bn9LyadytRRPJuF4A4V4H0ZGWvBejqumysnUmiS2HzzlCHmK+sESOT6Vnp3rXu1Uz
         IZcjFY488xnl1pnlk0l8catogL2GurjI54+npd4BGqA5KFiNNDLSCpeZzSFPFXm5GSPB
         AkdXjmpWl1POriJb7nVQXJbHL7Tg/+HSqaTdjhyV8hJ6MFZRIJKFph+wrMByzWTGTAQa
         hqeraFg3D29mwI14enlQwRaD0BU2phbKKTSfvfzqPv3M9NPtzcJLVPz6bkbmvCgl2e18
         w/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630332; x=1761235132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DqQ6MoGys1zapyNUJpLRuxdOB+fSzbQVKEkSbvrKC4=;
        b=FMmA8LZ32dfX4mB+kNJ91Fb9uyPCv8/8H+pLOi+kYlJC87pHhYAuIzY0TqknaW8XMK
         M4RxgTJjP6pENxhbQ4pzzfAJ4HmqsGoTDyYqtgdWIea7tb38NiFPnaScq7efAM16X0RX
         W1+cHmSvSprEcsVAxDCplihqrRYyYlsL8hMNatNjTOsxk3Un/N4gOIarVJXuHaaPlzMN
         Bs2kHqkEutJef2+hXFhv03X6LYoJBzaDI+toPUl9cMwZ7t+3EbIZrUq3/eKo2co6CW7Y
         JtQSWJioP5reUuVY93p4t07qWGe7wRP7zubRrxZ3EAT7j0XmOTQPxGqS/T+gCyySNpJR
         XYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTKQNJbK3JywTKLcR8UGFUuQ4gf8FdQ55MHyP+C5I2uIXGv13982HgxytA4B8dTKoTMYnwFC+vgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMVimxctIRfbqG793PF/fhEWoq3MQnoBOR0nxBGttpxcWTiVs
	YJTC1nIbHIHeyMqehZXWQxLNCQaPuNH+gtgdHK0PBYf8pV0WedzuYr9qaJa7Uw5Y6nc=
X-Gm-Gg: ASbGncuhjRtzb5RqzVtQjVqfEnikdLaPfXHL+rxD25PkweAfUlJA7mS0D0Tx+0lqkfM
	lZpiDeJtLA3qYqKida3jGh7BLz8ZmtrY/3/xwEVIr1EYy2CHs9Xk8xzNjpOyCnNmXr46gwZu4be
	o0YoVDVo+Y8Xt88nLqgPMn4likWfYpzrmEB3QdsEB2WhIDGuuYEVgk+Uchj95c7Tt4/IrdJMxGZ
	0ehcnXsGHpi4dc5WXR5KHQ6ZHcvQFDhtf4R78wXmFjx20bd3r59sEF1ixtWlyq+MxzCUNmarjtu
	dKMq9rI7apnSTLAennttvoQlQRNx+OI3cQukzxAuS15isNQjpikuTP1uZ6chPGXMv5h57y41i/7
	U/N0JTYERhOlxo2bMSHxF37FmoD3wWm7JgTvaN0U4eeym/6MRN5LbIYNI0OKynPfC8vrSw49NhW
	4vnpaBkiR2RNvQzFqQof6tI0D+4cygjmKXs3RvsmU3cUXt9quKuBd+AOARWRvse5J0R1U1xKVqi
	RtFy9Rx0g==
X-Google-Smtp-Source: AGHT+IGbtiixleiqyswoz3qLTql2jI01A11bbfMUkIlJUu938gTSGbLcf+e3VcOx41cjcQhTYXkCpw==
X-Received: by 2002:a17:907:3daa:b0:b5c:6a00:f8da with SMTP id a640c23a62f3a-b6472d5bbf5mr53175666b.1.1760630331578;
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:42 +0100
Subject: [PATCH v3 09/10] pmdomain: samsung: add support for
 google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-9-7b30797396e7@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On Google gs101, direct mmio register access to the PMU registers
doesn't work and access must happen via a (syscon) regmap created by
the PMU driver instead.

Try to obtain this regmap using the parent node in DT in case this PD
is a child of the PMU and fall back to the traditional direct mmio
regmap otherwise.

Additionally, the status is just one bit on gs101.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 65 +++++++++++++++++++---------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 15a1582aa92103a07335eb681600d9415369fefd..a7e55624728a62545eac049c9a51012a229f44c2 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/mfd/syscon.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
@@ -78,8 +79,15 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.need_early_sync_state	= true,
 };
 
+static const struct exynos_pm_domain_config gs101_cfg = {
+	.local_pwr_cfg		= BIT(0),
+};
+
 static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{
+		.compatible = "google,gs101-pd",
+		.data = &gs101_cfg,
+	}, {
 		.compatible = "samsung,exynos4210-pd",
 		.data = &exynos4210_cfg,
 	}, {
@@ -107,17 +115,9 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	struct of_phandle_args child, parent;
 	struct exynos_pm_domain *pd;
 	struct resource *res;
-	void __iomem *base;
 	unsigned int val;
 	int on, ret;
 
-	struct regmap_config reg_config = {
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-		.use_relaxed_mmio = true,
-	};
-
 	pm_domain_cfg = of_device_get_match_data(dev);
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -128,25 +128,50 @@ static int exynos_pd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/*
-	 * The resource typically points into the address space of the PMU.
+	 * The resource typically points into the address space of the PMU and
+	 * we have to consider two cases:
+	 *   1) some implementations require a custom syscon regmap
+	 *   2) this driver might map the same addresses as the PMU driver
 	 * Therefore, avoid using devm_platform_get_and_ioremap_resource() and
-	 * instead use platform_get_resource() and devm_ioremap() to avoid
+	 * instead use platform_get_resource() here, and below for case 1) use
+	 * syscon_node_to_regmap() while for case 2) use devm_ioremap() to avoid
 	 * conflicts due to address space overlap.
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return dev_err_probe(dev, -ENXIO, "missing IO resources");
 
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to ioremap PMU registers");
-
-	reg_config.max_register = resource_size(res) - reg_config.reg_stride;
-	pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
-	if (IS_ERR(pd->regmap))
-		return dev_err_probe(dev, PTR_ERR(base),
-				     "failed to init regmap");
+	if (dev->parent &&
+	    of_device_is_compatible(dev->parent->of_node, "syscon")) {
+		pd->regmap = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(pd->regmap))
+			return dev_err_probe(dev, PTR_ERR(pd->regmap),
+					     "failed to acquire PMU regmap");
+
+		pd->configuration_reg = res->start;
+		pd->status_reg = res->start;
+	} else {
+		void __iomem *base;
+
+		const struct regmap_config reg_config = {
+			.reg_bits = 32,
+			.val_bits = 32,
+			.reg_stride = 4,
+			.use_relaxed_mmio = true,
+			.max_register = (resource_size(res)
+					 - reg_config.reg_stride),
+		};
+
+		base = devm_ioremap(dev, res->start, resource_size(res));
+		if (!base)
+			return dev_err_probe(dev, -ENOMEM,
+					     "failed to ioremap PMU registers");
+
+		pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+		if (IS_ERR(pd->regmap))
+			return dev_err_probe(dev, PTR_ERR(base),
+					     "failed to init regmap");
+	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;

-- 
2.51.0.788.g6d19910ace-goog


