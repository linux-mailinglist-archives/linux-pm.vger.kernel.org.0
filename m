Return-Path: <linux-pm+bounces-21403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E008AA29496
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C96164896
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2118C93C;
	Wed,  5 Feb 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtGMLUbo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C31CA64
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768865; cv=none; b=O4o2T221igQkGkKvxwA/uJxfc6Pfc2VaTijJauc0VXl6NntOQTwh2qmh/mK5Dznti2EDbDAG1+5bEs7Mvg2PKhlzFjiTU62vJjTOQHC3bR8E5JTwyksRrFw8eXJ+K1RU0irx7/yxEfoX0I6ZPTfnAT/T5TLOPiU+1Jhs30SDv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768865; c=relaxed/simple;
	bh=iVvYWC6cKhlDIg5xivFFUGdfUxQs/GwvlEi8AzEZSx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3xcJDJhgYiW8OMUK0zJ3GUsnIcnk+3y0HXAGTUsaT6zqAi1c93NmZ03kVXakXKm1RtERlUQ5n69sI1WmK6ILLRv7Q23MpSlMehYm+VGobljb6uVsjXGc90RlxyAYLBy+WhlUTITt12PjghncdPOkSHlrM0tPitn/AFjUd+UOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtGMLUbo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768864; x=1770304864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iVvYWC6cKhlDIg5xivFFUGdfUxQs/GwvlEi8AzEZSx8=;
  b=FtGMLUbovdqAopK01rI5pCNR4f1VBW7KNUPPcjsIo8us7vJAldtyy9Ib
   /6M0n89w81LisGV4sX5zrTOV7YdPS1gaH36LYBbOZvMGD1PnYj60QiwHM
   kXy81z8+iXMCa+7DosoO0xOip4qVi1yxXpOSw72nayBEVsHcMqMbr3NKG
   XBm2jEaA10zqTDdFddr1iXoCJ+m7Dby3aydVYhQl/YSZkgizdwPwj//dG
   uTfMu7yt0b2QuYaLHNIoHA2EmwsRvb5i1X36rBZM00N4nzIP2oPHOP+1K
   CNowzThxf6s+f3GlCVd/VKsQJv277iqruEOTThJ6tF2/PVePO5h+z+kQ5
   A==;
X-CSE-ConnectionGUID: i0lLO+bXTfOmEePa8iTF/A==
X-CSE-MsgGUID: 4ppILSJ5SA+gwFHPNY8eYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39498159"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39498159"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:21:03 -0800
X-CSE-ConnectionGUID: 7SV2DHhLTNG8RpEmR4qNvw==
X-CSE-MsgGUID: SF/q9kqWQSuJ6omEzJZX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111109533"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2025 07:21:02 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com
Subject: [PATCH v10 2/4] ACPI: processor_idle: Add FFH state handling
Date: Wed,  5 Feb 2025 17:20:54 +0200
Message-ID: <20250205152057.171030-3-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
References: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
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

Based on patches from Patryk Wlazlyn <patryk.wlazlyn@gmail.com>.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
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


