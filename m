Return-Path: <linux-pm+bounces-18168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F39DAB97
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A85B2282B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0543200BB3;
	Wed, 27 Nov 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdSLLVcu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01978200BBF;
	Wed, 27 Nov 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724154; cv=none; b=MaDyVm8SUOV3kypYnGwg1DoFVvWU4X9/MiJLYSMOpOkfiw9EJwPCMLG7Zgc8uAOjVKGzj0H96+JHvlp+bPMyuonTcdSwXL1YRLPh1x3cVQ5LXd3OIQ8pjnsYOcFyw0IG9urBsZql/WnXKzQwRWmyk7MHfYxrGRYzxgoB6Lle08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724154; c=relaxed/simple;
	bh=IJyLqWUb34HjgoRr/RZU1HX6hMKRUjvhExUqCV0J0Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hpc/z/pdhdHMj4GlnaMYr5HBPd6ajpZ7BB5LgsYuycK+lgWG9fTwHbtyl118uqFSn9GciA7Zo6dS5Q1aYGBnuXkuMgcAlRVBBWhtqhfG7Gs2FczuRZq/bd/1ACvs6SE9LTq3WgpJNgxVUNGnAZvq81YiZcZH6Vm/8rVRWSC9etY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdSLLVcu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732724153; x=1764260153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJyLqWUb34HjgoRr/RZU1HX6hMKRUjvhExUqCV0J0Ws=;
  b=bdSLLVcufQC/CBLFEufYgjBIT94cYt9OkkbBtZ3Xd0BBTdyqJFB5F8+n
   j9pwbeRC38QYkDJl7T0NIT5FCeKu9GbVoF/F2ZMN4WRFzVIF2DFVHr27A
   wqL/jugQeTnMXwvvYJBDv87e4WQlQh1L5Bauo9IjcHQKnPRX3M+Vls5Oa
   zBCX4NiAKilvT0acox5AiCdI6YZ1ZV+Gwjz0lf0mTzagK4S4DRZRbMqx5
   mN4dVylfkbLPKAjzBQgCUmz2TZyh+cnb/0F8ovI7mq7uOiPIXig07ii7b
   BAUINjLPYMkC3mhESiRMMRr762KmuktmTtlKOP+I1ObqR/3UMQ2/lr6wW
   g==;
X-CSE-ConnectionGUID: U91slF+uRZGXxld74dlEcA==
X-CSE-MsgGUID: SBzbm6QZSjqUbThkWOAM3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43597597"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43597597"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:53 -0800
X-CSE-ConnectionGUID: AVUv9J3mSR+hHYGJuyaZMg==
X-CSE-MsgGUID: hEQ989sDTAW9F4fvJLQUTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97042425"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:49 -0800
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
Subject: [PATCH v6 2/4] ACPI: processor_idle: Add FFH state handling
Date: Wed, 27 Nov 2024 17:15:16 +0100
Message-ID: <20241127161518.432616-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
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
 arch/x86/kernel/acpi/cstate.c | 9 +++++++++
 drivers/acpi/processor_idle.c | 2 ++
 include/acpi/processor.h      | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..c80a3e6dba5f 100644
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
+	mwait_play_dead_with_hint(percpu_entry->states[cx->index].eax);
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


