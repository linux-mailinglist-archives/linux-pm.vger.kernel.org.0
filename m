Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C417584343
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiG1Plk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiG1Pli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B3675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:37 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOoN8FiiwmZUS54D6/VZ7DV2IZJi3XQRpcWkInl8IUQ=;
        b=XeKrfQ6sSEA5UOlBlzSslagAx4RywYeBUHfh47G0xW4kUwnYBlk2BRzNI/XwvqJLWAIRAk
        MyKd/lmbFd3c2CZo0EBuDJQNPEtrsA4cIO2Tggcgf1p4xifvQbujbaHU39ANokgphsn4XG
        Mja9wJDqb0wHLLKzvnHaMoFSDefuG0Y2zSWJppn7xVjDjdD4XkVrYplVn9Rn/c78cb3QLo
        cod+d7dUgTj1Io33KwpI1z1JgzTiBiecfA8/Yt66++ysUUwtal1YUrUhHkUpipNAByrZQb
        eDomcDvXp8p+HST41xjSRWi0KHzF9QndWlesKZ0111GZ9DUm2uXQi5g0i1XCPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOoN8FiiwmZUS54D6/VZ7DV2IZJi3XQRpcWkInl8IUQ=;
        b=bZkH8rKu8ZqMzTaRaJCjf0VKzl5KTnJDriYgEC6Hciu/q467dT2vQBOqbSyhGM+UvUQg81
        qaQiRKpdKUAVHUAQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove unneeded EXPORT_SYMBOLS
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220722200007.1839356-6-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-6-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <165902289540.15455.16871604229560239366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6390383b67fab6bfa652a39e87e904bfc3066235
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6390383b67fab6bfa652a39e87e904bfc3066235
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 22 Jul 2022 22:00:02 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:55 +02:00

thermal/core: Remove unneeded EXPORT_SYMBOLS

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220722200007.1839356-6-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047..f4c1e87 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
