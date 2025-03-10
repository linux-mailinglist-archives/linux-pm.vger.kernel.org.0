Return-Path: <linux-pm+bounces-23757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD18A59161
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88167A627B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D522A1D5;
	Mon, 10 Mar 2025 10:37:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86D2288F7
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603073; cv=none; b=dRpUjYoti2+Y58/hIP1Nfp5A2ZjPuRDe+dwh/XeB4iOslC7/y7XXPAbQL629uHoerQyGE4dch/zu6p9wgm7d6P8+43rrjd+y+5TGaZ9y357SLZQZ+ldU6/I/bZzy2xndu7G8609DIt2vEIfV0y+zsdGtJI6NABBnhe5hhyZ0CZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603073; c=relaxed/simple;
	bh=0FoY4apuBVcoZSzTb80vh405fBRPPL9Gu3QvwEqNPZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5lisdVF19YeypouU4admT1uWFuE+Th17oZ0/To6gI+Rs5c6zL/jujr6lX/3iR2+1aw/2nXW5RIdIGr4tfFsF8D+jDP9VKx67XOHsndeq4GeXdE2cKPaSRGMtuWMkkbkqh6kUAF20YIfIJNJXIu9cvYiIPSkMItR4bjP9SuOMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1traVq-0004EB-5V; Mon, 10 Mar 2025 11:37:34 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traVp-004yyz-0y;
	Mon, 10 Mar 2025 11:37:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traVp-001mCh-0j;
	Mon, 10 Mar 2025 11:37:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v5 2/7] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
Date: Mon, 10 Mar 2025 11:37:27 +0100
Message-Id: <20250310103732.423542-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310103732.423542-1-o.rempel@pengutronix.de>
References: <20250310103732.423542-1-o.rempel@pengutronix.de>
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
framework into the kernel. The framework is vital for systems where
PMICs or watchdogs cannot provide information on power state changes. It
stores reasons for system shutdowns and reboots, like under-voltage or
software-triggered events, in non-volatile hardware storage. This
approach is essential for postmortem analysis in scenarios where
traditional storage methods (block devices, RAM) are not feasible. The
framework aids bootloaders and early-stage system components in recovery
decision-making, although it does not cover resets caused by hardware
issues like system freezes or watchdog timeouts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/power/reset/Kconfig  |  19 ++
 drivers/power/reset/Makefile |   1 +
 drivers/power/reset/pscrr.c  | 408 +++++++++++++++++++++++++++++++++++
 include/linux/pscrr.h        |  89 ++++++++
 4 files changed, 517 insertions(+)
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf3..0f6aee415f1c 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -316,3 +316,22 @@ config POWER_MLXBF
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
 endif
