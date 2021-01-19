Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE512FC261
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbhASVb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbhASV2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D730C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngn/TZ5sPqqLKekh4wg9dLqmCdWWh8CK2YUIjBEkr+o=;
        b=ak3XXndeHwMBoCZtONi1atzcUNJHShnm2y9HEM8FVPa9X6dSY8sqjAf3c7iyGDX65deqDe
        wJzc5ESCbqqzU3VCJuGfR12iuOec5PmEZcN37pKgZI9p/4+9S2q6LzrzGQGx/PvIsv/jk2
        JDGz4ayuHwN41FakSBvibO40h+e3pbW/Z6hfAGxmjAqB0AS5Nq5crteVujapH8PEBHd2Vx
        BRNiga1LflMIz+eakpO9WA+P12NZSbYqVi9byVV9V/ht8kuVNA+qg3MheK9JnY0LxPzy7j
        Cxvf/s6WsQIiFQC85SIc9bSnETRd/6BBCvxXePZAHwdJEGVkGFOXhlhMkBDuWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngn/TZ5sPqqLKekh4wg9dLqmCdWWh8CK2YUIjBEkr+o=;
        b=sYiVSOhEoiYbV/Rm7bMvGvRzHcDzh+Tx1byVeRJOAJryIVAmw2eyrD8l8r+ufTF+U4mN82
        9HeIZ6nT1U/ixOAw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] acpi/drivers/thermal: Remove TRIPS_NONE
 cooling device binding
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>, amitk@kernel.org
In-Reply-To: <20201214233811.485669-4-daniel.lezcano@linaro.org>
References: <20201214233811.485669-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164649.414.16835710488335910524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     43bb4a9d658398151ad1b77340003ff81f4b8650
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//43bb4a9d658398151ad1b77340003ff81f4b8650
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:07 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:18 +01:00

acpi/drivers/thermal: Remove TRIPS_NONE cooling device binding

The loop is here to create default cooling device binding on the
THERMAL_TRIPS_NONE number which is used to be the 'forced_passive'
feature. However, we removed all code dealing with that in the thermal
core, thus this binding does no longer make sense.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-4-daniel.lezcano@linaro.org
---
 drivers/acpi/thermal.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b5e4bc9..26a89ff 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -764,25 +764,6 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 		}
 	}
 
-	for (i = 0; i < tz->devices.count; i++) {
-		handle = tz->devices.handles[i];
-		status = acpi_bus_get_device(handle, &dev);
-		if (ACPI_SUCCESS(status) && (dev == device)) {
-			if (bind)
-				result = thermal_zone_bind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev, THERMAL_NO_LIMIT,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_WEIGHT_DEFAULT);
-			else
-				result = thermal_zone_unbind_cooling_device
-						(thermal, THERMAL_TRIPS_NONE,
-						 cdev);
-			if (result)
-				goto failed;
-		}
-	}
-
 failed:
 	return result;
 }
