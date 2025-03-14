Return-Path: <linux-pm+bounces-24026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4297A6100D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CAF461F9C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B61FE470;
	Fri, 14 Mar 2025 11:36:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE91FE453
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952187; cv=none; b=KmN20LLJswhdbtCRwapNx1NLl0vHBupM559X236ncTtEk3NeCpfjRJ94CA7HqIwMtV9/9JUx20tbCrIQWeUcAalKp2wp7DPttnsKtGEgaYAvqiodIxsV4eA9ddhUsuKvztrKjc56G3uqDx83bvGMrxmX8Y/a5H0VrAIiVMVV8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952187; c=relaxed/simple;
	bh=bt9eeUG2BJh1cfC7p8x6xVrInMtRH4cNohZj2klFHNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTglFbZwcx7Gser0O80VeqREBPhmbEDjFIp+Kzfm5ODrUf1KIGZoBSHc4G485PMhUDDECkC/t4TGE6kOsr1Op756k3r+MsHt97gy9ZLH96glmYTglGD1bNSmknc9Vtc6z+84RBex06yfesA/6HkrlZrRekw9k0la9gI1zighXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kg-0007Na-QD; Fri, 14 Mar 2025 12:36:06 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-005h5s-21;
	Fri, 14 Mar 2025 12:36:05 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tt3Kf-007S6O-1k;
	Fri, 14 Mar 2025 12:36:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
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
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v6 3/7] power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
Date: Fri, 14 Mar 2025 12:36:00 +0100
Message-Id: <20250314113604.1776201-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314113604.1776201-1-o.rempel@pengutronix.de>
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
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
changes v6:
- move enum pscr_reason to kernel reboot core
- move reason storage to reboot core
- add locking
---
 drivers/power/reset/Kconfig  |  21 ++
 drivers/power/reset/Makefile |   1 +
 drivers/power/reset/pscrr.c  | 417 +++++++++++++++++++++++++++++++++++
 include/linux/pscrr.h        |  49 ++++
 4 files changed, 488 insertions(+)
 create mode 100644 drivers/power/reset/pscrr.c
 create mode 100644 include/linux/pscrr.h

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf3..b874a04698df 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -316,3 +316,24 @@ config POWER_MLXBF
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
 endif
