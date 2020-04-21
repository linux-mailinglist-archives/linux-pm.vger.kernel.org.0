Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15FC1B2174
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDUIWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 04:22:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUIWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 04:22:06 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jQoAL-0005Gc-PZ; Tue, 21 Apr 2020 08:22:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PM: core: Switch back to async_schedule_dev()
Date:   Tue, 21 Apr 2020 16:21:55 +0800
Message-Id: <20200421082155.23709-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 8b9ec6b73277 ("PM core: Use new async_schedule_dev command")
introduced a new function for better performance.

However commit f2a424f6c613 ("PM / core: Introduce dpm_async_fn()
helper") falls back to the non-optimized version, async_schedule().

So switch back to the sync_schedule_dev() to improve performance

Fixes: f2a424f6c613 ("PM / core: Introduce dpm_async_fn() helper")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fdd508a78ffd..0e07e17c2def 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -730,7 +730,7 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(func, dev);
+		async_schedule_dev(func, dev);
 		return true;
 	}
 
-- 
2.17.1

