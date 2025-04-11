Return-Path: <linux-pm+bounces-25252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547AA85D01
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787BA9A6360
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67429C336;
	Fri, 11 Apr 2025 12:18:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649629C328
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373919; cv=none; b=ebPDupBY14yl2bJ1FINaq6qircgrxZnAQSSiWEr+Gay2LeORt8TnT20+X4JqTtW/2DEUoy1GCjwYv52FzO3ir1r2Rfy3rh70uECMKtw1BUy2UrIFhdy8S9GdXBO0rcq2IFBAOqQr5C3vflTtzEaD9gmxQ6+EkF7CjjWk5nRNyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373919; c=relaxed/simple;
	bh=saHhgzILLYYRrBS9mwBgPqLZuuaZobYrDkh2JOgxy68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ya0GpXaJ5O43QgHDp84cuafQCIViGaXGoSAq/b8JfkEW8Fw0nN57cntRtyryWt/nZ6ReNrThhO5tTVEZVeJB9sCW7DsTopMLT3y2G6m4YCFxYsNbkXTO1N8WE1nCWYqIeZuPQZYr2elEk9R5Xd8cikH+skcehTOdfRkq8Xr4aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKZ-0006JS-Fu; Fri, 11 Apr 2025 14:17:59 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-004QkV-1i;
	Fri, 11 Apr 2025 14:17:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-002PBY-1R;
	Fri, 11 Apr 2025 14:17:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v8 2/7] reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
Date: Fri, 11 Apr 2025 14:17:52 +0200
Message-Id: <20250411121757.573419-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411121757.573419-1-o.rempel@pengutronix.de>
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Prepares the kernel for the Power State Change Reason (PSCR) recorder,
which will store shutdown and reboot reasons in persistent storage.

Instead of using string-based reason descriptions, which are often too
large to fit within limited storage spaces (e.g., RTC clocks with only 8
bits of battery-backed storage), we introduce `enum psc_reason`. This
enumerates predefined reasons for power state changes, making it
efficient to store and retrieve shutdown causes.

Key changes:
- Introduced `enum psc_reason`, defining structured reasons for power state
  changes.
- Replaced string-based shutdown reasons with `psc_reason` identifiers.
- Implemented `get_psc_reason()` and `set_psc_reason()` for tracking the
  last shutdown cause.
- Added `psc_reason_to_str()` to map enum values to human-readable strings.
- Updated `hw_protection_trigger()` to use `psc_reason` instead of string
  parameters.
- Updated all consumers of `hw_protection_trigger()` to pass an appropriate
  `psc_reason` value instead
  of a string.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
changes v8:
- add Acked/Reviewed-by.
changes v6:
- added in this version
---
 drivers/platform/chrome/cros_ec_lpc.c |  2 +-
 drivers/regulator/core.c              |  7 ++-
 drivers/regulator/irq_helpers.c       | 22 ++++---
 drivers/thermal/thermal_core.c        |  3 +-
 include/linux/reboot.h                | 77 ++++++++++++++++++++++-
 kernel/reboot.c                       | 89 +++++++++++++++++++++++++--
 6 files changed, 182 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7d9a78289c96..20d792f99f13 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -455,7 +455,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
 		/* Begin orderly shutdown. EC will force reset after a short period. */
