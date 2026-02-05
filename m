Return-Path: <linux-pm+bounces-42179-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKS2BiwPhWms7wMAu9opvQ
	(envelope-from <linux-pm+bounces-42179-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:44:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F0F7C99
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02553043BE8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7333508F;
	Thu,  5 Feb 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RueCvCdM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BE335071
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327757; cv=none; b=l8J4RSHyoj/nQvMDzUu0lCZ5P7x6bi9GpvlxlFC9vH447Mcq05SH3fPm+kDgz6XOHNtcxyGrYPhvR9EIKOJrfLMq216yd6DUZ0rWsM9qqX14SrZdYVHvy69dfcP/PSyNZwre/6yh1B/fyQwW3IuANi+L2ID4mPYhWBRLwo0HY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327757; c=relaxed/simple;
	bh=uB20qy/vVXEtCtRT2uVJX5h7neGT+7RwSgorsCbFxOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHLRq8CyzOX+AKDSYev2wbH6QJekYi3EsdGbu2CE63LH1uQ3VvEfdXOLvvmIOpoC7V4Br7dJojzlVqViYDHjNx/egyOt6HlStiDfPHmYDY5KO8tpykgKYwWRNgtJQ2IW5VjXKFnvyKEJx2KIb9yTJYaoW6Y02su5aJCKTZtvieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RueCvCdM; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso2317178a12.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 13:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770327755; x=1770932555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCXzqfHYm7jOM4K764nK1wT55TlXGLUYpjCnio4Cc9c=;
        b=RueCvCdMhoeKF06r+/Cy/8n7XV0b0lzrBM70SsxeO1PWJluBXcbvZsC5HwJj/gX6zT
         EcriDYM4RapbIsO7jzYZWcal5OTn4+TT4oI5WLRNGW7ecZU1SQC4wjjyAgxHUYwJQQsw
         mQWS0YHpZu7kn/zC8G+CUQ6/vItV1fDNMeX0pvDzI+IF61DmbMQPs2+pky6b81LjdzmF
         NV3UaFLCIzqxXkkBQD9gGTcoBLpA0gE/m+VsITCvoDP716cuF7K7ZQiDJiYHk8l9urhP
         OrTeiOrB5gWZ8IVd/Z5qDd08bAqMXohHOYJuH3y3eH3nQH7T+zm2CsKcwEoTNz92DDm/
         Bkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327755; x=1770932555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BCXzqfHYm7jOM4K764nK1wT55TlXGLUYpjCnio4Cc9c=;
        b=VyphavT63ZIFrtfR1iWCb6t1tQQZ8beWXU4DJOf5kCmL7jPsAfgh927mr6cpZQ8Fl6
         pqvIWbpE1xaVlDRh/eH2ARIehzfluVHF4DLr6XpmgjUv8VE2+gORT40SlXuQfyktYB8y
         dtwiAa/ek/Kxm+ZmOJ4dCyuD9+j34rX4AqP3E7tGhiSXS2LZTd2rMYot942BSGyk/23w
         qaM4wLzPy4TzmxYgFM0zMweQevbb477xSO6mlw55JSwf5GUf6sL24h/z5cGI0170mVaO
         c0qQowv1lwZwaVgdLaFpdpCw8xgvCsTD+d7t0Bv2/Cbq6qtMm3XI8wPdMp44EVgM61Yx
         rR5g==
X-Forwarded-Encrypted: i=1; AJvYcCUNW66smoWj2CBjLF8pUbntL+bs672rTNInvIIcveKo6fjtn+U984SrkX3M/2yt1GagQbh6uQij3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrzdh8e0/7S6Et3QAGAl42iXEoUPBjc0HaFX+8JEXYp75lRc3A
	nkyT54GwWTcRVdGPk9o7eV1Q4o3/+B5EKfwzC/nT4hrx3kHpnSOAHmnMMoJbrFyD8Jg=
X-Gm-Gg: AZuq6aKEXutDY22QicKyNI40NPmKh20tLWMLbAE/NE1LaZVLisuGAwE1e1ZHVubynGk
	CgjfSjkN6F3eVGrt9KTgpVb74wF2UO6DWFfzfuLL/vvhFqhXUHMoAQItE5cMV6bnKsbx/NpSQLL
	fhNGhFDYkdfh4qtorneXQu93vrBKKcuVVELcQAGj+/pL0C1rvb7sf1h3tehkg6WHCkfPCGZpQFc
	TNlpah7nPlqnibr3u4QAdX7xPJjHQDMHPZRz+8udsY2m2hmuiU0Rrx5Q7MpgdanoIdhiZPvUtoB
	BD7oBUcD4kCrT3U3t1gBmsfGX+xzGcUPv90AL9+VY0aPPuYZquujFTC8NqWErHcfdCW1sntACEr
	4X/8teJwYTcVWje3R1XtXRHsUCJNIbtDsO/xAZJLMiTbVgbD4zppmSErQ6148aTTtRJfhlIU2Ok
	oZwsUkxw10wmqktHf7chtZuT1Khd2qKXPY3lSy07i/BtKwTIxFCX8bxfENPXiWoyo0GvB9FLFn6
	gI/2g==
X-Received: by 2002:a17:907:9717:b0:b87:65c5:602f with SMTP id a640c23a62f3a-b8edf2f9bf5mr26839566b.34.1770327754876;
        Thu, 05 Feb 2026 13:42:34 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a0074sm21859966b.18.2026.02.05.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:42:34 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Feb 2026 21:42:33 +0000
Subject: [PATCH v5 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-gs101-pd-v5-5-ede49cdb57a6@linaro.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
In-Reply-To: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42179-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 957F0F7C99
X-Rspamd-Action: no action

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
regmap created by the PMU driver instead.

In preparation for supporting such SoCs convert the existing mmio
accesses to using a regmap wrapper.

With this change in place, a follow-up patch can update the driver to
optionally acquire the PMU-created regmap without having to change the
rest of the code.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
There is one checkpatch warning, relating to the non-const
regmap_config. It can not easily be made const at this stage, but a
follow-up patch allows us to make it const and the warning will go away
anyway.

v4:
- rework the loop in exynos_pd_power() slightly, to not return 0 early
  to allow more code to be run after pd on/off register write without
  changing the loop again, required for gs101.
- add error message in case first regmap write in exynos_pd_power() fails
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 83 +++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5c3aa898308793d424fb761c58ca01ba2580aeb5..3bcba7d38ac1572ef4bc2f4052c904dd6c4a7bfd 100644
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
@@ -36,31 +35,42 @@ struct exynos_pm_domain {
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
+	if (err) {
+		pr_err("Regmap write for power domain %s %sable failed: %d\n",
+		       domain->name, power_on ? "en" : "dis", err);
+		return err;
+	}
 
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
+		break;
 	}
 
-	return 0;
+	if (!timeout && !err)
+		/* Only return timeout if no other error also occurred. */
+		err = -ETIMEDOUT;
+	if (err)
+		pr_err("Power domain %s %sable failed: %d\n", domain->name,
+		       power_on ? "en" : "dis", err);
+
+	return err;
 }
 
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
@@ -109,8 +119,18 @@ static int exynos_pd_probe(struct platform_device *pdev)
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
@@ -120,9 +140,26 @@ static int exynos_pd_probe(struct platform_device *pdev)
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
@@ -137,7 +174,11 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "samsung,exynos4210-pd"))
 		exynos_pd_power_off(&pd->pd);
 
-	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
+	ret = regmap_read(pd->regmap, 0x4, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status");
+
+	on = val & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);

-- 
2.53.0.rc2.204.g2597b5adb4-goog


