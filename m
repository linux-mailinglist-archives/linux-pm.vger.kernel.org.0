Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5160719C541
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbgDBO7O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:59:14 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:54329 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388782AbgDBO6d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5g3T37zwy;
        Thu,  2 Apr 2020 16:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839511; bh=Ol/Fy27tVQcocJtHbCOujmzZ2avDxeNSc4gh5D0opQs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Ov6S14+1qIUTfiLKzfv9pmaec6kaL1/TzSMpOudtm+W8wRakdS0mmEaIeNrHQlD+S
         jiGEI4YO1P3yKat7Z3grQ5QWfliU1cp0TDMDqhpv5gO4EVu2KKBOUDwyK8KT5Y7hXp
         T3DQjnxVA6VnmbWBZbR1UpLPrDiD96OvyVWmU5t2DTVandgCTOeA3rlyNqJPFUK4lE
         r6AruVThZvDl+YnXZ+jrpD88Sv4PhTjz7WwcPZYkWD5/0r+rwzKdhI66MCoGhRZoGG
         45I9Q8WDOoMkEX9e4ajY+Eek+ViCpLRF4GqJX20RYFoA3zu7FS/G+zy3KRD5UvnLVO
         wY4z4Gh8mjHWA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:31 +0200
Message-Id: <58a369bc6c2cb1f5ee28dd6dda634999f78fa8b4.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 04/14] power: supply: bq25890: protect view of the chip's
 state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend bq->lock over whole updating of the chip's state. Might get
useful later for switching ADC modes correctly.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 82 ++++++++------------------
 1 file changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c4a69fd69f34..9339e216651f 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -510,74 +510,50 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 	return 0;
 }
 
-static bool bq25890_state_changed(struct bq25890_device *bq,
-				  struct bq25890_state *new_state)
-{
-	struct bq25890_state old_state;
-
-	mutex_lock(&bq->lock);
-	old_state = bq->state;
-	mutex_unlock(&bq->lock);
-
-	return (old_state.chrg_status != new_state->chrg_status ||
-		old_state.chrg_fault != new_state->chrg_fault	||
-		old_state.online != new_state->online		||
-		old_state.bat_fault != new_state->bat_fault	||
-		old_state.boost_fault != new_state->boost_fault ||
-		old_state.vsys_status != new_state->vsys_status);
-}
-
-static void bq25890_handle_state_change(struct bq25890_device *bq,
-					struct bq25890_state *new_state)
+static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 {
+	struct bq25890_state new_state;
 	int ret;
-	struct bq25890_state old_state;
 
-	mutex_lock(&bq->lock);
-	old_state = bq->state;
-	mutex_unlock(&bq->lock);
+	ret = bq25890_get_chip_state(bq, &new_state);
+	if (ret < 0)
+		return IRQ_NONE;
 
-	if (!new_state->online) {			     /* power removed */
+	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
+		return IRQ_NONE;
+
+	if (!new_state.online && bq->state.online) {	    /* power removed */
 		/* disable ADC */
 		ret = bq25890_field_write(bq, F_CONV_START, 0);
 		if (ret < 0)
 			goto error;
-	} else if (!old_state.online) {			    /* power inserted */
+	} else if (new_state.online && !bq->state.online) { /* power inserted */
 		/* enable ADC, to have control of charge current/voltage */
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
 		if (ret < 0)
 			goto error;
 	}
 
-	return;
+	bq->state = new_state;
+	power_supply_changed(bq->charger);
 
+	return IRQ_HANDLED;
 error:
-	dev_err(bq->dev, "Error communicating with the chip.\n");
+	dev_err(bq->dev, "Error communicating with the chip: %pe\n",
+		ERR_PTR(ret));
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t bq25890_irq_handler_thread(int irq, void *private)
 {
 	struct bq25890_device *bq = private;
-	int ret;
-	struct bq25890_state state;
-
-	ret = bq25890_get_chip_state(bq, &state);
-	if (ret < 0)
-		goto handled;
-
-	if (!bq25890_state_changed(bq, &state))
-		goto handled;
-
-	bq25890_handle_state_change(bq, &state);
+	irqreturn_t ret;
 
 	mutex_lock(&bq->lock);
-	bq->state = state;
+	ret = __bq25890_handle_irq(bq);
 	mutex_unlock(&bq->lock);
 
-	power_supply_changed(bq->charger);
-
-handled:
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int bq25890_chip_reset(struct bq25890_device *bq)
@@ -607,7 +583,6 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 {
 	int ret;
 	int i;
-	struct bq25890_state state;
 
 	const struct {
 		enum bq25890_fields id;
@@ -655,16 +630,12 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		return ret;
 	}
 
-	ret = bq25890_get_chip_state(bq, &state);
+	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Get state failed %d\n", ret);
 		return ret;
 	}
 
-	mutex_lock(&bq->lock);
-	bq->state = state;
-	mutex_unlock(&bq->lock);
-
 	return 0;
 }
 
@@ -1001,19 +972,16 @@ static int bq25890_suspend(struct device *dev)
 static int bq25890_resume(struct device *dev)
 {
 	int ret;
-	struct bq25890_state state;
 	struct bq25890_device *bq = dev_get_drvdata(dev);
 
-	ret = bq25890_get_chip_state(bq, &state);
+	mutex_lock(&bq->lock);
+
+	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&bq->lock);
-	bq->state = state;
-	mutex_unlock(&bq->lock);
-
 	/* Re-enable ADC only if charger is plugged in. */
-	if (state.online) {
+	if (bq->state.online) {
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
 		if (ret < 0)
 			return ret;
@@ -1022,6 +990,8 @@ static int bq25890_resume(struct device *dev)
 	/* signal userspace, maybe state changed while suspended */
 	power_supply_changed(bq->charger);
 
+	mutex_unlock(&bq->lock);
+
 	return 0;
 }
 #endif
-- 
2.20.1

