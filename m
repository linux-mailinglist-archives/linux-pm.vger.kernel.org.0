Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBF399A21
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFCFnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 01:43:09 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38506 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCFnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 01:43:08 -0400
Received: by mail-lj1-f171.google.com with SMTP id a4so5604059ljd.5;
        Wed, 02 Jun 2021 22:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avHrM7JfdyvFeGpZaxuvTLRbbrJcYYr/B2Y+l11QZLI=;
        b=nFrZNxyRY5OUywUNdwV5tHOacmSwKk18b4c02satxPJdccmmE+97Kb/g9plgdkuQTB
         MYEPzvEEg+wk7wxcmqduzdT30Kf2v49myIALvO0LG93GWtKXJRiLUhIy+n3dxLDlZToo
         5rv+bwiZyGYppdck+Upk4fQJpVO6MRl3Cqkj3iANhkzxHVExCqofBsaiXP1DI+aumkJJ
         erj7VOAkr8uw9S+SmoaMQJgMHHZ7cxPTshbwhTjT0ketIlVd8ujKeSfn5jE1wUmHoGLu
         4nESdWt1z67hreX4b/BHKvbmOvQYbR1gWyWrlkRo/1hjwuGedxppZgyLWr3WFMulzsvB
         qHQA==
X-Gm-Message-State: AOAM532iKzrjk3dHtQB0RZh6PxzjL3IyPy0TaGfW6Gykj7i4JPbM2DeZ
        A5Me/d9kl9cf58NQjAPgDbY=
X-Google-Smtp-Source: ABdhPJx65Mb0U6+bOzykCIrwAiL5/c73SJ3yyHRMr8zu84Ol76ONfTzz1p4wnCmSVqOF8o2RdMJQaQ==
X-Received: by 2002:a2e:979a:: with SMTP id y26mr4689887lji.130.1622698870591;
        Wed, 02 Jun 2021 22:41:10 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id w8sm227523ljj.61.2021.06.02.22.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 22:41:10 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:41:03 +0300
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
Subject: [PATCH RESEND v10 03/11] thermal: Use generic HW-protection shutdown
 API
Message-ID: <5531e89d9e710f5d10e7cdce3ee58957335b9e03.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The hardware shutdown function was exported from kernel/reboot for
other subsystems to use. Logic is copied from the thermal_core. The
protection mutex is replaced by an atomic_t to allow calls also from
an IRQ context. Also the WARN() was replaced by pr_emerg() based on
discussions here:
https://lore.kernel.org/lkml/YJuPwAZroVZ%2Fw633@alley/
and here:
https://lore.kernel.org/linux-iommu/20210331093104.383705-4-geert+renesas@g=
lider.be/

Use the exported API instead of implementing own just for the
thermal_core.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Changelog:
v10:
 - update commit message to mention changing WARN() to pr_emerg()
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

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC4a28ACgkQeFA3/03a
ocXL0gf9F81uoRGFo+y3osW+sOy4UZd6GstVkgrDOPlXTSJckGbEnPhdPWq8XvtE
KsADJqJYURMR2h5PJjg8S2dLQnjVEo4fgyVoDahYKzzhW3bFcC8gNkleuWiGJkv+
9TJOApwU5vLx5ZJzWQQE/staG4r0vTOT0Vi7VNwjwr4vYC+SFPS5oZh22mDNSzpc
DXDnc9d94vVRO+1hVhf4Nrt4uuNzjS/J5ZrHYhpITKv7BR7P44ZM4FNlvfy82Jve
vRX4yzLz3AHTbGHrWKm3hSePlMTghg3rn2UgbctJp14OTNnGCVMQWaFN2k/pE7Q/
QsZVtTWAVPrt03AmjYlvO+UqVvEi/w==
=v9Qp
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
