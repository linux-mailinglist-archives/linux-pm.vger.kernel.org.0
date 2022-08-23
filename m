Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA159E705
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiHWQWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbiHWQWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C932310AE12
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:51 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df9I5tsDdBN9e8vvi70yAwETV5VUw6cr8TSE7QLr9RY=;
        b=sU4UblkIEBZ4eFf9rg6A2C1T1Ku+wvwPpJa4FkN7okGjLhRz1B3e7LWJtWJMzaKxwi2YQe
        gTo6AI1HmWqEIts/3+yCYV/j+TYRuluBUVoqSGV7Z3jZAd9IQrgAtJgnWkrW4rk6CqTQ3R
        SYprIk/lfzA3juVLZcesEYkdR3ErCRMmueQx9C9K+fr+NsaMDhOOkMnMygVfZ5UVQX65XP
        FqdKYO4kDTgdDJq3p/+5SubR93gVHEv/Ny5TFRn37qukLdxfVa3gPtnUp6cs+qnCgMqjJg
        SQrsVhPZTC0f/1U+uACVXPOiSvAsP6Ipga9AqBFG8LXW4AsPW7mrbztSngdo+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df9I5tsDdBN9e8vvi70yAwETV5VUw6cr8TSE7QLr9RY=;
        b=8TvnJ2XBTw2Eb8mYlNt1cQbpD/jyR7FiZJTMuLsP+C+7zj4XaDGaGSwqB3Zco5G6X/7hix
        DHKOA2GIzRYf80BQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] regulator/drivers/max8976: Switch to new of
 thermal API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-31-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-31-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125856926.401.13325465212162714419.tip-bot2@tip-bot2>
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

Commit-ID:     826855ff5746d0f98877eaa4a438abc4e7b58fd5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//826855ff5746d0f98877eaa4a438abc4e7b58fd5
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

regulator/drivers/max8976: Switch to new of thermal API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-31-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/regulator/max8973-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index fdcb0f5..596cc36 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -434,9 +434,9 @@ static int max8973_init_dcdc(struct max8973_chip *max,
 	return ret;
 }
 
-static int max8973_thermal_read_temp(void *data, int *temp)
+static int max8973_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max8973_chip *mchip = data;
+	struct max8973_chip *mchip = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -465,7 +465,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct thermal_zone_of_device_ops max77621_tz_ops = {
+static const struct thermal_zone_device_ops max77621_tz_ops = {
 	.get_temp = max8973_thermal_read_temp,
 };
 
@@ -479,8 +479,8 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 	if (mchip->id != MAX77621)
 		return 0;
 
-	tzd = devm_thermal_zone_of_sensor_register(mchip->dev, 0, mchip,
-						   &max77621_tz_ops);
+	tzd = devm_thermal_of_zone_register(mchip->dev, 0, mchip,
+					    &max77621_tz_ops);
 	if (IS_ERR(tzd)) {
 		ret = PTR_ERR(tzd);
 		dev_err(mchip->dev, "Failed to register thermal sensor: %d\n",