-		__hw_protection_trigger("CrOS EC Panic", -1, HWPROT_ACT_SHUTDOWN);
+		__hw_protection_trigger(PSCR_EC_PANIC, -1, HWPROT_ACT_SHUTDOWN);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 90629a756693..a5b1bdbc2134 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5263,6 +5263,7 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 static void regulator_handle_critical(struct regulator_dev *rdev,
 				      unsigned long event)
 {
+	enum psc_reason pscr;
 	const char *reason = NULL;
 
 	if (!rdev->constraints->system_critical)
@@ -5271,18 +5272,22 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
 	switch (event) {
 	case REGULATOR_EVENT_UNDER_VOLTAGE:
 		reason = "System critical regulator: voltage drop detected";
+		pscr = PSCR_UNDER_VOLTAGE;
 		break;
 	case REGULATOR_EVENT_OVER_CURRENT:
 		reason = "System critical regulator: over-current detected";
+		pscr = PSCR_OVER_CURRENT;
 		break;
 	case REGULATOR_EVENT_FAIL:
 		reason = "System critical regulator: unknown error";
+		pscr = PSCR_REGULATOR_FAILURE;
 	}
 
 	if (!reason)
 		return;
 
-	hw_protection_trigger(reason,
+	rdev_crit(rdev, "%s\n", reason);
+	hw_protection_trigger(pscr,
 			      rdev->constraints->uv_less_critical_window_ms);
 }
 
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5742faee8071..31395a912341 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -63,17 +63,22 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 
 reread:
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
-		if (!d->die)
-			return hw_protection_trigger("Regulator HW failure? - no IC recovery",
+		if (!d->die) {
+			pr_crit("Regulator HW failure? - no IC recovery\n");
+			return hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+		}
+
 		ret = d->die(rid);
 		/*
 		 * If the 'last resort' IC recovery failed we will have
 		 * nothing else left to do...
 		 */
-		if (ret)
-			return hw_protection_trigger("Regulator HW failure. IC recovery failed",
+		if (ret) {
+			pr_crit("Regulator HW failure. IC recovery failed\n");
+			return hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+		}
 
 		/*
 		 * If h->die() was implemented we assume recovery has been
@@ -263,14 +268,17 @@ static irqreturn_t regulator_notifier_isr(int irq, void *data)
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
 		/* If we have no recovery, just try shut down straight away */
 		if (!d->die) {
-			hw_protection_trigger("Regulator failure. Retry count exceeded",
+			pr_crit("Regulator failure. Retry count exceeded\n");
+			hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 					      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		} else {
 			ret = d->die(rid);
 			/* If die() failed shut down as a last attempt to save the HW */
-			if (ret)
-				hw_protection_trigger("Regulator failure. Recovery failed",
+			if (ret) {
+				pr_crit("Regulator failure. Recovery failed\n");
+				hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+			}
 		}
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 17ca5c082643..9f13213f0722 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -377,11 +377,10 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz,
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
-	const char *msg = "Temperature too high";
 
 	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
-	__hw_protection_trigger(msg, poweroff_delay_ms, action);
+	__hw_protection_trigger(PSCR_OVER_TEMPERATURE, poweroff_delay_ms, action);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index aa08c3bbbf59..6477910c6a9e 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -178,6 +178,73 @@ void ctrl_alt_del(void);
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 
+
+/**
+ * enum psc_reason - Enumerates reasons for power state changes.
+ *
+ * This enum defines various reasons why a system might transition into a
+ * shutdown, reboot, or kexec state. While originally intended for hardware
+ * protection events, `psc_reason` can be extended to track other system
+ * transitions, such as controlled reboots triggered by software or
+ * maintenance operations.
+ *
+ * The values in this enumeration provide structured and standardized
+ * identifiers that replace free-form string descriptions. They are designed
+ * to be stored efficiently, making them suitable for use in environments
+ * with limited storage, such as battery-backed RTC registers, non-volatile
+ * memory, or bootloader communication mechanisms.
+ *
+ * Importantly, the order of these values **must remain stable**, as
+ * bootloaders, user-space tools, or post-mortem investigation utilities
+ * may rely on their numerical representation for consistent behavior.
+ *
+ * @PSCR_UNKNOWN: Unknown or unspecified reason for the power state change.
+ *	This value serves as a default when no explicit cause is recorded.
+ *
+ * @PSCR_UNDER_VOLTAGE: Shutdown or reboot triggered due to supply voltage
+ *      dropping below a safe threshold. This helps prevent instability or
+ *      corruption caused by insufficient power.
+ *
+ * @PSCR_OVER_CURRENT: System shutdown or reboot due to excessive current draw,
+ *      which may indicate a short circuit, an overloaded power rail, or other
+ *      hardware faults requiring immediate action.
+ *
+ * @PSCR_REGULATOR_FAILURE: A critical failure in a voltage regulator, causing
+ *      improper power delivery. This may be due to internal component failure,
+ *      transient conditions, or external load issues requiring mitigation.
+ *
+ * @PSCR_OVER_TEMPERATURE: System shutdown or reboot due to excessive thermal
+ *	conditions. This attempts to prevent hardware damage when temperature
+ *	sensors detect unsafe levels, often impacting CPUs, GPUs, or power
+ *	components.
+ *
+ * @PSCR_EC_PANIC: Shutdown or reboot triggered by an Embedded Controller (EC)
+ *	panic. The EC is a microcontroller responsible for low-level system
+ *	management, including power sequencing, thermal control, and battery
+ *	management. An EC panic may indicate critical firmware issues, power
+ *	management errors, or an unrecoverable hardware fault requiring
+ *	immediate response.
+ *
+ * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
+ *	value is useful for range checking and potential future extensions
+ *	while maintaining compatibility.
+ */
+enum psc_reason {
+	PSCR_UNKNOWN,
+	PSCR_UNDER_VOLTAGE,
+	PSCR_OVER_CURRENT,
+	PSCR_REGULATOR_FAILURE,
+	PSCR_OVER_TEMPERATURE,
+	PSCR_EC_PANIC,
+
+	/* Number of reasons */
+	PSCR_REASON_COUNT,
+};
+
+#define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)
+
+const char *psc_reason_to_str(enum psc_reason reason);
+
 /**
  * enum hw_protection_action - Hardware protection action
  *
@@ -191,13 +258,13 @@ extern void orderly_reboot(void);
  */
 enum hw_protection_action { HWPROT_ACT_DEFAULT, HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
 
-void __hw_protection_trigger(const char *reason, int ms_until_forced,
+void __hw_protection_trigger(enum psc_reason reason, int ms_until_forced,
 			     enum hw_protection_action action);
 
 /**
  * hw_protection_trigger - Trigger default emergency system hardware protection action
  *
- * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @reason:		Reason of emergency shutdown or reboot.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
  *			triggering it. Negative value disables the forced
  *			shutdown or reboot.
@@ -206,11 +273,15 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
  * hardware from further damage. The exact action taken is controllable at
  * runtime and defaults to shutdown.
  */
-static inline void hw_protection_trigger(const char *reason, int ms_until_forced)
+static inline void hw_protection_trigger(enum psc_reason reason,
+					 int ms_until_forced)
 {
 	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_DEFAULT);
 }
 
+enum psc_reason get_psc_reason(void);
+void set_psc_reason(enum psc_reason reason);
+
 /*
  * Emergency restart, callable from an interrupt handler.
  */
diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..7e9a1a2df66a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/power/power_on_reason.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -49,6 +50,7 @@ int reboot_default = 1;
 int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
+enum psc_reason psc_last_reason = PSCR_UNKNOWN;
 
 struct sys_off_handler {
 	struct notifier_block nb;
@@ -1010,10 +1012,86 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
 			      msecs_to_jiffies(action_delay_ms));
 }
 
+/**
+ * get_psc_reason - Retrieve the last recorded power state change reason.
+ *
+ * This function returns the most recent power state change reason stored
+ * in `psc_last_reason`. The value is set using `set_psc_reason()` when a
+ * shutdown, reboot, or kexec event occurs.
+ *
+ * The reason can be used for system diagnostics, post-mortem analysis, or
+ * debugging unexpected power state changes. Bootloaders or user-space tools
+ * may retrieve this value to determine why the system last transitioned to
+ * a new power state.
+ *
+ * Return: A value from `enum psc_reason`, indicating the last known power
+ * state change reason.
+ */
+enum psc_reason get_psc_reason(void)
+{
+	return READ_ONCE(psc_last_reason);
+}
+EXPORT_SYMBOL_GPL(get_psc_reason);
+
+/**
+ * set_psc_reason - Set the reason for the last power state change.
+ *
+ * @reason: A value from `enum psc_reason` indicating the cause of the power
+ *          state change.
+ *
+ * This function records the reason for a shutdown, reboot, or kexec event
+ * by storing it in `psc_last_reason`. It ensures that the value remains
+ * consistent within the running system, allowing retrieval via
+ * `get_psc_reason()` for diagnostics, logging, or post-mortem analysis.
+ *
+ * Persistence Consideration:
+ * - This function **does not persist** the recorded reason across power cycles.
+ * - After a system reset or complete power loss, the recorded reason is lost.
+ * - To store power state change reasons persistently, additional tools such as
+ *   the Power State Change Reason Recorder (PSCRR) framework should be used.
+ */
+void set_psc_reason(enum psc_reason reason)
+{
+	WRITE_ONCE(psc_last_reason, reason);
+}
+EXPORT_SYMBOL_GPL(set_psc_reason);
+
+/**
+ * psc_reason_to_str - Converts a power state change reason enum to a string.
+ * @reason: The `psc_reason` enum value to be converted.
+ *
+ * This function provides a human-readable string representation of the power
+ * state change reason, making it easier to interpret logs and debug messages.
+ *
+ * Return:
+ * - A string corresponding to the given `psc_reason` value.
+ * - `"Invalid"` if the value is not recognized.
+ */
+const char *psc_reason_to_str(enum psc_reason reason)
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
+	case PSCR_OVER_TEMPERATURE:
+		return POWER_ON_REASON_OVER_TEMPERATURE;
+	case PSCR_EC_PANIC:
+		return POWER_ON_REASON_EC_PANIC;
+	default:
+		return "Invalid";
+	}
+}
+EXPORT_SYMBOL_GPL(psc_reason_to_str);
+
 /**
  * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *
- * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @reason:		Reason of emergency shutdown or reboot.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
  *			triggering it. Negative value disables the forced
  *			shutdown or reboot.
@@ -1025,7 +1103,7 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_trigger(const char *reason, int ms_until_forced,
+void __hw_protection_trigger(enum psc_reason reason, int ms_until_forced,
 			     enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
@@ -1033,8 +1111,11 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
 	if (action == HWPROT_ACT_DEFAULT)
 		action = hw_protection_action;
 
-	pr_emerg("HARDWARE PROTECTION %s (%s)\n",
-		 hw_protection_action_str(action), reason);
+	set_psc_reason(reason);
+
+	pr_emerg("HARDWARE PROTECTION %s: %i (%s)\n",
+		 hw_protection_action_str(action), reason,
+		 psc_reason_to_str(reason));
 
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))
-- 
2.39.5


