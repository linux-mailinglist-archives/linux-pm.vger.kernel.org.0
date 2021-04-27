Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B808A36CBDC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhD0TpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhD0TpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:09 -0400
Date:   Tue, 27 Apr 2021 19:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKp4+vv6y9wv8xFhdrjRicbm3Ksr1R/I3wuLiVTb0AI=;
        b=EUCEJ37mwWLRxJp0xLb3Ers1htZdny9BzqhjszaV3S7kKc2HHVXd4ih3LWLQdzkj2uxd8O
        HJxsYyuHLTz0i9gjC5baRS7Hr5NAQOpwJnkkStUn1rXObCLMtq8YJyf8ZHWlp08xHlrJg7
        NAVyUafftAs/He3kFpa4Y9xanW937bteUQwqXc3MENo0P5xIeGqeS918flQMQJlS9VG7RC
        PWO42KE4ksH9kmjJmAJbeuOxPvoLMYOC1DcwpktykobgnVRCNujXSuBLS9kgB7zv6hZNRi
        P3LENhVBNr6G+y3nrDpj39P6/1Wa2+t4v8uk5k/okecIO7uw4lfsnELZa5NOnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKp4+vv6y9wv8xFhdrjRicbm3Ksr1R/I3wuLiVTb0AI=;
        b=J8sRbfa7+mUFPhoijfr/4BfTT2gzEUWl23sqyrU1lHvQgdTqwq31vusxSjsiD/x2mwg6sA
        iI3Am0JOXpwv30DA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/power_allocator: Update once
 cooling devices when temp is low
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210422114308.29684-4-lukasz.luba@arm.com>
References: <20210422114308.29684-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266443.29796.5088245739039949477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0952177f2a1f63ba87a1940fac21768f402c0b94
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0952177f2a1f63ba87a1940fac21768f402c0b94
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 12:43:08 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:51:14 +02:00

thermal/core/power_allocator: Update once cooling devices when temp is low

The cooling device state change generates an event, also when there is no
need, because temperature is low and device is not throttled. Avoid to
unnecessary update the cooling device which means also not sending event.
The cooling device state has not changed because the temperature is still
below the first activation trip point value, so we can do this.
Add a tracking mechanism to make sure it updates cooling devices only
once - when the temperature dropps below first trip point.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422114308.29684-4-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d393409..a6cdb2e 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -571,7 +571,7 @@ static void reset_pid_controller(struct power_allocator_params *params)
 	params->prev_err = 0;
 }
 
-static void allow_maximum_power(struct thermal_zone_device *tz)
+static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
@@ -594,9 +594,10 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 		 */
 		cdev->ops->get_requested_power(cdev, &req_power);
 
-		instance->cdev->updated = false;
+		if (update)
+			__thermal_cdev_update(instance->cdev);
+
 		mutex_unlock(&instance->cdev->lock);
-		thermal_cdev_update(instance->cdev);
 	}
 	mutex_unlock(&tz->lock);
 }
@@ -710,6 +711,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	int ret;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
+	bool update;
 
 	/*
 	 * We get called for every trip point but we only need to do
@@ -721,9 +723,10 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
 	if (!ret && (tz->temperature < switch_on_temp)) {
+		update = (tz->last_temperature >= switch_on_temp);
 		tz->passive = 0;
 		reset_pid_controller(params);
-		allow_maximum_power(tz);
+		allow_maximum_power(tz, update);
 		return 0;
 	}
 
