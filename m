Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72FCF7AD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHLAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 07:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47730 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJHLAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 07:00:25 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHnE5-0007jn-QI; Tue, 08 Oct 2019 13:00:21 +0200
Date:   Tue, 8 Oct 2019 13:00:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH] thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t
Message-ID: <20191008110021.2j44ayunal7fkb7i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Clark Williams <williams@redhat.com>

The spinlock pkg_temp_lock has the potential of being taken in atomic
context because it can be acquired from the thermal IRQ vector.
It's static and limited scope so go ahead and make it a raw spinlock.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -63,7 +63,7 @@ static int max_id __read_mostly;
 /* Array of zone pointers */
 static struct zone_device **zones;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -266,12 +266,12 @@ static void pkg_temp_thermal_threshold_w
 	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
 
 	zonedev = pkg_temp_thermal_get_dev(cpu);
 	if (!zonedev) {
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
@@ -285,7 +285,7 @@ static void pkg_temp_thermal_threshold_w
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -310,7 +310,7 @@ static int pkg_thermal_notify(u64 msr_va
 	struct zone_device *zonedev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -322,7 +322,7 @@ static int pkg_thermal_notify(u64 msr_va
 		pkg_thermal_schedule_work(zonedev->cpu, &zonedev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -368,9 +368,9 @@ static int pkg_temp_thermal_device_add(u
 	      zonedev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &zonedev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -407,7 +407,7 @@ static int pkg_thermal_cpu_offline(unsig
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -439,9 +439,9 @@ static int pkg_thermal_cpu_offline(unsig
 		 * To cancel the work we need to drop the lock, otherwise
 		 * we might deadlock if the work needs to be flushed.
 		 */
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		cancel_delayed_work_sync(&zonedev->work);
-		spin_lock_irq(&pkg_temp_lock);
+		raw_spin_lock_irq(&pkg_temp_lock);
 		/*
 		 * If this is not the last cpu in the package and the work
 		 * did not run after we dropped the lock above, then we
@@ -452,7 +452,7 @@ static int pkg_thermal_cpu_offline(unsig
 			pkg_thermal_schedule_work(target, &zonedev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
