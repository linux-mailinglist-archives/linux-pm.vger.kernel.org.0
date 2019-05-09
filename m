Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3716419481
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEIVTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:45844 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEIVTp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7E614104024;
        Thu,  9 May 2019 23:19:42 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iluzY6wj_yDR; Thu,  9 May 2019 23:19:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 53433104026;
        Thu,  9 May 2019 23:19:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekLLkc6jHzlj; Thu,  9 May 2019 23:19:19 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6330C10402B;
        Thu,  9 May 2019 23:19:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 5/7] clk: mmp2: create a power domain for the GPU core
Date:   Thu,  9 May 2019 23:19:09 +0200
Message-Id: <20190509211911.17998-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power management unit on MMP2 is able to gate clock for the GC860 GPU=
.

There's some special dance required to initialize the unit after the powe=
r
has been enabled. If not followed, either the GPU's memory interface or t=
he
GPU core doesn't work or the SoC just hangs.

Once the power has been applied to the GPU block, it doesn't seem
possible to turn it off entirely and initialize again.

As the data sheet is missing, neither the details about initialization, n=
or
the reason why it can't be reinitialized are understood. The meaning of
most bits in the APMU_GPU register are partially described in [1].

[1] http://lists.laptop.org/pipermail/devel/2019-April/039053.html

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/Kconfig     |  2 +
 drivers/clk/mmp/clk-of-mmp2.c | 91 +++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 94500bed56ab..a0efaefbfc74 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -124,6 +124,8 @@ config MACH_MMP2_DT
 	select PINCTRL_SINGLE
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_PJ4
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree.
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 45f94c89cdc1..7bbf70b2ccd2 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -16,8 +16,11 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/of_address.h>
+#include <linux/pm_domain.h>
+#include <linux/clk.h>
=20
 #include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/power/marvell,mmp2.h>
=20
 #include "clk.h"
 #include "reset.h"
@@ -58,6 +61,8 @@
=20
 struct mmp2_clk_unit {
 	struct mmp_clk_unit unit;
+	struct genpd_onecell_data pd_data;
+	struct generic_pm_domain gpu_pm_domain;
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
@@ -325,6 +330,90 @@ static void mmp2_clk_reset_init(struct device_node *=
np,
 	mmp_clk_reset_register(np, cells, nr_resets);
 }
=20
+static int mmp2_gpu_pm_domain_power_on(struct generic_pm_domain *genpd)
+{
+	struct mmp2_clk_unit *pxa_unit =3D container_of(genpd,
+			struct mmp2_clk_unit, gpu_pm_domain);
+	struct mmp_clk_unit *unit =3D &pxa_unit->unit;
+	void __iomem *reg =3D pxa_unit->apmu_base + APMU_GPU;
+	unsigned long flags =3D 0;
+	u32 tmp;
+	int ret;
+
+	spin_lock_irqsave(&gpu_lock, flags);
+
+	/* Power up the module. */
+	tmp =3D readl(reg);
+	tmp &=3D ~0x8700;
+	tmp |=3D 0x8600;
+	writel(tmp, reg);
+
+	ret =3D clk_prepare_enable(unit->clk_table[MMP2_CLK_GPU_GC]);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(unit->clk_table[MMP2_CLK_GPU_BUS]);
+	if (ret) {
+		clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_GC]);
+		return ret;
+	}
+
+	/* Disable isolation now that clocks are running. */
+	tmp =3D readl(reg);
+	tmp |=3D 0x100;
+	writel(tmp, reg);
+	udelay(1);
+
+	spin_unlock_irqrestore(&gpu_lock, flags);
+
+	return 0;
+}
+
+static int mmp2_gpu_pm_domain_power_off(struct generic_pm_domain *genpd)
+{
+	struct mmp2_clk_unit *pxa_unit =3D container_of(genpd,
+			struct mmp2_clk_unit, gpu_pm_domain);
+	struct mmp_clk_unit *unit =3D &pxa_unit->unit;
+	void __iomem *reg =3D pxa_unit->apmu_base + APMU_GPU;
+	unsigned long flags =3D 0;
+	u32 tmp;
+
+	spin_lock_irqsave(&gpu_lock, flags);
+
+	/*
+	 * Re-enable isolation. We must not touch the other bits,
+	 * otherwise the * GPU hangs without a known way to recover.
+	 */
+	tmp =3D readl(reg);
+	tmp &=3D ~0x100;
+	writel(tmp, reg);
+	udelay(1);
+
+	clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_BUS]);
+	clk_disable_unprepare(unit->clk_table[MMP2_CLK_GPU_GC]);
+
+	spin_unlock_irqrestore(&gpu_lock, flags);
+
+	return 0;
+}
+
+static struct generic_pm_domain *mmp2_pm_onecell_domains[MMP2_NR_POWER_D=
OMAINS];
+
+static void mmp2_pm_domain_init(struct device_node *np,
+			struct mmp2_clk_unit *pxa_unit)
+{
+	pm_genpd_init(&pxa_unit->gpu_pm_domain, NULL, true);
+	pxa_unit->gpu_pm_domain.name =3D "GPU";
+	pxa_unit->gpu_pm_domain.power_on =3D mmp2_gpu_pm_domain_power_on;
+	pxa_unit->gpu_pm_domain.power_off =3D mmp2_gpu_pm_domain_power_off;
+	mmp2_pm_onecell_domains[MMP2_POWER_DOMAIN_GPU]
+				=3D &pxa_unit->gpu_pm_domain;
+
+	pxa_unit->pd_data.domains =3D mmp2_pm_onecell_domains;
+	pxa_unit->pd_data.num_domains =3D ARRAY_SIZE(mmp2_pm_onecell_domains);
+	of_genpd_add_provider_onecell(np, &pxa_unit->pd_data);
+}
+
 static void __init mmp2_clk_init(struct device_node *np)
 {
 	struct mmp2_clk_unit *pxa_unit;
@@ -351,6 +440,8 @@ static void __init mmp2_clk_init(struct device_node *=
np)
 		goto unmap_apmu_region;
 	}
=20
+	mmp2_pm_domain_init(np, pxa_unit);
+
 	mmp_clk_init(np, &pxa_unit->unit, MMP2_NR_CLKS);
=20
 	mmp2_pll_init(pxa_unit);
--=20
2.21.0

