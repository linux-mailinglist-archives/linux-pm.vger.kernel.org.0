Return-Path: <linux-pm+bounces-25250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D4A85CFF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ADA9A56C6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5617B2BD5A6;
	Fri, 11 Apr 2025 12:18:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1B29CB4C
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373905; cv=none; b=VJ9EAIqN9sBAaHC8hTjuRnOHTyvYdO0zfP02Ntl/ybPnvxn0Ncgsp4pJ877WGkWf/d2d6ooT4aY5Tu/FIWWJUR/HEkbArienpZe1G1Y5Yf28p7fqNaU07i4zTtB9WaF4Y2P4+rBKefCwq5IeH50gh+K6mOpIPIXHefJqgI38Ka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373905; c=relaxed/simple;
	bh=YaC6+nGrs+nEVOskQISjDoNkOUyKMAcCdxZiulyTVFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9jCwyBKWnziMZJTGL/KYZtmLc3Z5rXaupT/MoJNJ0tN8VswlgzZdf01S9SP/26MqaKT78aGRpy82Y408U5Edn7nXvrIX69CaRYLj1soklIS4zu+iHLk01Q6q9q6biOwKMgm6MAeXHAZBV7xtoPZIczbiQ5roVhi8w06YL9swmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKZ-0006JT-Fu; Fri, 11 Apr 2025 14:17:59 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-004QkW-1l;
	Fri, 11 Apr 2025 14:17:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-002PBi-1V;
	Fri, 11 Apr 2025 14:17:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v8 3/7] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
Date: Fri, 11 Apr 2025 14:17:53 +0200
Message-Id: <20250411121757.573419-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411121757.573419-1-o.rempel@pengutronix.de>
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

This commit introduces the Power State Change Reasons Recording (PSCRR)
framework. It provides a generic mechanism to store shutdown or reboot
reasons, such as under-voltage, thermal events, or software-triggered
actions, into non-volatile storage.

PSCRR is primarily intended for systems where software is able to detect
a power event in time and store the reason—typically when backup power
(e.g., capacitors) allows a short window before shutdown. This enables
reliable postmortem diagnostics, even on devices where traditional storage
like eMMC or NAND may not survive abrupt power loss.

In its current form, PSCRR focuses on software-reported reasons. However,
the framework is also designed with future extensibility in mind and could
serve as a central frontend for exposing hardware-reported reset reasons
from sources such as PMICs, watchdogs, or SoC-specific registers.

This version does not yet integrate such hardware-based reporting.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
changes v8:
- Introduce struct pscrr_core to encapsulate backend and locking
- Replace global mutex and backend pointer with centralized pscrr_core
- Use DEFINE_GUARD() + guard(g_pscrr) for scoped mutex locking
- Simplify code using local backend pointer after locking
- Prepare code structure for future multi-backend support
changes v7:
- make write_reason optional
- update documentation
changes v6:
- move enum pscr_reason to kernel reboot core
- move reason storage to reboot core
- add locking
---
 drivers/power/reset/Kconfig  |  25 +++
 drivers/power/reset/Makefile |   1 +
 drivers/power/reset/pscrr.c  | 403 +++++++++++++++++++++++++++++++++++
 include/linux/pscrr.h        |  58 +++++
 4 files changed, 487 insertions(+)
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf3..7e4c4f317938 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -316,3 +316,28 @@ config POWER_MLXBF
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
 endif
