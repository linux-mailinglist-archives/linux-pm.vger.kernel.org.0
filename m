Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446962FC263
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbhASVbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbhASV2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53116C061793
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CI9Ai7A1FJ5R1ZqlnB/oUewDIpYVGn5dp1E+kUaLlls=;
        b=oMYGzLXH6tfuJDBwfJQu06ev2eREaIkDd/oX3Eqph9HK+7ax9nLLkl86evLzdE1v33w4MJ
        JMTEiEa8vVCLO/d9L4RJM4dpP+Tvw2ir/Z/7CtIXLdmHO7S79807qagKskoNA/YFs05I/g
        qts8sN8jWrP4KJwTB4TbYJdD3VN1kFhjnyh3UOk8E8BET7P3+P7qOGvz88bPxmwrBt47AQ
        bxnEttDNtCCfRvMxkmWalNpXQ+DXR7U1rJG+3H14KwkZwLkONEuyymSWuyyh1pzi4oSxn0
        zwNL1BRxLptFCkiC945q0h6ot5GZZjotknAmNQDHEmjSZdK8xSXwPsPCDid8nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CI9Ai7A1FJ5R1ZqlnB/oUewDIpYVGn5dp1E+kUaLlls=;
        b=y5UFO+/6jATuA4vacCwzwHpCXH9MBpjAJJKROUKDskmDkPuAHWWaEiHvRQ6SO4lrL1KqXx
        /kW3BSNDfJiUQTDg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove pointless test with the
 THERMAL_TRIPS_NONE macro
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201214233811.485669-3-daniel.lezcano@linaro.org>
References: <20201214233811.485669-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164668.414.11957267023735359312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     53f04ca8153cc043cd2fa968ed451a85e8f70bd8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//53f04ca8153cc043cd2fa968ed451a85e8f70bd8
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:06 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:11 +01:00

thermal/core: Remove pointless test with the THERMAL_TRIPS_NONE macro

The THERMAL_TRIPS_NONE is equal to -1, it is pointless to do a
conversion in this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-3-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 4e7f9e8..345917a 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -875,10 +875,7 @@ trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 	instance =
 	    container_of(attr, struct thermal_instance, attr);
 
-	if (instance->trip == THERMAL_TRIPS_NONE)
-		return sprintf(buf, "-1\n");
-	else
-		return sprintf(buf, "%d\n", instance->trip);
+	return sprintf(buf, "%d\n", instance->trip);
 }
 
 ssize_t
