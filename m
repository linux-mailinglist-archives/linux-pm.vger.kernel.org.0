Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369912FC264
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbhASVbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbhASV2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE85C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpc9H6rY4H5x966W3B1xqVwPqshuP6k9C/popEAj75A=;
        b=3ezC1Ang3theyCW8MNW3+BqyOtx2PO5uz+mGHL6OPrpzwY/S5RCwUn5yWwE31FSp/EDEM7
        du3zjM/nIco0FPiEjRt9KJ8aRXC6EdPKm+0rV/vvpMlKj120yiqa9YVGzVNrDOxxr/rno7
        jWFTpSLANTULMVZVe5jf0EGBx5juoSGDecto1HQ/nUHkLT9v9Vh3MinKpWZ1Mg5Au/7K3w
        CUc4GVkIV24D79lbLtlO6a3AirJ+iNpEIfd96nLAu22OBA+9rDmDfUeMIqI6F8EqERB8cv
        2dXVap34FbTcUIbNnMsWh02YfWtIqEfkthMflQZjQaB9XzsHYkf5R8AqWh+H3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpc9H6rY4H5x966W3B1xqVwPqshuP6k9C/popEAj75A=;
        b=HVs4IcO2i2lvmZWotEK1+5+3WqCzxd1ha/w+XH7eOa1ZIIKlJPk0koS3TtMBRgjcnCHr2+
        PpoNN0RVPlhni8Ag==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove THERMAL_TRIPS_NONE test
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201214233811.485669-5-daniel.lezcano@linaro.org>
References: <20201214233811.485669-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164630.414.10802725734402206447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     716072d065b62f5a63d81bee978fd234dc47a83b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//716072d065b62f5a63d81bee978fd234dc47a83b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:08 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:25 +01:00

thermal/core: Remove THERMAL_TRIPS_NONE test

The last site calling the thermal_zone_bind_cooling_device() function
with the THERMAL_TRIPS_NONE parameter was removed.

We can get rid of this test as no user of this function is calling
this function with this parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-5-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a0f0c33..bcc2ea4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -710,7 +710,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	unsigned long max_state;
 	int result, ret;
 
-	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
+	if (trip >= tz->trips || trip < 0)
 		return -EINVAL;
 
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
