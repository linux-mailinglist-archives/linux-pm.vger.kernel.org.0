Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECE25939E9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Aug 2022 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiHOT3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Aug 2022 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbiHOT1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 15:27:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CFC2B276
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 11:43:44 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:43:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660589016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4Jyj19ZLXLkDHDVMCAVyy3UmAqdQVKjB0VpIUEg32w=;
        b=N+CR7NB/djAHIB5DQEaVjvOLxkr5T+VPndcylpH1GnnoURjMAQ75980ZPs3zq7GJ/AIFyn
        Xmy/T2Hw243+PIK8BX0kENhBbjT6TCOwyu9Gm4mdURfTo7LddLPclSf5/BFD3Eu5c537JT
        +bHOaZBJWMvOV415e2X53whbWn4SR6QjnbF33WkD7uoH+ZELlX688M3bQRkNZZbn4MlK/B
        iylXPg5rBhGL1QB/wp9dEWD4Hma44qUrc25dxwQmkL7E5fkWd9y+Tciy+vS5cK6LqGDFQA
        rbVg6znx5qyzW86Nuunc0+VIy6M/Xk3Y1Z1Rqgry3PAT32TE0tdRBAUYco2bIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660589016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4Jyj19ZLXLkDHDVMCAVyy3UmAqdQVKjB0VpIUEg32w=;
        b=QOp+i0PQ4Eu/ozJbgZMcbu9234EUs5jaja+IIffwBF46oJyeW0m6PmiyhiIJ9vNZMvTw7Q
        zLNBlxfZud0Rc+AQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/core: Add missing EXPORT_SYMBOL_GPL
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220810100731.749317-1-daniel.lezcano@linaro.org>
References: <20220810100731.749317-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166058901552.401.11918907596464240553.tip-bot2@tip-bot2>
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

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     a921be53b46c393d8d594a62a44f418c97e5504b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a921be53b46c393d8d594a62a44f418c97e5504b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 10 Aug 2022 12:07:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Aug 2022 20:38:19 +02:00

thermal/core: Add missing EXPORT_SYMBOL_GPL

The function thermal_zone_device_register_with_trips() is not exported
for modules.

Add the missing EXPORT_SYMBOL_GPL().

Fixes: fae11de507f0e ("thermal/core: Add thermal_trip in thermal_zone")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220810100731.749317-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6a5d0ae..50d50ce 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1329,6 +1329,7 @@ free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
 }
+EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
