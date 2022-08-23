Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFC59E70B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbiHWQWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbiHWQWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196DEC57B0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:04 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXwdCKdXK7XilX0ow6Mqpt0C8U/ChV7b84cxZdmnZRU=;
        b=xSEVp1yWzGvdHeDDb+NbPBakAujMYUYK6ztEkdGrZC7U/0YnKzyXXGQnGnQsXV4iu+bDXl
        C82Fz0+QMDhWN43RpJOBsHhQIShwJUqFXvK5lUGaZesWUaR0nXFDjX4oHNIuAicxvR2KTG
        SR6MLBxGnCbEr8nZjW+OeNi35Ld/gAgHpMgWqIVw8sHtrNJJim5xSUwtLcKWWpzTGEBE9k
        ZhNiasDsWz8RMjnpi9aPeSq9g6gI36i2w0/yuxYqmcfBsccaWpWE2XtfgXy9lXc6NSy9gx
        poeh0n/8n91F0fzvfVXA+xK4ARYpyRLnvAEE8GiOBitxUkEWtsaTFIzvwekY8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXwdCKdXK7XilX0ow6Mqpt0C8U/ChV7b84cxZdmnZRU=;
        b=Si/Noj9GGWpOTM4AGlW9ke75oaYL1pZ7ewb/D9ksd6cgR21Rc5vdlb+6H2pnOiGxazEixR
        gQd9/HC5d1sNlYBQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rzg2l: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-19-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-19-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858157.401.17710373344559990363.tip-bot2@tip-bot2>
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

Commit-ID:     396cbbc6b711ef8d329303dc179a7a1c395f1f12
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//396cbbc6b711ef8d329303dc179a7a1c395f1f12
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/rzg2l: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Link: https://lore.kernel.org/r/20220804224349.1926752-19-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 51ae80e..2e0649f 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -114,7 +114,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static const struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -207,8 +207,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
