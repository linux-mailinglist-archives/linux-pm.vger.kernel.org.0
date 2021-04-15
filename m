Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D73608DD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhDOMEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhDOME1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB38C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 05:04:04 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRoARq+x/xatykkxto1ouWcvShbFW1YuL+8JliFuhEE=;
        b=4SUqi06kZXbwASCHUYKNGbeQz+lsG1C0c/zbV3YsgJCfvFSdlFoAAXtanw12CzUWmZX2h4
        C+7p6d2HVu9QfUAPtpmsLO38oxioikMspwMs1x0yAkWPYvNANfe9GWrm7K2IZ8L3x47l7L
        QjPdI3SrlstQI1xVAoGKG8aL09D8lVnrw5DHkHywXnzTFk+wmkYGTwt9s9SiitGs86ecyK
        yfedpxAPlNOZbhQXJ7jVyyEBtxSzHSEbOIRYXuZnggRCiKKORwM9lYiJQM4fPOIswmeh78
        KQKBt6+RxzZwfJRC4alUyCYplIX+YtQuLg2Aa1IYdMt1q98LMYbT8dR8WmLJOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRoARq+x/xatykkxto1ouWcvShbFW1YuL+8JliFuhEE=;
        b=b9eikFmK1gzdAWWp2tiS7Q3NzOSKPwij96cU2f45dzfwX+ok3lM8Rm9iXqnto5OMKnQ++1
        QJx46gc9KWeW6gBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/cpuidle_cooling: Fix use after error
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210319202522.891061-1-daniel.lezcano@linaro.org>
References: <20210319202522.891061-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161848824237.29796.17508442305407405734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6cc7b38c0ca3187abd07af849ec179b42337bcf6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6cc7b38c0ca3187abd07af849ec179b42337bcf6
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 19 Mar 2021 21:25:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:26 +02:00

thermal/drivers/cpuidle_cooling: Fix use after error

When the function successfully finishes it logs an information about
the registration of the cooling device and use its name to build the
message. Unfortunately it was freed right before:

drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
	warn: 'name' was already freed.

Fix this by freeing after the message happened.

Fixes: 6fd1b186d900 ("thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20210319202522.891061-1-daniel.lezcano@linaro.org
---
 drivers/thermal/cpuidle_cooling.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index f329761..4f41102 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -208,18 +208,20 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
 						  &cpuidle_cooling_ops);
-	kfree(name);
-
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
-		goto out_unregister;
+		goto out_kfree_name;
 	}
 
 	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
 		 name, idle_duration_us, latency_us);
 
+	kfree(name);
+
 	return 0;
 
+out_kfree_name:
+	kfree(name);
 out_unregister:
 	idle_inject_unregister(ii_dev);
 out_kfree:
