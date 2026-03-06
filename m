Return-Path: <linux-pm+bounces-43789-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Kj/KsCtqmluVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43789-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:34:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4321ED3F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB58F3098020
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B935E954;
	Fri,  6 Mar 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZE9N9f1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0837DEBD
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793006; cv=none; b=R1mHKSTkK3jVnQIMw+I3NrHrIT1Y017+ncELu5ov+FBPBX564RL09qiQRBY6VtBbKeT/2HoEsyEplQodL2qXmhualgkAD/BWtSalJEgSSebe27yPFFFggTIZlOuznGQ0TPtyVCVMJ0u2lEk3W+AhGUlfsZhT///gVNzinFVuxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793006; c=relaxed/simple;
	bh=0U4HtqSeHlGrJn9AJ7ErQ0CtQcraLAhfSS8YefF1XM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVyj7TucFOCF4uY6JB9GPoIdb4G5/4igJzl3BX7248AK/EuuLWk9RJH+JoEI5Vg9nv9vergIvpzCeWz6/iZGObM9x5FczpSBeEyIvZoc3lFLbXLPOTh0Yde+hTN4c71pvOfQ9KAejujkgwgDbrrRNmW3wk7DoxBY86cSZnee+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZE9N9f1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so2482077a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792999; x=1773397799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJGr1pYRHm/J99djTiuPZ983bNSUstvUPO/CtwCwtA8=;
        b=qZE9N9f1CMPnzrFnwCxX3bekxlpg45NjSj3kEadC3TDB7UoZbuOQ5tbtjqJ2n0pUR/
         UcsvstpwHKs8eYoJ5L1v9CHgETcB5OoVty2Rv/ohavJOxIWoptEJOWEkmIIxTGy1Zd03
         mhqHc92bYAN3L2mgVu39a4UMWVcscuBTgruaDwS3Yr7ZtdIX5z/uJISMfgI3Hw4rTi4+
         T2Bqrbvn1aBR9m2yTusw6+0B7mteEj3veP9p9vO7P4fpep8oqRmeYZjr6lXNEk7npYN7
         sr+BqmGespubQ2deW7ALDmy69mq157qJFn2By4sInNAFdCVxyduBi5p6GLUmVlYX6sct
         peWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792999; x=1773397799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VJGr1pYRHm/J99djTiuPZ983bNSUstvUPO/CtwCwtA8=;
        b=slYqVKcTqE/2NL8gVwk5lSl7xwMJ/zPlC+0i5zYt1FXy0TgYAfLdzRuOpMwQo8JYy/
         /XegXuiBpgwxfv/MHXuyxkSZ09AG9RMPQt73LiiH6KFTi3Uc+Bc1DqW5smvaMyTa0P+v
         70QLVJmw2+QqoHl2PmA9M41Bzwis+ZxqJBGohHUdggknmuAri+P9HXrBK4XGMPuuWHYl
         oBwm/m9+FiDlt4IET3Jf75jAHNuPpjY2Xlzmq+WoR8khyeljkYZoAu/UlYSDiHj7herB
         rmqlbpg+yXgn7wfxExy8LzCSxwx5q4UiV3Y0S07yTMMcrGOW85yAdWUuWUfBrH3ya2Wk
         Pvsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZP01d0VH+yqKft0o9tgNm5+PD2iawPNbKjSYtI8Ne2xRZ8HthVWa11lbg2uJBVupHALmkguwPVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywK/NIgsy+2Ddv1EUFvRzAcARblzM9WCRZ0/VtJPQ/EA+vY0nS
	XrgWftbp6Pz5cHkXZO6HGun71B5WAN3nUPCz6NDCNhd+SurX63xQ7hbtt9nASIfYdB0=
X-Gm-Gg: ATEYQzxm2XNgzg39pgHg0Q9JaYv6VFhpavHooZFVGXxZvjM4VPBx/dVS4DtqbGim5Dd
	DauBzYAqMdOPHL3YgpTNCEMiuiKPA2JzmDewbHjLMMJ8YrcHrUM6NC4xi/s71+8nLgfd6bx3ty3
	oYrb0eG+bpfvh8Kz4sUWWgRnzFuviU5PXjOEPz0Yk42HsUaSry7lVfEyMDJeZLW4IPE6LagW0y1
	OjUG5S7ASRIgnX32sStNNWGPzUpmN+9bOfrBKDlastwR5Es4sWQFuoDu2ZI6ts596b8zfvvge3F
	5JGx/zKsKehNHe5sTop7kDVu7QVT4Q2lBzIgzTlNX1U3dbHRuK6befHsWnX8dRbJyqPbCK4imCS
	e22kM309BayVndceG5E3J78BTXTB5HIaEx8RXZky5Tbyz0JTIt9GiGnmeF0CyjrEwZMcY2ocz6q
	iIY1svJQOREeaDnGg6On0VDuJZCHVfYQajH9BXlGe8w4mylSXHxLjq3UgC1oFMC/ZBYMzOLCAzF
	WtjhsjfZ2m96bg=
X-Received: by 2002:a17:907:6e9e:b0:b94:29e:a94c with SMTP id a640c23a62f3a-b942dbdc1femr96088266b.15.1772792998840;
        Fri, 06 Mar 2026 02:29:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:58 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:58 +0000
Subject: [PATCH v7 07/10] pmdomain: samsung: add support for
 google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-7-03f7c7965ba5@linaro.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
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
X-Rspamd-Queue-Id: 2FD4321ED3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43789-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Google gs101, direct mmio register access to the PMU registers
doesn't work and access must happen via a regmap created by the PMU
driver instead.

Add a flag to the device match data to denote this case, and obtain
the regmap using the parent node in DT if true, while keeping to use
the traditional direct mmio regmap otherwise.

Additionally, the status is just one bit on gs101.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v4:
- add 'use_parent_regmap' flag instead of going by 'syscon' compatible
  in parent, as it's not a given that the parent provides a syscon-
  compatible regmap (it actually doesn't anymore after recent changes
  on gs101)

I've still kept Marek's Tested-by from v3, as legacy Exynos code
doesn't change.
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 66 +++++++++++++++++++---------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 8df46b41f9bc..2214d9f32d59 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/mfd/syscon.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -21,6 +22,7 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	bool use_parent_regmap;
 };
 
 /*
@@ -93,8 +95,16 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.local_pwr_cfg		= 0xf,
 };
 
+static const struct exynos_pm_domain_config gs101_cfg = {
+	.local_pwr_cfg		= BIT(0),
+	.use_parent_regmap	= true,
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
@@ -122,17 +132,9 @@ static int exynos_pd_probe(struct platform_device *pdev)
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
@@ -143,25 +145,49 @@ static int exynos_pd_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/*
-	 * The resource typically points into the address space of the PMU.
+	 * The resource typically points into the address space of the PMU and
+	 * we have to consider two cases:
+	 *   1) some implementations require a custom regmap (from PMU parent)
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
+	if (pm_domain_cfg->use_parent_regmap) {
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
2.53.0.473.g4a7958ca14-goog


