Return-Path: <linux-pm+bounces-10480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54392532F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BAA1C2376E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691E4965D;
	Wed,  3 Jul 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbnLAQbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982A944D;
	Wed,  3 Jul 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986097; cv=none; b=AKLAT0Z3Sz92ZO5VNsOzKb/css+pNhD553BPldZx6SC8JNdG6r9Y2pKhHci7Vett9WQYd5af6amoPcpVGSYfGG6wjbWJifS/NoAz5qr7JyQ2JPSk4EIusL+kPpWnu56a51+HuMK1H9niD2qWRgVPcrIqlJUqqAKH/X+X5W/phHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986097; c=relaxed/simple;
	bh=iU0XEkm+zwjs5E+E4dfjzVEN8MWUzHivHpyH7ctwURA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cxdRo7QLthUh7nH/y0XckEQspQ7Shwcc2967QCG2nS2LGqUsK5VOeZ237hhEmt1yuSDJsKeEp7TJP835YPlIIgirAPbmRflPDf3QoAuEhFtzapf82Wbg0rU5sb5Q+159GCXRI7zS4/JmCADKL8M6LBOA1xV76nTh6dtfgdnCnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbnLAQbc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719986096; x=1751522096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iU0XEkm+zwjs5E+E4dfjzVEN8MWUzHivHpyH7ctwURA=;
  b=NbnLAQbc/jnRY9nT9oDBXJ7tK67zNc7TBp8m5zr4N83bO6ROmtBCg0i4
   tfZSmi+Kpsmpq56Ac78LdiL8DlNf12HMvpCOPIacfW/8pwzDwOJuwzGli
   aAapETdHT829Yx8q/wTOWXtnTIWyTJ1LO0EZwmVBKQSA22cIjuAJMPNm+
   vGU4AhPEk74LOQFGcgfr1FLl3bbybAa55EKxcmp6bBBT/rusgpylfUmWu
   61DnMgwYtxyyKki1yPwtgGwlxs7KtagCYFHG/hM5yHL56qrfgbr2qKpQ9
   GzDM1EOHQKNmH1FTUkDsBJ8WdJiPOMop3n2ykWO/0yjpD389qGyfXqVpQ
   w==;
X-CSE-ConnectionGUID: hRShQawAQfqCJqE6InRf3g==
X-CSE-MsgGUID: 6Y/ijQoAS76wWX9wCJ7YVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28328366"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28328366"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:54:55 -0700
X-CSE-ConnectionGUID: xKFjySjxQV6PE3978IEjQA==
X-CSE-MsgGUID: OZ/yg0G7Q6yCS/I459brPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46791247"
Received: from unknown (HELO localhost.localdomain) ([10.245.242.133])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:54:53 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH] Thermal: intel: hfi: Give HFI instances package scope
Date: Wed,  3 Jul 2024 13:54:45 +0800
Message-Id: <20240703055445.125362-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel Software Developer's Manual defines the scope of HFI (registers
and memory buffer) as package. Use package scope* in the software
representation of an HFI instance.

Using die scope in HFI instances has the effect of creating multiple,
conflicting, instances for the same package: each instance allocates its
own memory buffer and configures the same package-level registers.
Specifically, only one of the allocated memory buffers can be set in the
MSR_IA32_HW_FEEDBACK_PTR register. CPUs get incorrect HFI data from the
table.

The problem does not affect current HFI-capable platforms because they
all have single-die processors.

* We used die scope for HFI instances because there have been processors
in which packages where enumerated as dies. None of those systems support
HFI. If such a system emerged we would need to quirk it.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index a180a98bb9f1..5b18a46a10b0 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -401,10 +401,10 @@ static void hfi_disable(void)
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
  *
- * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
- * level. The first CPU in the die/package to come online does the full HFI
+ * Enable the HFI to be used in @cpu. The HFI is enabled at the package
+ * level. The first CPU in the package to come online does the full HFI
  * initialization. Subsequent CPUs will just link themselves to the HFI
- * instance of their die/package.
+ * instance of their package.
  *
  * This function is called before enabling the thermal vector in the local APIC
  * in order to ensure that @cpu has an associated HFI instance when it receives
@@ -414,31 +414,31 @@ void intel_hfi_online(unsigned int cpu)
 {
 	struct hfi_instance *hfi_instance;
 	struct hfi_cpu_info *info;
-	u16 die_id;
+	u16 pkg_id;
 
 	/* Nothing to do if hfi_instances are missing. */
 	if (!hfi_instances)
 		return;
 
 	/*
-	 * Link @cpu to the HFI instance of its package/die. It does not
+	 * Link @cpu to the HFI instance of its package. It does not
 	 * matter whether the instance has been initialized.
 	 */
 	info = &per_cpu(hfi_cpu_info, cpu);
-	die_id = topology_logical_die_id(cpu);
+	pkg_id = topology_logical_package_id(cpu);
 	hfi_instance = info->hfi_instance;
 	if (!hfi_instance) {
-		if (die_id >= max_hfi_instances)
+		if (pkg_id >= max_hfi_instances)
 			return;
 
-		hfi_instance = &hfi_instances[die_id];
+		hfi_instance = &hfi_instances[pkg_id];
 		info->hfi_instance = hfi_instance;
 	}
 
 	init_hfi_cpu_index(info);
 
 	/*
-	 * Now check if the HFI instance of the package/die of @cpu has been
+	 * Now check if the HFI instance of the package of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
 	 * do is to add @cpu to this instance's cpumask and enable the instance
 	 * if needed.
@@ -504,7 +504,7 @@ void intel_hfi_online(unsigned int cpu)
  *
  * On some processors, hardware remembers previous programming settings even
  * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
- * die/package of @cpu are offline. See note in intel_hfi_online().
+ * package of @cpu are offline. See note in intel_hfi_online().
  */
 void intel_hfi_offline(unsigned int cpu)
 {
@@ -674,9 +674,13 @@ void __init intel_hfi_init(void)
 	if (hfi_parse_features())
 		return;
 
-	/* There is one HFI instance per die/package. */
-	max_hfi_instances = topology_max_packages() *
-			    topology_max_dies_per_package();
+	/*
+	 * Note: HFI resources are managed at the physical package scope.
+	 * There could be platforms that enumerate packages as Linux dies.
+	 * Special handling would be needed if this happens on an HFI-capable
+	 * platform.
+	 */
+	max_hfi_instances = topology_max_packages();
 
 	/*
 	 * This allocation may fail. CPU hotplug callbacks must check
-- 
2.34.1


