Return-Path: <linux-pm+bounces-18541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633819E3C37
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FA1281B40
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8000207A05;
	Wed,  4 Dec 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTrdZlU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0D204087;
	Wed,  4 Dec 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321328; cv=none; b=rW+TwgjczTbgwO0Rex2fxU970yVuFmjLQgObSTanTVqOsUUWEe4LwYkhkr9z58Jh7tUay+sCUTLNLaopzzRhcyksF6/c3AlU/IQZfjRK8nUewP/Cfmqv9IOmBJpLjBgvksVN2ve4Rq2gN6Z1YuuuzCOvsoqb+mp2b3Jrn9AB9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321328; c=relaxed/simple;
	bh=kMW48E7qpSBZTt1YOx6YAvCT+CU+LS/A1l7cEYEL4ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpekXG6XwUHwRqQxgH/gSpzU64poLhS+eIhGHVuj4bA+wdnzf6fXLxa0zK2qw1Idf4/rceDm6zwL7LET57CN1FKV37wyHpK+xOJtxIadsiJNbyGtFhoJnFONQtpZwbimf5sAyQSebhh866jYhgCzsCJCB2Q2A9j1JOFO207Alrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTrdZlU9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321327; x=1764857327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMW48E7qpSBZTt1YOx6YAvCT+CU+LS/A1l7cEYEL4ig=;
  b=cTrdZlU9mZRnFPZc608///AFaUFcNF0Ll70RDfyQXPzHqwlchkEuDIsN
   69Rdxzo9EcDz+Flq521MBbmgFCr+dGgLC20iCyQeD8AdGLCGXT5PeyBIl
   8Ge1RFtI4PLVxt+EG/9lEeeUgk5cyZGgXREqFMXTpO99o16MbFJWeRrld
   +CkPHnvdi1j96E+XdLVnzJ/ey21F/uw5Y1mGHByt/KcOsUFncPYuskvJR
   mSFxafj/ZEDp11ILdyeGgztKXNfbazc1TvvmMD3YlC+GGd7AanRjejdJb
   Vhv9JE9f7heHxETCP4JFADkmrj3QzX8qYBy+YPDx4MRRgufTQz+Zlsug0
   Q==;
X-CSE-ConnectionGUID: nXa7S9S6Tny6A0rqyLasUw==
X-CSE-MsgGUID: ni10x1BhTPCYgPaTHB62JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56071360"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56071360"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:47 -0800
X-CSE-ConnectionGUID: 2ByUnF43RqiUmNuM97FBlg==
X-CSE-MsgGUID: efvytN1xRiSf7nR6WdWNqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98202780"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:44 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v8 2/4] ACPI: processor_idle: Add FFH state handling
Date: Wed,  4 Dec 2024 15:08:26 +0100
Message-ID: <20241204140828.11699-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent Intel platforms will depend on the idle driver to pass the
correct hint for playing dead via mwait_play_dead_with_hint(). Expand
the existing enter_dead interface with handling for FFH states and pass
the MWAIT hint to the mwait_play_dead code.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
 drivers/acpi/processor_idle.c |  2 ++
 include/acpi/processor.h      |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..8d7b8b02ddb9 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -15,6 +15,7 @@
 #include <acpi/processor.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
+#include <asm/smp.h>
 
 /*
  * Initialize bm_flags based on the CPU cache properties
@@ -204,6 +205,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
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
index ce728cf7e301..83213fa47c1b 100644
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


