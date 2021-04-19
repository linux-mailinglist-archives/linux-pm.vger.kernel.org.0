Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D013640EF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhDSLuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 07:50:11 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42792 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbhDSLuG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 07:50:06 -0400
Received: by mail-lf1-f41.google.com with SMTP id z13so38422070lfd.9;
        Mon, 19 Apr 2021 04:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jd8ZqQr7aA+TfxalG5Zpojil8sxWCY4+ctswmpE1Z1Q=;
        b=jXQ8MSwq9PfcDQVqc90MHB1699FOt7j/4n5k7E5puQDEXqtVJ+wtwP/gzOV+M/d6wG
         X+DaksaUIYRFd0hbORlDNfKgWdmHb710aLW7HD0g7ydCoZRpzIkYEEBd8YVYj4wAJLJK
         7MbIc+KbXZmOAVP6W9hJW9Qv+Oi2pyx/H7JtwTOu9KAvq47JaXkZbM8Z9mGtc0pFDvr1
         Qph1LPTIy1+dn+u4CRfJyMAUwkO7albZf6F44wzlE+oEk5bsiUeudeDlGvhk8E6L578f
         bX/Y9TccTVgWzUNkFncvzviJMXH3A+oHwpX5miLtcYiDdIdZfB0vNLcejMMC9/nXtDiY
         uO1A==
X-Gm-Message-State: AOAM532P+qiQMvhg9yMRm9GEnZgMC/NDixl89/n9ukflZdQXpEehoaZ8
        cilxWBHkDYATWkp2KbD/kxk=
X-Google-Smtp-Source: ABdhPJyFuwzrHLSm7DTsZU0JJPCmu1/xXK1hF4dMaPRI7Zfs3r/1hX4dbdT0xNJVAkEIRjcPMdeP4A==
X-Received: by 2002:ac2:5f1b:: with SMTP id 27mr11709672lfq.425.1618832975571;
        Mon, 19 Apr 2021 04:49:35 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id j11sm1803022lfg.257.2021.04.19.04.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:49:35 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:49:27 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v8 03/10] thermal: Use generic HW-protection shutdown API
Message-ID: <3b62226e320ab412357e102baf6d628e354a0b61.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hardware shutdown function was exported from kernel/reboot for
other subsystems to use. Logic is copied from the thermal_core. The
protection mutex is replaced by an atomic_t to allow calls also from
an IRQ context.

Use the exported API instead of implementing own just for the
thermal_core.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Changelog:
v8:
 - new patch (change added in v7, splitted in own patch at v8)

Use the exported API instead
---
 drivers/thermal/thermal_core.c | 63 +++-------------------------------
 1 file changed, 4 insertions(+), 59 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 996c038f83a4..b1444845af38 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -36,10 +36,8 @@ static LIST_HEAD(thermal_governor_list);
 
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
-static DEFINE_MUTEX(poweroff_lock);
 
 static atomic_t in_suspend;
-static bool power_off_triggered;
 
 static struct thermal_governor *def_governor;
 
@@ -327,70 +325,18 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 		       def_governor->throttle(tz, trip);
 }
 
-/**
- * thermal_emergency_poweroff_func - emergency poweroff work after a known delay
- * @work: work_struct associated with the emergency poweroff function
- *
- * This function is called in very critical situations to force
- * a kernel poweroff after a configurable timeout value.
- */
-static void thermal_emergency_poweroff_func(struct work_struct *work)
-{
-	/*
-	 * We have reached here after the emergency thermal shutdown
-	 * Waiting period has expired. This means orderly_poweroff has
-	 * not been able to shut off the system for some reason.
-	 * Try to shut down the system immediately using kernel_power_off
-	 * if populated
-	 */
-	WARN(1, "Attempting kernel_power_off: Temperature too high\n");
-	kernel_power_off();
-
-	/*
-	 * Worst of the worst case trigger emergency restart
-	 */
-	WARN(1, "Attempting emergency_restart: Temperature too high\n");
-	emergency_restart();
-}
-
-static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
-			    thermal_emergency_poweroff_func);
-
-/**
- * thermal_emergency_poweroff - Trigger an emergency system poweroff
- *
- * This may be called from any critical situation to trigger a system shutdown
- * after a known period of time. By default this is not scheduled.
- */
-static void thermal_emergency_poweroff(void)
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
-	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
-	 * Its a must for thermal_emergency_poweroff_work to be scheduled
+	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
-	if (poweroff_delay_ms <= 0)
-		return;
-	schedule_delayed_work(&thermal_emergency_poweroff_work,
-			      msecs_to_jiffies(poweroff_delay_ms));
-}
+	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
 
-void thermal_zone_device_critical(struct thermal_zone_device *tz)
-{
 	dev_emerg(&tz->device, "%s: critical temperature reached, "
 		  "shutting down\n", tz->type);
 
-	mutex_lock(&poweroff_lock);
-	if (!power_off_triggered) {
-		/*
-		 * Queue a backup emergency shutdown in the event of
-		 * orderly_poweroff failure
-		 */
-		thermal_emergency_poweroff();
-		orderly_poweroff(true);
-		power_off_triggered = true;
-	}
-	mutex_unlock(&poweroff_lock);
+	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
@@ -1549,7 +1495,6 @@ static int __init thermal_init(void)
 	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
-	mutex_destroy(&poweroff_lock);
 	return result;
 }
 postcore_initcall(thermal_init);
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
