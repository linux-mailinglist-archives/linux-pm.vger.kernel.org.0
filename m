Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D76D2FC255
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbhASV2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbhASV2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD04C061757
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:29 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0JrnK592PMI3aYw2nFksi7WfNUTal/RIU2VteBVPcc=;
        b=z7/XOOdZ6WUc9MjD1hnyrlRkXos/NM0rnstrHELbxq1e+uWyGjWgIuFDPmw8q9kjMsNgnj
        ilWhFuxFLwrouHlNUrU6OPUcH0z9JypdPrlXK7KBGatAZmBllxqzoXgFB1MxF2Njqxfk/7
        1W88IOWEP1NoEwQUiaznBhZz9X6G1tT7yWrel2w/20X2erY4ghJLzWM4BSXcnyodidx196
        O8nvRTCOTPK6gAKmcQv0EV3AeWToes8oosOHrPFsIo8NQ5sB6AuU01eJpAcz/AGoRfE8BM
        7dwlESxYmCKQ4avWb4rP+nkWB9YxyZEODGhaXNPpS6ws6E5ci0NbknMo3zb9AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0JrnK592PMI3aYw2nFksi7WfNUTal/RIU2VteBVPcc=;
        b=GvcvKkxemlSnIVbDBy8eTSps68GL11W/5ncq1wawv/u5rLH1pqJl8nXQ1t86bWaMwI9/eB
        +dDtKYQw0dWAP5AQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove pointless
 thermal_zone_device_reset() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201222181110.1231977-1-daniel.lezcano@linaro.org>
References: <20201222181110.1231977-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164527.414.7454992186507302673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d0df264fbd3c531787dec59c4b3fca854bc7ee49
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d0df264fbd3c531787dec59c4b3fca854bc7ee49
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 22 Dec 2020 19:11:10 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:49 +01:00

thermal/core: Remove pointless thermal_zone_device_reset() function

The function thermal_zone_device_reset() is called in the
thermal_zone_device_register() which allocates and initialize the
structure. The passive field is already zero-ed by the allocation, the
function is useless.

Call directly thermal_zone_device_init() instead and
thermal_zone_device_reset().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201222181110.1231977-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b261544..996c038 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -478,12 +478,6 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static void thermal_zone_device_reset(struct thermal_zone_device *tz)
-{
-	tz->passive = 0;
-	thermal_zone_device_init(tz);
-}
-
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -1363,7 +1357,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	thermal_zone_device_reset(tz);
+	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
