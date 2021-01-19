Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACFB2FC262
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbhASVbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbhASV2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A5C0613ED
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCXbuukmHnEV61L2/gvRyrSu7HuM5OfN7gFEU93OkhQ=;
        b=mvUFGu3PwuYU+P1VHiY0M+2uhlBePrtUCmEfj2RZ6xebynh4SV33VI2oKuF5zx6SK2NDuh
        /fgTSpy4na7MhAdyRxOoEzY3cGdivQR1roMDVBd20uncArcxiOyE/KcgpPxDvR5IiLGFlN
        wlEkzxfuesj390Wk+ST2dqhfAhPkvjgut1F3KYsylyEXKLoaG0I2SrazCBcq7ujpbEVNGM
        MpcfkjeF3iQjXqzgZPZMfENZbE1eO972avtRNAgGiwY8I/O0WjGISNUY0PfV6SIiGk1jJR
        XdphMcJHBKQbQS4vvcc3HpjkVyD+gAZe+4nNeXkA4Nk2VGWtdLG4I7bw+BPFog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCXbuukmHnEV61L2/gvRyrSu7HuM5OfN7gFEU93OkhQ=;
        b=uiMiKuXvTgcU0rh03AGrC5JsPsGj2qHNDPJls7nhS55ruI59k9iMlxkwTIq2qizw8/hHmE
        lQRO0CDeal2cRdCA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove notify ops
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201210121514.25760-5-daniel.lezcano@linaro.org>
References: <20201210121514.25760-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164731.414.8337540498286773236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     04f111130e9afa41c10d7bcec14e00e3be8b6977
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//04f111130e9afa41c10d7bcec14e00e3be8b6977
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 10 Dec 2020 13:15:14 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 07 Jan 2021 17:48:56 +01:00

thermal/core: Remove notify ops

With the removal of the notifys user in a previous patches, the ops is no
longer needed, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20201210121514.25760-5-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 3 ---
 include/linux/thermal.h        | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4a291d2..567bc6f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -412,9 +412,6 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	trace_thermal_zone_trip(tz, trip, trip_type);
 
-	if (tz->ops->notify)
-		tz->ops->notify(tz, trip, trip_type);
-
 	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
 		tz->ops->hot(tz);
 	else if (trip_type == THERMAL_TRIP_CRITICAL)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 31b8440..c800323 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -77,8 +77,6 @@ struct thermal_zone_device_ops {
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
-	int (*notify) (struct thermal_zone_device *, int,
-		       enum thermal_trip_type);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
 };
