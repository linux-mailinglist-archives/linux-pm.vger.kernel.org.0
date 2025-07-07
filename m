Return-Path: <linux-pm+bounces-30287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BEEAFB307
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 14:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E211AA137D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DB28853F;
	Mon,  7 Jul 2025 12:17:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D229AB07;
	Mon,  7 Jul 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890672; cv=none; b=cEHbzAxB5C6u1uWMHaJHDYmwZTRmEpCproHhBtf9bVu+xWJclxjDnIvILnudK/VpHioElwWIJB8bO14993FVeltTr32aaHqTdBoQEkNYJUStwjr6uZ6Wkt6OFU3dyT+41y1sUtVuI9yeT0q/tu+s7Q122iwdDyl7lNkOdZvCC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890672; c=relaxed/simple;
	bh=GHP2t4XYotp+4m74VTLoM0og2PSMiBPuSglV7gkwuzo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=i/qYENgHId2Fj0yy2jMv4Wa+Vp0oyr6Sd99qhNGsap/SK19/Ec6A9iySR884WlgsXa/s4laNFuHUxQn9oqwN2r8acFZRypUelbX2bHw3a67IoEKhhwV7rt+ZLwK2ccSOpVQ96BRLtc5ZhyKGx/s5wzcgmqwhFcfdcvAgsXw5wYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bbNXj4wqdz4x5pp;
	Mon,  7 Jul 2025 20:17:25 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 567CHOTs040120;
	Mon, 7 Jul 2025 20:17:24 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 7 Jul 2025 20:17:27 +0800 (CST)
Date: Mon, 7 Jul 2025 20:17:27 +0800 (CST)
X-Zmail-TransId: 2afa686bbad7fffffffffe8-248e9
X-Mailer: Zmail v1.0
Message-ID: <20250707201727549ObAZpoScxRwGsruRnQQCP@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <geert+renesas@glider.be>
Cc: <changhuang.liang@starfivetech.com>, <geert+renesas@glider.be>,
        <magnus.damm@gmail.com>, <heiko@sntech.de>, <alim.akhtar@samsung.com>,
        <walker.chen@starfivetech.com>, <sebastian.reichel@collabora.com>,
        <detlev.casanova@collabora.com>, <finley.xiao@rock-chips.com>,
        <shawn.lin@rock-chips.com>, <pgwipeout@gmail.com>,
        <shao.mingyin@zte.com.cn>, <linux-pm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0XSBwbWRvbWFpbjogVXNlIHN0cl9lbmFibGVfZGlzYWJsZSgpIGFuZCBzdHJfb25fb2ZmKCkgaGVscGVycw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 567CHOTs040120
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686BBAD5.000/4bbNXj4wqdz4x5pp

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Use str_enable_disable() and str_on_off() helper instead of open
coding the same.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
v4:
insert new includes alphabetically
 drivers/pmdomain/renesas/rcar-gen4-sysc.c    | 3 ++-
 drivers/pmdomain/renesas/rcar-sysc.c         | 3 ++-
 drivers/pmdomain/rockchip/pm-domains.c       | 3 ++-
 drivers/pmdomain/samsung/exynos-pm-domains.c | 6 +++---
 drivers/pmdomain/starfive/jh71xx-pmu.c       | 7 ++++---
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index e001b5c25bed..d93caae5bed5 100644
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
index 047495f54e8a..38406414035a 100644
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
diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 242570c505fb..a7abbb67ae70 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
+#include <linux/string_choices.h>
 #include <soc/rockchip/pm_domains.h>
 #include <soc/rockchip/rockchip_sip.h>
 #include <dt-bindings/power/px30-power.h>
@@ -599,7 +600,7 @@ static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 					is_on == on, 0, 10000);
 	if (ret) {
 		dev_err(pmu->dev, "failed to set domain '%s' %s, val=%d\n",
-			genpd->name, on ? "on" : "off", is_on);
+			genpd->name, str_on_off(on), is_on);
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
index 74720c09a6e3..dc3e109e273a 100644
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

@@ -197,8 +198,8 @@ static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	}

 	if (is_on == on) {
-		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
-			pmd->genpd.name, on ? "en" : "dis");
+		dev_dbg(pmu->dev, "pm domain [%s] is already %s status.\n",
+			pmd->genpd.name, str_enable_disable(on));
 		return 0;
 	}

-- 
2.25.1

