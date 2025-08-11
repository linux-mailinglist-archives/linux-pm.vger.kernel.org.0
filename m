Return-Path: <linux-pm+bounces-32172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6243B21233
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBD3B31C3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229129BDA5;
	Mon, 11 Aug 2025 16:33:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6CC247299;
	Mon, 11 Aug 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930036; cv=none; b=qAsG+OpOiQYFTvU3TzpA5v3yZ23llREQk2M60A+W70TlPrM/cswqS0F2xz0GkU4R3jKu4pxdTPH5K9vteckR/GXU0l7m8IQMEf4B7AsbxWCU4f76sOyKgYFmsxCX4SgWhXeUe8OkiIWFC9my2tartyRjCPobw85i188zirOev58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930036; c=relaxed/simple;
	bh=4PnEIGjEirZrlnNf7zJdzlXAtEotLOjgDkLV/5VgVy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uy3SpyFK+4USdMZdfSrhmViNBWoUvnS7XOu7s+k8nEJ37tTua9RwIrMhAPBqzJOSDyLoZkhv8rM1MXX5BauhuYxEGH2INhDNDaq53cmxajpVHNKyAqeI7DdLdqORzIHtWpLRdin18UL/bFhQPrnQDI1V+EDg+8rVJQgt8pNcQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0A826A4;
	Mon, 11 Aug 2025 09:33:45 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B42B3F738;
	Mon, 11 Aug 2025 09:33:50 -0700 (PDT)
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
Subject: [PATCH v2 2/6] arm64: initialise SCTLR2_ELx register at boot time
Date: Mon, 11 Aug 2025 17:33:36 +0100
Message-Id: <20250811163340.1561893-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811163340.1561893-1-yeoreum.yun@arm.com>
References: <20250811163340.1561893-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add initialisation for SCTRL2_ELx register at boot time.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/el2_setup.h |  6 ++++++
 arch/arm64/include/asm/sysreg.h    | 22 ++++++++++++++++++++++
 arch/arm64/kernel/head.S           |  5 ++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index d755b4d46d77..347ac4cc1283 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -48,6 +48,11 @@
 	isb
 .endm
 
+.macro __init_el2_sctlr2
+	init_sctlr2_elx	2, x0
+	isb
+.endm
+
 .macro __init_el2_hcrx
 	mrs	x0, id_aa64mmfr1_el1
 	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
@@ -411,6 +416,7 @@
  */
 .macro init_el2_state
 	__init_el2_sctlr
+	__init_el2_sctlr2
 	__init_el2_hcrx
 	__init_el2_timers
 	__init_el2_debug
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d5b5f2ae1afa..8b82af5be199 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -868,6 +868,8 @@
 #define INIT_SCTLR_EL2_MMU_OFF \
 	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
 
+#define INIT_SCTLR2_EL2			UL(0)
+
 /* SCTLR_EL1 specific flags. */
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
@@ -888,6 +890,8 @@
 	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
 	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 
+#define INIT_SCTLR2_EL1			UL(0)
+
 /* MAIR_ELx memory attributes (used by Linux) */
 #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
 #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
@@ -1164,6 +1168,24 @@
 	msr	hcr_el2, \reg
 #endif
 	.endm
+
+	.macro init_sctlr2_elx, el, tmp
+	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
+	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
+	cbz	\tmp, .Lskip_sctlr2_\@
+	.if	\el == 2
+	mov_q	\tmp, INIT_SCTLR2_EL2
+	msr_s	SYS_SCTLR_EL2, \tmp
+	.else
+	mov_q	\tmp, INIT_SCTLR2_EL1
+	.if	\el == 12
+	msr_s	SYS_SCTLR_EL12, \tmp
+	.else
+	msr_s	SYS_SCTLR_EL1, \tmp
+	.endif
+	.endif
+.Lskip_sctlr2_\@:
+	.endm
 #else
 
 #include <linux/bitfield.h>
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ca04b338cb0d..0dff7593e50b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -276,6 +276,7 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
+	init_sctlr2_elx	1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
 	msr	spsr_el1, x0
@@ -298,7 +299,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el2, x0
 	isb
 0:
-
 	init_el2_hcr	HCR_HOST_NVHE_FLAGS
 	init_el2_state
 
@@ -315,12 +315,15 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 	/* Set a sane SCTLR_EL1, the VHE way */
 	msr_s	SYS_SCTLR_EL12, x1
+	init_sctlr2_elx	12, x2
 	mov	x2, #BOOT_CPU_FLAG_E2H
 	b	3f
 
 2:
 	msr	sctlr_el1, x1
+	init_sctlr2_elx	1, x2
 	mov	x2, xzr
+
 3:
 	mov	x0, #INIT_PSTATE_EL1
 	msr	spsr_el2, x0
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


