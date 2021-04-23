Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B136928D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhDWM7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:59:20 -0400
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21171 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDWM7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 08:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619182713; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=R9f1QxYmddGFZTqz/hZqF5tvBoex/fKYbofSPjgmFSjDx6D7sY7sKVsf9EkH/Rc/zMNt9uzfM6kyc1LvkdLpwQOgmNAJf5eJKitrKz87QjswlDTNmGmuW0d5dZ/uwkPTbC8x94IsoJAPKlMfkeQSIdAg+AU6jn3F98QOb2FubJo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1619182713; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6fFd2RWg6ZB7ZOJqmflBA0fUpb9RZMdgrn2KoLcfnjg=; 
        b=ikuCEjOFE2ugOWiBOgaNi2sKXp7evILXchxeFMYGpRWwMvzOj3YQ5HasG4iRL0oBLrdYiyGHh5wyVGYvjUL0y7n1i82CbL9QcJoOOzTK/WAHmShGQ5Oa1s20YrOUWYlCJukdulQ+bbdLPqxkcKcVapW74IwgHgES0jmNd/fyQhQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-95-222-215-151.hsi15.unitymediagroup.de [95.222.215.151]) by mx.zoho.eu
        with SMTPS id 1619182711610837.8148067591384; Fri, 23 Apr 2021 14:58:31 +0200 (CEST)
Date:   Fri, 23 Apr 2021 14:58:31 +0200
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] power: supply: cpcap-battery: invalidate
 empty->counter_uah and charge_full when charge_now indicates that they are
 grossly wrong
Message-Id: <20210423145831.a8f0ba37baa211353cdf43b8@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This invalidates empty->counter_uah and charge_full when charge_now indicates
that they are grossly wrong and adds some tolerance to
POWER_SUPPLY_PROP_CHARGE_FULL to allow for inaccuracies in the charge counter
and manufacturing tolerances in the battery.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-battery.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 386d269e699f..9d9453231ea7 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -762,10 +762,23 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		if (!empty->voltage)
 			return -ENODATA;
 		val->intval = empty->counter_uah - latest->counter_uah;
-		if (val->intval < 0)
+		if (val->intval < 0) {
+			/* Assume invalid config if CHARGE_NOW is -20% */
+			if (ddata->charge_full && abs(val->intval) > ddata->charge_full/5) {
+				empty->voltage = 0;
+				ddata->charge_full = 0;
+				return -ENODATA;
+			}
 			val->intval = 0;
-		else if (ddata->charge_full && ddata->charge_full < val->intval)
+		} else if (ddata->charge_full && ddata->charge_full < val->intval) {
+			/* Assume invalid config if CHARGE_NOW exceeds CHARGE_FULL by 20% */
+			if (val->intval > (6*ddata->charge_full)/5) {
+				empty->voltage = 0;
+				ddata->charge_full = 0;
+				return -ENODATA;
+			}
 			val->intval = ddata->charge_full;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (!ddata->charge_full)
@@ -842,7 +855,7 @@ static int cpcap_battery_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (val->intval < 0)
 			return -EINVAL;
-		if (val->intval > ddata->config.info.charge_full_design)
+		if (val->intval > (6*ddata->config.info.charge_full_design)/5)
 			return -EINVAL;
 
 		ddata->charge_full = val->intval;
-- 
2.31.0


