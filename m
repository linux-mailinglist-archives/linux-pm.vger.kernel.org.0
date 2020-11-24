Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60CF2C219F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgKXJgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgKXJgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:47 -0500
Date:   Tue, 24 Nov 2020 09:36:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUuQ5Wd8zG5kC8x8S8SxmQyELHjut+4U+xV2p/WJzvI=;
        b=v+G7VKiZGsbWnjut/pyv6Xp19ghJ1FUhBgLTJWhvcWbIvMu+o5j4e4cM0qzgWLFTFxJM1e
        g+AMMZf6y1XS/ytEoVe568Vy8nzNFncWwFmzGZpNa5OnqVmnQ+lzgWDZ6Z3VcpcWrzj60D
        OnRp9lS+WrPab2DdBGQPSTfv24+6gHTky59sRDX+5LX8mxR53zUSNLggyMzIZZxGsCX9Ve
        yWyqMuNsrYhwRMNT8OoL2tuxcwGUdSXDiwbtDUP0dy4GPOKsMhty8+rYzx6aa1Pv2GT0N0
        aROFDFSUCRBwiDSLOb+8aoCsJIoGlqdpw0YAMBFn4l/EQOPOWp2X8+7Zs/k2Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUuQ5Wd8zG5kC8x8S8SxmQyELHjut+4U+xV2p/WJzvI=;
        b=8NdhEhVneGfrgpc7zID/GufV/9dhrDvdZb4P0lvJvI0GX72ynB6aT34sAwneOu+UPxlerM
        FTMgfd7FlqA8+IDA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: core: Remove unused functions in
 power actor section
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201015112441.4056-4-lukasz.luba@arm.com>
References: <20201015112441.4056-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160621060418.11115.18099361884279660318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     87d2380260524e55e090e14012c1b07c1f6d4096
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//87d2380260524e55e090e14012c1b07c1f6d4096
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 15 Oct 2020 12:24:40 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 09:44:32 +01:00

thermal: core: Remove unused functions in power actor section

Since the Intelligent Power Allocation (IPA) uses different way to get
minimum and maximum power for a given cooling device, the helper functions
are not needed. There is no other code which uses them, so remove the
helper functions.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201015112441.4056-4-lukasz.luba@arm.com
---
 drivers/thermal/thermal_core.c | 47 +---------------------------------
 drivers/thermal/thermal_core.h |  4 +---
 2 files changed, 51 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2ea3633..d5540bf 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -601,53 +601,6 @@ static void thermal_zone_device_check(struct work_struct *work)
  */
 
 /**
- * power_actor_get_max_power() - get the maximum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @max_power:	pointer in which to store the maximum power
- *
- * Calculate the maximum power consumption in milliwats that the
- * cooling device can currently consume and store it in @max_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      u32 *max_power)
-{
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	return cdev->ops->state2power(cdev, 0, max_power);
-}
-
-/**
- * power_actor_get_min_power() - get the mainimum power that a cdev can consume
- * @cdev:	pointer to &thermal_cooling_device
- * @min_power:	pointer in which to store the minimum power
- *
- * Calculate the minimum power consumption in milliwatts that the
- * cooling device can currently consume and store it in @min_power.
- *
- * Return: 0 on success, -EINVAL if @cdev doesn't support the
- * power_actor API or -E* on other error.
- */
-int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      u32 *min_power)
-{
-	unsigned long max_state;
-	int ret;
-
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	ret = cdev->ops->get_max_state(cdev, &max_state);
-	if (ret)
-		return ret;
-
-	return cdev->ops->state2power(cdev, max_state, min_power);
-}
-
-/**
  * power_actor_set_power() - limit the maximum power a cooling device consumes
  * @cdev:	pointer to &thermal_cooling_device
  * @instance:	thermal instance to update
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 681209d..416cdb1 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,10 +65,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 		cdev->ops->power2state;
 }
 
-int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      u32 *max_power);
-int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *ti, u32 power);
 /**