+
+menuconfig PSCRR
+	bool "Power State Change Reasons Recording (PSCRR) Framework"
+	help
+	  Enables the Power State Change Reasons Recording (PSCRR) framework.
+
+	  This framework is designed to store reasons for system shutdowns or
+	  reboots,  like under voltage or software-triggered events, in
+	  non-volatile hardware storage. It is particularly useful for
+	  postmortem analysis, where traditional storage methods (like block
+	  devices or RAM) are not feasible due to immediate power-down
+	  requirements or insufficient power to retain data.
+
+	  This is useful for bootloaders or other early-stage system components
+	  to make recovery decisions based on the last known system state. Note
+	  that this framework does not track hardware-induced resets, such as
+	  system freezes, watchdog timeouts, or sudden power losses without
+	  controlled shutdown. It is primarily intended for controlled power
+	  state transitions.
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
index 000000000000..818a5935d007
--- /dev/null
+++ b/drivers/power/reset/pscrr.c
@@ -0,0 +1,417 @@
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
+ *       hw_protection_trigger(PSCR_OVERTEMPERATURE, ...);
+ *   - Or, userspace sets the reboot or shutdown reason:
+ *       echo 3 > /sys/kernel/pscrr/reason
+ *   - The reboot subsystem records the reason as variable.
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
+#include <linux/mutex.h>
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
+	enum psc_reason last_boot_reason;
+
+	/* Kobject for sysfs */
+	struct kobject *kobj;
+};
+
+static struct pscrr_data *g_pscrr;
+static DEFINE_MUTEX(pscrr_lock);
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
+	mutex_lock(&pscrr_lock);
+
+	if (!g_pscrr || !g_pscrr->ops || !g_pscrr->ops->write_reason) {
+		mutex_unlock(&pscrr_lock);
+		return NOTIFY_DONE;
+	}
+
+	ret = g_pscrr->ops->write_reason(get_psc_reason());
+	if (ret) {
+		pr_err("PSCRR: Failed to store reason %d (%s) at reboot, err=%pe\n",
+		       get_psc_reason(), psc_reason_to_str(get_psc_reason()),
+		       ERR_PTR(ret));
+	} else {
+		pr_info("PSCRR: Stored reason %d (%s) at reboot.\n",
+			get_psc_reason(), psc_reason_to_str(get_psc_reason()));
+	}
+
+	mutex_unlock(&pscrr_lock);
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
+	enum psc_reason r;
+
+	mutex_lock(&pscrr_lock);
+
+	if (!g_pscrr || !g_pscrr->ops) {
+		mutex_unlock(&pscrr_lock);
+		return scnprintf(buf, PAGE_SIZE, "No backend registered\n");
+	}
+
+	/* If the backend can read from hardware, do so. Otherwise, use our cached value. */
+	if (g_pscrr->ops->read_reason) {
+		if (g_pscrr->ops->read_reason(&r) == 0) {
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
+	mutex_unlock(&pscrr_lock);
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
+	long val;
+	int ret;
+
+	mutex_lock(&pscrr_lock);
+
+	if (!g_pscrr || !g_pscrr->ops || !g_pscrr->ops->write_reason) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret)
+		goto err_unlock;
+
+	if (val > U32_MAX) {
+		ret = -ERANGE;
+		goto err_unlock;
+	}
+
+	if (val < PSCR_UNKNOWN || val > PSCR_MAX_REASON)
+		/*
+		 * Log a warning, but still attempt to write the value. In
+		 * case the backend can handle it, we don't want to block it.
+		 */
+		pr_warn("PSCRR: writing unknown reason %ld (out of range)\n",
+			val);
+
+	ret = g_pscrr->ops->write_reason((enum psc_reason)val);
+	if (ret) {
+		pr_err("PSCRR: write_reason(%ld) failed, err=%d\n", val, ret);
+		goto err_unlock;
+	}
+
+	set_psc_reason((enum psc_reason)val);
+
+	mutex_unlock(&pscrr_lock);
+
+	return count; /* number of bytes consumed */
+
+err_unlock:
+	mutex_unlock(&pscrr_lock);
+	return ret;
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
+
+	mutex_lock(&pscrr_lock);
+
+	if (!g_pscrr) {
+		mutex_unlock(&pscrr_lock);
+		return -ENODEV;
+	}
+
+	last_boot_reason = g_pscrr->last_boot_reason;
+
+	mutex_unlock(&pscrr_lock);
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
+	int ret;
+
+	mutex_lock(&pscrr_lock);
+
+	if (g_pscrr) {
+		pr_err("PSCRR: Core is already initialized!\n");
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	if (!ops->read_reason || !ops->write_reason) {
+		pr_err("PSCRR: Backend must provide read and write callbacks\n");
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	g_pscrr = kzalloc(sizeof(*g_pscrr), GFP_KERNEL);
+	if (!g_pscrr) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	g_pscrr->ops = ops;
+	g_pscrr->last_boot_reason = PSCR_UNKNOWN;
+
+	ret = ops->read_reason(&stored_val);
+	if (!ret) {
+		g_pscrr->last_boot_reason = stored_val;
+		pr_info("PSCRR: Initial read_reason: %d (%s)\n",
+			stored_val, psc_reason_to_str(stored_val));
+	} else {
+		pr_warn("PSCRR: read_reason failed, err=%pe\n",
+			ERR_PTR(ret));
+	}
+
+	/* Setup the reboot notifier */
+	g_pscrr->reboot_nb.notifier_call = pscrr_reboot_notifier;
+	ret = register_reboot_notifier(&g_pscrr->reboot_nb);
+	if (ret) {
+		pr_err("PSCRR: Failed to register reboot notifier, err=%pe\n",
+		       ERR_PTR(ret));
+		goto err_free;
+	}
+
+	/* Create a kobject and sysfs group under /sys/kernel/pscrr */
+	g_pscrr->kobj = kobject_create_and_add("pscrr", kernel_kobj);
+	if (!g_pscrr->kobj) {
+		pr_err("PSCRR: Failed to create /sys/kernel/pscrr\n");
+		ret = -ENOMEM;
+		goto err_unreg_reboot;
+	}
+
+	ret = sysfs_create_group(g_pscrr->kobj, &pscrr_attr_group);
+	if (ret) {
+		pr_err("PSCRR: Failed to create sysfs group, err=%pe\n",
+		       ERR_PTR(ret));
+		goto err_kobj_put;
+	}
+
+	mutex_unlock(&pscrr_lock);
+
+	pr_info("PSCRR: initialized successfully.\n");
+
+	return 0;
+
+err_kobj_put:
+	kobject_put(g_pscrr->kobj);
+err_unreg_reboot:
+	unregister_reboot_notifier(&g_pscrr->reboot_nb);
+err_free:
+	kfree(g_pscrr);
+	g_pscrr = NULL;
+err_unlock:
+	mutex_unlock(&pscrr_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pscrr_core_init);
+
+void pscrr_core_exit(void)
+{
+	mutex_lock(&pscrr_lock);
+
+	if (!g_pscrr) {
+		mutex_unlock(&pscrr_lock);
+		return;
+	}
+
+	if (g_pscrr->kobj) {
+		sysfs_remove_group(g_pscrr->kobj, &pscrr_attr_group);
+		kobject_put(g_pscrr->kobj);
+	}
+
+	unregister_reboot_notifier(&g_pscrr->reboot_nb);
+
+	kfree(g_pscrr);
+	g_pscrr = NULL;
+
+	mutex_unlock(&pscrr_lock);
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
index 000000000000..f49c49144239
--- /dev/null
+++ b/include/linux/pscrr.h
@@ -0,0 +1,49 @@
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
+ *			      reasons.
+ *
+ * This structure defines the interface for backend implementations that handle
+ * the persistent storage of power state change reasons. Different backends
+ * (e.g., NVMEM, EEPROM, battery-backed RAM) can implement these operations to
+ * store and retrieve shutdown reasons across reboots.
+ *
+ * @write_reason: Function pointer to store the specified `psc_reason` in
+ *		  persistent storage. This function is called before a reboot
+ *		  to record the last power state change reason.
+ * @read_reason:  Function pointer to retrieve the last stored `psc_reason`
+ *		  from persistent storage. This function is called at boot to
+ *		  restore the shutdown reason.
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


