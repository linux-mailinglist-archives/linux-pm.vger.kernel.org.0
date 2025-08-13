Return-Path: <linux-pm+bounces-32274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA389B2490A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731C717E267
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4E2FDC5C;
	Wed, 13 Aug 2025 12:01:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C32F83D4;
	Wed, 13 Aug 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086485; cv=none; b=qdMjvofROpYjTzMvsjOXqab8W0eekQ8vZI18d/Zos8X2AXJsVon9sW5vFaKxYlidz0NxzsKIqJASMR+99vvP4piP4OOBN7bgM4eACpgMnYI9irkJaMK4O15brYWKHcDdApxdLQOWAf+NuTWVotWu2wULitfMEhsKwCMzFCaVP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086485; c=relaxed/simple;
	bh=7X0lOn0jm5SLVm1tSVI75ZjHHupmSPGXDMqpMw7DGRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hjVjj+BADnNeLgbUxzjb5O14z6/k0AEbUk9IXgq62uF8GwdQWim+/Epy/xkCEhOWVpNTVYov4f9w3J5uxMdCNfnDPK0XMrO634fiNl8vk5LIRZVSRzjP5tx/JsSQUe+anukOQymQRPjgPZrjfYD8PbHkbJ4m/rzXCEsIkjLvRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C8912FC;
	Wed, 13 Aug 2025 05:01:15 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 781B93F5A1;
	Wed, 13 Aug 2025 05:01:20 -0700 (PDT)
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
Subject: [PATCH v3 0/5] initialize SCTRL2_ELx
Date: Wed, 13 Aug 2025 13:01:13 +0100
Message-Id: <20250813120118.3953541-1-yeoreum.yun@arm.com>
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

Patch History
==============
from v2 to v3:
  - rewrite commit messages.
  - fix missing SCTLR2_EL2 synchonization at boot.
  - https://lore.kernel.org/all/20250811163340.1561893-1-yeoreum.yun@arm.com/

from v1 to v2:
  - rebase to v6.17-rc1
  - https://lore.kernel.org/all/20250804121724.3681531-1-yeoreum.yun@arm.com/

Yeoreum Yun (5):
  arm64: make SCTLR2_EL1 accessible
  arm64: initialise SCTLR2_ELx register at boot time
  arm64: save/restore SCTLR2_EL1 when cpu_suspend()/resume()
  arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
  arm64: make the per-task SCTLR2_EL1

 arch/arm64/include/asm/assembler.h   | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/el2_setup.h   | 14 +++++++++++++-
 arch/arm64/include/asm/processor.h   |  5 +++++
 arch/arm64/include/asm/suspend.h     |  2 +-
 arch/arm64/include/asm/sysreg.h      |  5 +++++
 arch/arm64/kernel/cpu-reset.S        |  6 ++++++
 arch/arm64/kernel/head.S             |  5 +++++
 arch/arm64/kernel/hyp-stub.S         | 10 ++++++++++
 arch/arm64/kernel/process.c          |  9 +++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
 arch/arm64/mm/proc.S                 | 26 ++++++++++++++++++--------
 11 files changed, 97 insertions(+), 10 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


