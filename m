Return-Path: <linux-pm+bounces-32176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E3B2121A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3A4E35DD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E92D47ED;
	Mon, 11 Aug 2025 16:34:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645732C21F7;
	Mon, 11 Aug 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930051; cv=none; b=QRx7s3S8DzzITBjsMwuf4QQDBmrF7rVJ5cqPge5ZFt3W6az1H/pzUc9BN6PsouqELd6XqT8A3rKiqmbVmkRtUsOFD/OSwIvTa9APswawLUae6Dre337fV5NRORZHIqpL4yE4gA4urTlIxD53nhgshb8wbwacRjMkie4oI++Vfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930051; c=relaxed/simple;
	bh=iYkfBgo39WRXK6B+pCXlZSN5RvHkpDPKiQxLF87/cOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVBLnr3W6pqQHsom9ZYWseKaVzD6dRjDJ1DB59qRr0yMkd9M47Bd7v139zawuEqKxZcm4f6njXUz4v0IRHLxvOf/aBtNRfioMy6E3vkvszlJDYsinEGAqbgzs9GelrIaahYis0sY9JOkYTzVNoHy7DrVqFiIjdHVJ5L5gUD28bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6B52680;
	Mon, 11 Aug 2025 09:34:01 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 008373F738;
	Mon, 11 Aug 2025 09:34:05 -0700 (PDT)
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
Subject: [PATCH v2 6/6] KVM: arm64: initialise SCTLR2_EL1 at __kvm_host_psci_cpu_entry()
Date: Mon, 11 Aug 2025 17:33:40 +0100
Message-Id: <20250811163340.1561893-7-yeoreum.yun@arm.com>
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

initialise SCTLR2_EL1 at __kvm_host_psci_cpu_entry().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index c3e196fb8b18..4ed4b7fa57c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -4,6 +4,7 @@
  * Author: David Brazdil <dbrazdil@google.com>
  */
 
+#include <asm/alternative.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
@@ -219,6 +220,8 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 		release_boot_args(boot_args);
 
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
+	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2))
+		write_sysreg_el1(INIT_SCTLR2_EL1, SYS_SCTLR2);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
 	__host_enter(host_ctxt);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


