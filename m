Return-Path: <linux-pm+bounces-7844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67A8C4F83
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CD5281D7D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E51411C2;
	Tue, 14 May 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLU7lTaz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7I+fc7h8"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14213FD65
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681947; cv=none; b=KiR6veC2eEJiwaQ8PWOQGFXPddWTZo534FcTq1mPYsavoLnfuhRfKuV59zK/WTKBzSdMBzWyyFVcp9c8ITfuFyS6zALVT0yVJpQY9UqwQHJVMNC98fOYBGe+xOOt/+56fesIPAe+P9YQWdvEo+yc1Vr0nMNE1eP8uk21Afy9Ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681947; c=relaxed/simple;
	bh=3sIykLCXLNnQKWPz+Lc42z14/MaVVPql1+nUXJV8ZMM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ddU0rqy+6+VMxaLItXvgwfZaCtIZN7tD4K+rmaiLRftO7Oc5aIoR+McQbz8GLLq8IwMch0eYdQ4JnYTljKkdFbnZ9TWX9CIih9e//rnnsocS5MgzDfmtA2lCwhtDZIgyP/DcezN8GjCXJOIW6IDmguChEUJjCQV7hXyrLYkF+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pLU7lTaz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7I+fc7h8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V5nqonGXTzg1PTYj2lngB0Uu6BQce0wripvogN6RyrI=;
	b=pLU7lTazcMf6zlrYytw8uE1BDWsNgC+6lQauXVPSJlYFUrA0j1fVaKbsIPK4cxAUUvaiAk
	Tdp7dlYrrFb6hc691khSTCLVwxrJ1u4EWPOk6myRQavkIPxyIny1F4jzKNf7PJ+faH/2Vd
	+D4B6DKlfP/wMIHfCi2XFZy6Kq8oR/W5G/nmxjKNnLBA+10vbLdUCEJkr9AglbQBkW6FuE
	PU0bQOv/6/c6l07WfrqhOtXh0bAS2aC02Ce/Cb/C5tcBUdSNsWtICpx/8ulREXn0jpD0PY
	2ZY0IrKqR6H0YFWgi/XsjcFSC3HzdpIKkKcmqFJphb5jeNs2Sqneh0Vn2ruOCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V5nqonGXTzg1PTYj2lngB0Uu6BQce0wripvogN6RyrI=;
	b=7I+fc7h8z7Yz4BqQoY7p62YqAxPfaycTcRPuiXf7yyC5WzIy//WkL4QVUhMaMs5hXnsSAd
	EVSHclxIUDbw5VBA==
From: "thermal-bot for Stanislaw Gruszka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] thermal: intel: hfi: Enable HFI only when required
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193756.10875.8404713759324928045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     b33f3d2677b8ddd7a3aba2b02497422a1d2c2a01
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b33f3d2677b8ddd7a3aba2b02497422a1d2c2a01
Author:        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
AuthorDate:    Fri, 23 Feb 2024 16:59:42 +01:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 27 Mar 2024 14:50:26 +01:00

thermal: intel: hfi: Enable HFI only when required

Enable and disable hardware feedback interface (HFI) when user space
handler is present. For example, enable HFI, when intel-speed-select or
Intel Low Power daemon is running and subscribing to thermal netlink
events. When user space handlers exit or remove subscription for
thermal netlink events, disable HFI.

Summary of changes:

 - Register a thermal genetlink notifier

 - In the notifier, process THERMAL_NOTIFY_BIND and THERMAL_NOTIFY_UNBIND
   reason codes to count number of thermal event group netlink multicast
   clients. If thermal netlink group has any listener enable HFI on all
   packages. If there are no listener disable HFI on all packages.

- When CPU is online, instead of blindly enabling HFI, check if
  the thermal netlink group has any listener. This will make sure that
  HFI is not enabled by default during boot time.

