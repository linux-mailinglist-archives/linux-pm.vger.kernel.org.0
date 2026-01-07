Return-Path: <linux-pm+bounces-40384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED90CFF267
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E28E31A36A3
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898F36B079;
	Wed,  7 Jan 2026 16:21:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA55369214;
	Wed,  7 Jan 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802894; cv=none; b=j4fw7Rue8DbhTpIlh7bGnGJxKJUo2bhWXQtMTqwL7vuvQ0gY8ReT8y4NLjY4Y4cD0hmpXND8aLd4ca285FYe+5S84E5eISwX6LvfKscCQnhtiVn9L6d/bbJXXSGbMDoJQG5sTYos2laRPkvqhyy37CQ+/AOtKkL7lihzA0U8FTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802894; c=relaxed/simple;
	bh=D2P6qwmfvCQQdX/xeZoS88qJgTGpJkMtP5WtyVZU4L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0PSeWOp3t+ZMOCyxSc8f/khg6pWMLAyKUpjVmAxVZppogFsxH3P7a/cuibwz+Xu1/VSvN5JvvtP1MeLifBJrO2+p1sCL2lIWgDTIZ4kXy2bki8MwTBRT2BEN3uS0eaaeFC6zMrjb0BZUuBArqy7ZKMthDJ70XHQXozPh6w9x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C007497;
	Wed,  7 Jan 2026 08:21:12 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4329D3F5A1;
	Wed,  7 Jan 2026 08:21:17 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	pavel@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	joey.gouly@arm.com,
	kevin.brodsky@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
Date: Wed,  7 Jan 2026 16:21:15 +0000
Message-Id: <20260107162115.3292205-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCR2_ELx.E0POE is set during smp_init().
However, this bit is not reprogrammed when the CPU enters suspension and
later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
and there is no save/restore logic for the TCR2_ELx system register.

As a result, the E0POE feature no longer works after cpu_resume().

To address this, save and restore TCR2_EL1 in the cpu_suspend()/cpu_resume()
path, rather than adding related logic to __cpu_setup(), taking into account
possible future extensions of the TCR2_ELx feature.

Cc: stable@vger.kernel.org
Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---

Patch History
==============
from v1 to v2:
  - following @Kevin Brodsky suggestion.
  - https://lore.kernel.org/all/20260105200707.2071169-1-yeoreum.yun@arm.com/

NOTE:
  This patch based on v6.19-rc4
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e65f33edf9d6..e9ce68d50ba4 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H

-#define NR_CTX_REGS 13
+#define NR_CTX_REGS 14
 #define NR_CALLEE_SAVED_REGS 12

 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 01e868116448..5d907ce3b6d3 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -110,6 +110,10 @@ SYM_FUNC_START(cpu_do_suspend)
 	 * call stack.
 	 */
 	str	x18, [x0, #96]
+alternative_if ARM64_HAS_TCR2
+	mrs	x2, REG_TCR2_EL1
+	str	x2, [x0, #104]
+alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)

@@ -144,6 +148,10 @@ SYM_FUNC_START(cpu_do_resume)
 	msr	tcr_el1, x8
 	msr	vbar_el1, x9
 	msr	mdscr_el1, x10
+alternative_if ARM64_HAS_TCR2
+	ldr	x2, [x0, #104]
+	msr	REG_TCR2_EL1, x2
+alternative_else_nop_endif

 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


