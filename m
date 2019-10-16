Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54FCDA187
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfJPWaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:30:11 -0400
Received: from muru.com ([72.249.23.125]:37642 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWaK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:30:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id ED1908176;
        Wed, 16 Oct 2019 22:30:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] power: supply: cpcap-battery: Check voltage before orderly_poweroff
Date:   Wed, 16 Oct 2019 15:30:04 -0700
Message-Id: <20191016223005.9246-2-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016223005.9246-1-tony@atomide.com>
References: <20191016223005.9246-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can get the low voltage interrupt trigger sometimes way too early,
maybe because of CPU load spikes. This causes orderly_poweroff() be
called too easily.

Let's check the voltage before orderly_poweroff in case it was not
yet a permanent condition. We will be getting more interrupts anyways
if the condition persists.

Let's also show the measured voltages for low battery and battery
empty warnings since we have them.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -562,12 +562,14 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 	switch (d->action) {
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
 		if (latest->current_ua >= 0)
-			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
+			dev_warn(ddata->dev, "Battery low at %imV!\n",
+				latest->voltage / 1000);
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
-		if (latest->current_ua >= 0) {
+		if (latest->current_ua >= 0 && latest->voltage <= 3200000) {
 			dev_emerg(ddata->dev,
-				  "Battery empty at 3.1V, powering off\n");
+				  "Battery empty at %imV, powering off\n",
+				  latest->voltage / 1000);
 			orderly_poweroff(true);
 		}
 		break;
-- 
2.23.0
