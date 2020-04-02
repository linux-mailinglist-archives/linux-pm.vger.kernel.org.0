Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41D419C523
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbgDBO6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:58:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:55245 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388836AbgDBO6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5f6wnCzqB;
        Thu,  2 Apr 2020 16:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839511; bh=aHxtsC8N7E1pudNhXZCf8OSOZbxQCCFh3AVsjrqFoGw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=IQefsOsZdmpl1GYa4eHhaiWo6dqrxNummNHFhVfbtryIyvpgb3iPHfO0xEPoQhcRw
         QQIUp1TamaUdbVZ/sYm+zIb+1VHrW4Ffxtvhx9MvYhjPlOf3nvPAqOIjnI1n6W4qE5
         xJDe0DhCAMea3wwxFPvxyxZD4AQjkW99JZBXWk6vyXzWRN93XCo08rSwFmjJaPSTWy
         slJazljJIheIKQ/+UMdVdcx1PbqrpiMPKXHJ4Z84PMfh7Sp17cnt+X8bbh8jrQcZ8s
         ZSEBxvCs51KHR+veFn2csFumoshZ+urcZixmhmYvX2lGAQoxcmj4KeiuEysKrnKvL7
         Pu2MBPueRRRcA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:30 +0200
Message-Id: <3d647e5c2f69c0cef461ef19004ec40b14e799ca.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 03/14] power: supply: bq25890: make property table const
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Property list should not change, so mark it const.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f9f29edadddc..c4a69fd69f34 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -668,7 +668,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 	return 0;
 }
 
-static enum power_supply_property bq25890_power_supply_props[] = {
+static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
-- 
2.20.1

