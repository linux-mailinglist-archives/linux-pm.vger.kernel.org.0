Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6367B37
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2019 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGMQXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jul 2019 12:23:10 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:43659 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfGMQXK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jul 2019 12:23:10 -0400
X-Greylist: delayed 2358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jul 2019 12:23:08 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id x6DFhQTJ028509;
        Sat, 13 Jul 2019 18:43:31 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 5290843311;
        Sat, 13 Jul 2019 18:43:27 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] power: reset: reboot-mode: Fix author email format
Date:   Sat, 13 Jul 2019 18:42:48 +0300
Message-Id: <20190713154248.24382-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Closing angle bracket was missing.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/power/reset/reboot-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 06ff035b57f5..b4076b10b893 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -190,6 +190,6 @@ void devm_reboot_mode_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
 
-MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_DESCRIPTION("System reboot mode core library");
 MODULE_LICENSE("GPL v2");
-- 
2.16.4

