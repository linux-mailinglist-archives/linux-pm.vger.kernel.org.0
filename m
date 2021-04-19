Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762783640E6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhDSLtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 07:49:39 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41968 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbhDSLti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 07:49:38 -0400
Received: by mail-lj1-f169.google.com with SMTP id a36so28140549ljq.8;
        Mon, 19 Apr 2021 04:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1y568k09qtcL9FbHc6AZ/jNHO50SGhDLwYirPpmIwsU=;
        b=Y2TjJZ8UYyNPiyt5o+0GgNjastLMavb+BRq9xFQVVQgThsjpVIDCufnY8BFwiP7SOk
         DGF5tIUM6PMh5UP4l2sVh15Ej6uxSubQVDa9Qru4CocSEwv1VkDqvfytxETrAQvtU4O8
         LthlYBMza+kg9DTzCtYg/88uK2xYaXNBWKKue/wQhC858Kp/YqnVe/TOV6XdpNIeE9CN
         v7vk81VMX4es+NV5vFMtxGt8KCD1XljC9mcXLFilwotiyLlsd63QZ7kMHTTxjhIbGwaA
         UPS/zplZcY6eDXvaZcBLcJwLmqHjEXwipw2PrhcNCMXB6aaFzTjFhzVEJb/GMZPgdsvB
         WcfQ==
X-Gm-Message-State: AOAM531RWmBuavJFk2frsAvn42UgVO5Btjscj2FAM+QYv8Ixi4ImKU4T
        3o3xe2wmEsLOyE3cU9roxyc=
X-Google-Smtp-Source: ABdhPJz0+6sYh/9WvqRk29PhyZlnlhB58yYK7gD7vOFVu1WxhJxDyYTfQ5h62FTofyAoeJH2J2o+Dw==
X-Received: by 2002:a2e:3209:: with SMTP id y9mr11421161ljy.146.1618832946239;
        Mon, 19 Apr 2021 04:49:06 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id a9sm1815963lfo.186.2021.04.19.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:49:05 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:48:57 +0300
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
Subject: [PATCH v8 02/10] reboot: Add hardware protection power-off
Message-ID: <aae403d309b4f37be580f536d1ecd7d83b5a9523.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
+void hw_protection_shutdown(const char *reason, int ms_until_forced);
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a6ad5eb2fa73..5da8c80a2647 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt)	"reboot: " fmt
 
+#include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -518,6 +519,85 @@ void orderly_reboot(void)
 }
 EXPORT_SYMBOL_GPL(orderly_reboot);
 
+/**
+ * hw_failure_emergency_poweroff_func - emergency poweroff work after a known delay
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
+ * This may be called from any critical situation to trigger a system shutdown
+ * after a given period of time. If time is negative this is not scheduled.
+ */
+static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
+{
+	if (poweroff_delay_ms <= 0)
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
+ * further damage. Usage examples include a thermal protection or a voltage or
+ * current regulator failures.
+ * NOTE: The request is ignored if protection shutdown is already pending even
+ * if the previous request has given a large timeout for forced shutdown.
+ * Can be called from any context.
+ */
+void hw_protection_shutdown(const char *reason, int ms_until_forced)
+{
+	static atomic_t allow_proceed = ATOMIC_INIT(1);
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
