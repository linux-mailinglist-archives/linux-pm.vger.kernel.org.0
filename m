Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386135823D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhDHLnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhDHLnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3C926112F;
        Thu,  8 Apr 2021 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882187;
        bh=kEelFzjSz9xpmgaL1OIROLHhuhizV6MJnho6C7AnwZk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QoAgeWUx7uo2+swKI4tHE/mtAdLfrfPkf4N1dcqU9Uy6N5JJscV1GeXR08jP9Yhjq
         DgS+qhkagJCKVommrDncwJBwYsgHgDeAr0wlgiNTTrY+nxaCZ7oBvkAMaq7DU/6Kdz
         PkwWcK4DEErLuCQ66zzjVEUjTHh85zFFeciRNJphr8t3yygdSsUUJ0bpXx2F69o65e
         VeC5tFvNSgYdsCGdLOxxc4BsyPFnukWqbj6vvMLI07qanZU5iWxSI43zzibtBWPdkF
         YXO3M95nVpzCgUMHUUn6rrHUk4pFKdMIqp3IhexEmTTXpfeBUJP24pKStOwxrfdrgR
         Q0c/XZYyuhjIA==
Received: by pali.im (Postfix)
        id 6665EEBC; Thu,  8 Apr 2021 13:43:04 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 06/10] clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1 to L0
Date:   Thu,  8 Apr 2021 13:42:19 +0200
Message-Id: <20210408114223.8471-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When CPU frequency is at 250 MHz and set_rate() is called with 500 MHz (L1)
quickly followed by a call with 1 GHz (L0), the CPU does not necessarily
stay in L1 for at least 20ms as is required by Marvell errata.

This situation happens frequently with the ondemand cpufreq governor and
can be also reproduced with userspace governor. In most cases it causes CPU
to crash.

This change fixes the above issue and ensures that the CPU always stays in
L1 for at least 20ms when switching from any state to L0.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 61c40f35f5cd ("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz")
Cc: stable@vger.kernel.org
---
 drivers/clk/mvebu/armada-37xx-periph.c | 45 ++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index b15e177bea7e..32ac6b6b7530 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -84,6 +84,7 @@ struct clk_pm_cpu {
 	void __iomem *reg_div;
 	u8 shift_div;
 	struct regmap *nb_pm_base;
+	unsigned long l1_expiration;
 };
 
 #define to_clk_double_div(_hw) container_of(_hw, struct clk_double_div, hw)
@@ -504,22 +505,52 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
  * 2. Sleep 20ms for stabling VDD voltage
  * 3. Then switch from L1 (500/600 MHz) to L0 (1000/1200 MHz).
  */
-static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
+static void clk_pm_cpu_set_rate_wa(struct clk_pm_cpu *pm_cpu,
+				   unsigned int new_level, unsigned long rate,
+				   struct regmap *base)
 {
 	unsigned int cur_level;
 
-	if (rate < 1000 * 1000 * 1000)
-		return;
-
 	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
 	cur_level &= ARMADA_37XX_NB_CPU_LOAD_MASK;
-	if (cur_level <= ARMADA_37XX_DVFS_LOAD_1)
+
+	if (cur_level == new_level)
+		return;
+
+	/*
+	 * System wants to go to L1 on its own. If we are going from L2/L3,
+	 * remember when 20ms will expire. If from L0, set the value so that
+	 * next switch to L0 won't have to wait.
+	 */
+	if (new_level == ARMADA_37XX_DVFS_LOAD_1) {
+		if (cur_level == ARMADA_37XX_DVFS_LOAD_0)
+			pm_cpu->l1_expiration = jiffies;
+		else
+			pm_cpu->l1_expiration = jiffies + msecs_to_jiffies(20);
 		return;
+	}
+
+	/*
+	 * If we are setting to L2/L3, just invalidate L1 expiration time,
+	 * sleeping is not needed.
+	 */
+	if (rate < 1000*1000*1000)
+		goto invalidate_l1_exp;
+
+	/*
+	 * We are going to L0 with rate >= 1GHz. Check whether we have been at
+	 * L1 for long enough time. If not, go to L1 for 20ms.
+	 */
+	if (pm_cpu->l1_expiration && jiffies >= pm_cpu->l1_expiration)
+		goto invalidate_l1_exp;
 
 	regmap_update_bits(base, ARMADA_37XX_NB_CPU_LOAD,
 			   ARMADA_37XX_NB_CPU_LOAD_MASK,
 			   ARMADA_37XX_DVFS_LOAD_1);
 	msleep(20);
+
+invalidate_l1_exp:
+	pm_cpu->l1_expiration = 0;
 }
 
 static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -553,7 +584,9 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 			reg = ARMADA_37XX_NB_CPU_LOAD;
 			mask = ARMADA_37XX_NB_CPU_LOAD_MASK;
 
-			clk_pm_cpu_set_rate_wa(rate, base);
+			/* Apply workaround when base CPU frequency is 1000 or 1200 MHz */
+			if (parent_rate >= 1000*1000*1000)
+				clk_pm_cpu_set_rate_wa(pm_cpu, load_level, rate, base);
 
 			regmap_update_bits(base, reg, mask, load_level);
 
-- 
2.20.1

