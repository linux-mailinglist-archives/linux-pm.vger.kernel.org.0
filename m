Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF23D358237
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhDHLmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhDHLmk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:42:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BB4C61154;
        Thu,  8 Apr 2021 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882149;
        bh=XHwxXWgOc8mJliVRrHMpEKYuxrI1x22e6do2Ps+EQAs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QVbfyLPmryZjf9OR/5v3QjOJBynbbBBwNva/Dj/i1abisUYFBca8oNUcQZeUvE6U9
         q9DGr9PzuDuFre+aK6ND56zxSjoXQorJ2sLZgEEezZvLzXnFEZkXyDMCJIy/1MxwxN
         cwdZvw1kr6o1D6WT2b2N9qNjJ8yfP4/qa3c1CNtbjR8v8jq23zqFoa6FGgPTVg96M3
         oCcYwJF5vrpyrRengfuFaIpwG12oNtqcKQXRIb0T7v3O5b3+vQ0kQeHbYZvntf6bR7
         7O5A2drGLrH2REERbDgjxrpZQvGyCSpe2CbOYpCsd+O19GhRYTUewwJpv2NMl8SNMg
         dP4dPQ596KhAw==
Received: by pali.im (Postfix)
        id BE65CEE2; Thu,  8 Apr 2021 13:42:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 03/10] clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock
Date:   Thu,  8 Apr 2021 13:42:16 +0200
Message-Id: <20210408114223.8471-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

Remove the .set_parent method in clk_pm_cpu_ops.

This method was supposed to be needed by the armada-37xx-cpufreq driver,
but was never actually called due to wrong assumptions in the cpufreq
driver. After this was fixed in the cpufreq driver, this method is not
needed anymore.

Signed-off-by: Marek Behún <kabel@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
---
 drivers/clk/mvebu/armada-37xx-periph.c | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index f5746f9ea929..6507bd2c5f31 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -440,33 +440,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
-	struct regmap *base = pm_cpu->nb_pm_base;
-	int load_level;
-
-	/*
-	 * We set the clock parent only if the DVFS is available but
-	 * not enabled.
-	 */
-	if (IS_ERR(base) || armada_3700_pm_dvfs_is_enabled(base))
-		return -EINVAL;
-
-	/* Set the parent clock for all the load level */
-	for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
-		unsigned int reg, mask,  val,
-			offset = ARMADA_37XX_NB_TBG_SEL_OFF;
-
-		armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
-
-		val = index << offset;
-		mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
-		regmap_update_bits(base, reg, mask, val);
-	}
-	return 0;
-}
-
 static unsigned long clk_pm_cpu_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
@@ -592,7 +565,6 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_pm_cpu_ops = {
 	.get_parent = clk_pm_cpu_get_parent,
-	.set_parent = clk_pm_cpu_set_parent,
 	.round_rate = clk_pm_cpu_round_rate,
 	.set_rate = clk_pm_cpu_set_rate,
 	.recalc_rate = clk_pm_cpu_recalc_rate,
-- 
2.20.1

