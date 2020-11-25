Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF92C383D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 05:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKYEpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 23:45:19 -0500
Received: from comms.puri.sm ([159.203.221.185]:48000 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgKYEpT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 23:45:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0560AE0141;
        Tue, 24 Nov 2020 20:44:49 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d2T0OxrIJYPM; Tue, 24 Nov 2020 20:44:47 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 1/4] power: max17042_battery: Fix current_{avg,now} hiding with no current sense
Date:   Wed, 25 Nov 2020 05:44:44 +0100
Message-ID: <2264396.HPVdm0XNkV@pliszka>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When current sense is disabled, max17042_no_current_sense_psy_desc gets
used which ignores two last properties from the list.

Fixes: 21b01cc879cc ("power: supply: max17042_battery: Add support for the TTE_NOW prop")

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index f284547913d6..2e9672fe4df1 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -85,9 +85,10 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_TEMP_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	// these two have to be at the end on the list
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 };
 
 static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
-- 
2.29.2



