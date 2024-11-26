Return-Path: <linux-pm+bounces-18137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51909D9E54
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 21:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8BB20D36
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C41DF995;
	Tue, 26 Nov 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="du/y9325"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FE1DF97E;
	Tue, 26 Nov 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652168; cv=none; b=fqynNmHlhaQiUiDoz+ofpGToVa2UQqneyTX4fT39kwK/MCHwyzy9cN7oVmKLc/gaDWMHcdIpuhd0n1XW972VofJj+W4sNRAf1uUaI7SywiXeBRBamJOIm2xTWT3bNGMR4xyeCQNVFTlg/qEbKeI4f+BQyvdkSHyhu7FWx6UWqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652168; c=relaxed/simple;
	bh=wK6XwIVIv3BRZ7xl7V/JTpKvh3+xzLwjadHETiYGD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YltO0kP5QTCqxpMIOkRLAZKj0K8UdvPWhSMa8yLCf45qtRi86WEylcNOus/oMF4GoTWLk2V5AQwFQkT4vwqa/8i9iBzJW/4ENAKXn8Utmc5V74W1u82rAZWDTRIKtVu6t0IF8GWWZv9Jft5V59YwCQ9iIgsPPk5r/tko6FXlACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=du/y9325; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652166; x=1764188166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wK6XwIVIv3BRZ7xl7V/JTpKvh3+xzLwjadHETiYGD9k=;
  b=du/y93254iQ01ym5MfxiMbePjrPrHxHQFRS44iOAduOlxdtSrGCR3pqU
   7wfC5AmelCf9CVQKOdKoYzP45qIDmppogU02cKSvWQAyPw4rCleM7/rz/
   IIlrNWLVTqk39rgrZaw2XCMoEortEhOgI2ttp/kBrLbiSgsmT/rRNjx5S
   uU5nrMBTqjRSM5q3NATABkTSDVf3dRS78mDGqKqPDZ4K7snS0qy98ocVb
   K2xvNKg3hf7puORpX4CWZQCiAJB8ir0TCI++lbk66d9mXOZlcEW3KAP05
   9B1dYBK7aX0z7FwCENxLoG85lx1kMdLtrJQ1kbkESr9DwGEVK3XmAbIsv
   Q==;
X-CSE-ConnectionGUID: yx/EUNXmTgq6oKjfJAt8Ow==
X-CSE-MsgGUID: 6/VFDy4wQAa5+sbWl5S3vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36624214"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="36624214"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:06 -0800
X-CSE-ConnectionGUID: 6w71OYdNSEmBaKn/f/ozZw==
X-CSE-MsgGUID: OdEM+m3xSp+F0+333CeARg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92047569"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.172])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:03 -0800
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
Subject: [PATCH v5 2/3] ACPI: processor_idle: Add FFH state handling
Date: Tue, 26 Nov 2024 21:15:38 +0100
Message-ID: <20241126201539.477448-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
References: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the preceding commits removed the CPUID leaf 0x5 based play_dead
in favor of delegating the play_dead functionality to the idle driver.
It was mainly (perhaps exclusively) used for Intel CPUs. Add handling of
the FFH states to the acpi idle driver in case intel idle is missing.

Notice, that on Intel, play_dead code relies on intel idle driver to be
present or BIOS to expose the desired states now. On AMD, since the
preferred play_dead method is via HLT or IOPORT over FFH/MWAIT, the code
relies on BIOS to expose the states that will allow for efficient
play_dead.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/kernel/acpi/cstate.c | 9 +++++++++
 drivers/acpi/processor_idle.c | 2 ++
 include/acpi/processor.h      | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..ee2933001acf 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -204,6 +204,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
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