+
+menuconfig PSCRR
+    bool "Power State Change Reasons (PSCR) Recording Framework"
+    help
+      Enables the Power State Change Reasons (PSCR) Recording framework.
+
+      This framework is designed to store reasons for system shutdowns or
+      reboots,  like under voltage or software-triggered events, in non-volatile
+      hardware storage. It is particularly useful for postmortem analysis, where
+      traditional storage methods (like block devices or RAM) are not feasible
+      due to immediate power-down requirements or insufficient power to retain
+      data.
+
+      This is useful for bootloaders or other early-stage system components to
+      make recovery decisions based on the last known system state. Note that it
+      does not cover hardware-induced resets like system freezes or watchdog
+      timeouts.
+
+      If unsure, say N.
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
index 000000000000..2b2f0115184b
--- /dev/null
+++ b/drivers/power/reset/pscrr.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr_core.c - Core Power State Change Reason Recording
+ *
+ * This framework provides a method for recording the cause of the last system
+ * reboot, particularly in scenarios where **hardware protection events** (e.g.,
+ * undervoltage, overcurrent, thermal shutdown) force an immediate reset. Unlike
+ * traditional logging mechanisms that rely on block storage (e.g., NAND, eMMC),
+ * PSCRR ensures shutdown reasons are preserved in a way that survives power
+ * loss for later analysis.
+ *
+ * Purpose:
+ * --------
+ * The primary goal of PSCRR is to help developers and system operators analyze
+ * real-world failures by identifying what conditions embedded devices
+ * experience in the field. By persisting power state change reasons across
+ * reboots, engineers can gain insight into why and how systems fail, enabling
+ * better debugging and long-term system improvements.
+ *
+ * At the time of developing this framework, no specific recovery strategies
+ * were designed. Instead, the focus is on reliable event recording to support
+ * future diagnostic and recovery efforts.
+ *
+ * Sysfs Interface:
+ * ----------------
+ *    /sys/kernel/pscrr/reason       - Read/write current power state change
+ *				       reason
+ *    /sys/kernel/pscrr/reason_boot  - Read-only last recorded reason from
+ *				       previous boot
+ *
+ * Why is this needed?
+ * --------------------
+ * Many embedded systems experience power-related faults where **safe shutdown
+ * of block storage (e.g., NAND, eMMC) is not possible**:
+ *   - Undervoltage protection triggers a hard shutdown before data can be
+ *     written.
+ *   - eMMC/NAND cannot be safely updated during power failure.
+ *
+ * To ensure post-mortem analysis is possible, alternate non-volatile storage
+ * should be used, such as:
+ *   - Battery-backed RTC scratchpad
+ *   - EEPROM or small NVMEM regions
+ *   - FRAM or other fast, low-power persistent memory
+ *
+ * How PSCRR Works:
+ * ----------------
+ *   - A driver detects a problem (e.g., overtemperature) and calls:
+ *       set_power_state_change_reason(PSCR_OVERTEMPERATURE).
+ *   - Before reboot, PSCRR writes the reason to hardware storage
+ *     via the backend's `.write_reason()` callback.
+ *   - On the next boot, the stored reason is retrieved from persistent storage
+ *     and exposed via `/sys/kernel/pscrr/reason_boot` for analysis.
+ *   - Userspace can dynamically set `/sys/kernel/pscrr/reason` to
+ *     update the shutdown reason before a reboot.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/power/power_on_reason.h>
+#include <linux/pscrr.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct pscrr_data {
+	struct notifier_block reboot_nb;
+	const struct pscrr_backend_ops *ops;
+
+	enum pscr_reason last_reason;
+	enum pscr_reason last_boot_reason;
+
+	/* Kobject for sysfs */
+	struct kobject *kobj;
+};
+
+static struct pscrr_data *g_pscrr;
+
+/**
+ * pscrr_reason_to_str - Converts a power state change reason enum to a string.
+ * @reason: The `pscr_reason` enum value to be converted.
+ *
+ * This function provides a human-readable string representation of the power
+ * state change reason, making it easier to interpret logs and debug messages.
+ *
+ * Return:
+ * - A string corresponding to the given `pscr_reason` value.
+ * - `"Invalid"` if the value is not recognized.
+ */
+static const char *pscrr_reason_to_str(enum pscr_reason reason)
+{
+	switch (reason) {
+	case PSCR_UNKNOWN:
+		return POWER_ON_REASON_UNKNOWN;
+	case PSCR_UNDER_VOLTAGE:
+		return POWER_ON_REASON_BROWN_OUT;
+	case PSCR_OVER_CURRENT:
+		return POWER_ON_REASON_OVER_CURRENT;
+	case PSCR_REGULATOR_FAILURE:
+		return POWER_ON_REASON_REGULATOR_FAILURE;
+	case PSCR_OVERTEMPERATURE:
+		return POWER_ON_REASON_OVERTEMPERATURE;
+	default:
+		return "Invalid";
+	}
+}
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
+	int ret;
+
+	if (!g_pscrr || !g_pscrr->ops || !g_pscrr->ops->write_reason)
+		return NOTIFY_DONE;
+
+	ret = g_pscrr->ops->write_reason(g_pscrr->last_reason);
+	if (ret) {
+		pr_err("PSCRR: Failed to store reason %d (%s) at reboot, err=%pe\n",
+		       g_pscrr->last_reason,
+		       pscrr_reason_to_str(g_pscrr->last_reason),
+		       ERR_PTR(ret));
+	} else {
+		pr_info("PSCRR: Stored reason %d (%s) at reboot.\n",
+			g_pscrr->last_reason,
+			pscrr_reason_to_str(g_pscrr->last_reason));
+	}
+
+	/*
+	 * Return NOTIFY_OK to allow reboot to proceed despite failure, in
+	 * case there is any.
+	 */
+	return NOTIFY_OK;
+}
+
+/**
+ * set_power_state_change_reason - Sets the power state change reason for
+ *				   reboot.
+ * @reason: The `pscr_reason` enum value indicating the reason for reboot.
+ *
+ * This function updates the last recorded power state change reason, which will
+ * be stored in persistent storage when the system reboots. It allows various
+ * subsystems (e.g., power management, thermal management) to indicate the cause
+ * of a system reset.
+ *
+ * The reason is only updated if the PSCRR core is initialized.
+ */
+void set_power_state_change_reason(enum pscr_reason reason)
+{
+	if (g_pscrr)
+		g_pscrr->last_reason = reason;
+}
+EXPORT_SYMBOL_GPL(set_power_state_change_reason);
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
+ * The returned value is formatted as an integer (`enum pscr_reason`) followed
+ * by a newline (`\n`) for compatibility with standard sysfs behavior.
+ *
+ * Return:
+ * - Number of bytes written to `buf` (formatted integer string).
+ * - `"No backend registered\n"` if the PSCRR subsystem is uninitialized.
+ */
+static ssize_t reason_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	enum pscr_reason r;
+
+	if (!g_pscrr || !g_pscrr->ops)
+		return scnprintf(buf, PAGE_SIZE, "No backend registered\n");
+
+	/* If the backend can read from hardware, do so. Otherwise, use our cached value. */
+	if (g_pscrr->ops->read_reason) {
+		if (g_pscrr->ops->read_reason(&r) == 0) {
+			/* Also update our cached value for consistency */
+			g_pscrr->last_reason = r;
+		} else {
+			/* If read fails, fallback to cached. */
+			r = g_pscrr->last_reason;
+		}
+	} else {
+		r = g_pscrr->last_reason;
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
+	int ret;
+	long val;
+
+	if (!g_pscrr || !g_pscrr->ops || !g_pscrr->ops->write_reason)
+		return -ENODEV;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < PSCR_UNKNOWN || val > PSCR_MAX_REASON)
+		/*
+		 * Log a warning, but still attempt to write the value. In
+		 * case the backend can handle it, we don't want to block it.
+		 */
+		pr_warn("PSCRR: writing unknown reason %ld (out of range)\n",
+			val);
+
+	ret = g_pscrr->ops->write_reason((enum pscr_reason)val);
+	if (ret) {
+		pr_err("PSCRR: write_reason(%ld) failed, err=%d\n", val, ret);
+		return ret;
+	}
+
+	g_pscrr->last_reason = (enum pscr_reason)val;
+
+	return count; /* number of bytes consumed */
+}
+
+static struct kobj_attribute reason_attr = __ATTR(reason, 0664, reason_show,
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
+ * The returned value is formatted as an integer (`enum pscr_reason`) followed
+ * by a newline (`\n`) for sysfs compatibility.
+ *
+ * Return:
+ * - Number of bytes written to `buf` (formatted integer string).
+ * - `-ENODEV` if the PSCRR backend is not initialized.
+ */
+static ssize_t reason_boot_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	if (!g_pscrr)
+		return -ENODEV;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", g_pscrr->last_boot_reason);
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
+	enum pscr_reason stored_val;
+	int err;
+
+	if (g_pscrr) {
+		pr_err("PSCRR: Core is already initialized!\n");
+		return -EBUSY;
+	}
+
+
+	if (!ops->read_reason || !ops->write_reason) {
+		pr_err("PSCRR: Backend must provide read and write callbacks\n");
+		return -EINVAL;
+	}
+
+	g_pscrr = kzalloc(sizeof(*g_pscrr), GFP_KERNEL);
+	if (!g_pscrr)
+		return -ENOMEM;
+
+	g_pscrr->ops = ops;
+	g_pscrr->last_reason = PSCR_UNKNOWN;
+	g_pscrr->last_boot_reason = PSCR_UNKNOWN;
+
+	err = ops->read_reason(&stored_val);
+	if (!err) {
+		g_pscrr->last_boot_reason = stored_val;
+		pr_info("PSCRR: Initial read_reason: %d (%s)\n",
+			stored_val, pscrr_reason_to_str(stored_val));
+	} else {
+		pr_warn("PSCRR: read_reason failed, err=%pe\n",
+			ERR_PTR(err));
+	}
+
+	/* Setup the reboot notifier */
+	g_pscrr->reboot_nb.notifier_call = pscrr_reboot_notifier;
+	err = register_reboot_notifier(&g_pscrr->reboot_nb);
+	if (err) {
+		pr_err("PSCRR: Failed to register reboot notifier, err=%pe\n",
+		       ERR_PTR(err));
+		goto err_free;
+	}
+
+	/* Create a kobject and sysfs group under /sys/kernel/pscrr */
+	g_pscrr->kobj = kobject_create_and_add("pscrr", kernel_kobj);
+	if (!g_pscrr->kobj) {
+		pr_err("PSCRR: Failed to create /sys/kernel/pscrr\n");
+		err = -ENOMEM;
+		goto err_unreg_reboot;
+	}
+
+	err = sysfs_create_group(g_pscrr->kobj, &pscrr_attr_group);
+	if (err) {
+		pr_err("PSCRR: Failed to create sysfs group, err=%pe\n",
+		       ERR_PTR(err));
+		goto err_kobj_put;
+	}
+
+	pr_info("PSCRR: initialized successfully.\n");
+	return 0;
+
+err_kobj_put:
+	kobject_put(g_pscrr->kobj);
+err_unreg_reboot:
+	unregister_reboot_notifier(&g_pscrr->reboot_nb);
+err_free:
+	kfree(g_pscrr);
+	g_pscrr = NULL;
+	return err;
+}
+EXPORT_SYMBOL_GPL(pscrr_core_init);
+
+void pscrr_core_exit(void)
+{
+	if (!g_pscrr)
+		return;
+
+	sysfs_remove_group(g_pscrr->kobj, &pscrr_attr_group);
+	kobject_put(g_pscrr->kobj);
+
+	unregister_reboot_notifier(&g_pscrr->reboot_nb);
+
+	kfree(g_pscrr);
+	g_pscrr = NULL;
+	pr_info("PSCRR: exited.\n");
+}
+EXPORT_SYMBOL_GPL(pscrr_core_exit);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Power State Change Reason Recording (PSCRR) core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pscrr.h b/include/linux/pscrr.h
new file mode 100644
index 000000000000..2b8f4f1d475b
--- /dev/null
+++ b/include/linux/pscrr.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pscrr.h - Public header for Power State Change Reason Recording (PSCRR).
+ */
+
+#ifndef __PSCRR_H__
+#define __PSCRR_H__
+
+/*
+ * enum pscr - Enumerates reasons for power state changes.
+ *
+ * This enum lists the various reasons why a power state change might
+ * occur in a system. Each value represents a specific condition that
+ * could trigger a change in power state, such as shutdown or reboot.
+ *
+ * PSCR_UNKNOWN: Represents an unknown or unspecified reason.
+ * PSCR_UNDER_VOLTAGE: Indicates a power state change due to under-voltage.
+ * PSCR_OVER_CURRENT: Indicates a power state change due to over-current.
+ * PSCR_REGULATOR_FAILURE: Indicates a failure in a voltage regulator.
+ * PSCR_OVERTEMPERATURE: Indicates an over-temperature condition.
+ */
+enum pscr_reason {
+	PSCR_UNKNOWN,
+	PSCR_UNDER_VOLTAGE,
+	PSCR_OVER_CURRENT,
+	PSCR_REGULATOR_FAILURE,
+	PSCR_OVERTEMPERATURE,
+	PSCR_REASON_COUNT,
+};
+
+#define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)
+
+/**
+ * struct pscrr_backend_ops - Backend operations for storing power state change
+ *			      reasons.
+ *
+ * This structure defines the interface for backend implementations that handle
+ * the persistent storage of power state change reasons. Different backends
+ * (e.g., NVMEM, EEPROM, battery-backed RAM) can implement these operations to
+ * store and retrieve shutdown reasons across reboots.
+ *
+ * @write_reason: Function pointer to store the specified `pscr_reason` in
+ *		  persistent storage. This function is called before a reboot
+ *		  to record the last power state change reason.
+ * @read_reason:  Function pointer to retrieve the last stored `pscr_reason`
+ *		  from persistent storage. This function is called at boot to
+ *		  restore the shutdown reason.
+ */
+struct pscrr_backend_ops {
+	int (*write_reason)(enum pscr_reason reason);
+	int (*read_reason)(enum pscr_reason *reason);
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
+#if IS_ENABLED(CONFIG_PSCRR)
+
+/**
+ * set_power_state_change_reason - Record reason for next reboot/shutdown
+ * @reason: The enumerated reason code to record
+ *
+ * Other drivers (e.g. regulator, thermal) call this whenever they detect
+ * a condition that may lead to or cause a reboot.
+ */
+void set_power_state_change_reason(enum pscr_reason reason);
+
+#else
+
+static inline void set_power_state_change_reason(enum pscr_reason pscr)
+{
+}
+#endif
+
+#endif /* __PSCRR_H__ */
-- 
2.39.5


