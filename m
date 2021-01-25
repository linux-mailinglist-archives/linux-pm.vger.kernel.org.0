Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E230359C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 06:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhAZFr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:47:57 -0500
Received: from leibniz.telenet-ops.be ([195.130.137.77]:51970 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbhAYOmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 09:42:06 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 09:42:04 EST
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4DPXPS00Z3zMsJct
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 15:31:55 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id M2Wi240034C55Sk012WiV4; Mon, 25 Jan 2021 15:30:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42t7-000emF-Gs; Mon, 25 Jan 2021 15:30:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42t6-004PfB-P9; Mon, 25 Jan 2021 15:30:40 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Viresh Kumar <vireshk@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ntp: Use freezable workqueue for RTC synchronization
Date:   Mon, 25 Jan 2021 15:30:39 +0100
Message-Id: <20210125143039.1051912-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bug fixed by commit e3fab2f3de081e98 ("ntp: Fix RTC synchronization
on 32-bit platforms") revealed an underlying issue: RTC synchronization
may happen anytime, even while the system is partially suspended.

On systems where the RTC is connected to an I2C bus, the I2C bus
controller may already or still be suspended, triggering a WARNING
during suspend or resume from s2ram:

    WARNING: CPU: 0 PID: 124 at drivers/i2c/i2c-core.h:54 __i2c_transfer+0x634/0x680
    i2c i2c-6: Transfer while suspended
    [...]
    Workqueue: events_power_efficient sync_hw_clock
    [...]
    [<c0738e08>] (__i2c_transfer) from [<c0738eac>] (i2c_transfer+0x58/0xf8)
    [<c0738eac>] (i2c_transfer) from [<c065202c>] (regmap_i2c_read+0x58/0x94)
    [<c065202c>] (regmap_i2c_read) from [<c064de40>] (_regmap_raw_read+0x19c/0x2f4)
    [<c064de40>] (_regmap_raw_read) from [<c064dfdc>] (_regmap_bus_read+0x44/0x68)
    [<c064dfdc>] (_regmap_bus_read) from [<c064ccb4>] (_regmap_read+0x84/0x1a4)
    [<c064ccb4>] (_regmap_read) from [<c064d334>] (_regmap_update_bits+0xa8/0xf4)
    [<c064d334>] (_regmap_update_bits) from [<c064d464>] (_regmap_select_page+0xe4/0x100)
    [<c064d464>] (_regmap_select_page) from [<c064d554>] (_regmap_raw_write_impl+0xd4/0x6c4)
    [<c064d554>] (_regmap_raw_write_impl) from [<c064ec10>] (_regmap_raw_write+0xd8/0x114)
    [<c064ec10>] (_regmap_raw_write) from [<c064eca4>] (regmap_raw_write+0x58/0x7c)
    [<c064eca4>] (regmap_raw_write) from [<c064ede0>] (regmap_bulk_write+0x118/0x13c)
    [<c064ede0>] (regmap_bulk_write) from [<c073660c>] (da9063_rtc_set_time+0x44/0x8c)
    [<c073660c>] (da9063_rtc_set_time) from [<c0734164>] (rtc_set_time+0xc8/0x228)
    [<c0734164>] (rtc_set_time) from [<c02abe78>] (sync_hw_clock+0x128/0x1fc)
    [<c02abe78>] (sync_hw_clock) from [<c023e6a0>] (process_one_work+0x330/0x550)
    [<c023e6a0>] (process_one_work) from [<c023f0a8>] (worker_thread+0x22c/0x2ec)

Fix this race condition by using the freezable instead of the normal
power-efficient workqueue.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/ntp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 54d52fab201d283e..6310328fe398406a 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -502,7 +502,7 @@ static struct hrtimer sync_hrtimer;
 
 static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
-	queue_work(system_power_efficient_wq, &sync_work);
+	queue_work(system_freezable_power_efficient_wq, &sync_work);
 
 	return HRTIMER_NORESTART;
 }
@@ -668,7 +668,7 @@ void ntp_notify_cmos_timer(void)
 	 * just a pointless work scheduled.
 	 */
 	if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
-		queue_work(system_power_efficient_wq, &sync_work);
+		queue_work(system_freezable_power_efficient_wq, &sync_work);
 }
 
 static void __init ntp_init_cmos_sync(void)
-- 
2.25.1