- Actual processing to enable/disable matches what is done in
  suspend/resume callbacks. Create two functions hfi_enable_instance()
  and hfi_disable_instance(), which can be called from the netlink
  notifier callback and suspend/resume callbacks.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 97 +++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 40d664a..fbc7f0c 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -159,6 +159,7 @@ struct hfi_cpu_info {
 static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
 
 static int max_hfi_instances;
+static int hfi_clients_nr;
 static struct hfi_instance *hfi_instances;
 
 static struct hfi_features hfi_features;
@@ -477,8 +478,11 @@ void intel_hfi_online(unsigned int cpu)
 enable:
 	cpumask_set_cpu(cpu, hfi_instance->cpus);
 
-	/* Enable this HFI instance if this is its first online CPU. */
-	if (cpumask_weight(hfi_instance->cpus) == 1) {
+	/*
+	 * Enable this HFI instance if this is its first online CPU and
+	 * there are user-space clients of thermal events.
+	 */
+	if (cpumask_weight(hfi_instance->cpus) == 1 && hfi_clients_nr > 0) {
 		hfi_set_hw_table(hfi_instance);
 		hfi_enable();
 	}
@@ -573,18 +577,33 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
-static void hfi_do_enable(void)
+/*
+ * If concurrency is not prevented by other means, the HFI enable/disable
+ * routines must be called under hfi_instance_lock."
+ */
+static void hfi_enable_instance(void *ptr)
+{
+	hfi_set_hw_table(ptr);
+	hfi_enable();
+}
+
+static void hfi_disable_instance(void *ptr)
+{
+	hfi_disable();
+}
+
+static void hfi_syscore_resume(void)
 {
 	/* This code runs only on the boot CPU. */
 	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
 	struct hfi_instance *hfi_instance = info->hfi_instance;
 
 	/* No locking needed. There is no concurrency with CPU online. */
-	hfi_set_hw_table(hfi_instance);
-	hfi_enable();
+	if (hfi_clients_nr > 0)
+		hfi_enable_instance(hfi_instance);
 }
 
-static int hfi_do_disable(void)
+static int hfi_syscore_suspend(void)
 {
 	/* No locking needed. There is no concurrency with CPU offline. */
 	hfi_disable();
@@ -593,8 +612,58 @@ static int hfi_do_disable(void)
 }
 
 static struct syscore_ops hfi_pm_ops = {
-	.resume = hfi_do_enable,
-	.suspend = hfi_do_disable,
+	.resume = hfi_syscore_resume,
+	.suspend = hfi_syscore_suspend,
+};
+
+static int hfi_thermal_notify(struct notifier_block *nb, unsigned long state,
+			      void *_notify)
+{
+	struct thermal_genl_notify *notify = _notify;
+	struct hfi_instance *hfi_instance;
+	smp_call_func_t func = NULL;
+	unsigned int cpu;
+	int i;
+
+	if (notify->mcgrp != THERMAL_GENL_EVENT_GROUP)
+		return NOTIFY_DONE;
+
+	if (state != THERMAL_NOTIFY_BIND && state != THERMAL_NOTIFY_UNBIND)
+		return NOTIFY_DONE;
+
+	mutex_lock(&hfi_instance_lock);
+
+	switch (state) {
+	case THERMAL_NOTIFY_BIND:
+		if (++hfi_clients_nr == 1)
+			func = hfi_enable_instance;
+		break;
+	case THERMAL_NOTIFY_UNBIND:
+		if (--hfi_clients_nr == 0)
+			func = hfi_disable_instance;
+		break;
+	}
+
+	if (!func)
+		goto out;
+
+	for (i = 0; i < max_hfi_instances; i++) {
+		hfi_instance = &hfi_instances[i];
+		if (cpumask_empty(hfi_instance->cpus))
+			continue;
+
+		cpu = cpumask_any(hfi_instance->cpus);
+		smp_call_function_single(cpu, func, hfi_instance, true);
+	}
+
+out:
+	mutex_unlock(&hfi_instance_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hfi_thermal_nb = {
+	.notifier_call = hfi_thermal_notify,
 };
 
 void __init intel_hfi_init(void)
@@ -628,10 +697,22 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	/*
+	 * Both thermal core and Intel HFI can not be build as modules.
+	 * As kernel build-in drivers they are initialized before user-space
+	 * starts, hence we can not miss BIND/UNBIND events when applications
+	 * add/remove thermal multicast group to/from a netlink socket.
+	 */
+	if (thermal_genl_register_notifier(&hfi_thermal_nb))
+		goto err_nl_notif;
+
 	register_syscore_ops(&hfi_pm_ops);
 
 	return;
 
+err_nl_notif:
+	destroy_workqueue(hfi_updates_wq);
+
 err_nomem:
 	for (j = 0; j < i; ++j) {
 		hfi_instance = &hfi_instances[j];

