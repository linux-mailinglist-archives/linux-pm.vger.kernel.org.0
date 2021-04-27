Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC136CBDA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhD0TpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhD0TpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:08 -0400
Date:   Tue, 27 Apr 2021 19:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3t543Wq7xZwddu9kC36y+cPJam7zaRbCDTvi/d6XCg=;
        b=M4CCSbobB+beKAUVKcWPHq2yDY+H+JBbf8E51OnGMr8CEs95JZITVZ1WC01zgjdGwfEWuI
        nez07JbmJXC1NkqQILvqemelNTfKkNMzF1/dTr3eMHShFY+v3Gr+rFsoraX/uwH1eqV1Dq
        8iL2z8PGxxNksnL8j1feUwTzWW6e24BIqFt/TtZNxhTiWLSQ4OrdvngaFFTtyTmlDS7nmA
        KoE9ZCR0GGSSSlDMoW5LS+hC894/S0WPeUVP87tUlanTWFKIYi8ve4lyiobEBKuG0R6mm1
        AS2b4ztFJ7yhSCk5nnss8oGEHed8jfMLP2bj3v+rAvRqcECp1gYWsSaWrayWXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3t543Wq7xZwddu9kC36y+cPJam7zaRbCDTvi/d6XCg=;
        b=DbqXJc3Cf9QlNyKlpzLSdvifDkpqlq2B9xo54S8U9ytJPNkf9n0LMUJFdnVmDaoV8HEiQP
        kmiSSKlCyiqaL0Bw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/fair share: Use the lockless
 __thermal_cdev_update() function
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210422153624.6074-3-lukasz.luba@arm.com>
References: <20210422153624.6074-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266363.29796.213784428248674373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1a93369810660905f5e89b527cd709fa6832f7c8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1a93369810660905f5e89b527cd709fa6832f7c8
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 16:36:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:51:32 +02:00

thermal/core/fair share: Use the lockless __thermal_cdev_update() function

Use the new helper function and avoid unnecessery second lock/unlock,
which was present in old approach with thermal_cdev_update().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422153624.6074-3-lukasz.luba@arm.com
---
 drivers/thermal/gov_fair_share.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 645432c..1e5abf4 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -107,10 +107,9 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		instance->target = get_target_state(tz, cdev, percentage,
 						    cur_trip_level);
 
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false;
-		mutex_unlock(&instance->cdev->lock);
-		thermal_cdev_update(cdev);
+		mutex_lock(&cdev->lock);
+		__thermal_cdev_update(cdev);
+		mutex_unlock(&cdev->lock);
 	}
 
 	mutex_unlock(&tz->lock);
