Return-Path: <linux-pm+bounces-41711-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BRbEt+oe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41711-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9947B39D7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B5B301E3CE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB12FA0EF;
	Thu, 29 Jan 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMCXSuMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E12F7ABB;
	Thu, 29 Jan 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711827; cv=none; b=pvVtoxksW+4rM/lG5CuBQh4/+hPxfOV6XVTIUkkNCs9ArWIF3PzIbfbpYcGl3l4E4Farfcwl8aeUF2VjJ3f91t6x95NAD1hkXSGn0GWtJ/QYMWG8TxprRskmYi5QCJ+kQw59F0DB0kgrLNfYnjTDYGA6CA2mSBLDm0m4VskrHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711827; c=relaxed/simple;
	bh=P7qDJl9poxdlAgRPdvy39YWN+7mXrtTmMuaKyU1I1f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2URo94Y9puHg8zBjPHxknNx4u2gOL9Mih/XeTfr7c4SeXlROTGqleyy9qNsQjDrPuZGjIumFMDjji3wOnz+DJcdEbmlBYly3e8bA98JG0rg8+kmDegxnM5qhewwED+bSBZW04TnQGc5UuuWAIz5Sq3I8gvh7bZbGGzQqhpR17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMCXSuMi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711826; x=1801247826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7qDJl9poxdlAgRPdvy39YWN+7mXrtTmMuaKyU1I1f8=;
  b=nMCXSuMiB1nqWsXD9560HMeDfVGB2UZO3HULNzE8LatNSW2Ue02RH4sO
   Jcdu/OWAmth6NxWMKO2th06ArDFWhEy0DdPEITBmQaS/87c5sKbTYgKQh
   08Wfb3zZB9im9Y+8d2TUFPDkYl3ygOd9Qb8Qd7GypnCLV1QCfiDshQMBe
   MbuzZll4VLRhO4CZlxVvqPe0frvDQVZl9V9iRNOdlaBhYo+YB48qMmG+Q
   vZHA6Nxa2cz9NeVVQMx1emN6NfGg8HxN1BeJDUfODbiG+UvY5fR3cKDZA
   qyQbC5F6wqdJ3e9Ig4ZUee+d+T4/Nv2AekdxAXVKJVgCrEQ1chNnG18j4
   Q==;
X-CSE-ConnectionGUID: +3yYnf5ARNiC2gEO+AciRQ==
X-CSE-MsgGUID: JFNKUDskQFCzCVYVy27yig==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388344"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388344"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:04 -0800
X-CSE-ConnectionGUID: QaZmCnzgRLyAieugw09aww==
X-CSE-MsgGUID: RJbHqI4MQrG1f79SmpA/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070953"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:04 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] powercap: intel_rapl: Add a symbol namespace for intel_rapl exports
Date: Thu, 29 Jan 2026 10:36:38 -0800
Message-ID: <20260129183646.558866-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41711-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9947B39D7
X-Rspamd-Action: no action

Cleanup of the intel_rapl common driver requires introducing additional
exported helper and lifecycle functions. Before adding new exports,
create a dedicated symbol namespace for intel_rapl and update the
relevant interface drivers to explicitly import it.

This makes the intended usage of these symbols explicit, avoids
polluting the global namespace, and prepares the codebase for the
ongoing RAPL refactoring.

No functional changes are intended.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c          | 20 +++++++++----------
 drivers/powercap/intel_rapl_msr.c             |  1 +
 drivers/powercap/intel_rapl_tpmi.c            |  1 +
 .../int340x_thermal/processor_thermal_rapl.c  |  1 +
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3ff6da3bf4e6..3471cee7ac04 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2089,7 +2089,7 @@ int rapl_package_add_pmu_locked(struct rapl_package *rp)
 
 	return rapl_pmu_update(rp);
 }
-EXPORT_SYMBOL_GPL(rapl_package_add_pmu_locked);
+EXPORT_SYMBOL_NS_GPL(rapl_package_add_pmu_locked, "INTEL_RAPL");
 
 int rapl_package_add_pmu(struct rapl_package *rp)
 {
@@ -2097,7 +2097,7 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 
 	return rapl_package_add_pmu_locked(rp);
 }
