Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B982B561
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfE0MdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 08:33:25 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:37444 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE0MdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 08:33:25 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id HQZQ2000R3XaVaC06QZQlf; Mon, 27 May 2019 14:33:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEoe-0001VO-Di; Mon, 27 May 2019 14:33:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEoe-0001oD-CK; Mon, 27 May 2019 14:33:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: renesas: cpg-mssr: Use genpd of_node instead of local copy
Date:   Mon, 27 May 2019 14:33:23 +0200
Message-Id: <20190527123323.6912-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit 6a0ae73d95956f7e ("PM / Domain: Add support to parse
domain's OPP table"), of_genpd_add_provider_simple() fills in
the dev.of_node field in the generic_pm_domain structure.

Hence cpg_mssr_is_pm_clk() can use that instead of its own copy in the
driver-private cpg_mssr_clk_domain structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in clk-renesas-for-v5.3.

 drivers/clk/renesas/renesas-cpg-mssr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 0201809bbd377df4..d1054204f3a75022 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -447,7 +447,6 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 struct cpg_mssr_clk_domain {
 	struct generic_pm_domain genpd;
-	struct device_node *np;
 	unsigned int num_core_pm_clks;
 	unsigned int core_pm_clks[0];
 };
@@ -459,7 +458,7 @@ static bool cpg_mssr_is_pm_clk(const struct of_phandle_args *clkspec,
 {
 	unsigned int i;
 
-	if (clkspec->np != pd->np || clkspec->args_count != 2)
+	if (clkspec->np != pd->genpd.dev.of_node || clkspec->args_count != 2)
 		return false;
 
 	switch (clkspec->args[0]) {
@@ -549,7 +548,6 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	if (!pd)
 		return -ENOMEM;
 
-	pd->np = np;
 	pd->num_core_pm_clks = num_core_pm_clks;
 	memcpy(pd->core_pm_clks, core_pm_clks, pm_size);
 
-- 
2.17.1

