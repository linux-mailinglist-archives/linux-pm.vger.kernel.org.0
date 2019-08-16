Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9654E90206
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfHPMw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 08:52:29 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50488 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHPMw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 08:52:29 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id posT2000T05gfCL01osTT6; Fri, 16 Aug 2019 14:52:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiV-0005JG-Ki; Fri, 16 Aug 2019 14:52:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hybiV-0004By-JV; Fri, 16 Aug 2019 14:52:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] clk: renesas: r9a06g032: Set GENPD_FLAG_ALWAYS_ON for clock domain
Date:   Fri, 16 Aug 2019 14:52:24 +0200
Message-Id: <20190816125225.16061-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816125225.16061-1-geert+renesas@glider.be>
References: <20190816125225.16061-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RZ/N1 Clock Domain driver does not implement the
generic_pm_domain.power_{on,off}() callbacks, as the domain itself
cannot be powered down.  Hence the domain should be marked as always-on
by setting the GENPD_FLAG_ALWAYS_ON flag.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware, but similar in spirit to the other
Clock Domain drivers.
---
 drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index b33e1383efe3abcd..1907ee195a08cf77 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -421,7 +421,8 @@ static int r9a06g032_add_clk_domain(struct device *dev)
 		return -ENOMEM;
 
 	pd->name = np->name;
-	pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
+	pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
+		    GENPD_FLAG_ACTIVE_WAKEUP;
 	pd->attach_dev = r9a06g032_attach_dev;
 	pd->detach_dev = r9a06g032_detach_dev;
 	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
-- 
2.17.1

