Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B3901D3
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHPMlM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 08:41:12 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:35340 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHPMlM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 08:41:12 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id poh92000A05gfCL01oh9nz; Fri, 16 Aug 2019 14:41:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybXZ-0005Gl-Jm; Fri, 16 Aug 2019 14:41:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybXZ-00040w-HF; Fri, 16 Aug 2019 14:41:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] soc: renesas: rmobile-sysc: Set GENPD_FLAG_ALWAYS_ON for always-on domain
Date:   Fri, 16 Aug 2019 14:41:06 +0200
Message-Id: <20190816124106.15383-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the R-Mobile "always-on" PM Domain is implemented by returning
-EBUSY from the generic_pm_domain.power_off() callback, and doing
nothing in the generic_pm_domain.power_on() callback.  However, this
means the PM Domain core code is not aware of the semantics of this
special domain, leading to boot warnings like the following on
SH/R-Mobile SoCs:

    sh_cmt e6130000.timer: PM domain c5 will not be powered off

Fix this by making the always-on nature of the domain explicit instead,
by setting the GENPD_FLAG_ALWAYS_ON flag.  This removes the need for the
domain to provide power control callbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-devel for v5.4.

 drivers/soc/renesas/rmobile-sysc.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index 444c97f84ea5a76e..caecc24d5d68739c 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -48,12 +48,8 @@ struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
-	unsigned int mask;
+	unsigned int mask = BIT(rmobile_pd->bit_shift);
 
-	if (rmobile_pd->bit_shift == ~0)
-		return -EBUSY;
-
-	mask = BIT(rmobile_pd->bit_shift);
 	if (rmobile_pd->suspend) {
 		int ret = rmobile_pd->suspend();
 
@@ -80,14 +76,10 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 
 static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
 {
-	unsigned int mask;
+	unsigned int mask = BIT(rmobile_pd->bit_shift);
 	unsigned int retry_count;
 	int ret = 0;
 
-	if (rmobile_pd->bit_shift == ~0)
-		return 0;
-
-	mask = BIT(rmobile_pd->bit_shift);
 	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
 		return ret;
 
@@ -122,11 +114,15 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
 	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
-	genpd->power_off		= rmobile_pd_power_down;
-	genpd->power_on			= rmobile_pd_power_up;
-	genpd->attach_dev		= cpg_mstp_attach_dev;
-	genpd->detach_dev		= cpg_mstp_detach_dev;
-	__rmobile_pd_power_up(rmobile_pd);
+	genpd->attach_dev = cpg_mstp_attach_dev;
+	genpd->detach_dev = cpg_mstp_detach_dev;
+
+	if (!(genpd->flags & GENPD_FLAG_ALWAYS_ON)) {
+		genpd->power_off = rmobile_pd_power_down;
+		genpd->power_on = rmobile_pd_power_up;
+		__rmobile_pd_power_up(rmobile_pd);
+	}
+
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 }
 
@@ -270,6 +266,11 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		break;
 
 	case PD_NORMAL:
+		if (pd->bit_shift == ~0) {
+			/* Top-level always-on domain */
+			pr_debug("PM domain %s is always-on domain\n", name);
+			pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
+		}
 		break;
 	}
 
-- 
2.17.1

