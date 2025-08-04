Return-Path: <linux-pm+bounces-31876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E82B1A119
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B9817B2A1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D6253F12;
	Mon,  4 Aug 2025 12:17:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37A1B043F;
	Mon,  4 Aug 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309852; cv=none; b=GM0HZloMRq1qQPvj5Td0tvEgF+FdbwGKqq9UQ/rA/RVMdQDsFsMqY145Ye2gYYJ6hhGbcJpJ9vIPGtBr1QZvTkjth4rbIYMN+Ut7kppUIijJp+5VG+vktR5osekNQwobjkpDih2DRZN3on6ygEKbrHnG9yuoJ6T71o4ntSaeOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309852; c=relaxed/simple;
	bh=+vBccoEF6CjVVqZRmZq3xXno0H4IwN7FYJcgQGpOHq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kMzjf4IIGxwbfrClgAczRUvFnJMZNXJ5kKuRbDLf/Gut7JplyMih3bzfQbcZ1TtXw+AaeUVOvvspopX6v4MGSeFFqcNRDW9UgEMz6mRvsA+x3ucqFzSsz0bLNd6G85w7Y3W+vVVqjv8UASQyqSd6MiBvC5r+ChhppNSwmrm19ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01291150C;
	Mon,  4 Aug 2025 05:17:22 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D8BB3F738;
	Mon,  4 Aug 2025 05:17:26 -0700 (PDT)
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
Subject: [PATCH 00/11] support SCTLR2_ELx
Date: Mon,  4 Aug 2025 13:17:13 +0100
Message-Id: <20250804121724.3681531-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces initial support for the SCTLR2_ELx registers in Linux.
The feature is optional starting from ARMv8.8/ARMv9.3,
and becomes mandatory from ARMv8.9/ARMv9.4.

Currently, Linux has no strict need to modify SCTLR2_ELx—
at least assuming that firmware initializes
these registers to reasonable defaults.

However, several upcoming architectural features will require configuring
control bits in these registers.
Notable examples include FEAT_PAuth_LR and FEAT_CPA2.

This series is based on v6.16 and probably KVM-safe but
Not tested yet:
  - nVHE boot.

Yeoreum Yun (11):
  arm64/sysreg: add system registers SCTLR2_EL2
  arm64: make SCTLR2_EL1 accessible
  arm64: initialise SCTLR2_ELx register at boot time
  arm64: cpufeature: add FEAT_SCTLR2 feature
  arm64: save/restore SCTLR2_EL1 when cpu_suspend()/resume()
  arm64: init SCTLR2_EL1 at cpu_soft_restart()
  arm64: make the per-task SCTLR2_EL1
  KVM: arm64: initialise SCTLR2_EL1 at __kvm_host_psci_cpu_entry()
  KVM: arm64: support SCTLR2_EL1 for guest
  KVM: arm64: nv: support SCTLR2_ELx on nv
  KVM: arm64: expose FEAT_SCTLR2 feature to guest

 arch/arm64/include/asm/el2_setup.h         | 14 +++++++++++-
 arch/arm64/include/asm/kvm_host.h          |  7 ++++++
 arch/arm64/include/asm/processor.h         |  5 +++++
 arch/arm64/include/asm/suspend.h           |  2 +-
 arch/arm64/include/asm/sysreg.h            | 22 ++++++++++++++++++
 arch/arm64/include/asm/vncr_mapping.h      |  1 +
 arch/arm64/kernel/cpu-reset.S              |  6 +++++
 arch/arm64/kernel/cpufeature.c             |  8 +++++++
 arch/arm64/kernel/head.S                   |  5 ++++-
 arch/arm64/kernel/process.c                |  9 ++++++++
 arch/arm64/kvm/emulate-nested.c            |  2 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 16 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c       |  3 +++
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         |  6 +++++
 arch/arm64/kvm/nested.c                    | 13 +++++++++++
 arch/arm64/kvm/sys_regs.c                  | 25 +++++++++++++++++++--
 arch/arm64/mm/proc.S                       | 26 +++++++++++++++-------
 arch/arm64/tools/cpucaps                   |  1 +
 arch/arm64/tools/sysreg                    | 17 ++++++++++++++
 19 files changed, 175 insertions(+), 13 deletions(-)


base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


