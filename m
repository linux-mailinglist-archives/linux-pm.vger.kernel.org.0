Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA5B52D2BD
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiESMoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiESMoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ABCBA994
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:07 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opwERRWIj0sxxZeBcW7qT0jJL6bBgdgJiccxCc7Ug5k=;
        b=CMjTLFi6+91zKjtsF3rcAo74G2Siyn+pQ2HyxINn54lM0WF8F8EUFliiWrtmNhFDIBn0Li
        gYkF05psibwSmmAMDNrqjjn2PCtmUlkrP44wC+8xTt+276BBF2B7M8O0mEXFLGOOgZdJ1Y
        H3ZJe5mz1S4kRcUqbFJj1M4xPXEnRDFFjyQHvBFoMw9gRnwoNZq2W4OAHLqfkwF63ct/2e
        qNbHs38sVFf0o9TVJ0Vcj1al0lV5U6QS3tPmhgXaUarIkjVWpqHxhELh4F7josudoWelXA
        d9fWMsiFyvp7RKVv9DQF3eBhQQyzYuh31/EubPTy++BdWZshFTlLTgAjrfqT4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opwERRWIj0sxxZeBcW7qT0jJL6bBgdgJiccxCc7Ug5k=;
        b=hjxqPRr++qDPXSxmUoJfUE8VLxPWN5T9bDDtBHBtmrNYOZ0YZ6aydPTet1Ouqm0WbvkoXD
        4rgm91kzj8vERVDg==
From:   "thermal-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx_sc_thermal: Fix refcount
 leak in imx_sc_thermal_probe
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220517055121.18092-1-linmq006@gmail.com>
References: <20220517055121.18092-1-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165296424452.4207.17886812979420204225.tip-bot2@tip-bot2>
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

Commit-ID:     09700c504d8e63faffd2a2235074e8c5d130cb8f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//09700c504d8e63faffd2a2235074e8c5d130cb8f
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Tue, 17 May 2022 09:51:21 +04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:53 +02:00

thermal/drivers/imx_sc_thermal: Fix refcount leak in imx_sc_thermal_probe

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: e20db70dba1c ("thermal: imx_sc: add i.MX system controller thermal support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220517055121.18092-1-linmq006@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_sc_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 8d76dbf..331a241 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -94,8 +94,8 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
 			of_node_put(child);
-			of_node_put(sensor_np);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto put_node;
 		}
 
 		ret = thermal_zone_of_get_sensor_id(child,
@@ -124,7 +124,9 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
+put_node:
 	of_node_put(sensor_np);
+	of_node_put(np);
 
 	return ret;
 }
