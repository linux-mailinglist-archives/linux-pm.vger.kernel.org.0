Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D584317C1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhJRLsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhJRLsQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:16 -0400
Date:   Mon, 18 Oct 2021 11:46:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UCHsTOUXaegVXYwLcZ8Xdzc+kqsYzZ1rwgGIBkjz1c=;
        b=TF5y2hX1anV+kx2uIDpdjX6NWcyBs8+PxEqwnAPLF187vFxrVB7IRx9hjIKKsUAsoVpmJW
        SuaH7fkqCfTrVffTbzPOOenIeybRKDfvmgM6hkWTMUH/mPMqAFT8eacVD3j3tIaAY0nWvN
        mV1kWStHVWL+XVhVku+jxIOG9fzjIxXiSVBMhIj816uryUn7+ChbJ4CQFJxL8qeWxO9xWD
        869tcXePktUWhCo4EYiJxbjiOegNBY6jecWQgPEfcA84BpQ2w6wNxLeaZm5eVwuIkSUDve
        +BBmnHLxjxiUOln1XbgbPBaubfd4+gxOR4WEvyix8yivcXGI9uUTbR0W/MYJsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UCHsTOUXaegVXYwLcZ8Xdzc+kqsYzZ1rwgGIBkjz1c=;
        b=8CdLUxjf9MhCXj3LYVjis+ANxyfkQd1n1fo/VwbcgalxshEhlK5nmMhUzRWSHct+mC/NWk
        kXlOKUXaZQXLOcDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/netlink: Add the temperature
 when crossing a trip point
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
References: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <163455756280.25758.2126616786096568156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fc656fa14da7865774b4251afa88ffcf22bf02d2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fc656fa14da7865774b4251afa88ffcf22bf02d2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sat, 02 Oct 2021 00:33:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 07 Oct 2021 15:41:38 +02:00

thermal/drivers/netlink: Add the temperature when crossing a trip point

The slope of the temperature increase or decrease can be high and when
the temperature crosses the trip point, there could be a significant
difference between the trip temperature and the measured temperatures.

That forces the userspace to read the temperature back right after
receiving a trip violation notification.

In order to be efficient, give the temperature which resulted in the
trip violation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20211001223323.1836640-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c    |  6 ++++--
 drivers/thermal/thermal_netlink.c | 11 ++++++-----
 drivers/thermal/thermal_netlink.h |  8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 51374f4..9e243d9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -375,10 +375,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
 		if (tz->last_temperature < trip_temp &&
 		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip);
+			thermal_notify_tz_trip_up(tz->id, trip,
+						  tz->temperature);
 		if (tz->last_temperature >= trip_temp &&
 		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip);
+			thermal_notify_tz_trip_down(tz->id, trip,
+						    tz->temperature);
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 1234dbe..a16dd4d 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param *p)
 static int thermal_genl_event_tz_trip_up(struct param *p)
 {
 	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
-	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
 		return -EMSGSIZE;
 
 	return 0;
@@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
 }
 
-int thermal_notify_tz_trip_down(int tz_id, int trip_id)
+int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
+	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
 }
 
-int thermal_notify_tz_trip_up(int tz_id, int trip_id)
+int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
+	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
 }
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 828d1dd..e554f76 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const char *name);
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
 int thermal_notify_tz_disable(int tz_id);
-int thermal_notify_tz_trip_down(int tz_id, int id);
-int thermal_notify_tz_trip_up(int tz_id, int id);
+int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
+int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
 int thermal_notify_tz_trip_delete(int tz_id, int id);
 int thermal_notify_tz_trip_add(int tz_id, int id, int type,
 			       int temp, int hyst);
@@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int tz_id)
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_down(int tz_id, int id)
+static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_up(int tz_id, int id)
+static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
 {
 	return 0;
 }
