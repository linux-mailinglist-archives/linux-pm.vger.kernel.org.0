Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94366D1A81
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJIVGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:06:31 -0400
Received: from muru.com ([72.249.23.125]:36498 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIVGb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:06:31 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id EF2F48140;
        Wed,  9 Oct 2019 21:07:04 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/5] power: supply: cpcap-battery: Simplify coulomb counter calculation with div_s64
Date:   Wed,  9 Oct 2019 14:06:18 -0700
Message-Id: <20191009210621.10522-3-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210621.10522-1-tony@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can simplify cpcap_battery_cc_raw_div() with div_s64.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -33,8 +33,6 @@
 #include <linux/iio/types.h>
 #include <linux/mfd/motorola-cpcap.h>
 
-#include <asm/div64.h>
-
 /*
  * Register bit defines for CPCAP_REG_BPEOL. Some of these seem to
  * map to MC13783UG.pdf "Table 5-19. Register 13, Power Control 0"
@@ -219,28 +217,17 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 				    s16 offset, u32 divider)
 {
 	s64 acc;
-	u64 tmp;
-	int avg_current;
 
 	if (!divider)
 		return 0;
 
 	acc = accumulator;
-	acc = acc - ((s64)sample * offset);
-
-	if (acc >=  0)
-		tmp = acc;
-	else
-		tmp = acc * -1;
+	acc -= (s64)sample * offset;
+	acc *= ddata->cc_lsb;
+	acc *= -1;
+	acc = div_s64(acc, divider);
 
-	tmp = tmp * ddata->cc_lsb;
-	do_div(tmp, divider);
-	avg_current = tmp;
-
-	if (acc >= 0)
-		return -avg_current;
-	else
-		return avg_current;
+	return acc;
 }
 
 /* 3600000μAms = 1μAh */
-- 
2.23.0
