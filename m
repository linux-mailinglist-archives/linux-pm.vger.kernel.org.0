Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5991E1027
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390817AbgEYOMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 10:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgEYOMK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 10:12:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12428207C3;
        Mon, 25 May 2020 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590415930;
        bh=H7j7pXAQBMY0+lN3fLm+BybDcMoNqFcnyIRJOr6BKAc=;
        h=From:To:Cc:Subject:Date:From;
        b=DuOnfyoWC6xbM3Cnr0lkDtdQinhZ20Qt1GC41RL1WfZo49g3v9/IGD3YEpWaWQh83
         RCPX1T38RBRb5KXYsSrM+JMvOd+qOR89Tomz2KoQbXLlOt4sH+vkYqEcAkr4ZthJTQ
         qQ0z526sARs3FyspaUjJ6NQlJB5y1JeZcdUrbm2w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all battery changes
Date:   Mon, 25 May 2020 16:11:59 +0200
Message-Id: <20200525141200.17199-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All battery related data could be important for user-space.  For example
time-to-full could be shown to user on the screen or health could be
monitored for any issues.  Instead of comparing few selected old/new
values, just check if anything changed in the cache.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 942c92127b6d..33c26d42cd02 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1612,12 +1612,10 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
-	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
+	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0) {
 		power_supply_changed(di->bat);
-
-	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
 		di->cache = cache;
+	}
 
 	di->last_update = jiffies;
 }
-- 
2.17.1

