Return-Path: <linux-pm+bounces-35745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714EBBEB26
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EC41895918
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45802DECC2;
	Mon,  6 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRoJhF6J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688472DE6F4
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769014; cv=none; b=j2FpDnOTcA9fIS3+Yxa1VHCHxBS/EW40hkerlYnRV/F9XrnevuZ73J2Gux8cWrL0e1LY4Qrc3o0/gYxnUtYgvzhhsAP7DeIV6tEM1MeQGfi1C//oUKyFnQREsOKZG0NuUfhIdrzrrkyXVHfI72RrCfJBav7imBjjt/nmWcMsThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769014; c=relaxed/simple;
	bh=MmooWtSwyNxH8293LjogrmzXAohDxJ5oHpXuWWJ/W58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJ5hY3neBPPh3k0KK+neCr4QeGZoyPVT9XrJOW2+AyAljS9zz98sxO9n8ATg/7iVtJHqJs+J4IUKztatAHkg+2RlczvVTD0hUzNAoiaHewUCBVFFT93XQFuUBl5Rue0GPqn9Oo5bQgCkwf6V29oZCLMaqpQpCUTmnDA0hlWvBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cRoJhF6J; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4f323cf89bso26984366b.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769010; x=1760373810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO3U9E5jlyRzt5gakHuWl7JAgxXNMoK2+FWGHF/5Pz8=;
        b=cRoJhF6J7TaAYBQYDdqshiI9axVhTXcDH+DiQNXjG0rQ92L8Euie5LolKSJMcSP+3b
         Hhxhb5wJJ1j4A+kU7ddfBmr+Mkg2UJ4vxttG7qoWe52d2W0ycgbpI97lR6U82mUZ2TsJ
         VNDD6QNS/ZSNjw3yroABVRsfcTSE//yxnDaC1+IbRTQCQdRjxKaIJ9bitmc9mtPr9nq0
         kSiusIFb2OVSEtO0DWoadvmG8dwTbqT0H+S7JDNNfUxtp0p0qcGBwbxTXF91yq4t0P4M
         f8WRkQIJDiGr0sT0bp/mmy8DEfwagcUz2MTiQG/4wjsnJ4KETw5RkU1La/0WVRMbKIRE
         zhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769010; x=1760373810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO3U9E5jlyRzt5gakHuWl7JAgxXNMoK2+FWGHF/5Pz8=;
        b=qg8iIJTxHYha8hZJ+/9KrYjsTN8h/C70idOky7LYsbXIvkP2ppI3TTNeJHPIrdm2DW
         MN0kMnuBxAWVeL6Gcr9QKtktwKmYDqZp8vzfIyhtZFh7QBxQ0/Yc/tEW61BUAvoajmyf
         KgvAtcAye1Hx9khmB42bIHi3WjKaG9/uruLORwEDtUiIxo2Dy5d4yJ85x7TCzFW5FcZ0
         4d5XiGUg97DoK02rehAtptlTmea2ZxjQjbBs3SLFMfAHQisz4Z0wy28wD0Xp68AKiD8K
         FPcWWh5eWncw6Vm7Cxv3T3UIw/e/dA9ulXXzKuugJD4aHFoQ96/9HvMXp2EdnGau3YMl
         0gZw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+z92J7YKDmUkHPCenjIbsaqNsQw3PrF4vFiCllRblk6JVZFl46PgdQgHmSH3cbeeZcLIUhvvxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX63I93t5KT3qqALzglQHr4yDTmsKEzK7d8S1FLUidb5mcEqUY
	mjgt7voa0ykFioPYz+achXqGcaGZJ7fK2iBQxgKZ44tWQvYeSpcGGr+8IZTeFmMB5Cs=
X-Gm-Gg: ASbGncvACer/S1ztHbNI0npbwPCN291LNIeAOJAv88EIUxgkmG4rCZEgMwVB+WzvFGL
	EmhHSiUPpCIL62BQTFN8XYqnrKVrc5zkSQNj+zq41Vll5aAjF7DGpLF9LQFUxjHV2fkAkeJ2rED
	CBdxNaRy6Gv+JrF+xiaWpM91HlKHQiZ+IsQsJXgUK33drbPy51dNVnCR3PbAauJguJ0VA+HXUQs
	LdnadGq+2jvCTg6yHaXbmYNsCdMll6OTBywvkFfZlnLLQHC0yqG7/GJO56suP5iHrNeP43qn5gS
	H426adq+RV9YdfL7+HdWismkRgtbUP137nxH2jzDsaY+fbCdBCA3jxWduSgXBuujhDRwuvc/j5l
	uK+9c9OpdaX/I1SaM20ptrOj32+CFhHMP8gPxbE6xZpgyNc/P4mi4VSpCwGagXzPrFcemdXH+Oo
	QWkCUCHilixrph8YJ8Y9+gq/HtvLs5mzCtFldH2gue
