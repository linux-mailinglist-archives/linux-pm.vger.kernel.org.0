Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8958584354
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiG1Plz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiG1Plz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3406268DF0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:54 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7PiDqb/4OlGA2bYKr9VabPonFXXnCntWjnHf4DmzC0=;
        b=WodvzzNFQvhfA0D2G2xknxUOK3I3vB9nUeHY8XS2H3Gnrijs6nK6LPOmgFP2HEdMaKF9Ts
        oS78pSIG7QQ9K1cfYH2qyi/+qRIFR6TDeA22pOaW6OE1VeZZh+akCwm7/MiVnwT958iKSs
        vw7ZnPTLDJ7jbrgXS6cp7fdPmZmi071mL/s3L94hx8JLsd5kBfMLDsCkYgXg3ybxazeYDv
        chojLjwxzI5zgTZSG60d+LAmGfoKFd3JhYtaHG3Gw6HyKpz75ZHgkO3fKwdFdZBQP1uyNY
        LArjmbYUNOH3Wf0VNstLXmhkVB1yTFcbA74uOx7V3Efqx6OXBZRlpEs5oiz5bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7PiDqb/4OlGA2bYKr9VabPonFXXnCntWjnHf4DmzC0=;
        b=bcj1SNDTBlpDGemGhmJtaahSGUSNswphwx7YTBPeMbx/nKXTCYumcUbFSEaAjfVfQ6ApN8
        lOfMMwoTsqg+dRDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove DROP_FULL and RAISE_FULL
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220629151012.3115773-2-daniel.lezcano@linaro.org>
References: <20220629151012.3115773-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291163.15455.6354391914611113397.tip-bot2@tip-bot2>
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

Commit-ID:     4102c4042a33c682021683ec26c2dca3fd9d7cc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4102c4042a33c682021683ec26c2dca3fd9d7cc2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 29 Jun 2022 17:10:12 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:47 +02:00

thermal/core: Remove DROP_FULL and RAISE_FULL

The trends DROP_FULL and RAISE_FULL are not used and were never used
in the past AFAICT. Remove these conditions as they seems to not be
handled anywhere.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220629151012.3115773-2-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 11 -----------
 include/linux/thermal.h         |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 6efbfaf..9729b46 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -67,10 +67,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		}
 		break;
-	case THERMAL_TREND_RAISE_FULL:
-		if (throttle)
-			next_target = instance->upper;
-		break;
 	case THERMAL_TREND_DROPPING:
 		if (cur_state <= instance->lower) {
 			if (!throttle)
@@ -81,13 +77,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			}
 		}
 		break;
-	case THERMAL_TREND_DROP_FULL:
-		if (cur_state == instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
-		} else
-			next_target = instance->lower;
-		break;
 	default:
 		break;
 	}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 365733b..231bac2 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -40,8 +40,6 @@ enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
 	THERMAL_TREND_DROPPING, /* temperature is dropping */
-	THERMAL_TREND_RAISE_FULL, /* apply highest cooling action */
-	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
 };
 
 /* Thermal notification reason */
