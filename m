Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF16D7A97
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfJOPyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 11:54:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53411 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfJOPyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 11:54:25 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKP9M-0007JU-6w; Tue, 15 Oct 2019 16:54:16 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKP9L-0006aI-I0; Tue, 15 Oct 2019 16:54:15 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: fix __le32 cast in reset code
Date:   Tue, 15 Oct 2019 16:54:14 +0100
Message-Id: <20191015155414.25267-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The writel() takes standard integers, not __le32 so
fix the following sparse warnings by removing the
cpu_to_le32() calls.

drivers/power/reset/at91-reset.c:134:9: warning: cast from restricted __le32
drivers/power/reset/at91-reset.c:143:9: warning: cast from restricted __le32

This has made no code changes, the md5sums pre and post applying
this patch are the same. The at91 should be natively little endian
anyway.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/reset/at91-reset.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 44ca983a49a1..d94e3267c3b6 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -131,7 +131,7 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
 static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
 			   void *cmd)
 {
-	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
+	writel(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST,
 	       at91_rstc_base);
 
 	return NOTIFY_DONE;
@@ -140,9 +140,7 @@ static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
 static int samx7_restart(struct notifier_block *this, unsigned long mode,
 			 void *cmd)
 {
-	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
-	       at91_rstc_base);
-
+	writel(AT91_RSTC_KEY | AT91_RSTC_PROCRST, at91_rstc_base);
 	return NOTIFY_DONE;
 }
 
-- 
2.23.0

