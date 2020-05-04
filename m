Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2D1C474F
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEDTsF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:48:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:15765 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgEDTrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0g0Jymzrw;
        Mon,  4 May 2020 21:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621667; bh=ntq4LsnQORIu89CAAoAWstxPg4wqt9nj/OAT5Y/wOmw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=O4pXp3vPql6IYtDedgKJMj1dOt1gY66txvYxvQ/BG3uVbOAFpwL24XkbnPGo9xt4+
         xjxs2cCEE7w8vmTZuNLYE1yTzMjqeE3UsUt+09ltCZKL+OwvCAthetpPFl2JryhalJ
         L0yhGV2yKFZLraVElhXvndS5fomhlxL1oyLA2cRiHvyuQkKBZ/RKpE0BDNq8FmeCyo
         V1Rrk2X0c4gQzukHpusH+Z+DHqXPFRCLLpqzgxALQi6r9xIlErTQqSgN7H23rG4kED
         zSRqoK4yEwUR91nuYGZQJhQvRqyb80iB4Y7oNIdUt3IXoYj1lPzIHAREebda1TUlu/
         eK4d2wnbdc3XA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:46 +0200
Message-Id: <8a4f95cce6625635380e804bd2ef931e62896ed3.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 5/8] power: bq25890: implement PRECHARGE_CURRENT property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Report configured precharge current.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 02e62ac76e15..dfd7bf9a3a55 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -486,6 +486,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
 		break;
 
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
+		break;
+
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
@@ -686,6 +690,7 @@ static const enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
-- 
2.20.1