+
+menuconfig PSCRR
+	bool "Power State Change Reasons Recording (PSCRR) Framework"
+	help
+	  Enables the Power State Change Reasons Recording (PSCRR) framework.
+
+	  This framework allows software to store a reason for system shutdown
+	  or reboot in non-volatile storage. It is useful on systems where
+	  power failures can be detected in advance, giving software a short
+	  window (e.g., via backup capacitors) to persist a shutdown reason
+	  before full power loss.
+
+	  This mechanism supports diagnostics and recovery logic in bootloaders
+	  or early-stage software. It avoids reliance on block-based storage,
+	  which may not survive hard shutdowns.
+
+	  The framework is designed to be extensible and can also support
+	  hardware-backed reset reason sources (e.g., PMIC or watchdog
+	  registers), allowing a uniform interface for both software-defined
+	  and hardware-reported reasons.
+
+	  Sudden power cuts, CPU freezes, or other uncontrolled resets may not
+	  be recorded unless hardware provides the reset cause.
+
+	  If unsure, say N.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 10782d32e1da..dbd6ae6b26a4 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_PSCRR) += pscrr.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
new file mode 100644
index 000000000000..ce73e764a1c8
--- /dev/null
+++ b/drivers/power/reset/pscrr.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr_core.c - Core Power State Change Reason Recording
+ *
+ * This framework provides a method for recording the cause of the last system
+ * reboot or shutdown, in scenarios where software can detect the shutdown cause
+ * early enough, or where hardware components (e.g., PMICs) retain this
+ * information across reboots.
+ *
+ * Unlike traditional logging mechanisms that rely on block storage (e.g., NAND,
+ * eMMC), PSCRR enables persistent recording of shutdown reasons using
+ * lightweight non-volatile memory, suitable for early boot diagnostics.
+ *
+ * Purpose:
+ * --------
+ * The primary goal of PSCRR is to help developers and system operators analyze
+ * field failures by tracking the reason for each power state change. This
+ * improves root cause analysis and can aid in future recovery strategies.
+ *
+ * The framework is useful when the system includes backup power (e.g.,
+ * capacitors) and early power-fail detection, allowing software enough time to
+ * record the reason. It can also support hardware-reported reasons, if
+ * available.
+ *
+ * Sysfs Interface:
+ * ----------------
+ *   /sys/kernel/pscrr/reason       - Read/write current power state change
+ *				      reason
+ *   /sys/kernel/pscrr/reason_boot  - Read-only last recorded reason from
+ *				      previous boot
+ *
+ * Why is this needed?
+ * -------------------
+ * On many embedded systems:
+ *   - Block storage cannot be updated safely during power loss.
+ *   - Power-down may be too fast to allow clean shutdown.
+ *
+ * To enable reliable postmortem diagnostics, alternate non-volatile storage
+ * should be used, such as:
+ *   - Battery-backed RTC scratchpads
+ *   - EEPROM or NVMEM cells
+ *   - FRAM or other persistent low-power memory
+ *
+ * How PSCRR Works:
+ * ----------------
+ *   - A driver detects a protection event (e.g., regulator failure) and calls:
+ *       hw_protection_trigger(PSCR_REGULATOR_FAILURE,
+ *                              REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+ *   - Or, userspace sets the reason before shutdown:
+ *       echo 3 > /sys/kernel/pscrr/reason
+ *   - On reboot, PSCRR stores the reason using the backend’s .write_reason().
+ *   - The next boot reads it via .read_reason() and exposes it through sysfs.
+ *
+ * If only hardware-backed sources are used (e.g., PMIC or watchdog), the reason
+ * is not written by PSCRR but read from the hardware after the system restarts.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/power/power_on_reason.h>
+#include <linux/pscrr.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct pscrr_backend {
+	const struct pscrr_backend_ops *ops;
+
+	enum psc_reason last_boot_reason;
+};
+
+struct pscrr_core {
+	struct mutex lock;
+	struct pscrr_backend *backend;
+	/* Kobject for sysfs */
+	struct kobject *kobj;
+	struct notifier_block reboot_nb;
+} g_pscrr = {
+	.lock = __MUTEX_INITIALIZER(g_pscrr.lock),
+};
+
+DEFINE_GUARD(g_pscrr, struct pscrr_core *, mutex_lock(&_T->lock),
+	     mutex_unlock(&_T->lock));
+
+/**
+ * pscrr_reboot_notifier - Stores the last power state change reason before
+ *			   reboot.
+ * @nb: Notifier block structure (unused in this function).
+ * @action: The type of reboot action (unused in this function).
+ * @unused: Unused parameter.
+ *
+ * This function is called when the system is about to reboot or shut down. It
+ * writes the last recorded power state change reason to persistent storage
+ * using the registered backend’s write_reason() function.
+ *
+ * If writing fails, an error message is logged, but the reboot sequence is
+ * not blocked. The function always returns `NOTIFY_OK` to ensure that the
+ * system can reboot safely even if the reason cannot be stored.
+ *
+ * Return:
+ * - `NOTIFY_OK` on success or failure, allowing reboot to proceed.
+ * - `NOTIFY_DONE` if the PSCRR subsystem is not initialized.
+ */
+static int pscrr_reboot_notifier(struct notifier_block *nb,
+				 unsigned long action, void *unused)
+{
+	struct pscrr_backend *backend;
+	int ret;
+
+	guard(g_pscrr)(&g_pscrr);
+
+	backend = g_pscrr.backend;
+
+	if (!backend || !backend->ops || !backend->ops->write_reason)
+		return NOTIFY_DONE;
+
+	ret = backend->ops->write_reason(get_psc_reason());
+	if (ret) {
+		pr_err("PSCRR: Failed to store reason %d (%s) at reboot, err=%pe\n",
+		       get_psc_reason(), psc_reason_to_str(get_psc_reason()),
+		       ERR_PTR(ret));
+	} else {
+		pr_info("PSCRR: Stored reason %d (%s) at reboot.\n",
+			get_psc_reason(), psc_reason_to_str(get_psc_reason()));
+	}
+
+	/*
+	 * Return NOTIFY_OK to allow reboot to proceed despite failure, in
+	 * case there is any.
+	 */
+	return NOTIFY_OK;
+}
+
+/*----------------------------------------------------------------------*/
+/* Sysfs Interface */
+/*----------------------------------------------------------------------*/
+
+/**
+ * reason_show - Retrieves the current power state change reason via sysfs.
+ * @kobj: Kernel object associated with this attribute (unused).
+ * @attr: The sysfs attribute being accessed (unused).
+ * @buf: Buffer to store the output string.
+ *
+ * This function is used to read the current power state change reason from
+ * the `/sys/kernel/pscrr/reason` sysfs entry.
+ *
+ * If the PSCRR subsystem is not initialized, the function returns a message
+ * indicating that no backend is registered.
+ *
+ * The returned value is formatted as an integer (`enum psc_reason`) followed
+ * by a newline (`\n`) for compatibility with standard sysfs behavior.
+ *
+ * Return:
+ * - Number of bytes written to `buf` (formatted integer string).
+ * - `"No backend registered\n"` if the PSCRR subsystem is uninitialized.
+ */
+static ssize_t reason_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct pscrr_backend *backend;
+	enum psc_reason r;
+
+	guard(g_pscrr)(&g_pscrr);
+
+	backend = g_pscrr.backend;
+
+	if (!backend || !backend->ops)
+		return scnprintf(buf, PAGE_SIZE, "No backend registered\n");
+
+	/* If the backend can read from hardware, do so. Otherwise, use our cached value. */
+	if (backend->ops->read_reason) {
+		if (backend->ops->read_reason(&r) == 0) {
+			/* Also update our cached value for consistency */
+			set_psc_reason(r);
+		} else {
+			/* If read fails, fallback to cached. */
+			r = get_psc_reason();
+		}
+	} else {
+		r = get_psc_reason();
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", r);
+}
+
+/**
+ * reason_store - Updates the current power state change reason via sysfs.
+ * @kobj: Kernel object associated with this attribute (unused).
+ * @attr: The sysfs attribute being modified (unused).
+ * @buf: User-provided input buffer containing the reason value.
+ * @count: Number of bytes written to the attribute.
+ *
+ * This function allows users to set the power state change reason through
+ * the `/sys/kernel/pscrr/reason` sysfs entry.
+ *
+ * If the reason is out of range, a warning is logged but the write is still
+ * attempted. If the backend write fails, an error is logged, and the function
+ * returns the error code.
+ *
+ * Return:
+ * - `count` on success (indicating the number of bytes processed).
+ * - `-ENODEV` if the PSCRR subsystem is not initialized.
+ * - Any other error code returned by the backend’s `write_reason()`.
+ */
+static ssize_t reason_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pscrr_backend *backend;
+	long val;
+	int ret;
+
+	guard(g_pscrr)(&g_pscrr);
+
+	backend = g_pscrr.backend;
+
+	if (!backend || !backend->ops || !backend->ops->write_reason)
+		return -ENODEV;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	if (val < PSCR_UNKNOWN || val > PSCR_MAX_REASON)
+		/*
+		 * Log a warning, but still attempt to write the value. In
+		 * case the backend can handle it, we don't want to block it.
+		 */
+		pr_warn("PSCRR: writing unknown reason %ld (out of range)\n",
+			val);
+
+	ret = backend->ops->write_reason((enum psc_reason)val);
+	if (ret) {
+		pr_err("PSCRR: write_reason(%ld) failed, err=%d\n", val, ret);
+		return ret;
+	}
+
+	set_psc_reason((enum psc_reason)val);
+
+	return count; /* number of bytes consumed */
+}
+
+static struct kobj_attribute reason_attr = __ATTR(reason, 0644, reason_show,
+						  reason_store);
+
+/**
+ * reason_boot_show - Retrieves the last recorded power state change reason.
+ * @kobj: Kernel object associated with this attribute (unused).
+ * @attr: The sysfs attribute being accessed (unused).
+ * @buf: Buffer to store the output string.
+ *
+ * This function provides access to the `/sys/kernel/pscrr/reason_boot` sysfs
+ * entry, which contains the last recorded power state change reason from the
+ * **previous boot**. The value is retrieved from `priv->last_boot_reason`,
+ * which is initialized at module load time by reading from persistent storage.
+ *
+ * If the PSCRR NVMEM backend (`priv`) is not initialized, the function returns
+ * `-ENODEV` to indicate that the value is unavailable.
+ *
+ * The returned value is formatted as an integer (`enum psc_reason`) followed
+ * by a newline (`\n`) for sysfs compatibility.
+ *
+ * Return:
+ * - Number of bytes written to `buf` (formatted integer string).
+ * - `-ENODEV` if the PSCRR backend is not initialized.
+ */
+static ssize_t reason_boot_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	enum psc_reason last_boot_reason;
+	struct pscrr_backend *backend;
+
+	guard(g_pscrr)(&g_pscrr);
+
+	backend = g_pscrr.backend;
+
+	if (!backend)
+		return -ENODEV;
+
+	last_boot_reason = backend->last_boot_reason;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", last_boot_reason);
+}
+
+static struct kobj_attribute reason_boot_attr =
+	__ATTR(reason_boot, 0444, reason_boot_show, NULL); /* Read-only */
+
+static struct attribute *pscrr_attrs[] = {
+	&reason_attr.attr,
+	&reason_boot_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pscrr_attr_group = {
+	.attrs = pscrr_attrs,
+};
+
+int pscrr_core_init(const struct pscrr_backend_ops *ops)
+{
+	enum psc_reason stored_val = PSCR_UNKNOWN;
+	struct pscrr_backend *backend;
+	int ret;
+
+	guard(g_pscrr)(&g_pscrr);
+
+	backend = g_pscrr.backend;
+
+	if (backend) {
+		pr_err("PSCRR: Core is already initialized!\n");
+		return -EBUSY;
+	}
+
+	if (!ops->read_reason) {
+		pr_err("PSCRR: Backend must provide read callbacks\n");
+		return -EINVAL;
+	}
+
+	backend = kzalloc(sizeof(*backend), GFP_KERNEL);
+	if (!backend)
+		return -ENOMEM;
+
+	backend->ops = ops;
+	backend->last_boot_reason = PSCR_UNKNOWN;
+	g_pscrr.backend = backend;
+
+	ret = ops->read_reason(&stored_val);
+	if (!ret) {
+		backend->last_boot_reason = stored_val;
+		pr_info("PSCRR: Initial read_reason: %d (%s)\n",
+			stored_val, psc_reason_to_str(stored_val));
+	} else {
+		pr_warn("PSCRR: read_reason failed, err=%pe\n",
+			ERR_PTR(ret));
+	}
+
+	/* Setup the reboot notifier */
+	g_pscrr.reboot_nb.notifier_call = pscrr_reboot_notifier;
+	ret = register_reboot_notifier(&g_pscrr.reboot_nb);
+	if (ret) {
+		pr_err("PSCRR: Failed to register reboot notifier, err=%pe\n",
+		       ERR_PTR(ret));
+		goto err_free;
+	}
+
+	/* Create a kobject and sysfs group under /sys/kernel/pscrr */
+	g_pscrr.kobj = kobject_create_and_add("pscrr", kernel_kobj);
+	if (!g_pscrr.kobj) {
+		pr_err("PSCRR: Failed to create /sys/kernel/pscrr\n");
+		ret = -ENOMEM;
+		goto err_unreg_reboot;
+	}
+
+	ret = sysfs_create_group(g_pscrr.kobj, &pscrr_attr_group);
+	if (ret) {
+		pr_err("PSCRR: Failed to create sysfs group, err=%pe\n",
+		       ERR_PTR(ret));
+		goto err_kobj_put;
+	}
+
+	pr_info("PSCRR: initialized successfully.\n");
+
+	return 0;
+
+err_kobj_put:
+	kobject_put(g_pscrr.kobj);
+err_unreg_reboot:
+	unregister_reboot_notifier(&g_pscrr.reboot_nb);
+err_free:
+	kfree(g_pscrr.backend);
+	g_pscrr.backend = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pscrr_core_init);
+
+void pscrr_core_exit(void)
+{
+	guard(g_pscrr)(&g_pscrr);
+
+	if (!g_pscrr.backend)
+		return;
+
+	if (g_pscrr.kobj) {
+		sysfs_remove_group(g_pscrr.kobj, &pscrr_attr_group);
+		kobject_put(g_pscrr.kobj);
+	}
+
+	unregister_reboot_notifier(&g_pscrr.reboot_nb);
+
+	kfree(g_pscrr.backend);
+	g_pscrr.backend = NULL;
+
+	pr_info("PSCRR: exited.\n");
+}
+EXPORT_SYMBOL_GPL(pscrr_core_exit);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Power State Change Reason Recording (PSCRR) core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pscrr.h b/include/linux/pscrr.h
new file mode 100644
index 000000000000..b208f1a12b97
--- /dev/null
+++ b/include/linux/pscrr.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pscrr.h - Public header for Power State Change Reason Recording (PSCRR).
+ */
+
+#ifndef __PSCRR_H__
+#define __PSCRR_H__
+
+#include <linux/reboot.h>
+
+/**
+ * struct pscrr_backend_ops - Backend operations for storing power state change
+ *                            reasons.
+ *
+ * This structure defines the interface for backend implementations that handle
+ * the persistent storage of power state change reasons. Different backends
+ * (e.g., NVMEM, EEPROM, battery-backed RAM) can implement these operations to
+ * store and retrieve shutdown reasons across reboots.
+ *
+ * Some systems may have **read-only** hardware-based providers, such as PMICs
+ * (Power Management ICs), that automatically log reset reasons without software
+ * intervention. In such cases, the backend may implement only the `read_reason`
+ * function, while `write_reason` remains unused or unimplemented.
+ *
+ * @write_reason: Function pointer to store the specified `psc_reason` in
+ *                persistent storage. This function is called before a reboot
+ *                to record the last power state change reason. Some hardware
+ *                may not support software-initiated writes, in which case
+ *                this function may not be required.
+ * @read_reason:  Function pointer to retrieve the last stored `psc_reason`
+ *                from persistent storage. This function is called at boot to
+ *                restore the shutdown reason. On read-only hardware providers
+ *                (e.g., PMICs with built-in reset reason registers), this may
+ *                be the only function implemented.
+ */
+struct pscrr_backend_ops {
+	int (*write_reason)(enum psc_reason reason);
+	int (*read_reason)(enum psc_reason *reason);
+};
+
+/**
+ * pscrr_core_init - Initialize the PSCRR core with a given backend
+ * @ops: Backend operations that the core will call
+ *
+ * Return: 0 on success, negative error code on failure.
+ * The core sets up sysfs, registers reboot notifier, etc.
+ */
+int pscrr_core_init(const struct pscrr_backend_ops *ops);
+
+/**
+ * pscrr_core_exit - De-initialize the PSCRR core
+ *
+ * Unregisters the reboot notifier, removes the sysfs entries, etc.
+ * Should be called by the backend driver at removal/shutdown.
+ */
+void pscrr_core_exit(void);
+
+#endif /* __PSCRR_H__ */
-- 
2.39.5


