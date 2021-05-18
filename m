Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF741387774
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhERL1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 07:27:00 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37409 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhERL07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 07:26:59 -0400
Received: by mail-lj1-f173.google.com with SMTP id e2so4792931ljk.4;
        Tue, 18 May 2021 04:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cd/c2LtdpRuc14pg+36HsS3RaXLeJ4fTyyPGFfmqhkE=;
        b=Xa4sYrBY29t8ofvNjeyzaohTYUSh9jkmZNCo/JaCGRWEWTQYuEu/TjPRZydx2U5AbT
         EOxJnvBWPSrbdAp1HoYH0TLwesJ+ubmZIyouMz4l9p1DtZ4IM/pluJZZRUfPCH7EerFa
         6B1vgwLO18sHpxxVsqZDv61bf094ukVbHOfc8xYotC511zriFhM4+CF0TBPY9IULhit8
         KNmWlVtb5kDv7qN9+a4T8I4rRG0ekGmAk7cbceZtbruCUxoS38ZnzlICxyS+2yxQZiG2
         hJnX+pSRSP2uUizvhPVvyaLHA21LgDdoIhisBrnAT3d/vRCpR6jN4fCoCrNI0FuWWyCs
         RnYg==
X-Gm-Message-State: AOAM530rUMaUW0QGg0z6XKgvubHv7IIgefSkQJPsX4OCQH+/iFaF6LAI
        WnbVstbCIzJdJo6zedSh43OhFmrVn5ekhg==
X-Google-Smtp-Source: ABdhPJzLc2VgvEnx2hGYnKlpfErMzh2nxmZLWUbZ/UEcZIWBpi+IyEV3oOLkkJZsk+qLptiONpwS+w==
X-Received: by 2002:a2e:9d43:: with SMTP id y3mr3583993ljj.85.1621337139127;
        Tue, 18 May 2021 04:25:39 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id h14sm3264777lji.57.2021.05.18.04.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:25:38 -0700 (PDT)
Date:   Tue, 18 May 2021 14:25:31 +0300
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
Subject: [PATCH v10 02/11] reboot: Add hardware protection power-off
Message-ID: <1278eb55ebf2de82b08761c69ab1c65a05c20b37.1621333893.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621333893.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <cover.1621333893.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There can be few cases when we need to shut-down the system in order to
protect the hardware. Currently this is done at least by the thermal core
when temperature raises over certain limit.

Some PMICs can also generate interrupts for example for over-current or
over-voltage, voltage drops, short-circuit, ... etc. On some systems
these are a sign of hardware failure and only thing to do is try to
protect the rest of the hardware by shutting down the system.

Add shut-down logic which can be used by all subsystems instead of
implementing the shutdown in each subsystem. The logic is stolen from
thermal_core with difference of using atomic_t instead of a mutex in
order to allow calls directly from IRQ context and changing the WARN()
to pr_emerg() as discussed here:
https://lore.kernel.org/lkml/YJuPwAZroVZ%2Fw633@alley/
and here:
https://lore.kernel.org/linux-iommu/20210331093104.383705-4-geert+renesas@g=
lider.be/

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---

Changelog:
v10: (changes suggested by Petr Mladek and Geert)
 - replace WARN() by pr_emerg()
v8: (changes suggested by Daniel Lezcano)
 - replace a protection implemented by a flag + spin_lock_irqsave() with
   simple atomic_dec_and_test().
 - Split thermal-core changes and adding the new API to separate patches
v7:
 - New patch
---
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 3734cd8f38a8..af907a3d68d1 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -79,6 +79,7 @@ extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
=20
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
+void hw_protection_shutdown(const char *reason, int ms_until_forced);
=20
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a6ad5eb2fa73..f7440c0c7e43 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -7,6 +7,7 @@
=20
 #define pr_fmt(fmt)	"reboot: " fmt
=20
+#include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -518,6 +519,84 @@ void orderly_reboot(void)
 }
 EXPORT_SYMBOL_GPL(orderly_reboot);
=20
+/**
+ * hw_failure_emergency_poweroff_func - emergency poweroff work after a kn=
own delay
+ * @work: work_struct associated with the emergency poweroff function
+ *
+ * This function is called in very critical situations to force
+ * a kernel poweroff after a configurable timeout value.
+ */
+static void hw_failure_emergency_poweroff_func(struct work_struct *work)
+{
+	/*
+	 * We have reached here after the emergency shutdown waiting period has
+	 * expired. This means orderly_poweroff has not been able to shut off
+	 * the system for some reason.
+	 *
+	 * Try to shut down the system immediately using kernel_power_off
+	 * if populated
+	 */
+	pr_emerg("Hardware protection timed-out. Trying forced poweroff\n");
+	kernel_power_off();
+
+	/*
+	 * Worst of the worst case trigger emergency restart
+	 */
+	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n=
");
+	emergency_restart();
+}
+
+static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
+			    hw_failure_emergency_poweroff_func);
+
+/**
+ * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
+ *
+ * This may be called from any critical situation to trigger a system shut=
down
+ * after a given period of time. If time is negative this is not scheduled.
+ */
+static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
+{
+	if (poweroff_delay_ms <=3D 0)
+		return;
+	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
+			      msecs_to_jiffies(poweroff_delay_ms));
+}
+
+/**
+ * hw_protection_shutdown - Trigger an emergency system poweroff
+ *
+ * @reason:		Reason of emergency shutdown to be printed.
+ * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
+ *			forced shudown. Negative value disables the forced
+ *			shutdown.
+ *
+ * Initiate an emergency system shutdown in order to protect hardware from
+ * further damage. Usage examples include a thermal protection or a voltag=
e or
+ * current regulator failures.
+ * NOTE: The request is ignored if protection shutdown is already pending =
even
+ * if the previous request has given a large timeout for forced shutdown.
+ * Can be called from any context.
+ */
+void hw_protection_shutdown(const char *reason, int ms_until_forced)
+{
+	static atomic_t allow_proceed =3D ATOMIC_INIT(1);
+
+	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
+
+	/* Shutdown should be initiated only once. */
+	if (!atomic_dec_and_test(&allow_proceed))
+		return;
+
+	/*
+	 * Queue a backup emergency shutdown in the event of
+	 * orderly_poweroff failure
+	 */
+	hw_failure_emergency_poweroff(ms_until_forced);
+	orderly_poweroff(true);
+}
+EXPORT_SYMBOL_GPL(hw_protection_shutdown);
+
 static int __init reboot_setup(char *str)
 {
 	for (;;) {
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

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjpCsACgkQeFA3/03a
ocUO5ggAoQ4/hSUFizZmQxrWO7h8hGoJBJgfjxi050BocYzDFHaNcNxDyqBPK6+u
DSMXdHzfLWcrGovYxLe/lcpNdcqvAkmbbgYuhGtteZV0ls6KHngRZrypCgZh4FbA
fi/S8mARK6sCYYR2OTY64wECJuyYTA3Yb7QtG7GW7hX4L7jBwlKaFDUqxjfAP4M0
l11CYazhm9ocXC93SAEGaVlAy8okBqZnPg/v/P4KRGauNiOenuIiuOrSf3oFF/1z
AcjKO5jpRrSoF1DCYk+IBufuK01VjHSQ0w5gkGb+JmP8fkJUxut6VmtHD3dcM00t
Vv6CL9n4/YA5Yp9HLQGAGudm3+hQ7Q==
=ZWDu
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
