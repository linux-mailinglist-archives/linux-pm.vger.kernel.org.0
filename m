Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5481619DF1F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgDCUUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:33 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:41777 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDCUUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBk6XyxzGl;
        Fri,  3 Apr 2020 22:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945231; bh=PxKU8o7BoNDyLrnKFV+GeC6g2YaP/coZt/imF8aw61k=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Rp/xDo2NMn12KWOwZ97Q+rGvA9PFSNCj0UJ70qKRIcVBTdR0x4kB4/OFSyAsTXkqC
         cdPfiiZp6rOkmPZ3iWJ8I1yMbddICzP54BTtK0AgbkZzibHM9QnR46s7B9F0f5sY5O
         KcscNokGsWF34mqVcKjSWTP1lRJi0OCDKFNVDalnS29LbOD1qNhciiY3xFrO19wzAY
         +w/PClpyJFYBzyoJc/dz+vaASEZRV0t0vFitKn+IqFtiO9EhqOOkX6TEl4eMV+kwcu
         /ocuroFjabcxyV46D4iJLzelb14/quZxuhXIUBRHiRkBB5YyE7XbiEgJFxabYDXlNg
         QylkDPUIXOt6w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:30 +0200
Message-Id: <c911486f7d8727c5264f3cb4142c26b6765eadec.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 01/11] power: charger-manager: remove duplicate assignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

num_properties is already copied earlier using memcpy().
Remove the duplicate.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v3: initial version
---
 drivers/power/supply/charger-manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a21e1a2673f8..887f5bb879e5 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1728,7 +1728,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	memcpy(cm->charger_psy_desc.properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
-	cm->charger_psy_desc.num_properties = psy_default.num_properties;
 
 	/* Find which optional psy-properties are available */
 	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
-- 
2.20.1

