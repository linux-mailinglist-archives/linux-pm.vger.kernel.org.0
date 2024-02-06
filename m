Return-Path: <linux-pm+bounces-3481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F042B84B68E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7C31C2435A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C313174B;
	Tue,  6 Feb 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5Ayx5C0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94356130AC6;
	Tue,  6 Feb 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226591; cv=none; b=akPEy324czabynTmzdQaSGhQz7dg77M18Zcdx0DnyYSzeMoKDD5PmMYjSwHuzQiV5brDgDJICFVcWnQGsDqYPQpqZYclRCdTf/82Dw71PMrcNoc3DIjzkvU3S1YJJcBp2Z8WanolmuKLY4S8lEU3BWmA7q5D0yyyM0KgT2KX4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226591; c=relaxed/simple;
	bh=7plR84WWRswcCrnNW4hL+hM3NAlvi40gEEuXirSUnpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4060OINVYpc7AX9cgvIv/xKQ3o5s/zchj+n+lCxPCitTdCwapO3Skg3Y82s7q/ZfxQgjCa4r3k20RvVd5Ikf1uiJGEqtFf1OGL/s6gXual3s8Kl9RX382uM3t/QRea/ZcwcGujyYEU0oFfZ2fEOanhsjeEs4S3lC9fIe3+Qs34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5Ayx5C0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707226589; x=1738762589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7plR84WWRswcCrnNW4hL+hM3NAlvi40gEEuXirSUnpQ=;
  b=C5Ayx5C0Bd19mZGVkoReLjHxoIuK/p6irolB74kUNk7SN/3tOdjF+D4m
   eSZa9WPh7moNJD+Ydmn8OKVLuq8Vet/AVAQkqn7KpPClzzza+LYUchmkT
   eZ+F9KfnZul9XkKac03NU9NaS7CW7LNgYQBFvRB/bIpC+hVlq0I+Jze0i
   1cpzosjuyBEjn3+jiIKD40QpI2wBD0YJvAsrgrIiBjeiovFULawDBDKJ9
   yq7OrbBzuIEZrZbbTP00qOPvtjxQIgD3pUnoeESRzxlqt6uTWCoFBPT1N
   ib93TQKGmOUodICNo3FkwZksuflLiKhty5Fy91gSkyOvVxT8Ftn9wWUC6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="1014406"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1014406"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909636886"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909636886"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:25 -0800
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
Subject: [PATCH v2 3/3] thermal: intel: hfi: Enable interface only when required
Date: Tue,  6 Feb 2024 14:36:05 +0100
Message-Id: <20240206133605.1518373-4-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
References: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
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


