Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE934405938
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbhIIOkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:40:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbhIIOjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:39:52 -0400
Date:   Thu, 09 Sep 2021 14:38:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0fBsRaNjLvN8TSv8vAK7C+zHaues0ROUfZtgWDVqUg=;
        b=1DCV28qgqoJoRqqEBeT6ZPIM+h+/VHeRg8ZwagtQwUd6rMT99bA6MqtKjZlYFWe8jONIZA
        7SjysyPRlvoyatYBq5/FmWj5YrNEaeLrsqZ5uxDU480fMsAQi/i/oGMRjS+REBqeGVUO15
        zABGJdU8oKPomhzkvOEF0oTAodhciX6ELYYrjpvjm3szekeMdIofHJw7WfkZ3V3ik1+EE2
        m8OdpW1h4twatPVlkHCxudoA9bQvkdeGPGxBKs31T0YYVSf8tsC2OWDkKzjo3gceKf7/1f
        O5FYjHVbIBflKNAKdpKXQs9MrXGzZLJ3qhtT4ihzMDaGlt1M4yS+d4PfQgYMvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0fBsRaNjLvN8TSv8vAK7C+zHaues0ROUfZtgWDVqUg=;
        b=oPSKTOmfbWlB3yddNqY8XzAeCML+iQKCPRbeHCogUL92GMOo5zYdECQwfN1bfEI0UbuQYe
        BS/IFfpVV4S0GsAg==
From:   "thermal-bot for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/intel_powerclamp: Replace
 deprecated CPU-hotplug functions.
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-20-bigeasy@linutronix.de>
References: <20210803141621.780504-20-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163119832150.25758.17104675699410065503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d31eb7c1a2288f61df75558f59328be01a264300
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d31eb7c1a2288f61df75558f59328be01a264300
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:02 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:51:42 +02:00

thermal/drivers/intel_powerclamp: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210803141621.780504-20-bigeasy@linutronix.de
---
 drivers/thermal/intel/intel_powerclamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index b0eb5ec..a5b58ea 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -528,7 +528,7 @@ static int start_power_clamp(void)
 
 	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
-	get_online_cpus();
+	cpus_read_lock();
 
 	/* prefer BSP */
 	control_cpu = 0;
@@ -542,7 +542,7 @@ static int start_power_clamp(void)
 	for_each_online_cpu(cpu) {
 		start_power_clamp_worker(cpu);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 }
