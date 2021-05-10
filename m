Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7846F3789CD
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 13:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhEJLbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 07:31:47 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35591 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhEJLaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 07:30:15 -0400
Received: by mail-lf1-f46.google.com with SMTP id x19so22835214lfa.2;
        Mon, 10 May 2021 04:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzQ+Nz9poSHpUxzvatLe0g2jmD0SGDmCH+kVxSHNzj4=;
        b=PlxF0vGHlA21tt0/MbhAua1ZbbZIOchJ2XhyIz/pD6YnW5RRfVe+aM3lG4QexIm83H
         W1oed0CffV3Kgal14OBnvtNPlCpyV+8my1Q2nq1gsGcWx9H1Orc3aIBT75T0++mNapQg
         5pO42nrOtt8u71Ed8EfuIQudbYTifqZwkGqTkIB2cna5gVvy3+So9J05ml3eFaotK7h1
         KFcDjkSX3gh3l2eUYDuszdeUaluSmfqJGu5cT+INv84twg2SSAqKGUGYQqb3mF613dke
         JW8eDFHL/ocaqGEAqy4NtGi30bFn9Zu0hK70AHSROIwSmmw7iLbNabYaw6FJG8xu6KBK
         UQyw==
X-Gm-Message-State: AOAM531ek7YhT3jJKV7s9Bi/9x7XywEMw8vzLHOLnU0zILJ2Ss9yc23Q
        5NzjYKOH+kDyau25MoN6qpY=
X-Google-Smtp-Source: ABdhPJxLYmVjwd0wzFK+eB5KWLIx/wHnY9RaJa1SkL16OjlXf9O/zw2mnj1mO8wBoPth8Sfa3GYLrA==
X-Received: by 2002:ac2:5f72:: with SMTP id c18mr16937012lfc.233.1620646148352;
        Mon, 10 May 2021 04:29:08 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id h32sm2192974lfv.251.2021.05.10.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:29:07 -0700 (PDT)
Date:   Mon, 10 May 2021 14:29:01 +0300
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
Subject: [PATCH v9 03/10] thermal: Use generic HW-protection shutdown API
Message-ID: <85d0225cd0e287ec9a7b43709400794c5cf470d5.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The hardware shutdown function was exported from kernel/reboot for
other subsystems to use. Logic is copied from the thermal_core. The
protection mutex is replaced by an atomic_t to allow calls also from
an IRQ context.

Use the exported API instead of implementing own just for the
thermal_core.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Changelog:
v9:
 - Update the thermal documentation
v8:
 - new patch (change added in v7, splitted in own patch at v8)

Use the exported API instead
---
 .../driver-api/thermal/sysfs-api.rst          | 24 +++----
 drivers/thermal/thermal_core.c                | 63 ++-----------------
 2 files changed, 13 insertions(+), 74 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation=
/driver-api/thermal/sysfs-api.rst
index 4b638c14bc16..c93fa5e961a0 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -740,21 +740,15 @@ possible.
 5. thermal_emergency_poweroff
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
-On an event of critical trip temperature crossing. Thermal framework
-allows the system to shutdown gracefully by calling orderly_poweroff().
-In the event of a failure of orderly_poweroff() to shut down the system
-we are in danger of keeping the system alive at undesirably high
-temperatures. To mitigate this high risk scenario we program a work
-queue to fire after a pre-determined number of seconds to start
-an emergency shutdown of the device using the kernel_power_off()
-function. In case kernel_power_off() fails then finally
-emergency_restart() is called in the worst case.
+On an event of critical trip temperature crossing the thermal framework
+shuts down the system by calling hw_protection_shutdown(). The
+hw_protection_shutdown() first attempts to perform an orderly shutdown
+but accepts a delay after which it proceeds doing a forced power-off
+or as last resort an emergency_restart.
=20
 The delay should be carefully profiled so as to give adequate time for
-orderly_poweroff(). In case of failure of an orderly_poweroff() the
-emergency poweroff kicks in after the delay has elapsed and shuts down
-the system.
+orderly poweroff.
=20
-If set to 0 emergency poweroff will not be supported. So a carefully
-profiled non-zero positive value is a must for emergency poweroff to be
-triggered.
+If the delay is set to 0 emergency poweroff will not be supported. So a
+carefully profiled non-zero positive value is a must for emergency
+poweroff to be triggered.
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d20b25f40d19..10a2d8e1cacf 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -36,10 +36,8 @@ static LIST_HEAD(thermal_governor_list);
=20
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
-static DEFINE_MUTEX(poweroff_lock);
=20
 static atomic_t in_suspend;
-static bool power_off_triggered;
=20
 static struct thermal_governor *def_governor;
=20
@@ -327,70 +325,18 @@ static void handle_non_critical_trips(struct thermal_=
zone_device *tz, int trip)
 		       def_governor->throttle(tz, trip);
 }
=20
-/**
- * thermal_emergency_poweroff_func - emergency poweroff work after a known=
 delay
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
- * This may be called from any critical situation to trigger a system shut=
down
- * after a known period of time. By default this is not scheduled.
- */
-static void thermal_emergency_poweroff(void)
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
-	int poweroff_delay_ms =3D CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
-	 * Its a must for thermal_emergency_poweroff_work to be scheduled
+	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
-	if (poweroff_delay_ms <=3D 0)
-		return;
-	schedule_delayed_work(&thermal_emergency_poweroff_work,
-			      msecs_to_jiffies(poweroff_delay_ms));
-}
+	int poweroff_delay_ms =3D CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
=20
-void thermal_zone_device_critical(struct thermal_zone_device *tz)
-{
 	dev_emerg(&tz->device, "%s: critical temperature reached, "
 		  "shutting down\n", tz->type);
=20
-	mutex_lock(&poweroff_lock);
-	if (!power_off_triggered) {
-		/*
-		 * Queue a backup emergency shutdown in the event of
-		 * orderly_poweroff failure
-		 */
-		thermal_emergency_poweroff();
-		orderly_poweroff(true);
-		power_off_triggered =3D true;
-	}
-	mutex_unlock(&poweroff_lock);
+	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
=20
@@ -1538,7 +1484,6 @@ static int __init thermal_init(void)
 	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
-	mutex_destroy(&poweroff_lock);
 	return result;
 }
 postcore_initcall(thermal_init);
--=20
2.25.4


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCZGP0ACgkQeFA3/03a
ocXzNgf/RReSMwzTrFY5G7gutoPa+m8huOMKWI7OwNA/JfTV4mGNjhxMBlvXZ6zO
9LDGGDJNR//U7CRLvQ8hBd2STGAKYMAy0Ko87kw16fzII0Nwvv+VoQMbR7bvipnY
WKgik8aiOwt+irLds5mLaPRpaXTvSGIkT5j2tvRd/ZXZBcEdbikAh0/XmLieKPVc
ZqCEXC59eCq+CbD5vqYJt0F97yzBo4eVUC4p9/aGHiFAjRbCTCV0icWMZyhISYoX
De67gSVFjoqNI0N5rIkLLqkRmZnKGRMA7/4U4p5W+TrB00evJvm5ALYVs0DJdhfK
jvtN8p8P6hS6mXYAH6EdcWwQAzfvaA==
=w/dz
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
