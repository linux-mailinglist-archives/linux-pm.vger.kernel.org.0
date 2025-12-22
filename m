Return-Path: <linux-pm+bounces-39811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CDCD71B6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AF3E3023A10
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89084347BBB;
	Mon, 22 Dec 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KouQRqVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FF347BA8;
	Mon, 22 Dec 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435900; cv=none; b=EtNVTjQ56FqMn9dXNklZTIqbp9Zdoxx/a+rBGpe38tJttv0K3UY5judm8SmEqniWHlJnKWnyMjaP594SktxgnFYt+1t7MrdyKpuLi+K9OEGtQev7r4i/nRPfrPzubVrEHgz1X+J+mBXVVM2NfLeC5QRuwgNm+e3OblBUlg1HMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435900; c=relaxed/simple;
	bh=bg6qNCsf46yjQR+W4i7aCIbrsapW96xa5ysgoxgK0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIwU4d+5jB93+2XAEsVd/Mv7uI31EsnnSmz0471jwOis4ZxU9PZ/GvK9QNzyoDNgA1x0M1lPotN5ZMZoOxHCZjnFD9i4qG1UxD8/og1Z9hFY+HM3K2RKadlvCFw9A2BuFy8w6qspD3RSCJ1NXWr6x0ggapaIQp9KTSJHGVhbwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KouQRqVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882AC4CEF1;
	Mon, 22 Dec 2025 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435899;
	bh=bg6qNCsf46yjQR+W4i7aCIbrsapW96xa5ysgoxgK0r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KouQRqVa9zOUD3opuetOYTu1y/SlRfOPCxYa8IJZCS4WPQ+XM5diQyt2cQp5j/uXQ
	 0MQzos+mm5VhDrM7L8vQGsU4sOwhOFBVzw0vFyfVU/fYiBfBpI0nF82IM/N+KoiQ80
	 z+KMyc4rEwP5YUtbRe8f8ifHsU56VgoXBckpI+cb5Qx9x8WebfkDbZCezoHCdE856r
	 5ZaaO7aSsTbl3eG5Oe8IjUyx+zW6RZE5gCbUSMm486UKQVTLmaFyVAMfaNgiUDr1Ve
	 xRhxi6jpBoVtQGkjeTVkvDhwpKPO1dMPHdyOwMzC3k8Cv8f0azRXAXicc07fS6v8+S
	 Jk9hQVhE/f9Aw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>
Subject:
 [PATCH v1 01/23] genirq/chip: Change irq_chip_pm_put() return type to void
Date: Mon, 22 Dec 2025 20:50:10 +0100
Message-ID: <4723896.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
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

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

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
+ * not disable power at all (which may be prefented by user space, for example).
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




