Return-Path: <linux-pm+bounces-36283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9EBE4654
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A358218C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A7350D79;
	Thu, 16 Oct 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIwgT0O/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4634F49C
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630329; cv=none; b=O3xyZ+qyjbRZXNuj1pJfhmJ559cT0UHx2NxakQJU9OEKCOvsuKY/2i3LSI6W7uYsvKJ8/NHA7rQby7JvD5k5aa0X6t8KtBazYYa5G9xOdY7PDGYT0b2dvkZKV5N4SlTCmOKqO8HnIj9RyVRkdy3ScqN7HDUR4Z6A9AXh1hmRVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630329; c=relaxed/simple;
	bh=nBudP7+99iBkFh3qe0ZdmQhnQbG9lraMj3SNNZddgS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXnCzjzHzpmf+QiGa2OVWTnmVbw87HGdSIxyJxcNEdYrVvQzer5YcVp8uaHj8Zvu4UyukQ2U4wLrtQ60TtufDZTfuySWMg4p9z1AfkJ29CLYvKYG8jLfhQ48Q1Q+0Ogk07fS3FtWwDDBUbROJGw8zOxnTTRcJmX0huFnqsByrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eIwgT0O/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso1580371a12.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630326; x=1761235126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sx/VxWL+zXIwDerOXQo/SlWkRBTA5eJCirxOIqSzME=;
        b=eIwgT0O/O/HgYvsar5WwyzGpzgTedaNg7vFkmfiuMi+WZxmu8AqNr6lDagvZ9aC29s
         QyvpGuRb8VAmXWwa2z/zRQSM16to99fOMb7xIqCSC2fZ81OrBNt8yRIZYxDKD2DsGdIp
         GP33Gfl8XVnFpGoyFwn5shib1URB1iYxe00SkK6F+K1YGvP6TiS5unZfPr1O0jBh/Rqt
         22xhOzrLDqR5lOcNmhY/QSm7Onc2dlscctAJJMu5fY13szShegKCw2oSmzA57WFTsjmx
         RQNWc9IG6OZmGhOsoSL5lEz3EGbtG2F3MbLgLs1Jo3J8e+xs+3eWfcgS2rZrhhXm/cJ3
         4KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630326; x=1761235126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sx/VxWL+zXIwDerOXQo/SlWkRBTA5eJCirxOIqSzME=;
        b=hqIpg03SJ6CvcRCScMbvJj+inIRs6bL9Mi4j9WjoOBjX7koQPtaw8ggIQrW5YEYGC7
         VVeB1+xiSpsAcerf1DUExIfkeL03nCHVp8AtslTmLm1bJa93TsmmQwjRj467Q7eFUA5b
         CjlqeQDHjcA4hSPM3A8HBnBKW6s50wbG4fzjOqh4yDSGU6ouo7Ya7xH4iS2y5MoJaMI2
         OzmeYo4i9YKIsynaLGN7bSix86S2GIjFNVsAL+D77gDMJctb5orMiiz8lLOFbZFnGssB
         WDtIH6NedB+r0oWKe5e1mdN+QuwRp/wm+NZvEh+0cx96ObCjOBbOObNhMSuVsGXDvQZL
         5dBw==
X-Forwarded-Encrypted: i=1; AJvYcCWnEmodWMlS15mhGFLbivFGC9fh/Ux0UCdGlMYw9eiZjD588wwPBhLBstuOZs8Q1gNMw6nL7eolVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmF79uiZu1q8IovrZboBg+y5G4dQ+IrY02HegotblYy+5GSyw3
	opQinWGuYEQIUmHGhv39EFeXKa6InZaAQqbPnhg6ookXe1oJnLM+V15ZoFob2lQ4+zk=
X-Gm-Gg: ASbGncvBC8g/Sg1m7sApmNJ0zlzHtStDpY+Hpe57ihTAACQeOS+IkTpTo+zP8NcOqJb
	wGJKn6Ubwrp7J9z0smxnoXvOwYJT6O4M6x4WT25tS+Ny3eW8zC5OhISHVMvz62fORIxVHvlSch5
	a5Xc6ivUPoC7SjMk0VaEBJLXbf1e1pP73bf7/7S+j0UU8H3gbStw4XwzgF6orGb4Ltz7Jbec6nY
	wYU8uYLDm6P7Dz4bX+AsD/aFZ43pYLCVnxq1uAkeHMok8SaH9BypWTYjEbAdQJRcZxo2Y8XTrgF
	GXLJMhlntM2o53gPMg4yKnS9eaa5j/I13jHQfgTt1V6OIcO8zbr9U4odGvuAwE+Sk86oAZNLa8V
	4sIwOzivA3Qsy5hhOrgmoqro7W/mt7jA9HNpNwtgcw0fSuidM/YChY6gpoUxu02R0tewlJx/S1k
	yQEvZ+sTtPTkTzUFu4vzUl5okORGxcIRaTaZpbSKoH86C0Ue9vK+X01uGpZpdB
X-Google-Smtp-Source: AGHT+IGK8Ey29vlNo00zlc+GOkFyC2bjHLvIDXKhESpfZnJ6rq6388SEUQEklyoTNIyqpHblnkTV0Q==
X-Received: by 2002:a17:907:2d88:b0:b40:33ec:51de with SMTP id a640c23a62f3a-b6472b60651mr49198966b.8.1760630325841;
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:38 +0100
Subject: [PATCH v3 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-5-7b30797396e7@linaro.org>
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
regmap_config. It can not easily be made const at this stage, but a
follow-up patch allows us to make it const and the warning will go away
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
2.51.0.788.g6d19910ace-goog


