Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D33789CA
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhEJLbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 07:31:42 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37753 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhEJL3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 07:29:44 -0400
Received: by mail-lf1-f41.google.com with SMTP id 2so22822971lft.4;
        Mon, 10 May 2021 04:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSCIycZ4be1RayJUkUz89M7xayRC4UjtGgdTGNbT714=;
        b=GadFIdurhR+i9GwByilTl0uP4wj/NF7C/lbUteXhXrg0VPIrwY+F6wKnZGL5T6BGP3
         oXZNWAmRntHvmKQfGf3p8YJlX+h88QgW+EGgvr7bSQogOvvmUp/VITJbaxh/HFrkYA1D
         O3xkAM3fUeM81bhJTYRwyOe3cKKcpds+kX9WB/XdOWskNt61lPjM7qkb+OQ+HoVc3zBF
         IOCWNnV+BbQzlm2F+X6fw8AZL0B2FKuduNSuJmfb+NADAQdbValkWMWVS8xSxb2CC9tE
         DKTtzdxxtXA44+SyWNwnJXRQJ5n8qDgW2rvwFFAzdB4s3dnIiiZw4qI7gdV06uq/tidu
         VLiQ==
X-Gm-Message-State: AOAM531F+gjaUPpXrNUFNK7RtxBfmtcGOH20bWCHYAbt/PbA1R4PXD6N
        0p/u+ocqn2fZTiwroY/mpxE=
X-Google-Smtp-Source: ABdhPJwXwsZbwZfge7a+eGifC1Frwq17v6o0DDFO/wLp57MfQoXVNyw30VYur7MPSB67ySrlZBrqkQ==
X-Received: by 2002:a05:6512:5c5:: with SMTP id o5mr17262255lfo.168.1620646117822;
        Mon, 10 May 2021 04:28:37 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id 17sm2229864lfr.187.2021.05.10.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:28:37 -0700 (PDT)
Date:   Mon, 10 May 2021 14:28:30 +0300
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
Subject: [PATCH v9 02/10] reboot: Add hardware protection power-off
Message-ID: <97260f8e150abb898a262fade25860609b460912.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <cover.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There can be few cases when we need to shut-down the system in order to
protect the hardware. Currently this is done at east by the thermal core
when temperature raises over certain limit.

Some PMICs can also generate interrupts for example for over-current or
over-voltage, voltage drops, short-circuit, ... etc. On some systems
these are a sign of hardware failure and only thing to do is try to
protect the rest of the hardware by shutting down the system.

Add shut-down logic which can be used by all subsystems instead of
implementing the shutdown in each subsystem. The logic is stolen from
thermal_core with difference of using atomic_t instead of a mutex in
order to allow calls directly from IRQ context.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---

Changelog:
v8: (changes suggested by Daniel Lezcano)
 - replace a protection implemented by a flag + spin_lock_irqsave() with
   simple atomic_dec_and_test().
 - Split thermal-core changes and adding the new API to separate patches
v7:
 - New patch
---
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 80 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

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
index a6ad5eb2fa73..5da8c80a2647 100644
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
@@ -518,6 +519,85 @@ void orderly_reboot(void)
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
+	WARN(1, "Hardware protection timed-out. Trying forced poweroff\n");
+	kernel_power_off();
+
+	/*
+	 * Worst of the worst case trigger emergency restart
+	 */
+	WARN(1,
+	     "Hardware protection shutdown failed. Trying emergency restart\n");
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

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCZGN4ACgkQeFA3/03a
ocVxkwf/V/uO6urS2v6z4nhTdR0gcwQvpoRWDZyJT1DjcCauRH42M77H7zVoCO57
bh+dqZ73JaQmb+7X3l+xkz/IVvOsI1J2RMQavflcqdVYhc6Mw7kS6EXK/4PZv+0s
ESl5vFLC9fh966uCBSMwh2Tu+oRxDvNTMMs8gtqzwhM1Ul8ivN4Rs6nWx7R+1g6B
Iz+x2+ry59RgB7hv89ozLuvoSpU9KXw3FVoemm1ErCADbNcR1H3iapKAVuo2yLUv
sAAinYOFnp91XEI4WpXbykpwiWuoizsGqVeTMhfDRrJR6aNqVgBl0B3B7GirIJ2c
SK5eXUQ+dV0TaJisbdA4DzaqFFP5/g==
=Ajf7
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
