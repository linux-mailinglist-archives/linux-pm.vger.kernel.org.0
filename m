Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF7648516
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLIP0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLIP03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F4D8C6A4
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfx+VKab7peo6WyQaY8yvHR07r9sBJAXO1lbuFyI4M0=;
        b=PDVYTSo8uPhnw04DOF6JA08YmyC3mB0/CGxJSJzPi6dtQlfSDUs+m4bxuVVZHfMLlTXCpy
        jC9k/ZufAYok5xevRgK89f5tJzuF9ra8LPwf+otIk7kSeSCHNEWLeOLPFfcqb+gEXRS/b4
        53ljgDlapHgZU+AeYd7k88oh929PzsJ/DlssG8uDxiMRkrmBgjzkytomk+Kk+YUXHCsH8i
        jVd4UZ7gTEBY8UrpIIquxjkHtL8hO6eOgSZpoUYrN6I5k76aIt7a6TIDqeot993Wgg9djl
        xKN/CtMGAtduLQC/V1pqPqu+kaqyh5d7DZcvTJwhaThghlUFIGwuQO2wAGW1aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfx+VKab7peo6WyQaY8yvHR07r9sBJAXO1lbuFyI4M0=;
        b=B82hSbgFz28tEXfUG/V9l3GnbOqMnzXXNBPmu/TfT9BmzzAra0RMudFXVYS6VPB9olx7BL
        RKks5IyvSyna9CDQ==
From:   "thermal-bot for Minghao Chi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/st: Use
 devm_platform_get_and_ioremap_resource()
Cc:     Minghao Chi <chi.minghao@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <202211171409524332954@zte.com.cn>
References: <202211171409524332954@zte.com.cn>
MIME-Version: 1.0
Message-ID: <167059958577.4906.16315263385134771213.tip-bot2@tip-bot2>
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

Commit-ID:     ca756c11c40f8309b50114ed637dc14904ddcfa3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ca756c11c40f8309b50114ed637dc14904ddcfa3
Author:        Minghao Chi <chi.minghao@zte.com.cn>
AuthorDate:    Thu, 17 Nov 2022 14:09:52 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:45 +01:00

thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Link: https://lore.kernel.org/r/202211171409524332954@zte.com.cn
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/st/stm_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 78feb80..e7834cc 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -488,7 +488,6 @@ MODULE_DEVICE_TABLE(of, stm_thermal_of_match);
 static int stm_thermal_probe(struct platform_device *pdev)
 {
 	struct stm_thermal_sensor *sensor;
-	struct resource *res;
 	void __iomem *base;
 	int ret;
 
@@ -506,8 +505,7 @@ static int stm_thermal_probe(struct platform_device *pdev)
 
 	sensor->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
