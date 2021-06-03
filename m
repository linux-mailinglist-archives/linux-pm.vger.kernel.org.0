Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00F8399A1D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 07:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFCFmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 01:42:39 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:33600 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCFmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 01:42:38 -0400
Received: by mail-lf1-f52.google.com with SMTP id a5so7045955lfm.0;
        Wed, 02 Jun 2021 22:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ne1WWYaCz65VdAFxTqyE7mZ4II+d9O5bnHyG1KNO9ao=;
        b=rllPTt9yXlLbdYDVXD/IrGc4zDp1OkdGD3wnd6wW7gpKpucWcsEP1Q4Wb67qlmHNf2
         bOUfIGdt5uTNnJbfd6wBmzwL4XV3mQ2lfp5E3tH8CBqMjxcbL+qVJFioTnsQWVdQpLYZ
         Dn2kZRBSP6K3ELLfieDxRviwbRFxg7FiSxvFtnDzTzt1VVf65JNI/N8JiSxSJDO9GzYJ
         raYA8JNd1DP/Da+HhbJ4b+w/wi1iFTl1RC/ZXsp61GQpBsCl1Ed0MHRdr8MjKsxQ8so7
         6D+RdHoHktGkyKIuVf9p9p7CEsVa7Tk/wRoJYRmKf7H3yhC5TGDc7IPqpYXjCOLMIYAJ
         zaAA==
X-Gm-Message-State: AOAM532o13FIv7O+Qq+lvVS6XEbMGWxu/1Qs/QAsCHWjmFQ+TS7K7OMv
        Dc+ZSjG8jF0kOPo44fcerqs=
X-Google-Smtp-Source: ABdhPJxFQnRk+OrsSMmQSfI6rnJotjROrRNP5Eozx9NckB7ER95WTv+coYn8QFo/ngLkmUgT/n7qxg==
X-Received: by 2002:a05:6512:68e:: with SMTP id t14mr24206418lfe.624.1622698852327;
        Wed, 02 Jun 2021 22:40:52 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id q127sm233306ljq.88.2021.06.02.22.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 22:40:51 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:40:45 +0300
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
Subject: [PATCH RESEND v10 02/11] reboot: Add hardware protection power-off
Message-ID: <e83ec1ca9408f90c857ea9dcdc57b14d9037b03f.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
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

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC4a10ACgkQeFA3/03a
ocXOLgf/ZNhv5TcFiTD+yfchGHzXDRLKSTBYqXGCYVTCdxRvCM61bGfSoHHbW0+w
XZAywsRI0EosQbFSnIdpzKOwsw5Zs+DyuyARIKrTY1mesGKc7zg56Hf85LEYNUd8
fR0KJGoTrTedCPLIZgdnL3TIF+VeK3AzKFyzympSTuMGLbBzOWtAwpdboNJgga2F
Ux1dRWkOeaKsQPEU1c6Os/5l3T4DggpCxH2FlJfBBBTCj4WIvlvVVQj/vr3PcfVg
Z6l1mb31UWv/yUsX3qv6TTXaebzT1NjTyL/O0eGbs5D364cQY8B2bf2MxbbOhkr7
BtTlfJGcPy2ElBzzKWEg+Q9QBsJYpw==
=KJ8E
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
