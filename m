Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C46E1C2D47
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgECPVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:16 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34101 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbgECPVP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:15 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7X31HqzfV;
        Sun,  3 May 2020 17:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519272; bh=X6di/kZ9JXtfx1MiBhjtRiHxgwlcVR2sOcyLvmd+Kuk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=iJkQy5WjomYB9rOwyo93wOUgoSQnHTuwg9EeOBxUThjQ3uVn45QuVMor/q2XrucnT
         TrQuLdTHTLC5nIO1NkMou8t48udmThxM3KQSz877MrKCBOKTZdLA4tj8+fGTFF2JFq
         b17jmceveqZZT03PfPz2xYNvvQJiIY5S8JaMrZLSeDKXVip31hiNiDJftB63LsqebX
         GCh2hNtKEWTYeP8jPsbJ7pCAkqFMd45MzY7bH5MpSkADff0N9UfKOFp5PJIfQ2QBrK
         NN28r18PEa/iCOxy7/0+pbHebZ36O62qFaeJN3EqWlTu4dHU9DnYXBO1tjDQTyHrXy
         As/FvQxWBabQQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:12 +0200
Message-Id: <5c8e8f4c5a7fc2cecb62342f9a964f69f3fde7ae.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 06/11] power: bq25890: update state on property read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Edge interrupts from the charger may be lost or stuck in fault mode
since probe(). Check if something changed everytime userspace wants
some data.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 3b02fa80aedd..e4368d01396a 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -389,6 +389,8 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 	}
 }
 
+static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq);
+
 static int bq25890_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -399,6 +401,8 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 	int ret;
 
 	mutex_lock(&bq->lock);
+	/* update state in case we lost an interrupt */
+	__bq25890_handle_irq(bq);
 	state = bq->state;
 	do_adc_conv = !state.online && bq25890_is_adc_property(psp);
 	if (do_adc_conv)
-- 
2.20.1