X-Google-Smtp-Source: AGHT+IGS3njBrZsQ87tYM91STie880rOmzE7eSI7lZ+5noJx3QO+oaLr3u+TwbXHZ8Hk5CihM+ezuA==
X-Received: by 2002:a17:907:6d0d:b0:b43:b7ec:b89a with SMTP id a640c23a62f3a-b49c214bb24mr1487687166b.26.1759769010288;
        Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:30 +0100
Subject: [PATCH 04/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-4-f0cb0c01ea7b@linaro.org>
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

In preparation for supporting such SoCs convert the existing mmio
accesses to using a regmap wrapper.

With this change in place, a follow-up patch can update the driver to
optionally acquire the PMU-created regmap without having to change the
rest of the code.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
There is one checkpatch warning, relating to the non-const
regmap_config. It can a) not be made const without resorting to having
two copies and copying, and b) will go away in a follow-up patch
anyway.
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 78 ++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f53e1bd2479807988f969774b4b7b4c5739c1aba..383126245811cb8e4dbae3b99ced3f06d3093f35 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -9,15 +9,14 @@
 // conjunction with runtime-pm. Support for both device-tree and non-device-tree
 // based power domain support is included.
 
-#include <linux/io.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
@@ -28,7 +27,7 @@ struct exynos_pm_domain_config {
  * Exynos specific wrapper around the generic power domain
  */
 struct exynos_pm_domain {
-	void __iomem *base;
+	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 };
@@ -36,31 +35,37 @@ struct exynos_pm_domain {
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
-	void __iomem *base;
 	u32 timeout, pwr;
-	char *op;
+	int err;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
-	base = pd->base;
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	writel_relaxed(pwr, base);
+	err = regmap_write(pd->regmap, 0, pwr);
+	if (err)
+		return err;
 
 	/* Wait max 1ms */
 	timeout = 10;
-
-	while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
-		if (!timeout) {
-			op = (power_on) ? "enable" : "disable";
-			pr_err("Power domain %s %s failed\n", domain->name, op);
-			return -ETIMEDOUT;
+	while (timeout-- > 0) {
+		unsigned int val;
+
+		err = regmap_read(pd->regmap, 0x4, &val);
+		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
+			cpu_relax();
+			usleep_range(80, 100);
+			continue;
 		}
-		timeout--;
-		cpu_relax();
-		usleep_range(80, 100);
+
+		return 0;
 	}
 
-	return 0;
+	if (!err)
+		err = -ETIMEDOUT;
+	pr_err("Power domain %s %sable failed: %d\n", domain->name,
+	       power_on ? "en" : "dis", err);
+
+	return err;
 }
 
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
@@ -109,8 +114,18 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args child, parent;
 	struct exynos_pm_domain *pd;
+	struct resource *res;
+	void __iomem *base;
+	unsigned int val;
 	int on, ret;
 
+	struct regmap_config reg_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.use_relaxed_mmio = true,
+	};
+
 	pm_domain_cfg = of_device_get_match_data(dev);
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -120,15 +135,36 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd->pd.name)
 		return -ENOMEM;
 
-	pd->base = of_iomap(np, 0);
-	if (!pd->base)
-		return -ENODEV;
+	/*
+	 * The resource typically points into the address space of the PMU.
+	 * Therefore, avoid using devm_platform_get_and_ioremap_resource() and
+	 * instead use platform_get_resource() and devm_ioremap() to avoid
+	 * conflicts due to address space overlap.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -ENXIO, "missing IO resources");
+
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to ioremap PMU registers");
+
+	reg_config.max_register = resource_size(res) - reg_config.reg_stride;
+	pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+	if (IS_ERR(pd->regmap))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "failed to init regmap");
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
 
-	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
+	ret = regmap_read(pd->regmap, 0x4, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status");
+
+	on = val & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);

-- 
2.51.0.618.g983fd99d29-goog


