Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6030FD1A20
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfJIUw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 16:52:58 -0400
Received: from muru.com ([72.249.23.125]:36422 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIUw6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 16:52:58 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5BDA98162;
        Wed,  9 Oct 2019 20:53:31 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] power: supply: cpcap-battery: Check voltage before orderly_poweroff
Date:   Wed,  9 Oct 2019 13:52:51 -0700
Message-Id: <20191009205252.9510-2-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009205252.9510-1-tony@atomide.com>
References: <20191009205252.9510-1-tony@atomide.com>
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
 drivers/power/supply/cpcap-battery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -562,12 +562,15 @@ static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 	switch (d->action) {
 	case CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW:
 		if (latest->current_ua >= 0)
-			dev_warn(ddata->dev, "Battery low at 3.3V!\n");
+			dev_warn(ddata->dev, "Battery low at %imV!\n",
+				latest->voltage / 1000);
 		break;
 	case CPCAP_BATTERY_IRQ_ACTION_POWEROFF:
-		if (latest->current_ua >= 0) {
+		if (latest->current_ua >= 0 && latest->voltage >= 0 &&
+		    latest->voltage <= 3100000) {
 			dev_emerg(ddata->dev,
-				  "Battery empty at 3.1V, powering off\n");
+				  "Battery empty at %imV, powering off\n",
+				  latest->voltage / 1000);
 			orderly_poweroff(true);
 		}
 		break;
-- 
2.23.0
