Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE3648534
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiLIP1B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiLIP0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B48F733
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLAqhVe9ReEh/v9AhZFL0Ja0A9hVe9o5iVlt4EPDFEA=;
        b=p1J92YSIpdBiI3xhSDVLrDmGGpcuP6f1yGptyINPBnaTLJNrtiHkAazSUkbuMIaV5PVxxn
        JrSedPlwIEnukfkCKTDlFuiHjiHVyGM8hGMYOrLS8jN+py2/p+8ow7ZJ3MjYdhDksokX35
        2JASrgHsC3DYwnMtsp5FgIPokMKf7mwCujSbZnHiQa5TaL+jcrI/JoLnmSwS8OULYDprCA
        Mvzc80/dTwsMYpk+iwofSyzS7i/09gzybCmkHmqa0RrvI/ATCsQyUYnDBau5n5uUM2AhqN
        AF8iz9m5MtFvenB4H57VpoLklUEjsP30bs2WPQtFSq6tFNw5MG+h6Vqm+KZ9Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLAqhVe9ReEh/v9AhZFL0Ja0A9hVe9o5iVlt4EPDFEA=;
        b=a2TVXoQ4tHdN1iOb0zL/PmhyDbokGF4xRMxDipaGwPYn6VVSQ9qVAev5v/UCMoXs2My133
        VMOcLxxvtlIz6OAQ==
From:   "thermal-bot for Jon Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra: Fix crash when getting
 critical temp
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221010150311.40384-1-jonathanh@nvidia.com>
References: <20221010150311.40384-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Message-ID: <167059959082.4906.8475881283331386734.tip-bot2@tip-bot2>
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

Commit-ID:     340e74d08972239f8ec6ad3bed706b360162f293
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//340e74d08972239f8ec6ad3bed706b360162f293
Author:        Jon Hunter <jonathanh@nvidia.com>
AuthorDate:    Mon, 10 Oct 2022 16:03:11 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/tegra: Fix crash when getting critical temp

Commit 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
removed the function of_thermal_get_crit_temp() and this is causing a
NULL pointer deference crash when attempting to call the 'get_crit_temp'
function pointer because this function pointer is no longer initialised.
Fix this by replacing the call to the 'get_crit_temp' function pointer
with a call to the function thermal_zone_get_crit_temp() instead.

Fixes: 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20221010150311.40384-1-jonathanh@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index d2e4549..4203e74 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -742,7 +742,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
 	if (min_low_temp == temperature)
-		if (tz->ops->get_crit_temp(tz, &temperature))
+		if (thermal_zone_get_crit_temp(tz, &temperature))
 			temperature = max_high_temp;
 
 	ret = thermtrip_program(dev, sg, temperature);
