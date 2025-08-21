Return-Path: <linux-pm+bounces-32826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E59B300FA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 19:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BD4581C0D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC531DDBC;
	Thu, 21 Aug 2025 17:24:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C031813A;
	Thu, 21 Aug 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797075; cv=none; b=qYR1JlKLY8vZy7kVDzjPiYmACt0SD5VObMHw0qfQJxTEDKCrPj3R5y42fAxt3eQyE/qAQWZFDos2GC+SEgAolCl7cOJL5HIlvDU0IsJLCR9H778ZWOKrxSY/WnlkIUQ/8QzLODP3LakCZjrRiBMkUKtt+5gT5p3kakvm20BH4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797075; c=relaxed/simple;
	bh=jpG4OioajyvO9e69rzujynWFs3I89Xv/VGW/yDdnHLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhYZEwUBZIEZF/nCL+JztY31E/f/mFz4iAQMuUTExw6XNCa2iB//oyOOx3/0KHLgn2m/HcFCb9SnxKnV9tnrN6pxpWDIbJqCCCFScrs7la72mKl+fAxFajpoeuYZafEp2w9XpQvAkyRvfIQmAN7o9lu4cK27bzByMneC2RRedBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C4A4152B;
	Thu, 21 Aug 2025 10:24:25 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7F023F59E;
	Thu, 21 Aug 2025 10:24:29 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	Dave.Martin@arm.com,
	ahmed.genidi@arm.com,
	kevin.brodsky@arm.com,
	scott@os.amperecomputing.com,
	mbenes@suse.cz,
	james.clark@linaro.org,
	frederic@kernel.org,
	rafael@kernel.org,
	pavel@kernel.org,
	ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 5/5] arm64: make the per-task SCTLR2_EL1
Date: Thu, 21 Aug 2025 18:24:08 +0100
Message-Id: <20250821172408.2101870-6-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821172408.2101870-1-yeoreum.yun@arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bits in SCTLR2_EL1 that control system behavior can be
configured on a per-task basis (e.g., fields related to FEAT_CPA2).
To support future use of these fields, SCTLR2_EL1 is maintained
per task.

On platforms without FEAT_SCTLR2 support, there is no functional
change and only minimal performance overhead.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/processor.h | 3 +++
 arch/arm64/kernel/process.c        | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 61d62bfd5a7b..e066116735c6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -184,6 +184,7 @@ struct thread_struct {
 	u64			mte_ctrl;
 #endif
 	u64			sctlr_user;
+	u64			sctlr2_user;
 	u64			svcr;
 	u64			tpidr2_el0;
 	u64			por_el0;
@@ -258,6 +259,8 @@ static inline void task_set_sve_vl_onexec(struct task_struct *task,
 	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
 	 SCTLR_EL1_TCF0_MASK)
 
+#define SCTLR2_USER_MASK	(0)
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 96482a1412c6..e54f192c0629 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -698,6 +698,11 @@ void update_sctlr_el1(u64 sctlr)
 	isb();
 }
 
+static void update_sctlr2_el1(u64 sctlr2)
+{
+	sysreg_clear_set_s(SYS_SCTLR2_EL1, SCTLR2_USER_MASK, sctlr2);
+}
+
 /*
  * Thread switching.
  */
@@ -737,6 +742,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	if (prev->thread.sctlr_user != next->thread.sctlr_user)
 		update_sctlr_el1(next->thread.sctlr_user);
 
+	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2) &&
+	    prev->thread.sctlr2_user != next->thread.sctlr2_user)
+		update_sctlr2_el1(next->thread.sctlr2_user);
+
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


