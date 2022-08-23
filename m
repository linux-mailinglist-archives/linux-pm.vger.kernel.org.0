Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC359E700
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiHWQWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbiHWQWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3510BE00
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:07 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwRvLPbkaLJIEe78j5Po1pr/Xx3myGWOSLQluz4DJzk=;
        b=hEf8h8fKhKofKxUoySuZ2MedLpF1keP37MBZ/iYg3o2jUdzssd8ZKVgMpvrf5EC5w8jhzP
        QX3IUuxCPPepgt3rcXOpMmJn4QA4rYPpYS/xuuQDIX8UB3c3ZP69Zy5954ZItzQXfuMq/T
        tvB2Tp2u0wx0iv5t8dPXFJ2tEn/Bd7vBRXyOH0TmHGRCdKi3qlIZ5M1uUNq1MFZ1s0aRLA
        DJBEH21v6vAxNuQO1Me8tBTu1Q/uw3a3wrrgXKfmq0v5EQCBEfXJbcTX+MUVnf99TMXfRK
        H2nlvqJyEsB6yu6NAMJl0K8PGNyjOsdis25qu8D3ufLEjXQPt1499UTZWQK7NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwRvLPbkaLJIEe78j5Po1pr/Xx3myGWOSLQluz4DJzk=;
        b=FvQ++SU/Low2tFTVR+c7QKCl9Wq064ms5SInAwmquB1daBbAqmZoH3bvukzinTeVhKNjby
        XJYBBEHwSEil96Bw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/db8500: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-16-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-16-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858459.401.5634546767701067543.tip-bot2@tip-bot2>
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

Commit-ID:     2320be6032e1c1b17a3fcac98813947d1d28c32f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2320be6032e1c1b17a3fcac98813947d1d28c32f
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/db8500: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-16-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 121cf85..cb10e28 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -58,9 +58,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -72,7 +72,7 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 };
 
@@ -182,7 +182,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
