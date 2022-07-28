Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA76584355
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiG1Pl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1Plz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD468DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:55 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2P2ZzaK8VenEkNwhwAEal1XsUQYPyic5x8XE72i2Fk=;
        b=Fg74jfH/2fOJv3zvmZRB+ZmKZO6XCVavuU/Jd9YognPuzQPdJw/KcLT/zFrLBnTrcTrWje
        AD0Z948eDBbMjhV30zIFD2Jgqm5KhoEZbipE9k91LKTtnKRfpWc8HCcoN+dLBuoRTihwJe
        zvgDwXw2WNaGz+NdCYNEfvbPT9/PHvIJNuE+mWMAasQkMO56imMOeiB4acfmbM4/0rTHGN
        FV5J15uRAQr00N+IhvgJBaL7cUwtKcqMXib6TVD5KmsxeFr8QkXP8RqY5hkDOxoKMmzGZg
        q/iN6mIhqTccKOFoJx0ppYg8BQQ4fB5zfAQ3pdSZkM+s7uyxzsMPfPrOsasf5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2P2ZzaK8VenEkNwhwAEal1XsUQYPyic5x8XE72i2Fk=;
        b=xfUWytf9/6rxZPDvnwZVJlpJY/R0/cmVDKl2oXkw4sr0rtIZhZAIdd6K69SmAgyOdcBVth
        xcYHk8IVlZEpVJDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Use clamp() helper in the
 stepwise governor
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
References: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291255.15455.9761232716849801405.tip-bot2@tip-bot2>
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

Commit-ID:     25bff3ed9a8aaee45c3b554cca58673f1bea1bdc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//25bff3ed9a8aaee45c3b554cca58673f1bea1bdc
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 29 Jun 2022 17:10:11 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:47 +02:00

thermal/core: Use clamp() helper in the stepwise governor

The code is actually clampling the next cooling device state using the
lowest and highest states of the thermal instance.

That code can be replaced by the clamp() macro which does exactly the
same. It results in a simpler routine to read.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220629151012.3115773-1-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 12acb12..6efbfaf 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/thermal.h>
+#include <linux/minmax.h>
 #include <trace/events/thermal.h>
 
 #include "thermal_core.h"
@@ -52,10 +53,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
 	if (!instance->initialized) {
 		if (throttle) {
-			next_target = (cur_state + 1) >= instance->upper ?
-					instance->upper :
-					((cur_state + 1) < instance->lower ?
-					instance->lower : (cur_state + 1));
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		} else {
 			next_target = THERMAL_NO_TARGET;
 		}
@@ -66,10 +64,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
 		if (throttle) {
-			next_target = cur_state < instance->upper ?
-				    (cur_state + 1) : instance->upper;
-			if (next_target < instance->lower)
-				next_target = instance->lower;
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		}
 		break;
 	case THERMAL_TREND_RAISE_FULL:
@@ -82,9 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 				next_target = THERMAL_NO_TARGET;
 		} else {
 			if (!throttle) {
-				next_target = cur_state - 1;
-				if (next_target > instance->upper)
-					next_target = instance->upper;
+				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
 			}
 		}
 		break;
