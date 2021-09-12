Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EBC4081B0
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhILUzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:55:40 -0400
Received: from comms.puri.sm ([159.203.221.185]:32776 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236129AbhILUzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Sep 2021 16:55:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6ED6FE030C;
        Sun, 12 Sep 2021 13:54:25 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U2GGkN6HnWPj; Sun, 12 Sep 2021 13:54:24 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] power: supply: max17042_battery: Clear status bits in interrupt handler
Date:   Sun, 12 Sep 2021 22:54:01 +0200
Message-Id: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The gauge requires us to clear the status bits manually for some alerts
to be properly dismissed. Previously the IRQ was configured to react only
on falling edge, which wasn't technically correct (the ALRT line is active
low), but it had a happy side-effect of preventing interrupt storms
on uncleared alerts from happening.

Fixes: 7fbf6b731bca ("power: supply: max17042: Do not enforce (incorrect) interrupt trigger type")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 8dffae76b6a3..c53980c8432a 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -876,6 +876,9 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 		max17042_set_soc_threshold(chip, 1);
 	}
 
+	regmap_clear_bits(chip->regmap, MAX17042_STATUS,
+			  0xFFFF & ~(STATUS_POR_BIT | STATUS_BST_BIT));
+
 	power_supply_changed(chip->battery);
 	return IRQ_HANDLED;
 }
-- 
2.33.0

