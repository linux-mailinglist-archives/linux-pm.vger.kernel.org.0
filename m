Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD013D51D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406918AbfFKSIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:08:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60308 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406891AbfFKSIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560276490; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgjadQ8woauPoEbSwNwRZmihTgDSBNSW4pKaADLdN3c=;
        b=jugfGK+VHtQGMgTit+9GiOkDLn4a4NqrlamYQ5keozanzGWqn0JjXo4aTyNQ5daaMI1eZA
        v5fTyM8wVpHCL1LLnxcgO9Hyy+PPQUAldwFhq4WNrhX9CC0CEJ70ygRBX8hiScqowSuWkR
        3lovWg1oskWKKNyb0+n7lzMZjdIK5z8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/5] clk: ingenic: Remove unused functions
Date:   Tue, 11 Jun 2019 20:07:56 +0200
Message-Id: <20190611180757.32299-4-paul@crapouillou.net>
In-Reply-To: <20190611180757.32299-1-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These functions are not called anywhere anymore, they can safely be
removed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc4

 drivers/clk/ingenic/jz4740-cgu.c | 73 --------------------------------
 1 file changed, 73 deletions(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index efa893ee1de9..a495d75d5133 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4740-cgu.h>
-#include <asm/mach-jz4740/clock.h>
 #include "cgu.h"
 #include "pm.h"
 
@@ -223,75 +222,3 @@ static void __init jz4740_cgu_init(struct device_node *np)
 	ingenic_cgu_register_syscore_ops(cgu);
 }
 CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
-
-void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
-{
-	uint32_t lcr = readl(cgu->base + CGU_REG_LCR);
-
-	switch (mode) {
-	case JZ4740_WAIT_MODE_IDLE:
-		lcr &= ~LCR_SLEEP;
-		break;
-
-	case JZ4740_WAIT_MODE_SLEEP:
-		lcr |= LCR_SLEEP;
-		break;
-	}
-
-	writel(lcr, cgu->base + CGU_REG_LCR);
-}
-
-void jz4740_clock_udc_disable_auto_suspend(void)
-{
-	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
-
-	clkgr &= ~CLKGR_UDC;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
-}
-EXPORT_SYMBOL_GPL(jz4740_clock_udc_disable_auto_suspend);
-
-void jz4740_clock_udc_enable_auto_suspend(void)
-{
-	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
-
-	clkgr |= CLKGR_UDC;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
-}
-EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
-
-#define JZ_CLOCK_GATE_UART0	BIT(0)
-#define JZ_CLOCK_GATE_TCU	BIT(1)
-#define JZ_CLOCK_GATE_DMAC	BIT(12)
-
-void jz4740_clock_suspend(void)
-{
-	uint32_t clkgr, cppcr;
-
-	clkgr = readl(cgu->base + CGU_REG_CLKGR);
-	clkgr |= JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
-
-	cppcr = readl(cgu->base + CGU_REG_CPPCR);
-	cppcr &= ~BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
-	writel(cppcr, cgu->base + CGU_REG_CPPCR);
-}
-
-void jz4740_clock_resume(void)
-{
-	uint32_t clkgr, cppcr, stable;
-
-	cppcr = readl(cgu->base + CGU_REG_CPPCR);
-	cppcr |= BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
-	writel(cppcr, cgu->base + CGU_REG_CPPCR);
-
-	stable = BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.stable_bit);
-	do {
-		cppcr = readl(cgu->base + CGU_REG_CPPCR);
-	} while (!(cppcr & stable));
-
-	clkgr = readl(cgu->base + CGU_REG_CLKGR);
-	clkgr &= ~JZ_CLOCK_GATE_TCU;
-	clkgr &= ~JZ_CLOCK_GATE_DMAC;
-	clkgr &= ~JZ_CLOCK_GATE_UART0;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
-}
-- 
2.21.0.593.g511ec345e18

