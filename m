Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AEB90207
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHPMw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 08:52:29 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:40034 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfHPMw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 08:52:29 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id posT2000A05gfCL06osTD2; Fri, 16 Aug 2019 14:52:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiV-0005JD-Af; Fri, 16 Aug 2019 14:52:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiV-0004Bv-9R; Fri, 16 Aug 2019 14:52:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
Date:   Fri, 16 Aug 2019 14:52:23 +0200
Message-Id: <20190816125225.16061-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816125225.16061-1-geert+renesas@glider.be>
References: <20190816125225.16061-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPG/MSTP Clock Domain driver does not implement the
generic_pm_domain.power_{on,off}() callbacks, as the domain itself
cannot be powered down.  Hence the domain should be marked as always-on
by setting the GENPD_FLAG_ALWAYS_ON flag.

This gets rid of the following boot warning on RZ/A1:

    sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered off

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/clk-mstp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index dfbef37eed4a82e8..fcf753a6249a0e53 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -335,7 +335,8 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
 		return;
 
 	pd->name = np->name;
-	pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
+		    GENPD_FLAG_ACTIVE_WAKEUP;
 	pd->attach_dev = cpg_mstp_attach_dev;
 	pd->detach_dev = cpg_mstp_detach_dev;
 	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
-- 
2.17.1

