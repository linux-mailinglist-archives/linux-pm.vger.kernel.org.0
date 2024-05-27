Return-Path: <linux-pm+bounces-8162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAF8D005F
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F741C20DD1
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406D15E5D6;
	Mon, 27 May 2024 12:47:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2813AA2A
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814059; cv=none; b=FiUunCC6i8X5PgO8BPqsXrO9OPszGgBSxff/Xa3w1rRWka7SbimnVh3zdR4iM0vfciINu46U+b0UDLOC4qRcDckrhBZcgn1Y7nLz2aT1sBLbXirD7HANRFM8hB2vVjBVOpu/dF1nfL+lEZIDB1ZcHOBUyrAG5ZgRTpWtLmWwbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814059; c=relaxed/simple;
	bh=/6WTDSc5iLDDk2l/Y6xCKmU+DGYC5Ga9O6+yrTK+INs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsMwT8ap5eCt3G9W17tk7/JnOZvitzclzfRJeAN4RIBnLvaPttnIw7j/bYrtw1sA0IHnLuWKuufGNbnvUqH8MoF9VUATxOS+j3HjpQNo+813XXxgL3kjibadlO2YD/WtODMRCoMHGDGtGhB54B+Zz/NTCrKqOBW6zT7GREktOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4VnwHq2Dcgz4x72C
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:41:27 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c993:5573:f894:7353])
	by michel.telenet-ops.be with bizsmtp
	id UChF2C0022nC7mg06ChFXw; Mon, 27 May 2024 14:41:19 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZeD-00CfTk-6G;
	Mon, 27 May 2024 14:41:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZf8-003hdh-UO;
	Mon, 27 May 2024 14:41:14 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCHPATCH 3/3] pmdomain: renesas: rmobile-sysc: Remove serial console handling
Date: Mon, 27 May 2024 14:41:13 +0200
Message-Id: <f7e9a5e163046511ed63f6832eac4474beea6513.1716811405.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716811405.git.geert+renesas@glider.be>
References: <cover.1716811405.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a47cf07f60dcb02d ("serial: core: Call
device_set_awake_path() for console port"), the serial driver properly
handles the case where the serial console is part of the awake path, so
the special serial console handling can be removed from the R-Mobile
SYSC PM Domain driver.

The PM Domain containing the serial port can now be powered down when
none of its devices are in use.  Before, it was only powered down during
s2ram without no_console_suspend.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 33 +------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 0b77f37787d58f48..cc1f6f8b7a746850 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -10,7 +10,6 @@
  *  Copyright (C) 2011 Magnus Damm
  */
 #include <linux/clk/renesas.h>
-#include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -31,8 +30,6 @@
 
 struct rmobile_pm_domain {
 	struct generic_pm_domain genpd;
-	struct dev_power_governor *gov;
-	int (*suspend)(void);
 	void __iomem *base;
 	unsigned int bit_shift;
 };
@@ -49,13 +46,6 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 	unsigned int mask = BIT(rmobile_pd->bit_shift);
 	u32 val;
 
-	if (rmobile_pd->suspend) {
-		int ret = rmobile_pd->suspend();
-
-		if (ret)
-			return ret;
-	}
-
 	if (readl(rmobile_pd->base + PSTR) & mask) {
 		writel(mask, rmobile_pd->base + SPDCR);
 
@@ -98,7 +88,6 @@ static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
-	struct dev_power_governor *gov = rmobile_pd->gov;
 
 	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = cpg_mstp_attach_dev;
@@ -110,22 +99,12 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 		__rmobile_pd_power_up(rmobile_pd);
 	}
 
-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-}
-
-static int rmobile_pd_suspend_console(void)
-{
-	/*
-	 * Serial consoles make use of SCIF hardware located in this domain,
-	 * hence keep the power domain on if "no_console_suspend" is set.
-	 */
-	return console_suspend_enabled ? 0 : -EBUSY;
+	pm_genpd_init(genpd, &simple_qos_governor, false);
 }
 
 enum pd_types {
 	PD_NORMAL,
 	PD_CPU,
-	PD_CONSOLE,
 	PD_DEBUG,
 	PD_MEMCTL,
 };
@@ -184,10 +163,6 @@ static void __init get_special_pds(void)
 	for_each_of_cpu_node(np)
 		add_special_pd(np, PD_CPU);
 
-	/* PM domain containing console */
-	if (of_stdout)
-		add_special_pd(of_stdout, PD_CONSOLE);
-
 	/* PM domains containing other special devices */
 	for_each_matching_node_and_match(np, special_ids, &id)
 		add_special_pd(np, (uintptr_t)id->data);
@@ -227,12 +202,6 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 		break;
 
-	case PD_CONSOLE:
-		pr_debug("PM domain %s contains serial console\n", name);
-		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_console;
-		break;
-
 	case PD_DEBUG:
 		/*
 		 * This domain contains the Coresight-ETM hardware block and
-- 
2.34.1


