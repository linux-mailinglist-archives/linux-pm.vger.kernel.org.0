Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9990D185DE4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgCOPOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33259 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so11459200wmg.0;
        Sun, 15 Mar 2020 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGa9XEWZMhEoDRa47mK7TK3lt95mt5tdXrfwlGeJG80=;
        b=dV3MGRtdBX7aV53hQXzH3oSrN/MU+PyFfA2h5sOYUy/Uh/dAn5U6pICCNIF9oZIkMz
         VWnn2UEUgO4sdyrr01upGHO/V+9O9Cw5+pwgRc0ngxEzJxHXYELExIGkIoJ0i5fp4SOO
         m31KUhiBjkO/jLbgjfmBTf/jiJ6Krn367nZeR4xVqpgnli/6Z2cwmka3DSTfwk2AQRvs
         FTXqH3DzyMG4ulfqSquUlc5P6HPGzJhNu0sz62Y++aTsiV1hydoCQ2l4xYhiS3x8QqHL
         PpLlvW2igZwTxSEPQdihDGVaz7tWs8ZccSCWXq1IXTJhSx8LHrTnwl9P6YBrnP7stgD3
         DhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGa9XEWZMhEoDRa47mK7TK3lt95mt5tdXrfwlGeJG80=;
        b=dE9gaQmw1sGNz54zm0CnvkSN3WoeBb24taBXT45KIJl5uVY1YB4iEr4xZ3LHIa72N7
         uknuqrHV5ELc/YuC77tmMEtrHwAAap7Xi5Rb7GCI0zBWrVBOERSncZ+QO7z1PZrelb8n
         TWRkWjbH+TwNJ/mPJc1j/53AOA1weTAyk48KxpNoKVyGpb62d9IKRUY/sLr6UjvfJp4Q
         FJj/Sez5Hlk3wFUzZZfgarJihhtc06b3rbwxcfjmdPMqSiSGZ1i/6/YJKTpHSY9o51AI
         NWGpNiq9eynL/YsHRQj714U1B0YWuX+eMahsylVrto5nRlG5Co+wnKezZt+dfxwNM212
         gsow==
X-Gm-Message-State: ANhLgQ1d8UQtS5o5Vdi/Rl6Q/gyfbrelnvR6tUJtrrEDVicxTDjS4r4g
        Biw7rYeiDmVNFGBN/MgShnQ=
X-Google-Smtp-Source: ADFU+vtFLZjnsh5uhh0CF57nC0sQeFklQRD/6ueYBTaTtlvakrexgUWnHCfv+pwL9r05kQsGiegl6Q==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr8833448wmu.89.1584285286473;
        Sun, 15 Mar 2020 08:14:46 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:45 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 12/15] power: supply: cpcap-battery: stabilize charge_full value
Date:   Sun, 15 Mar 2020 18:12:03 +0300
Message-Id: <20200315151206.30909-12-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It will not grow after the battery met "fully charged" state. This is
needed because of how constant voltage charging works. If we want "fully
charged" state to be reported in a user expected manner we are forced to
do it when the charging current is low enough, but not a zero value.

So, we report "battery full" when the charging current is as low as 100
mA. But the actual charging continues until the user disconnects the
charger. It means that a few mAh will be added to the reported
charge_full value, which the user shouldn't see. With that purpose we
clamp the charge_now value to not exceed charge_full.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 66ea1a718e02..517acdfa6009 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -469,15 +469,15 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	if (cpcap_battery_full(ddata)) {
 		full = cpcap_battery_get_full(ddata);
 		/* Update full state value? */
-		if (latest->counter_uah <= full->counter_uah ||
-		    !full->voltage) {
+		if (!full->voltage) {
 			memcpy(full, latest, sizeof(*full));
 
 			empty = cpcap_battery_get_empty(ddata);
-			if (empty->voltage && empty->voltage != -1)
+			if (empty->voltage) {
 				ddata->charge_full =
 					empty->counter_uah - full->counter_uah;
-			else if (ddata->charge_full) {
+				empty->voltage = -1;
+			} else if (ddata->charge_full) {
 				/* Initialize with user provided data */
 				empty->counter_uah =
 					full->counter_uah + ddata->charge_full;
@@ -488,18 +488,15 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	} else if (cpcap_battery_low(ddata)) {
 		empty = cpcap_battery_get_empty(ddata);
 		/* Update empty state value? */
-		if (latest->counter_uah >= empty->counter_uah ||
-		    !empty->voltage) {
+		if (!empty->voltage || empty->voltage == -1) {
 			memcpy(empty, latest, sizeof(*empty));
 
 			full = cpcap_battery_get_full(ddata);
-			if (full->voltage)
+			if (full->voltage) {
 				ddata->charge_full =
 					empty->counter_uah - full->counter_uah;
-			else if (ddata->charge_full)
-				/* Initialize with user provided data */
-				full->counter_uah =
-					empty->counter_uah - ddata->charge_full;
+				full->voltage = 0;
+			}
 		}
 	}
 
@@ -638,9 +635,9 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		empty = cpcap_battery_get_empty(ddata);
 		if (!empty->voltage || !ddata->charge_full)
 			return -ENODATA;
-		val->intval = (empty->counter_uah -
-			       latest->counter_uah) * 100;
-		val->intval /= ddata->charge_full;
+		val->intval = empty->counter_uah - latest->counter_uah;
+		val->intval = clamp(val->intval, 0, ddata->charge_full);
+		val->intval = val->intval * 100 / ddata->charge_full;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		val->intval = cpcap_battery_get_capacity_level(ddata);
@@ -650,6 +647,10 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		if (!empty->voltage)
 			return -ENODATA;
 		val->intval = empty->counter_uah - latest->counter_uah;
+		if (val->intval < 0)
+			val->intval = 0;
+		else if (ddata->charge_full && ddata->charge_full < val->intval)
+			val->intval = ddata->charge_full;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (!ddata->charge_full)
-- 
2.11.0

