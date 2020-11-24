Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65C2C21A0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgKXJgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgKXJgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:48 -0500
Date:   Tue, 24 Nov 2020 09:36:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZGZw1gg8jtu7jbm4IbnFbWzEhJIDiC6FWQLQy6YKbk=;
        b=QB5ncI//Tzq6FJXdC6nMsaI3K2w6LLYpQUdZYraIyw1D8PefuwMMaXjdeucjyV+TLr6ChY
        1k4zlzyYeCqDWRUxdicjCm2yrjD/gsKPXSKmBZ9zXLyTjoVEL2BXX9rSnj9lMTvJfUGvpR
        6wddeAqNMkQcFsp+Husy2sMlewBeVO03ScDf1Wv83BG/GH4R8H3u9DZX3gF56+cGTkATkP
        kJjazCOxh7HMwCG3vrgJAM2oQNrho1CdlJZchNp+m4Io85HMbPC3hwNvZiZnGk6eqRNd30
        wi66gtxZwoldQn0oBI/o3HUI1Xeg1s5zv/PFEZzJLBMcrkRgeVM3lTBnDjJA4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZGZw1gg8jtu7jbm4IbnFbWzEhJIDiC6FWQLQy6YKbk=;
        b=JEi79KDAzukOZXNGpkKzdF6ntmAK4/hPlmKyvNnLp9gOkEBNWwSExco8SVVFyr3qwjx6Oq
        mEfIGH0hh2BfzIAA==
From:   "thermal-bot for Michael Kao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: core: Add upper and lower limits to
 power_actor_set_power
Cc:     Michael Kao <michael.kao@mediatek.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201007024332.30322-1-michael.kao@mediatek.com>
References: <20201007024332.30322-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Message-ID: <160621060566.11115.363303793358263038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4ab17ed1318609da5c36cb7e427a1d24e52a7d6f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4ab17ed1318609da5c36cb7e427a1d24e52a7d6f
Author:        Michael Kao <michael.kao@mediatek.com>
AuthorDate:    Wed, 07 Oct 2020 10:43:32 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 26 Oct 2020 19:46:35 +01:00

thermal: core: Add upper and lower limits to power_actor_set_power

The upper and lower limits of thermal throttle state in the
DT do not apply to the Intelligent Power Allocation (IPA) governor.
Add the clamping for cooling device upper and lower limits in the
power_actor_set_power() used by IPA.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201007024332.30322-1-michael.kao@mediatek.com
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc..2ea3633 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -672,7 +672,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	if (ret)
 		return ret;
 
-	instance->target = state;
+	instance->target = clamp_val(state, instance->lower, instance->upper);
 	mutex_lock(&cdev->lock);
 	cdev->updated = false;
 	mutex_unlock(&cdev->lock);