-EXPORT_SYMBOL_GPL(rapl_package_add_pmu);
+EXPORT_SYMBOL_NS_GPL(rapl_package_add_pmu, "INTEL_RAPL");
 
 void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 {
@@ -2115,7 +2115,7 @@ void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 	perf_pmu_unregister(&rapl_pmu.pmu);
 	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
 }
-EXPORT_SYMBOL_GPL(rapl_package_remove_pmu_locked);
+EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu_locked, "INTEL_RAPL");
 
 void rapl_package_remove_pmu(struct rapl_package *rp)
 {
@@ -2123,7 +2123,7 @@ void rapl_package_remove_pmu(struct rapl_package *rp)
 
 	rapl_package_remove_pmu_locked(rp);
 }
-EXPORT_SYMBOL_GPL(rapl_package_remove_pmu);
+EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu, "INTEL_RAPL");
 #endif
 
 /* called from CPU hotplug notifier, hotplug lock held */
@@ -2156,14 +2156,14 @@ void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 	list_del(&rp->plist);
 	kfree(rp);
 }
-EXPORT_SYMBOL_GPL(rapl_remove_package_cpuslocked);
+EXPORT_SYMBOL_NS_GPL(rapl_remove_package_cpuslocked, "INTEL_RAPL");
 
 void rapl_remove_package(struct rapl_package *rp)
 {
 	guard(cpus_read_lock)();
 	rapl_remove_package_cpuslocked(rp);
 }
-EXPORT_SYMBOL_GPL(rapl_remove_package);
+EXPORT_SYMBOL_NS_GPL(rapl_remove_package, "INTEL_RAPL");
 
 /*
  * RAPL Package energy counter scope:
@@ -2206,14 +2206,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(rapl_find_package_domain_cpuslocked);
+EXPORT_SYMBOL_NS_GPL(rapl_find_package_domain_cpuslocked, "INTEL_RAPL");
 
 struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
 	guard(cpus_read_lock)();
 	return rapl_find_package_domain_cpuslocked(id, priv, id_is_cpu);
 }
-EXPORT_SYMBOL_GPL(rapl_find_package_domain);
+EXPORT_SYMBOL_NS_GPL(rapl_find_package_domain, "INTEL_RAPL");
 
 /* called from CPU hotplug notifier, hotplug lock held */
 struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv, bool id_is_cpu)
@@ -2267,14 +2267,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 	kfree(rp);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(rapl_add_package_cpuslocked);
+EXPORT_SYMBOL_NS_GPL(rapl_add_package_cpuslocked, "INTEL_RAPL");
 
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
 	guard(cpus_read_lock)();
 	return rapl_add_package_cpuslocked(id, priv, id_is_cpu);
 }
-EXPORT_SYMBOL_GPL(rapl_add_package);
+EXPORT_SYMBOL_NS_GPL(rapl_add_package, "INTEL_RAPL");
 
 static void power_limit_state_save(void)
 {
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9a7e150b3536..6f23e601832d 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -264,3 +264,4 @@ module_platform_driver(intel_rapl_msr_driver);
 MODULE_DESCRIPTION("Driver for Intel RAPL (Running Average Power Limit) control via MSR interface");
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("INTEL_RAPL");
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 0a0b85f4528b..3b52403c14f8 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -348,6 +348,7 @@ static struct auxiliary_driver intel_rapl_tpmi_driver = {
 
 module_auxiliary_driver(intel_rapl_tpmi_driver)
 
+MODULE_IMPORT_NS("INTEL_RAPL");
 MODULE_IMPORT_NS("INTEL_TPMI");
 
 MODULE_DESCRIPTION("Intel RAPL TPMI Driver");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index bf51a17c5be6..e56b18aeda71 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -111,4 +111,5 @@ void proc_thermal_rapl_remove(void)
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_remove);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("INTEL_RAPL");
 MODULE_DESCRIPTION("RAPL interface using MMIO");
-- 
2.43.0


