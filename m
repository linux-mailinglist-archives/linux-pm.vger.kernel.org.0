Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267422D764A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436589AbgLKNKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436618AbgLKNKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:10:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D63C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 05:09:45 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhopZhOdCE1Yiygmm1cgDSrGJVBuPtxEiDpRL0jYM+g=;
        b=EA1SLagCTHcSZbN2iAs7unRq6NyjRYLw3qxtxlDw3iqhppNzXrHLbKbAI3GHylfmGw79fu
        jhl4kbNEHUGZOE5Iu64/ymB+WygwIQtUe5Wr4139ZZ1a3Inx6edw19QWMwnx2hL5gCqXtC
        TWrL7ECgucM0/s251U5U4EtY9tt7mi02Hl8EY31e+tzJNZUnQb+lFa0sUsPELB5cM5yUx6
        gvHbHZVp8sCQSSZm8WxZsdqvZQzdh2t2dnFQkmGlN8aAadW5RIyh/pY2f7EHGF5RKJwoJU
        UO3Q47WixCZfBbZ2jmurLP7//CVDfv5hLdz9SFO+m+QMJXJ9J9MLUkvDV9DwqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhopZhOdCE1Yiygmm1cgDSrGJVBuPtxEiDpRL0jYM+g=;
        b=HrnH7xpnfenOOJYBj6+5IQYS09qKYBI6ymm/h7B7QbBmuNzH68wbESzxBssgdvlULOKJ2N
        YmgqUYG/BnjDxUAA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] platform/x86/drivers/acerhdf: Check the
 interval value when it is set
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
References: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160769214363.3364.16765018211098393975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f34a32fae7fde6655ada6b33dc6739c9d1b6a82c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f34a32fae7fde6655ada6b33dc6739c9d1b6a82c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 03 Dec 2020 08:17:38 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Dec 2020 17:04:50 +01:00

platform/x86/drivers/acerhdf: Check the interval value when it is set

Currently the code checks the interval value when the temperature is
read which is bad for two reasons:

 - checking and setting the interval in the get_temp callback is
   inaccurate and awful, that can be done when changing the value.

 - Changing the thermal zone structure internals is an abuse of the
   exported structure, moreover no lock is taken here.

The goal of this patch is to solve the first item by using the 'set'
function called when changing the interval. The check is done there
and removed from the get_temp function. If the thermal zone was not
initialized yet, the interval is not updated in this case as that will
happen in the init function when registering the thermal zone device.

I don't have any hardware to test the changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20201203071738.2363701-2-daniel.lezcano@linaro.org
---
 drivers/platform/x86/acerhdf.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 19fc8ff..b6aa6e5 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -334,7 +334,10 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 		}
 		if (verbose)
 			pr_notice("interval changed to: %d\n", interval);
-		thermal->polling_delay = interval*1000;
+
+		if (thermal)
+			thermal->polling_delay = interval*1000;
+
 		prev_interval = interval;
 	}
 }
@@ -349,8 +352,6 @@ static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
 {
 	int temp, err = 0;
 
-	acerhdf_check_param(thermal);
-
 	err = acerhdf_get_temp(&temp);
 	if (err)
 		return err;
@@ -823,8 +824,21 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
 
+static int interval_set_uint(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_uint(val, kp);
+	if (ret)
+		return ret;
+
+	acerhdf_check_param(thz_dev);
+
+	return 0;
+}
+
 static const struct kernel_param_ops interval_ops = {
-	.set = param_set_uint,
+	.set = interval_set_uint,
 	.get = param_get_uint,
 };
 
