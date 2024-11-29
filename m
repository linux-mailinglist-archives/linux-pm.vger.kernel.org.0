Return-Path: <linux-pm+bounces-18258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F109DEC0D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 19:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9EBB221F6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E21A257A;
	Fri, 29 Nov 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCKqoEQr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641E1A2554;
	Fri, 29 Nov 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904576; cv=none; b=LYIW/yKDnoL4puhrTmphLXUKCbn8kZk/ygd0AHYEgtVTmMX9kwNwLf8sEMuRBhErmPDEsPWQYZtXUS1z+jRXMp7MEKhpvLMSdYI9YQPtgsGlOQ2gcH1fGE1gBrBolcU0R+Ru6bm09pMnZo+X7NjY5V75TvCT5d6Fu07L/yoEb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904576; c=relaxed/simple;
	bh=kMW48E7qpSBZTt1YOx6YAvCT+CU+LS/A1l7cEYEL4ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqxoqWIvHygCPNGMJ3I9qTv2PvX5G9vE+3m76IJNFvjKftUDl1w6Xjb4rL6QJtCF5t6hh/22g/mbDVC67jY+vs/tswTlF901DlfZ/F/W3OReTE4yaLZOusgnOLjWPnQ3vDHxDRWyRvzUIbv6GEC+Bwic1ykc/DlxYU0rW1B1sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCKqoEQr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732904575; x=1764440575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMW48E7qpSBZTt1YOx6YAvCT+CU+LS/A1l7cEYEL4ig=;
  b=hCKqoEQrYczc3iDxEjSU487tgXpB/F1ZNhp90lqVdKSjYDkJUIkUcjUV
   2leQGE/3v97fmX4fvlvhxIJnzISnfhSQI9t8GruUjNLIYZM51nuZZiwt2
   HTPpiFjT6BKNUQ7TLthykYl1yLnsSTVSOiOiWAfS+FCroTe3rrAVILut4
   fux6EST15ZnVHxpYPsQhMp0d30EK1moJgp1LpDsdCqmuntxSXNrgo+yiV
   TrJ9V3pqDZF55t1/lIm+1ZEzHnw7uHp9AvieuNS7pXSOqSiwTtA3qppMh
   fEHGW0iHXqaLeWSIhqO8z83OQfRWFGQmRl3zHRL66pyGkNvFNYp2/IWt3
   Q==;
X-CSE-ConnectionGUID: fyuifrI6Rbaj7dGbOYqchg==
X-CSE-MsgGUID: Z3AAukgOTsOkYi3ixdLavw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36811948"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36811948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:55 -0800
X-CSE-ConnectionGUID: /hvGRJtATnesQn6vlP80yg==
X-CSE-MsgGUID: 1+2PbXy6RWe/69G50FESgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="92422149"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:52 -0800
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
Subject: [PATCH v7 2/4] ACPI: processor_idle: Add FFH state handling
Date: Fri, 29 Nov 2024 19:22:30 +0100
Message-ID: <20241129182232.14987-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
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


