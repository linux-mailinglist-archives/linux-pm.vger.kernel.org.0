Return-Path: <linux-pm+bounces-32279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F987B24914
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2115A52D8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082B2FF148;
	Wed, 13 Aug 2025 12:01:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05382FE59E;
	Wed, 13 Aug 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086504; cv=none; b=UaD0SHUTMdwkH1d8GbZE3EykxLVVkoitpoYblZm3YvDH6o2v4N8O9s6ED8w0hAdLXz1eAgT3RYIEOR1VVUVyCcK0SFKyufJexzzNy4PABvd8rYv9Yv+zqMRRU1i+DSPpB3Mlf1KMVadFoACI3mi1KfBzbgeswY8VVgghkJpbA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086504; c=relaxed/simple;
	bh=jvrnSFo2RTnrxOsEOCw0HxS3H2GPEPcK5sDoiCpspPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCO+u0sKhm4O/deW+5m/gzPy28/vCnuuF7LUf+DbgodhdfVPy7HhgyQ/YXbfuUprni2sSuuRfGiaIXL2oPnRcO2PpML3UvhZoCmYjQuUY4fXYrJ116o4prPm5JlGwPbhv3tBzDO+j86dwErVLYkHG/Ves43nP7jfS6pdryNko0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5758312FC;
	Wed, 13 Aug 2025 05:01:34 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 204DA3F5A1;
	Wed, 13 Aug 2025 05:01:39 -0700 (PDT)
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
	suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 5/5] arm64: make the per-task SCTLR2_EL1
Date: Wed, 13 Aug 2025 13:01:18 +0100
Message-Id: <20250813120118.3953541-6-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813120118.3953541-1-yeoreum.yun@arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
and becomes mandatory from ARMv8.9/ARMv9.4
and serveral architectural feature are controled by bits in
these registers and some of bits could be configurable per task
not globally -- i.e) FEAT_CPA2 related field and etc.

For future usage of these fields, make the per-task SCTLR2_EL1.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/processor.h | 5 +++++
 arch/arm64/kernel/process.c        | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 61d62bfd5a7b..2c962816de70 100644
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
@@ -258,6 +259,9 @@ static inline void task_set_sve_vl_onexec(struct task_struct *task,
 	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
 	 SCTLR_EL1_TCF0_MASK)
 
+#define SCTLR2_USER_MASK	\
+	(SCTLR2_EL1_EnPACM0 | SCTLR2_EL1_CPTA0 | SCTLR2_EL1_CPTM0)
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
@@ -370,6 +374,7 @@ struct task_struct;
 unsigned long __get_wchan(struct task_struct *p);
 
 void update_sctlr_el1(u64 sctlr);
+void update_sctlr2_el1(u64 sctlr2);
 
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 96482a1412c6..9191180c4875 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -698,6 +698,11 @@ void update_sctlr_el1(u64 sctlr)
 	isb();
 }
 
+void update_sctlr2_el1(u64 sctlr2)
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


