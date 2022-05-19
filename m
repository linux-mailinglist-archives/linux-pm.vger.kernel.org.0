Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6992C52D2CE
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiESMoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbiESMoX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEABA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:21 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xqx2nVbtJzQw900fM+mGQu0/V7EtYBHVW9GYzT6TnEo=;
        b=OKqhy+A8AHnNSUyPHNZPrBsYFrBEausJXyEiGl27fHXwBYHW2Z6s50gDjSQORPXzLcCHaa
        6jJzL694YTUOCcDyUGOrlL0rrj7oK+zzewPDWpyhx2YttWFraKDAnCvFjCd9wtghHh2SIp
        fG8oSRCp/ekjpsv83a58l/aoSMh5iUxVvWcXG/DEoMOdA3PXL3HDA753nsKI4OSJGjaNok
        wWpf2MuW2wks6K5voBO8V2H6BBD0fMF2AETDu6WBECR5/y1Vo9fokOZk3nNSSeyb/iCRf9
        do/SyQzPO9y7WHby+h+KiOR1UBDTlXJSVCJLv6yOYFP0NE2NUPR7YK9rMTPWZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xqx2nVbtJzQw900fM+mGQu0/V7EtYBHVW9GYzT6TnEo=;
        b=SPn7DMb6xuVQmyVifT9DJ/eNXfikdDwKUHg5tbfj+k5Aqgh6p5wTLXoEr7/W+H2Oo86d/r
        5/cgiONxcWQVCBBg==
From:   "thermal-bot for Stefan Wahren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/bcm2711: Don't clamp
 temperature at zero
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220412195423.104511-1-stefan.wahren@i2se.com>
References: <20220412195423.104511-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Message-ID: <165296425912.4207.4920256466367626942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     106e0121e243de4da7d634338089a68a8da2abe9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//106e0121e243de4da7d634338089a68a8da2abe9
Author:        Stefan Wahren <stefan.wahren@i2se.com>
AuthorDate:    Tue, 12 Apr 2022 21:54:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

thermal/drivers/bcm2711: Don't clamp temperature at zero

The thermal sensor on BCM2711 is capable of negative temperatures, so don't
clamp the measurements at zero. Since this was the only use for variable t,
drop it.

This change based on a patch by Dom Cobley, who also tested the fix.

Fixes: 59b781352dc4 ("thermal: Add BCM2711 thermal driver")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220412195423.104511-1-stefan.wahren@i2se.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 1ec57d9..e9bef5c 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -38,7 +38,6 @@ static int bcm2711_get_temp(void *data, int *temp)
 	int offset = thermal_zone_get_offset(priv->thermal);
 	u32 val;
 	int ret;
-	long t;
 
 	ret = regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
 	if (ret)
@@ -50,9 +49,7 @@ static int bcm2711_get_temp(void *data, int *temp)
 	val &= AVS_RO_TEMP_STATUS_DATA_MSK;
 
 	/* Convert a HW code to a temperature reading (millidegree celsius) */
-	t = slope * val + offset;
-
-	*temp = t < 0 ? 0 : t;
+	*temp = slope * val + offset;
 
 	return 0;
 }
