Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB436CBE8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhD0TpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhD0TpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:14 -0400
Date:   Tue, 27 Apr 2021 19:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoePwL4adksA2zQQ0czMsvKSCsX4UKGg4ezhUhUvFuE=;
        b=eaer9jMEfzqzjuQrDWciB+uJChG/sxEKHFv0qDqy/awT5mdsKSff3ezlF94QkEOEWrCElU
        TuV+mWx4J5m6wfOS6ge7YMOzClVDmN6bmQwdPJZVGS9FBHAeSVwnX+FbUkV/fT7FH5ZDGY
        IkE/UXVB1Ny1ilgE6GOETDPS20ywE/NNEuIhKO6L+t3c4X/184h71FAUf3BOBQqtm2HWla
        tBBcRbEv2ZawwXuGWqpyRlqTmEsC4oaPTgHBt37RQvwHgrlB8UcWOhsO0YFq2Eghzd1jsy
        h7+NpcQ9fWTNYFWsmlUXInWeCApACwmj1ORC4ViE+kxnCyQV4LxzqJdBYbwIYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoePwL4adksA2zQQ0czMsvKSCsX4UKGg4ezhUhUvFuE=;
        b=VXdbdIelTvhI6WMlx9Ruj0pZdDQ9zNxhkokKBLelIiri77+xZmAe4O4d6X8KbUqOHen0Ot
        Z7/1jBZL5f9FNeAQ==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] Documentation: driver-api: thermal: Remove
 thermal_notify_framework from documentation
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210122023406.3500424-4-thara.gopinath@linaro.org>
References: <20210122023406.3500424-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <161955266951.29796.17603412725978656311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a5655d90cf508598b5f5bbccd911924cf8dc9060
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a5655d90cf508598b5f5bbccd911924cf8dc9060
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Thu, 21 Jan 2021 21:34:06 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 13:15:19 +02:00

Documentation: driver-api: thermal: Remove thermal_notify_framework from documentation

Since thermal_notify_framework is no longer supported/implemented
remove the entry from sysfs-api.rst.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210122023406.3500424-4-thara.gopinath@linaro.org
---
 Documentation/driver-api/thermal/sysfs-api.rst | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 29fdd81..4b638c1 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -730,17 +730,7 @@ This function returns the thermal_instance corresponding to a given
 {thermal_zone, cooling_device, trip_point} combination. Returns NULL
 if such an instance does not exist.
 
-4.3. thermal_notify_framework
------------------------------
-
-This function handles the trip events from sensor drivers. It starts
-throttling the cooling devices according to the policy configured.
-For CRITICAL and HOT trip points, this notifies the respective drivers,
-and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
-The throttling policy is based on the configured platform data; if no
-platform data is provided, this uses the step_wise throttling policy.
-
-4.4. thermal_cdev_update
+4.3. thermal_cdev_update
 ------------------------
 
 This function serves as an arbitrator to set the state of a cooling
