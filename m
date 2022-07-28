Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B7584357
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiG1Pl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiG1Pl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19E675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCuh1/7iooYsRMKgxvE8bCmp1t9D1HqRBxEA8GkF+5Y=;
        b=ba1g+eP29bBmU1nnL8CTcsCXV96ApsVZS2Bvl+d2qQF8AZqw+nYgaJNJCOaT+eKeb0rmlU
        VQN0OQcB+pRPX46qid4VWjNFdyt/jVfXVXGms6NpG5dLpG+Xlo47vY9Omw32YOv9HYCDaS
        aT50HB8bDunZvUPl+Bj+gaZwB3RrqzohmbplJ0akWAHXh4Y7DwYy5SgI5u6WDFt9jT8CC6
        XoSF4Z7nqj76Rmg77I0LZcGnAkjAPe5PBXKtKG228fsgCVWSSojC1IbJ0+NXvIg58zNGJX
        NfLQChPp5qISVklKPBJQ5pApGFP0C14m46duJDxskOLpqCEuPw9k0Vnxqtgwmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCuh1/7iooYsRMKgxvE8bCmp1t9D1HqRBxEA8GkF+5Y=;
        b=ACx9ZaYYNQNrLJ5VUzNHcV0V4jvSLRAK9JzHPUDxo6SBzYDqLSRutiJzJTfYBLjkUe+lSK
        EQHDQRXbaXhtUPDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra: Remove get_trend function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220616202537.303655-2-daniel.lezcano@linaro.org>
References: <20220616202537.303655-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291444.15455.4376455696379488120.tip-bot2@tip-bot2>
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

Commit-ID:     afbeb99e2e33df7cb0833f94128320989c58d6d2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//afbeb99e2e33df7cb0833f94128320989c58d6d2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 16 Jun 2022 22:25:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:46 +02:00

thermal/drivers/tegra: Remove get_trend function

The get_trend function does already what the generic framework does.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://lore.kernel.org/r/20220616202537.303655-2-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 32 +-------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 210325f..825eab5 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
-static int tegra_thermctl_get_trend(void *data, int trip,
-				    enum thermal_trend *trend)
-{
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
-	int trip_temp, temp, last_temp, ret;
-
-	if (!tz)
-		return -EINVAL;
-
-	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
-	if (ret)
-		return ret;
-
-	temp = READ_ONCE(tz->temperature);
-	last_temp = READ_ONCE(tz->last_temperature);
-
-	if (temp > trip_temp) {
-		if (temp >= last_temp)
-			*trend = THERMAL_TREND_RAISING;
-		else
-			*trend = THERMAL_TREND_STABLE;
-	} else if (temp < trip_temp) {
-		*trend = THERMAL_TREND_DROPPING;
-	} else {
-		*trend = THERMAL_TREND_STABLE;
-	}
-
-	return 0;
-}
-
 static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
 {
 	u32 r;
@@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
-	.get_trend = tegra_thermctl_get_trend,
 	.set_trips = tegra_thermctl_set_trips,
 };
 
