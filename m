Return-Path: <linux-pm+bounces-43646-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJnWABEfqWmg2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43646-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923A20B3F6
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C259830440E2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756062DAFAF;
	Thu,  5 Mar 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2ayCt3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488DE2C3245
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691121; cv=none; b=kOV7Ougqh/eK/JirHWRoC5WcVwKhmnN9SJ5k3ydQS2dXO8eKEgEgeAymFmF8fJZSa0Uazu3+0h6FfOWciVlhLh0mT11ksZaWTtAM+NdrhpnhpSQkYvY0nZGaVC9lcYZ028wgP+JZtZM7OddWIhSXqLUllRMrYNCNRo2gsI/40Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691121; c=relaxed/simple;
	bh=F1S+e9a469QdSHta0n9ziXmHQDihxHrwcFmPJNecLNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elT2W5YztXs7JERuJ1ptm1iO8enzC6vG9Fd2S71omn9qoGY5ijn0mSVZPpKW2Qev5DXGI8e4duPiBnw7sKpmrRTklKYApbEGJNOYjcGmesWRRapRg3Q1/H5w37YyhHr5+EjSGgWidxvT6DE2H91QdU/jOGuu5qUqA7uAjQ8Qobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2ayCt3J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b936505e7a0so571137366b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691118; x=1773295918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ65cMxmtD9hm2QF0vSs9PHPLSm4kdpoTVF35SUjEBw=;
        b=y2ayCt3JPfFX3wD2lcldptVQLlwd1cWpEDqtJQXWh9TZ44Sve3nVHsNKwCIOMe02Lo
         pu19GLxU6g+Ipkf0nfcmF1rLq+Xl+1Fvfvb5ssagOdY/QQnk2+2SUek0jYbq/on7Goxf
         fk5nUFFuh2e9fSof6lN4hD9m4md0V9qabEQJwLpALBQVOhNb2WqWWwJtr4/IjyaAF3ZZ
         we3nsfR9nZpKJP79Y0/NpR8Tt3SteBRnaQW/0UInSzug5WgCB/txTljsoBc699nmFApr
         FbazG049pmTaZYNTz9Fu3YtkBmptJ5d49Yd4Y0sP2EP0nZ3xBqmlfoWo1qUFxmUDxt5o
         wd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691118; x=1773295918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJ65cMxmtD9hm2QF0vSs9PHPLSm4kdpoTVF35SUjEBw=;
        b=Ts2ym/v/Xq9uXuX1bxecVyMAcWc22KViqDav4Ps+5YlG4awc6zrs3h+V4xsH5K6kvg
         MK5mATvilRpNyQVOBuE0glPHt3m8jh3tO7whdvo8P8uLiyVEuqIv4gaJkqz35waHWaMx
         ZDcNoZHU0T81rx/RpVm5uftKAOWk4Cg4h3eJiqrJ5w0uuMsWLeCF5Ud+/GYF2iMX4XcT
         zSCLSfmQqYZR672uTzhYGVYkPmdyY/rBJblAwgqvWTjAbwPdPNPY70g2r4oO+RMqkR8T
         +wrJ+Uj4MrP73u/59CnAA1nzgGu0HrNnIKPOBhKlMjjcu59PCgmJIdb8TkSSqbp60jx4
         HYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZpXFJU2OFXAvtlKWz6S2LWMpq9tAPGnGEMQIXtDsiC63seUsxP5lrKu6RKH+DYPC7Ks1LvW0S8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ijIDdrruGqiVC4Bvj8PFi7wunUNThFv9bj7XeUuhPRMgBeeY
	zWxzohQleBQZmrhlqZ8a09D9IcQqOATi8M83h/y9oOEDvyjNT3j50uLWY0x/vr6By4o=
X-Gm-Gg: ATEYQzyOLu3jYOd/4jmyy5BMNhWw+d1b9VbqQ9s0ZO+kUeD9dcs1ujYCdpIwI0xs0Zw
	e9qjTtwJ/1CDkbq9dp3bK/j6HL21xwcLStAJC/rF5TuR8VKWqyzKfCP3TRbiqNSyq966UmvLOJw
	fk99/3cAPsvN9X+X5mFUaZ7J+yQmxgyQRuy9LbAB8w6hXuxH1ducAzOL9kAqn1PzBzcKl8pk2UG
	sxurl0Kmhb2pe1nXAKF7OHj+DKGGwCdxyoAG+oQJYb7s7c7Lg3RJYab1hTC83a/F3kQnTfgNDsZ
	FrooWKFmTOZHa4z2Bsgui8l/OZ56I4JtSVj7+MKLKuVROy2bOcDhs7CipycPrYC64Y+beBQaKsd
	g8OHTrRq3rm7ZgZX+P50KUgYkkqZBXwRYYOpbzHYbv4WOKMElILQSm+OImjH9TtRnFCtyYYT7+f
	bmVkQuqG8yppWuysvmauwDMWqB8lX10s7LheMg3Rgs1F7p1cQ9wXXnnEOE3MOD4kG/M5tDdx1t1
	JriTkuC1uPJTsw=
X-Received: by 2002:a17:906:730a:b0:b93:80f3:b35b with SMTP id a640c23a62f3a-b9409e510c0mr64413966b.19.1772691117541;
        Wed, 04 Mar 2026 22:11:57 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:54 +0000
Subject: [PATCH v6 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-5-8cb953c1a723@linaro.org>
References: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
In-Reply-To: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 2923A20B3F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43646-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,samsung.com:email,linaro.org:dkim,linaro.org:email,linaro.org:mid]
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
index 5c3aa8983087..3bcba7d38ac1 100644
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
2.53.0.473.g4a7958ca14-goog


