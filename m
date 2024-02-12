Return-Path: <linux-pm+bounces-3806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 751568518CE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6EFB21CE7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5383D0DB;
	Mon, 12 Feb 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5BVhsnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D03D0B6;
	Mon, 12 Feb 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754607; cv=none; b=X06jOD8o0pktG1LETK9Z4n/pQEg9Qou4RilhETK2oG6KE+hA42XtlqZzX7iNQDv2WS0wXK3Ju0Lt3DDhDfszEI793/1T6Nx+tDB8Dkyb+MdOeAKa98+LT5qOM0m73ixOOz0kxZnjsDYQ/1PIHVFI504wGs+0JWhapOjtjPLcPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754607; c=relaxed/simple;
	bh=7plR84WWRswcCrnNW4hL+hM3NAlvi40gEEuXirSUnpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzcLOJkQQzFfEveVX9gP1+yQ3PWpcFFbGLDd9qBp63DzTr0xAvFqv731W5oihhd0VBEkFPecBAsq9wa0UrnHBp8rloXey9/XuEn1CyszAkfkidbOL3DeFSd3TegmEkT1lJ9+IWJCpncwBWSkTHMLtHghxwfRCBtBxtdZI6BzZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5BVhsnB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707754606; x=1739290606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7plR84WWRswcCrnNW4hL+hM3NAlvi40gEEuXirSUnpQ=;
  b=L5BVhsnBTwOIWLkbp8En91KZK8fgl5rwZKRNQjBcifOs63BWDdM2yZSV
   W8n+gDr6qMMJZj4uQG3QAMmtdArq1k/nYnOLa1D74IaMyja5qJavhVJs6
   GWakUiZpMyj+i3EI8QonHATmpGMOnovB0dIZgXOyc6BJIrHfpmKl8ZXkX
   5mfuChvm43VoGuuucepZXRTMRkchC9tyNyBvvrb/SMtVQuAzioUrvDwjh
   y4yw+Ppa3DfjXaSRM/nHVli4ly0H4xrGhmoM1833IQ+wLmugvDPDSV/gb
   Mfg/9MCa9hxiYWxbLNUbcvVYLY3BILDp8VrdZ+o4pqU+OqAFP7hjbbHwn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1873202"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1873202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7258742"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.44.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:42 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org
Subject: [PATCH v4 3/3] thermal: intel: hfi: Enable interface only when required
Date: Mon, 12 Feb 2024 17:16:15 +0100
Message-Id: <20240212161615.161935-4-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
suspend/resume callbacks. Create two functions hfi_do_enable()
and hfi_do_disable(), which can be called from  the netlink notifier
callback and suspend/resume callbacks.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3b04c6ec4fca..5e1e2b5269b7 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -159,6 +159,7 @@ struct hfi_cpu_info {
 static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
 
 static int max_hfi_instances;
+static int hfi_thermal_clients_num;
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
+	if (cpumask_weight(hfi_instance->cpus) == 1 && hfi_thermal_clients_num > 0) {
 		hfi_set_hw_table(hfi_instance);
 		hfi_enable();
 	}
@@ -573,28 +577,93 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
-static void hfi_do_enable(void)
+/*
+ * HFI enable/disable run in non-concurrent manner on boot CPU in syscore
+ * callbacks or under protection of hfi_instance_lock.
+ */
+static void hfi_do_enable(void *ptr)
+{
+	struct hfi_instance *hfi_instance = ptr;
+
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
+}
+
+static void hfi_do_disable(void *ptr)
+{
+	hfi_disable();
+}
+
+static void hfi_syscore_resume(void)
 {
 	/* This code runs only on the boot CPU. */
 	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
 	struct hfi_instance *hfi_instance = info->hfi_instance;
 
-	/* No locking needed. There is no concurrency with CPU online. */
-	hfi_set_hw_table(hfi_instance);
-	hfi_enable();
+	if (hfi_thermal_clients_num > 0)
+		hfi_do_enable(hfi_instance);
 }
 
-static int hfi_do_disable(void)
+static int hfi_syscore_suspend(void)
 {
-	/* No locking needed. There is no concurrency with CPU offline. */
 	hfi_disable();
 
 	return 0;
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
+	smp_call_func_t func;
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
+		hfi_thermal_clients_num++;
+		break;
+
+	case THERMAL_NOTIFY_UNBIND:
+		hfi_thermal_clients_num--;
+		break;
+	}
+
+	if (hfi_thermal_clients_num > 0)
+		func = hfi_do_enable;
+	else
+		func = hfi_do_disable;
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
+	mutex_unlock(&hfi_instance_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hfi_thermal_nb = {
+	.notifier_call = hfi_thermal_notify,
 };
 
 void __init intel_hfi_init(void)
@@ -628,10 +697,16 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
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


