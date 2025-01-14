Return-Path: <linux-pm+bounces-20444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0DBA1121C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7DD16A42B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59020AF8F;
	Tue, 14 Jan 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK3PAgRa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F971FCD05
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886958; cv=none; b=bYyXbK31uK0jydfZcb0Gkj6UOagXbPvtemzR1KC7LIUM2n0n8E444Kb45spjk580KuBBape+KI3LNFLLYOrfa7KEyU2iOHo8DqlA75VrOmc0m4nZNsUrwTeTToOc1y5HTtQ0eyHGD1CQUKMVc067AtCaw/4w+7FmnxUlXI9BHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886958; c=relaxed/simple;
	bh=5EHDsAh1gvS0BQE9Spp73R1FEpmpoEEz/oly6xIBojg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kqsz2hFxAQtCNK1A7/oq9LJE7a+H+ltgN9I0c3A5jEF5gJ4HjdMEzqNW3wF6fErj4+PKOl2qeTVQ9dgkpGMFVLAzQFoCtmBL4VSfuYT4KMXnqmQjIpVexrfuB+N7CGFfmFbTzBRmNIWZAS6xgjPyCL1VV6lP2DHjPluKHlUZZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK3PAgRa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f09be37so7523425e9.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736886954; x=1737491754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YEUyfDTrDdv/X9cKczpOY/bvfGujRsuEaW/USYXyac=;
        b=GK3PAgRas5Aa2HRds65LI6Tos9tAE8+j6/bcMaY0bMNXD4ObirARXRZ1rhqBMC8YoF
         NCnfU94Ty3DxDSazKhQCeTI/CKJd9ngjywPsJP70InO+aeZK0G11p8zapyG8t9htLF0z
         rWx4i7kdJVAIN3mOjnCxM5Cp5X9q23zaUEXtsT/AQnb9uJL3KiY1SKjDz8r8ehR0N9al
         yzgTF/N7eYY8KNH+laTZOHD3EQfvU1suh9LGUKKFsbpeIaE0KA8P3yEpgj3bxVGqjDv6
         dFIhKRUYBom+Bdh2U3XSEmFTXuh0nEcIIW4Hwq8JNezibEtbsJ91CUSP6gr20btAdG+s
         z9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736886954; x=1737491754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YEUyfDTrDdv/X9cKczpOY/bvfGujRsuEaW/USYXyac=;
        b=X1CWi8V6fqT/wEXZmSJ9cnzRAnFbIxVqKWe0fsd71JP9Pc7oP7crA4ZBOuKmGssEje
         qX/e4vvn4Vdg1FgArCHNl6N13s3gczKyYSKo9CpPR4WkrA4RyNoArB/Xc19FJqM0ICjA
         w3/QgUECL9ikPKKei9SZYvioPMHNgukDEOkCl76IwhYDA8P5lxo5sXzFihYr/fjoZlXf
         FVhdroRa3P3qb3rR0L8mFB3nDJbyRdBx9GFiqa7BR3zB7slVi316RP9NJgxMIjvDIpLO
         2hYArhfkiKLT517oyRlf1rGODLKZ57DhfehDDQkH3eHKiloO1vZeNSmwSvT7K8/BgnSl
         glfg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzPr2BhQXNoXIziouR3Pgn5rZ0E+7YunYWCtIqNArCuQly5d2dyVFANAnAWNUI/fQkatLHjslLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ll+/POo01+yrsee6AcXcl0CLermftdkdjgGZNi7RFSk5/TOP
	12VFCJyag7yEc+VyhI6sUdocD5VmcGvqSPxwXN5IWLe6yuLcp9jXsFsVdmDKYOk=
X-Gm-Gg: ASbGncuQeloR8I8zGj+Qb1xj/H4rT/assyf+WzD/k8iX3LqH46EX/+7FigcdTq97YH8
	311nXMt3gHFwoJ2s2uByZj2uSdgclvxO1WShBiGcdMQFDM6ET5tavPM07folyTWa992dpWfUQjp
	j1krAPRF5iv0Q5nLY/9fZUbbNnIIJApb3fHmbpcKUXBo2d97IODng14RkcQfaTFEljX2+hsaG4M
	LPBpWGfNr/FC+uLYVA84p5UrwlHDVpH/QIV+j+73BbIZM9W65nrKL17WTc4Ysy+GkH8bY4=
X-Google-Smtp-Source: AGHT+IEGIFldZ+L4k4Dl+6+c14xQU/JWpFaLddSCbKXPeGIlOQ60LNvgiaZaK9zGFGqW8cmq+2DOXg==
X-Received: by 2002:adf:9ccd:0:b0:386:3c21:b1f7 with SMTP id ffacd0b85a97d-38a872f40f3mr8004257f8f.7.1736886954611;
        Tue, 14 Jan 2025 12:35:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1c01sm16042789f8f.97.2025.01.14.12.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:35:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 21:35:47 +0100
Message-ID: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c    | 3 ++-
 drivers/pmdomain/renesas/rcar-sysc.c         | 3 ++-
 drivers/pmdomain/samsung/exynos-pm-domains.c | 6 +++---
 drivers/pmdomain/starfive/jh71xx-pmu.c       | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 66409cff2083..fe9a0c1deaa3 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -17,6 +17,7 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 #include "rcar-gen4-sysc.h"
@@ -171,7 +172,7 @@ static int rcar_gen4_sysc_power(u8 pdr, bool on)
  out:
 	spin_unlock_irqrestore(&rcar_gen4_sysc_lock, flags);
 
-	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", str_on_off(on),
 		 pdr, ioread32(rcar_gen4_sysc_base + SYSCISCR(reg_idx)), ret);
 	return ret;
 }
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index b99326917330..e3f2c7edf22a 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -14,6 +14,7 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/soc/renesas/rcar-sysc.h>
@@ -162,7 +163,7 @@ static int rcar_sysc_power(const struct rcar_sysc_pd *pd, bool on)
 
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
 
-	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", str_on_off(on),
 		 pd->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
 	return ret;
 }
diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 9b502e8751d1..1a892c611dad 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -38,7 +39,6 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	struct exynos_pm_domain *pd;
 	void __iomem *base;
 	u32 timeout, pwr;
-	char *op;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
@@ -51,8 +51,8 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 
 	while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
 		if (!timeout) {
-			op = (power_on) ? "enable" : "disable";
-			pr_err("Power domain %s %s failed\n", domain->name, op);
+			pr_err("Power domain %s %s failed\n", domain->name,
+			       str_enable_disable(power_on));
 			return -ETIMEDOUT;
 		}
 		timeout--;
diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 74720c09a6e3..30c29ac9391f 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/string_choices.h>
 #include <dt-bindings/power/starfive,jh7110-pmu.h>
 
 /* register offset */
@@ -155,7 +156,7 @@ static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 
 	if (ret) {
 		dev_err(pmu->dev, "%s: failed to power %s\n",
-			pmd->genpd.name, on ? "on" : "off");
+			pmd->genpd.name, str_on_off(on));
 		return -ETIMEDOUT;
 	}
 
-- 
2.43.0


