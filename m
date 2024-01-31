Return-Path: <linux-pm+bounces-3068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D584402C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505371C2730B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502B7BB0D;
	Wed, 31 Jan 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRCKs/WT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC237D416;
	Wed, 31 Jan 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706596; cv=none; b=eZEWIFMrZAoffcIxfMAgIFeaYOK90E9CW1gP3gxjMZGXqX4WEpWcgKstKmv3fac5XaqUy/JwnsrAzYYDkKuSNdt7Ce1knxyX0VabhoY5MRGPcn129sc0rJ8Pss1HodUg9LTRv6XoYHpVvIj27bMKnctv25oxcY/CX0MfRBIvI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706596; c=relaxed/simple;
	bh=rcpiNeB7CiWeBJw4zwN20vL/n4yivIooXRYMSS2oiw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=morBDBP1w6uNkGpkFXISG2O44MmcGTm775ohGVDVbBuzntaOKAb16QexHwvi1gbFPFJg+WvsNJKups4ujOY2mq2vr61u2OzFhM62BrhunS71veplxPyz9h31Wt+GYdUIfZua+3ggN3n1dpehvoIX55Wua1HGm1YTM7cUtaSh8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRCKs/WT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706594; x=1738242594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcpiNeB7CiWeBJw4zwN20vL/n4yivIooXRYMSS2oiw4=;
  b=FRCKs/WTqV4XJCdhCxtHyjehc27jpnacKHlLamFpc5NKS/2OdIDj/O4b
   WLd8yGcEQerwWUt8xj5at54EbTlCPH02G4E54fSURQuAE3IXea3KVJtYi
   Lxmwk6wwgjPzsmn3O5I1veV7Esje10f9EGQTiJld2FI8meZl2Bw5JdokU
   mkUDQKlw1P/IJJ9sVsVnhMoJi0dGSuoE+V6isyQ6JAWcmR6lkVaiK+YEo
   +BECU0IkMzAEMpWPUo+hS8zIJcWfLeTQSwfqeuQjY/OhYBw/1ifNwqgiB
   3946PGg7u5W05C7278ujC4q3Gznl2mOVFAR+w5WMtI07eZNaVAYWikFwr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17127027"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17127027"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858816218"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858816218"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:52 -0800
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
	netdev@vger.kernel.org
Subject: [PATCH 3/3] thermal: intel: hfi: Enable interface only when required
Date: Wed, 31 Jan 2024 13:05:35 +0100
Message-Id: <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
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
events,. When user space handlers exit or remove subscription for
thermal netlink events, disable HFI.

Summary of changes:

- When CPU is online, instead of blindly enabling HFI by calling
hfi_enable(), check if the thermal netlink group has any listener.
This will make sure that HFI is not enabled by default during boot
time.

- Register a netlink notifier.

- In the notifier process reason code NETLINK_CHANGE and
NETLINK_URELEASE. If thermal netlink group has any listener enable
HFI on all packages. If there are no listener disable HFI on all
packages.

- Actual processing to enable/disable matches what is done in
suspend/resume callbacks. So, create two functions hfi_do_enable()
and hfi_do_disable(), which can be called from  the netlink notifier
callback and suspend/resume callbacks.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 82 +++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3b04c6ec4fca..50601f75f6dc 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/mutex.h>
+#include <linux/netlink.h>
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
@@ -480,7 +481,8 @@ void intel_hfi_online(unsigned int cpu)
 	/* Enable this HFI instance if this is its first online CPU. */
 	if (cpumask_weight(hfi_instance->cpus) == 1) {
 		hfi_set_hw_table(hfi_instance);
-		hfi_enable();
+		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
+			hfi_enable();
 	}
 
 unlock:
@@ -573,28 +575,84 @@ static __init int hfi_parse_features(void)
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
+	hfi_do_enable(hfi_instance);
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
+static int hfi_netlink_notify(struct notifier_block *nb, unsigned long state,
+			      void *_notify)
+{
+	struct netlink_notify *notify = _notify;
+	struct hfi_instance *hfi_instance;
+	smp_call_func_t func;
+	unsigned int cpu;
+	int i;
+
+	if (notify->protocol != NETLINK_GENERIC)
+		return NOTIFY_DONE;
+
+	switch (state) {
+	case NETLINK_CHANGE:
+	case NETLINK_URELEASE:
+		mutex_lock(&hfi_instance_lock);
+
+		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
+			func = hfi_do_enable;
+		else
+			func = hfi_do_disable;
+
+		for (i = 0; i < max_hfi_instances; i++) {
+			hfi_instance = &hfi_instances[i];
+			if (cpumask_empty(hfi_instance->cpus))
+				continue;
+
+			cpu = cpumask_any(hfi_instance->cpus);
+			smp_call_function_single(cpu, func, hfi_instance, true);
+		}
+
+		mutex_unlock(&hfi_instance_lock);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hfi_netlink_nb = {
+	.notifier_call = hfi_netlink_notify,
 };
 
 void __init intel_hfi_init(void)
@@ -628,10 +686,16 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	if (netlink_register_notifier(&hfi_netlink_nb))
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


