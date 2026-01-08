Return-Path: <linux-pm+bounces-40467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E82DD03D03
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB307300B348
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC2346AC6;
	Thu,  8 Jan 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqliWBhc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E93469EF;
	Thu,  8 Jan 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884742; cv=none; b=suf+P5Ig6lVSj76YqYcJ0ogiEK20cph8x0zPFl6u7fe1kXI2Dr5scomt1s6KrZbuZpz6tmmYf4O5Nsc6j1aHkq/uJSzi46r2VlK/sOauHBq6oANwDVDyiLE5AYqJMxBiu0nWuvmdwLzCIpUH1eCrEeTmvAkTlI4EjaWizrVzCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884742; c=relaxed/simple;
	bh=R0fTKDCa8xhF7V5q8TY77wd3fWvEGzFAiYFUa9s0Vuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lbQ1afG3/phO7stRAB5P01U7onLqtEjUcEpYxa8qQIiuuvhnC6nAJafQpRutQ8nf9MogHmeLn6cKoVEzi3bvBTTLswPlk6e/HdXBxVBpvuQtlbMrmKxe/4L7UIVk8NsGLrqnKonnX9sVGJ3P+vXdhc/kpMP9FJhI21au6zfGZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqliWBhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C6C19422;
	Thu,  8 Jan 2026 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884742;
	bh=R0fTKDCa8xhF7V5q8TY77wd3fWvEGzFAiYFUa9s0Vuc=;
	h=From:To:Cc:Subject:Date:From;
	b=LqliWBhcFTCt6EnDLXoa4NRQqBI4jbdJDAIkAY5t1jiB3c2xG6yeakPFq+yK93pZ7
	 +CczqO7l2Uq73D9+vppUd0BP7r0JIwJPCyHc3cjFZIlpRc3RJVXVuWOFpndrcj9VFy
	 xe5vsjsc8n5D9+PwSbkGf9EldBxBQFA9ebyVlwiI7CgrzUi7HXoTU0Oep3ye5LMuAg
	 LjImsBdK362E8fj3A+tCzoHWM1xktrJ0zv7y180tCmp3TQoPmlppreXnGX//K91yV6
	 8KZSIrNb3yfmJZYU111xt5GndhcKNeNqnE1ui/P5PK3BPCceXNXnYRhsFb8a7I5bsU
	 3FR8grnju+tcA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Molnar Ingo <mingo@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jon Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] genirq/chip: Change irq_chip_pm_put() return type to void
Date: Thu, 08 Jan 2026 16:05:37 +0100
Message-ID: <5075294.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The irq_chip_pm_put() return value is only used in __irq_do_set_handler()
to trigger a WARN_ON() if it is negative, but doing so is not useful
because irq_chip_pm_put() simply passes the pm_runtime_put() return value
to its callers.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

For this reason, modify irq_chip_pm_put() to discard the pm_runtime_put()
return value, change its return type to void, and drop the WARN_ON()
around the irq_chip_pm_put() invocation from __irq_do_set_handler().
Also update the irq_chip_pm_put() kerneldoc comment to be more accurate.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is requisite for converting pm_runtime_put() into a void
function.

If you decide to pick it up, please let me know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

The v1 is here:

https://lore.kernel.org/linux-pm/4723896.LvFx2qVVIh@rafael.j.wysocki/

v1 -> v2:
   * Fix a typo in the new part of the irq_chip_pm_put() kerneldoc comment
     and rephrase it slightly.

---
 include/linux/irq.h |    2 +-
 kernel/irq/chip.c   |   22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -659,7 +659,7 @@ extern void handle_percpu_devid_fasteoi_
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
-extern int irq_chip_pm_put(struct irq_data *data);
+extern void irq_chip_pm_put(struct irq_data *data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void handle_fasteoi_ack_irq(struct irq_desc *desc);
 extern void handle_fasteoi_mask_irq(struct irq_desc *desc);
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -995,7 +995,7 @@ __irq_do_set_handler(struct irq_desc *de
 		irq_state_set_disabled(desc);
 		if (is_chained) {
 			desc->action = NULL;
-			WARN_ON(irq_chip_pm_put(irq_desc_get_irq_data(desc)));
+			irq_chip_pm_put(irq_desc_get_irq_data(desc));
 		}
 		desc->depth = 1;
 	}
@@ -1551,20 +1551,20 @@ int irq_chip_pm_get(struct irq_data *dat
 }
 
 /**
- * irq_chip_pm_put - Disable power for an IRQ chip
+ * irq_chip_pm_put - Drop a PM reference on an IRQ chip
  * @data:	Pointer to interrupt specific data
  *
- * Disable the power to the IRQ chip referenced by the interrupt data
- * structure, belongs. Note that power will only be disabled, once this
- * function has been called for all IRQs that have called irq_chip_pm_get().
+ * Drop a power management reference, acquired via irq_chip_pm_get(), on the IRQ
+ * chip represented by the interrupt data structure.
+ *
+ * Note that this will not disable power to the IRQ chip until this function
+ * has been called for all IRQs that have called irq_chip_pm_get() and it may
+ * not disable power at all (if user space prevents that, for example).
  */
-int irq_chip_pm_put(struct irq_data *data)
+void irq_chip_pm_put(struct irq_data *data)
 {
 	struct device *dev = irq_get_pm_device(data);
-	int retval = 0;
-
-	if (IS_ENABLED(CONFIG_PM) && dev)
-		retval = pm_runtime_put(dev);
 
-	return (retval < 0) ? retval : 0;
+	if (dev)
+		pm_runtime_put(dev);
 }




