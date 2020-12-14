Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF292D9A2B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439925AbgLNOlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407382AbgLNOlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0454BC0613CF;
        Mon, 14 Dec 2020 06:40:23 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rttGEuuDGWrcC7Zv1rWeT2P10O8CX/sOs0Tas2ZJVeY=;
        b=WjfjDLaZd2sv/IQnz8ZDSa+V/sx291vlcNkdoqO9SE9gp/Tp4kFBLCgjGjQcPR1ULGjdkR
        RE5nNnfBUhohde0ebE7mwSNdQTcSaqV3b3mlqqUs6kyenf35+aTwMhseDFotfougQG8nFc
        Rc29GbHIwH4FKr6HF5E3+Xldr1gQZ9jknTMbWJQNeMCe6hpv9U0Qe0H6lozVszM9Fa6HyI
        zHYbOcyKfLOaOSjzuBsOqA+c4L3mDErsXGXenhdxFMWPJWIaXFx9hw+f69Zu/3PtHwJ5t+
        7cPmrf2x8DzuUdN8+7JWBmc8Ta/zNh5i2UKAZ7Tih8+qFPdUIupt/2wOVmusBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rttGEuuDGWrcC7Zv1rWeT2P10O8CX/sOs0Tas2ZJVeY=;
        b=F27ycY8Yd5lbW+FvXmoTphB+C1Yy742MootHtIzNfm3LzzBhenzX7Wm7CxxmujiGWosxXM
        8DYuaIvvmXh+HWDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Emit a warning if the thermal
 zone is updated without ops
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com
In-Reply-To: <20201210121514.25760-1-daniel.lezcano@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160795681944.3364.300819678667626552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     433178e75834dc35f1ae79b56ec2cf396f2c6f3c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//433178e75834dc35f1ae79b56ec2cf396f2c6f3c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 10 Dec 2020 13:15:10 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:11:13 +01:00

thermal/core: Emit a warning if the thermal zone is updated without ops

The actual code is silently ignoring a thermal zone update when a
driver is requesting it without a get_temp ops set.

That looks not correct, as the caller should not have called this
function if the thermal zone is unable to read the temperature.

That makes the code less robust as the check won't detect the driver
is inconsistently using the thermal API and that does not help to
improve the framework as these circumvolutions hide the problem at the
source.

In order to detect the situation when it happens, let's add a warning
when the update is requested without the get_temp() ops set.

Any warning emitted will have to be fixed at the source of the
problem: the caller must not call thermal_zone_device_update if there
is not get_temp callback set.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20201210121514.25760-1-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 90e38cc..64de098 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -553,7 +553,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (!tz->ops->get_temp)
+	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
+		      "'get_temp' ops set\n", __func__))
 		return;
 
 	update_temperature(tz);
