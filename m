Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FF3D51A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406902AbfFKSIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:08:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60354 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406922AbfFKSIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560276492; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0viPHiuXiALagAuJTSTKg7DcwkXlKKizYTwevl9VkvY=;
        b=OTwdAqC2vxPwXL7L28WXviP21bWFGV8y+cGYif32mwzSRT/BCSzKwjk+Q1ux7qa69HTLuA
        NMsb+cpARFlcB6oDVxpRdkKf5ip8o5k64lSVX4AREDhS8/6/Lvkb5Mo2To3RRy5ez6iVzS
        Xz7JVemZ00WM1JLCzB/0e01Vrd1ZMHs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/5] MIPS: Remove dead code
Date:   Tue, 11 Jun 2019 20:07:57 +0200
Message-Id: <20190611180757.32299-5-paul@crapouillou.net>
In-Reply-To: <20190611180757.32299-1-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the unused <asm/mach-jz4740/clock.h> include.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc4

 arch/mips/include/asm/mach-jz4740/clock.h | 22 ----------------------
 arch/mips/jz4740/board-qi_lb60.c          |  2 --
 arch/mips/jz4740/platform.c               |  2 --
 arch/mips/jz4740/time.c                   |  3 ---
 4 files changed, 29 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-jz4740/clock.h

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
deleted file mode 100644
index 600d5051691a..000000000000
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __ASM_JZ4740_CLOCK_H__
-#define __ASM_JZ4740_CLOCK_H__
-
-enum jz4740_wait_mode {
-	JZ4740_WAIT_MODE_IDLE,
-	JZ4740_WAIT_MODE_SLEEP,
-};
-
-void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
-
-void jz4740_clock_suspend(void);
-void jz4740_clock_resume(void);
-
-void jz4740_clock_udc_enable_auto_suspend(void);
-void jz4740_clock_udc_disable_auto_suspend(void);
-
-#endif
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 071e9d94eea7..d07ee418e5b0 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -37,8 +37,6 @@
 
 #include <asm/mach-jz4740/platform.h>
 
-#include "clock.h"
-
 /* GPIOs */
 #define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
 #define QI_LB60_GPIO_KEYIN(x)		(JZ_GPIO_PORTD(18) + (x))
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 4b89abb17950..c74c99f5951d 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -21,8 +21,6 @@
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 
-#include "clock.h"
-
 /* USB Device Controller */
 struct platform_device jz4740_udc_xceiv_device = {
 	.name = "usb_phy_generic",
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index a3260c754e65..cb768e560d8b 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -13,13 +13,10 @@
 #include <linux/clockchips.h>
 #include <linux/sched_clock.h>
 
-#include <asm/mach-jz4740/clock.h>
 #include <asm/mach-jz4740/irq.h>
 #include <asm/mach-jz4740/timer.h>
 #include <asm/time.h>
 
-#include "clock.h"
-
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
 
-- 
2.21.0.593.g511ec345e18

