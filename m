Return-Path: <linux-pm+bounces-4335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F08616AC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E531C21038
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1581AD3;
	Fri, 23 Feb 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9ItCKQr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D486E618
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704025; cv=none; b=TDKmYLRT3X+NiJtL4+wDep+lxWrxPvyaEt5uxYFonYAY+YUTj6z8vmxvZrdM7KlhBM97nDOUusL/1X/z/V/CJH0/zV94hZFpYZiebCn7FnqV4I9yYgoP+fCfHSitCSHLUgAhD+83Epw6AREBhXQSteAE6Nuo8Ac99a7CJvmi6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704025; c=relaxed/simple;
	bh=/H84Yr/tvo2ppCHDCDXjFpzdcWymEVLMY+DGEKgYOCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GK0lPyNMu5PKVWon6SoCymVgMnGh9t9ccNYyQIF60xmTBBT/EejklW7zLrEYMdHj4r1glDQgiwXOsGYu5EZ084S2PfJJezSRC9IuMxnDLJPj2rutkTK4RcaW65ajkoM5CIMuiWoLno+sMZ2Eh0L30x+XuGrJ0ueRJGwN8jAuiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9ItCKQr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704024; x=1740240024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/H84Yr/tvo2ppCHDCDXjFpzdcWymEVLMY+DGEKgYOCg=;
  b=Y9ItCKQr8WGNHGqxAgRgpPI/+/L9Av56eh6wN8aUYJRFOd927zD9oDbY
   sBbzMv+iQSjjJP60t0jYehxBdE09wtgbGYiYR8b7A4YbqM99sWGwuNyIE
   +X4VCxt7OBbKmLL+UIoi7WDRWPr2RuAHF6rbeNaaEl5DhOjVrS3gzqT31
   T43v9D00jqcjOU699w0s8iYeiaVdSC4v+RBOts+WsDJIvMZpJnCv/9Jg+
   b2FpvIfnDYX5SYTpVYerTTl8jYUf4X0lXbnVxFp2unZouyoBy5PVtfORm
   nsymhqcYlXk/2YvpXkT+LchhpR3pfpahSFXAGr1NiFAYh/a9Is9A0a3UM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13724161"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13724161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6309317"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.110])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:57 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v5 3/3] thermal: intel: hfi: Enable interface only when required
Date: Fri, 23 Feb 2024 16:59:42 +0100
Message-Id: <20240223155942.60813-4-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
References: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
and hfi_disable_instance(), which can be called from the netlink notifier
callback and suspend/resume callbacks.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 97 ++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3b04c6ec4fca..6a596a6b8329 100644
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
-- 
2.34.1


