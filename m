Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4122CD94
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGXSYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgGXSYn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CAF620791;
        Fri, 24 Jul 2020 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615082;
        bh=lEKVZDzJhtzFur3P/7OyNZHCfVYi8hoC3ip/4L1ggro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RL46EB3CTxtzUCIVIi+XqDeDv38NEZ0GXle2sMfIjXN4qNhS46/CeXzxZHfeYTqTt
         2VyVzL5bGmQA2yUlpROLf56SpgmwH8kUj8D88wre4+YvdT42fz7kVJh8nGfvQbAsAZ
         wO+lF7iSF1rC46bkzDYMqaxMg1jQjmmGdcyf08ts=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/16] memory: omap-gpmc: Correct white space issues
Date:   Fri, 24 Jul 2020 20:23:19 +0200
Message-Id: <20200724182328.3348-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove some unneeded blank lines, align indentation with open
parenthesis (or fix existing alignment).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index e4d2f359bcfa..9339a7c75fdd 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -297,7 +297,6 @@ static unsigned long gpmc_get_fclk_period(void)
  */
 static unsigned long gpmc_get_clk_period(int cs, enum gpmc_clk_domain cd)
 {
-
 	unsigned long tick_ps = gpmc_get_fclk_period();
 	u32 l;
 	int div;
@@ -317,7 +316,6 @@ static unsigned long gpmc_get_clk_period(int cs, enum gpmc_clk_domain cd)
 	}
 
 	return tick_ps;
-
 }
 
 static unsigned int gpmc_ns_to_clk_ticks(unsigned int time_ns, int cs,
@@ -509,7 +507,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
 	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
-			 GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
+			       GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 22, 22, "wait-on-read");
@@ -623,9 +621,8 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit, int max
 
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef CONFIG_OMAP_GPMC_DEBUG
-	pr_info(
-		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-	       cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
+	pr_info("GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
+		cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
 			(l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
@@ -652,7 +649,6 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit, int max
  */
 static int gpmc_calc_waitmonitoring_divider(unsigned int wait_monitoring)
 {
-
 	int div = gpmc_ns_to_ticks(wait_monitoring);
 
 	div += GPMC_CONFIG1_WAITMONITORINGTIME_MAX - 1;
@@ -664,7 +660,6 @@ static int gpmc_calc_waitmonitoring_divider(unsigned int wait_monitoring)
 		div = 1;
 
 	return div;
-
 }
 
 /**
@@ -718,7 +713,6 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 	if (!s->sync_read && !s->sync_write &&
 	    (s->wait_on_read || s->wait_on_write)
 	   ) {
-
 		div = gpmc_calc_waitmonitoring_divider(t->wait_monitoring);
 		if (div < 0) {
 			pr_err("%s: waitmonitoringtime %3d ns too large for greatest gpmcfclkdivider.\n",
@@ -1512,7 +1506,6 @@ static void gpmc_mem_exit(void)
 			continue;
 		gpmc_cs_delete_mem(cs);
 	}
-
 }
 
 static void gpmc_mem_init(void)
@@ -1681,17 +1674,14 @@ static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
 	/* oe_on */
 	temp = dev_t->t_oeasu;
 	if (mux)
-		temp = max_t(u32, temp,
-			gpmc_t->adv_rd_off + dev_t->t_aavdh);
+		temp = max_t(u32, temp, gpmc_t->adv_rd_off + dev_t->t_aavdh);
 	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
 
 	/* access */
 	temp = max_t(u32, dev_t->t_iaa, /* XXX: remove t_iaa in async ? */
-				gpmc_t->oe_on + dev_t->t_oe);
-	temp = max_t(u32, temp,
-				gpmc_t->cs_on + dev_t->t_ce);
-	temp = max_t(u32, temp,
-				gpmc_t->adv_on + dev_t->t_aa);
+		     gpmc_t->oe_on + dev_t->t_oe);
+	temp = max_t(u32, temp, gpmc_t->cs_on + dev_t->t_ce);
+	temp = max_t(u32, temp, gpmc_t->adv_on + dev_t->t_aa);
 	gpmc_t->access = gpmc_round_ps_to_ticks(temp);
 
 	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ps(1);
-- 
2.17.1

