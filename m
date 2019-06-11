Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1C3D512
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406829AbfFKSIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:08:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60280 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406861AbfFKSIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560276488; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxguP54LGk1LDDmHZ+LTxj1W+hmJy/VMSDmPzHC2W88=;
        b=aywADk+hxDpBBFft8+10XyUbQRWOiHGjl23uw3oFuaKJxkXjeuWaXskKTIRbMaaR3JCY8L
        Ke1xODBKLCtKbtv0UHh85kIcboviI2QZaUPPT5fLgNqcAv0FpGJrRH74wrhfVOaeXzI5+p
        Pd/wB9sIZsRtldtihvI4RT5b6DPV4FE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/5] MIPS: jz4740: PM: Let CGU driver suspend clocks and set sleep mode
Date:   Tue, 11 Jun 2019 20:07:55 +0200
Message-Id: <20190611180757.32299-3-paul@crapouillou.net>
In-Reply-To: <20190611180757.32299-1-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of forcing the jz4740 clocks to suspend here, we let the CGU
driver handle it.
We also let the CGU driver set the "sleep mode" bit.

This has the added benefit that now it is possible to build a kernel on
SoCs newer than the JZ4740 with CONFIG_PM.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc4

 arch/mips/jz4740/pm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/jz4740/pm.c b/arch/mips/jz4740/pm.c
index bbdd2b801e6e..f9b551f01f42 100644
--- a/arch/mips/jz4740/pm.c
+++ b/arch/mips/jz4740/pm.c
@@ -9,21 +9,13 @@
 #include <linux/delay.h>
 #include <linux/suspend.h>
 
-#include <asm/mach-jz4740/clock.h>
-
 static int jz4740_pm_enter(suspend_state_t state)
 {
-	jz4740_clock_suspend();
-
-	jz4740_clock_set_wait_mode(JZ4740_WAIT_MODE_SLEEP);
-
 	__asm__(".set\tmips3\n\t"
 		"wait\n\t"
 		".set\tmips0");
 
-	jz4740_clock_set_wait_mode(JZ4740_WAIT_MODE_IDLE);
 
-	jz4740_clock_resume();
 
 	return 0;
 }
-- 
2.21.0.593.g511ec345e18

