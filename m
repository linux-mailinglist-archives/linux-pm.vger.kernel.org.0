Return-Path: <linux-pm+bounces-31883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBAB1A128
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027F1189E86A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE2258CF0;
	Mon,  4 Aug 2025 12:17:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9C258CDC;
	Mon,  4 Aug 2025 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309879; cv=none; b=g759m93WTox7h/5dzo4WG4gtg9E2YuudxLvmN5cfzRKHzapSmuYbmKHhtdrlBB117X4tLD1D6jBACiZEtJmiOU3thr9XDg7EoQFJbxTtYetYL6DB+j/h3MEiJ9UNGfzp0A5Zkx/qrTGMHkTJqbeItltFyZwXeCI4iwmUbYRF+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309879; c=relaxed/simple;
	bh=6dzm+Zi+XjXp5mYLVu5J9JmYF9QrHLzEoJ97N/GyEkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgrJT1VRAx73H3k5jtHvhFUCYm0AbC/3f7mStv4E8+vUWk8pnAooVF0I1DWWJ9NpThm/rV2+tPm0oIx9jzmZJQw6SCWhCcAq/wzgrIZ2YGTxE34hy66Jill71Mo/Fstn3iGzmG43jj0zjFUvqdZlZhGqKcV7/H1uxMSSHFfxl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5CF150C;
	Mon,  4 Aug 2025 05:17:49 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 057273F738;
	Mon,  4 Aug 2025 05:17:53 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ry111@xry111.site,
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
Subject: [PATCH 07/11] arm64: make the per-task SCTLR2_EL1
Date: Mon,  4 Aug 2025 13:17:20 +0100
Message-Id: <20250804121724.3681531-8-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804121724.3681531-1-yeoreum.yun@arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of field of SCTLR2 registers should be configurable per task
not globally -- i.e) FEAT_CPA2 related field and etc.

For future usage of these fields, make the per-task SCTLR2_EL1.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/processor.h | 5 +++++
 arch/arm64/kernel/process.c        | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 1bf1a3b16e88..7980161172f7 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -182,6 +182,7 @@ struct thread_struct {
 	u64			mte_ctrl;
 #endif
 	u64			sctlr_user;
+	u64			sctlr2_user;
 	u64			svcr;
 	u64			tpidr2_el0;
 	u64			por_el0;
@@ -256,6 +257,9 @@ static inline void task_set_sve_vl_onexec(struct task_struct *task,
 	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
 	 SCTLR_EL1_TCF0_MASK)

+#define SCTLR2_USER_MASK	\
+	(SCTLR2_EL1_EnPACM0 | SCTLR2_EL1_CPTA0 | SCTLR2_EL1_CPTM0)
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
@@ -368,6 +372,7 @@ struct task_struct;
 unsigned long __get_wchan(struct task_struct *p);

 void update_sctlr_el1(u64 sctlr);
+void update_sctlr2_el1(u64 sctlr2);

 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 08b7042a2e2d..e86325d07fa8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -699,6 +699,11 @@ void update_sctlr_el1(u64 sctlr)
 	isb();
 }

+void update_sctlr2_el1(u64 sctlr2)
+{
+	sysreg_clear_set(sctlr2_el1, SCTLR2_USER_MASK, sctlr2);
+}
+
 /*
  * Thread switching.
  */
@@ -738,6 +743,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
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


