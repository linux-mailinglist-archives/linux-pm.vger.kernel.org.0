Return-Path: <linux-pm+bounces-35749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7D9BBEB5C
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DC91895E9D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B482DF709;
	Mon,  6 Oct 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEuvZG+A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27152DEA94
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=L1Ieb9u+Do2YE9vA/zZPwN/R8Oj10vjMOFPj3fyYSb46UhdN1foKxs4me9AnjSPecRaH+2749FgEyV2gXBjgaN8tH39euqXJjsU4Cwnhnl3mPvDL2oJ+oJrj3BTaWxN07QMTAW3mzOOubeeNCiHEbo0ZFRKi/n03bOzpnW9O9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=vc8UBGPhuDSOYJ9/vAmaIt+O2yLpd9dPu2EvvobJfog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaMlZycWuprfT5fm+iGNzywbYBimpZ/wyg5AcKLwH6YkWYYz8b8OtyYsohJmIjaGl/fJVjVUsIo+29OgDc9+94yC1KHR7hgukXfNqSAS9Iyvfgp+YW9GnSzsAkViSqIaqZEGrdT1gD2bUWhB1xy9It4h8HU8UMFjeJpSG37Iszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEuvZG+A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b403bb7843eso1059930266b.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769012; x=1760373812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVe/h8oE+b7BSIsHHmcvuc3lfDEBo1cFpLLSAyL8B6I=;
        b=LEuvZG+AHWt3imcJMLDzZp/ILlABXXwELXQzDUo7k4DDKDVYxTXLYpVJAG7vHLCumJ
         M2DhzwzqjhLYu1rY5xehbPvTDVZ+UNZOsQqUeRddKm9uqPQ7rJE5HvnJgl1nTeZAoOoB
         5eiM3nmQoEBFajK1sKKW9CZRKR60i1kqtZr5raCyWigS50nrj1NQ3FvR6VnQetfGh5UX
         e96PId1m2u9hMRWDfoTgWU6/DixYLswDqPGqNh+Ee42cuBRR61Gq251qL+l72+DcjrPB
         z3qUtMuQzvdxUfimC3/CXEii9b9RCrSq2J+tcfS4UZalCriTQzZyj+4ON3y4pb6udTdH
         cTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769012; x=1760373812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVe/h8oE+b7BSIsHHmcvuc3lfDEBo1cFpLLSAyL8B6I=;
        b=AFsi2j2FryiYkjcWfnJHdyoPizVOWJk+OxWRDY0vrTdP9nd2LHUlTn+ufrinV/fmoR
         5oRK2S6fMlxI4uyIIAuXSBqlW0nbPfCTJ/PTrAdXVXoebarV+41YkdphZSyQFa6hE+Wl
         MNy6I3WBdgOz1nb2OWmMm+t6Cyf1zub3oatfsi6WBQBwCl/0I1A6Q48MeplibmdTBxHW
         HcZmzpL5GGO7gJkUEnqD9uKahRgk85crMCfLjW8i31HFIQOZl0IVVUDL4LvX9M0h7TdQ
         QpWI2SlIEuZEazL/O50Nwpx9pwY9hHLE/wBUplXFZ4H6kJRIPQ7pLj5tioNTP23eWDvN
         QQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSV3jb5YK6WCUpwxjCzXXlTjpQdrnJAWyAhKC+mc4sdrCskH2nk5QclM79v5HB3s7jg0LrasUAZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGCNgxlppyNCtSiPZYP6Vvi8ox0525BBtNzlz0IiEgafb7fpt
	KSJ50DKML+UvCs/KJbw2nG7OCTPAK2QRPtvc/zKO71IhNFHUXr/LEgEDo2QBa3qkNgo=
X-Gm-Gg: ASbGncsqIKWrWZU7fckehTdmweU9n0gstInvpyv75LKmfCt44Zw2t3iGG3qhiRJ6NBd
	qyHrHhhBL8TjwNWhToYE9HAZmnqf+ggvtoOr/edj8EtWrYWbNxX26AuMr4+uBvvlSrcDXKg5A8O
	1e2rZTuNbFtHbZY+QXo7sIplLa6qzhJMrelYiGzPNMB5AgvWsjhwk+flOSFKSa4wZVCvXiyYCNy
	n0wjgrnIKrz/6OfXuIRLVFz+JQdOAw5c+HW164t04kGUX7O8Xr5DJ3yH3WbDS59mz0Otx/4IIIO
	+YOV3qTFUjzjGwX0RsVMHcXrza/sz42/rR4pbyLe0i1CqN2+7G91PlAC9v79/ZQHY6WYDqEyzRZ
	ObBq3qZuNlRxWArIkQWhFsJWBdEaIby2FZaMfAE570DOR+pPpiNlTVckzM5JHDlkSq+0NnZvUhJ
	XAsRCdV8i2Zc+OZ0Sy2CzDhnl4dj24uunQHUsZ7jcf
X-Google-Smtp-Source: AGHT+IHyfqUJ/1bbZ0b+uTuR4SP9fVf5ypcK6bma2PpVrFAj23Ekd8i6RkAsU0S6e1awiYiWiR2poA==
X-Received: by 2002:a17:907:3ea1:b0:b41:297c:f7bb with SMTP id a640c23a62f3a-b49c3639c42mr1623024966b.26.1759769012219;
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:34 +0100
Subject: [PATCH 08/10] pmdomain: samsung: try to get PMU (syscon) regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-8-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
(syscon) regmap created by the PMU driver instead.

Try to obtain this regmap using the parent node in DT in case this PD
is a child of the PMU and fall back to the traditional direct mmio
regmap otherwise.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 58 ++++++++++++++++++----------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5a87802cff394945cb0202d08f2cf6bcbbcc774d..c1b5830b2ad3e8b272dcc8ebc364be49aa7fda7c 100644
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
@@ -107,17 +108,9 @@ static int exynos_pd_probe(struct platform_device *pdev)
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
@@ -128,25 +121,50 @@ static int exynos_pd_probe(struct platform_device *pdev)
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
2.51.0.618.g983fd99d29-goog


