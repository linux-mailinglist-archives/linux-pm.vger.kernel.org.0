Return-Path: <linux-pm+bounces-34876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789ADB80550
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC33BF57C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A482333A92;
	Wed, 17 Sep 2025 14:56:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F6D332A4F;
	Wed, 17 Sep 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120986; cv=none; b=sOYLmIxuyx04CK+ZCXGYAA2nMb4O1mWQIBcxvnDFbmQQditx02KS1vHezW+PEd6uYrWem+kBuqaI493NQRxU5miwGq7jk4FpNSFoV+zrJyICwvCVkwUqxLibfehSXo7v6BKzcxP2AOqh0lgUB+ySt0EjfHZTrwiU8S6abQoj97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120986; c=relaxed/simple;
	bh=CU9RzvofJ4FfgZQ9P8d849yVJTEcbdjODfkj+pcbBGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pt8/mVgl6VPhU7hS7KkRUhexZ022leE1ZpRTozrakCgBJCy4s2cGp8Ac21F1lgp0Qx4DfDVoAy9trqPDd+9oiQgbu2j049TUQT7eOwkr7bEKqavz2IECUCn44nyXTvRl8XLjaVaAO1Cz3Jb9/b4c4oG7VDrfg9jBNOAiiZAphSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1303267F;
	Wed, 17 Sep 2025 07:56:15 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A75023F66E;
	Wed, 17 Sep 2025 07:56:20 -0700 (PDT)
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
Subject: [PATCH v5 0/6] initialize SCTRL2_ELx
Date: Wed, 17 Sep 2025 15:56:12 +0100
Message-Id: <20250917145618.1232329-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces initial support for the SCTLR2_ELx registers in Linux.
The feature is optional starting from ARMv8.8/ARMv9.3,
and becomes mandatory from ARMv8.9/ARMv9.4.

Currently, Linux has no strict need to modify SCTLR2_ELx--
at least assuming that firmware initializes
these registers to reasonable defaults.

However, several upcoming architectural features will require configuring
control bits in these registers.
Notable examples include FEAT_PAuth_LR and FEAT_CPA2.

Patch History
==============
from v4 to v5:
  - using .ifc in set_sctlr2_elx
  - change (re)initialise position after SCTLR_ELx
  - add docs for SCTRL2_ELx
  - rebase to v6.17-rc6
  - https://lore.kernel.org/all/20250821172408.2101870-1-yeoreum.yun@arm.com/

from v3 to v4:
  - integrate set_sctlr2_elx() and __set_sctlr2_elx() to set_sctlr2_elx()
    without isb()
  - fix the wrong register setting in set_sctlr2_elx().
  - add initialise SCTLR2_EL2 at HVC_SOFT_RESTART.
  - https://lore.kernel.org/all/20250813120118.3953541-1-yeoreum.yun@arm.com/

from v2 to v3:
  - rewrite commit messages.
  - fix missing SCTLR2_EL2 synchonization at boot.
  - merging the __kvm_host_psci_cpu_entry() changes into patch #1
  - https://lore.kernel.org/all/20250811163340.1561893-1-yeoreum.yun@arm.com/

from v1 to v2:
  - rebase to v6.17-rc1
  - https://lore.kernel.org/all/20250804121724.3681531-1-yeoreum.yun@arm.com/


Dave Martin (1):
  docs: arm64: Document booting requirements for FEAT_SCTLR2

Yeoreum Yun (5):
  arm64: make SCTLR2_EL1 accessible
  arm64: initialise SCTLR2_ELx register at boot time
  arm64: save/restore SCTLR2_EL1 when cpu_suspend()/resume()
  arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
  arm64: make the per-task SCTLR2_EL1

 Documentation/arch/arm64/booting.rst | 10 ++++++++++
 arch/arm64/include/asm/assembler.h   | 15 +++++++++++++++
 arch/arm64/include/asm/el2_setup.h   | 17 +++++++++++++++--
 arch/arm64/include/asm/processor.h   |  3 +++
 arch/arm64/include/asm/suspend.h     |  2 +-
 arch/arm64/include/asm/sysreg.h      |  5 +++++
 arch/arm64/kernel/cpu-reset.S        |  3 +++
 arch/arm64/kernel/head.S             |  5 +++++
 arch/arm64/kernel/hyp-stub.S         | 13 +++++++++++++
 arch/arm64/kernel/process.c          |  9 +++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  3 +++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
 arch/arm64/mm/proc.S                 | 24 ++++++++++++++++--------
 13 files changed, 101 insertions(+), 11 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


