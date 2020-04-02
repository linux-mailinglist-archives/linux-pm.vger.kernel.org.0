Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9619C53E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbgDBO7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:59:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37958 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388781AbgDBO6e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5h2hkPz1vW;
        Thu,  2 Apr 2020 16:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839512; bh=X6di/kZ9JXtfx1MiBhjtRiHxgwlcVR2sOcyLvmd+Kuk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=aKsvPqp9eEE1e3/OOmvgA0P552rUjkO0alh15EpymshDJkzGwBF5W4tGdNFcA7Pyz
         EXIS12pOUL3N5yIYHdfNIec2P57TahFr1eZYjvoJIGQVcKrhDoxPE0S/bZ2S75aUB9
         7K6IFE3wO1hCNCb11zuzdCnGHflAG4JjhQ0urRc6cNkWg3+KL7z0KMr9hh+CsRnGeR
         rwMD7gdEa0SS3uecNeagcwvSW3ihusPGLtIn+pqmitwraRUFeGKhV8rLM6kRdLddCn
         j+DmTsv7guGRMnsBxLF91I0wKxGXCauFe/nB1jmh/mke9CyxSRHoTjDTMo+L9tinUF
         laUrPPhFFGdrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:32 +0200
Message-Id: <3aa6336d84b67425a1c590e18668b2da92f618a3.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 06/14] power: supply: bq25890: update state on property read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

