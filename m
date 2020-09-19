Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F90270E55
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgISOEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 10:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOEg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6250923119;
        Sat, 19 Sep 2020 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524275;
        bh=NPVHKsTIcPLqsD4JdOC7choTv9Cwr4e7aqMqj1vQEdc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SRdV0o88M4vpqaXBk2ifx0PZaqd165Fipx4yUOEUKEnGnQU1ESoRfhWZf0dYlp+V5
         U0cSfz9NiMsFftGpi7X5M/yQNlgbxSfFBWchegTGb4If8mzkYNBFF5zwKmTmG1X6hX
         Qugq5N5UagFsWLX79fTokYx/WyMinVe0hAMaESoY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] power: supply: bq27xxx: report "not charging" on all types
Date:   Sat, 19 Sep 2020 16:04:14 +0200
Message-Id: <20200919140418.3705-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
References: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 6f24ff97e323 ("power: supply: bq27xxx_battery: Add the
BQ27Z561 Battery monitor") and commit d74534c27775 ("power:
bq27xxx_battery: Add support for additional bq27xxx family devices")
added support for new device types by copying most of the code and
adding necessary quirks.

However they did not copy the code in bq27xxx_battery_status()
responsible for returning POWER_SUPPLY_STATUS_NOT_CHARGING.

Unify the bq27xxx_battery_status() so for all types when charger is
supplied, it will return "not charging" status.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on BQ27Z561 or other types of batteries. Tested however on
bq34z100.
---
 drivers/power/supply/bq27xxx_battery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 92de7b720182..65806f668b1f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1765,8 +1765,6 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 			status = POWER_SUPPLY_STATUS_FULL;
 		else if (di->cache.flags & BQ27000_FLAG_CHGS)
 			status = POWER_SUPPLY_STATUS_CHARGING;
-		else if (power_supply_am_i_supplied(di->bat) > 0)
-			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
 	} else if (di->opts & BQ27Z561_O_BITS) {
@@ -1785,6 +1783,10 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 			status = POWER_SUPPLY_STATUS_CHARGING;
 	}
 
+	if ((status == POWER_SUPPLY_STATUS_DISCHARGING) &&
+	    (power_supply_am_i_supplied(di->bat) > 0))
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
 	val->intval = status;
 
 	return 0;
-- 
2.17.1

