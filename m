Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6936CBD9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhD0TpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbhD0TpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E6C061574
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:25 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1AIkcoASM/pnlIlcIl8sxr7ncjeEI92lXe/x3Op0rA=;
        b=Hn46TXMKxbLdrOZvFsKwz+4IhHtAcl+qyTP7zXsSPWeLgBugVvWKh4lW2Z0YvsxfAvylIs
        /szKxUu38UahJQsDzPg1d/zWUU6Eb7aqh0K9++9Ghek2Br13IwmL8S2gxqhev9cpYFRlxY
        Vrs3FYSny12HjgAPZ3goDfTCfieU4ciZCYcRf7rPoxnKoZhGee6Bm6UtHeMjpacRz7yw1a
        WVXn74groYpN94SL19Wof5hmE+xp4OY8ZJa8pduzbPLg8mB/JphH2tWxeIdamI1nHBVgdH
        s4jWb7FobPSU2ItmXCLWSKhwVSHUiJ1TXa5JP+8IfQxQHhT8VWAsN2IGCejjrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1AIkcoASM/pnlIlcIl8sxr7ncjeEI92lXe/x3Op0rA=;
        b=uDxaVDwFE6xj7kdjQzk88S88FErXe9TemA5SZu19u4a/7z6+amoGxxSQNkZkzr+sP7VoJy
        eb2F3eRzUpwhjFAA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/power allocator: Use the
 lockless __thermal_cdev_update() function
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210422153624.6074-4-lukasz.luba@arm.com>
References: <20210422153624.6074-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266323.29796.8033580750194184814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ab39c8853737158604e154ad3b03639e74082bd6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ab39c8853737158604e154ad3b03639e74082bd6
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 16:36:24 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:51:32 +02:00

thermal/core/power allocator: Use the lockless __thermal_cdev_update() function

Use the new helper function and avoid unnecessery second lock/unlock,
which was present in old approach with thermal_cdev_update().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422153624.6074-4-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index a6cdb2e..13e3757 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -301,9 +301,8 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 
 	instance->target = clamp_val(state, instance->lower, instance->upper);
 	mutex_lock(&cdev->lock);
-	cdev->updated = false;
+	__thermal_cdev_update(cdev);
 	mutex_unlock(&cdev->lock);
-	thermal_cdev_update(cdev);
 
 	return 0;
 }
