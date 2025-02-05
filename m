Return-Path: <linux-pm+bounces-21409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54842A29557
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7C5168B2F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658121A83ED;
	Wed,  5 Feb 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU6TNJ/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0419B586
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770741; cv=none; b=Nyuwh8UZwO38Pqy5JZlGl29/ZURXumF1bIqRN3AenwEWod7CWDpyF4YF9QsPHYnYXK43iHYNdxIPoGuyzwe4dUVhuZIWs+KE/r18lZUak0vm0dZCrzVEkHx6wQFt05A7ikW16xkMin/Iblq+0JwLdPY/p7tcfMzKZAETe2M/PC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770741; c=relaxed/simple;
	bh=t7eOToCgBKG1DbFYdZ+wsVNuSxawOa1QVblX3KxdcSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNMqUE42pvEon4Igt93GofHWul639KIlfcL3LagWNoXRcH+fTWR1AQlTarvNig/ZlEws8klxUQlz/HRVeYJ982I8P/5jDtUIrEsY1iCdgJh/oWZGOW+ARKrg2UcHqKkO0aQmt7srnBZuSJ3SX9mXpom8Nrmw3AJMgAVPBJuRNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU6TNJ/1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738770740; x=1770306740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7eOToCgBKG1DbFYdZ+wsVNuSxawOa1QVblX3KxdcSQ=;
  b=ZU6TNJ/1hVH+gVJOoHJ+uYHTArss1/onMB9A1XtN7EKJ31w7u1jXcB85
   y5uCI8l9DR6FNTy7gjhLFJlQplm4Nf5lBAB4uRbUBIl2UEyWBbsMOLpOm
   AneRwJLXlB/s3Oqyu8dqlwW/tMMwCplrZFoUrT5yYi+RZp8AFWTx3dlfK
   OaVonKKyQ/Q89OEv/tQCBxyuWFUKi4pGPAM4OwSALsCHvWgr6DZDxSCNv
   dfm8KsFK7BZRJs1XEH8i+emOrtORePZyus7LBBfLHnlmOSGOa/FZ4scaw
   Kyq/fGwOYloqBi5vpSKi02owxf4VGW/TgW1WCh7vQtF2Z5ktHfRO9DahH
   g==;
X-CSE-ConnectionGUID: k+kTEa95SXe+yl2joEyKMg==
X-CSE-MsgGUID: YQh9blhrTQylce3rgUNZSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50330989"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="50330989"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:52:20 -0800
X-CSE-ConnectionGUID: GDa+AjonRcGt9IHSkn88HQ==
X-CSE-MsgGUID: P0YfcayZRwagxx/6KxBrIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111516304"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa009.fm.intel.com with ESMTP; 05 Feb 2025 07:52:17 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com
Subject: [PATCH v11 2/4] ACPI: processor_idle: Add FFH state handling
Date: Wed,  5 Feb 2025 17:52:09 +0200
Message-ID: <20250205155211.329780-3-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205155211.329780-1-artem.bityutskiy@linux.intel.com>
References: <20250205155211.329780-1-artem.bityutskiy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Recent Intel platforms will depend on the idle driver to pass the
correct hint for playing dead via mwait_play_dead_with_hint(). Expand
the existing enter_dead interface with handling for FFH states and pass
the MWAIT hint to the mwait_play_dead code.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
 drivers/acpi/processor_idle.c |  2 ++
 include/acpi/processor.h      |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5854f0b8f0f1..5bdb65516969 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -16,6 +16,7 @@
 #include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
+#include <asm/smp.h>
 
 /*
  * Initialize bm_flags based on the CPU cache properties
@@ -205,6 +206,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cstate_entry *percpu_entry;
+
+	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	mwait_play_dead(percpu_entry->states[cx->index].eax);
+}
+
 void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 698897b29de2..586cc7d1d8aa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			raw_safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			io_idle(cx->address);
+		} else if (cx->entry_method == ACPI_CSTATE_FFH) {
+			acpi_processor_ffh_play_dead(cx);
 		} else
 			return;
 	}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index a17e97e634a6..63a37e72b721 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
 				    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
+void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
 	return;
 }
+static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+{
+	return;
+}
 #endif
 
 static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
-- 
2.47.1


