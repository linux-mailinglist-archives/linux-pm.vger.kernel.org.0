Return-Path: <linux-pm+bounces-32278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7530B24917
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EBE3BC0BF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0D2FE599;
	Wed, 13 Aug 2025 12:01:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674122FD1DB;
	Wed, 13 Aug 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086500; cv=none; b=o3TwkXCTtI9vc9yxlEOHgB4kshIps913zYZaPutZeUN/DNHkn/VRCj1AXlbN43WM+SDW+1vkjQJ7D71Nsw2QHIJGggUT2wiyT137QHS8FjlpGWo1FzZ6uAYd5OFx+FPaeqmzQDdp/er6DDz8WmxMfF/57swJeaUWOySMFn2LFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086500; c=relaxed/simple;
	bh=r6iAioU7NGMVRtLf/WwoCruCLoEFlASexN779ATZbps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHIJPPAE834jim4nxtN6h+D65ivcnF3os536s8qzKOYFdtIFortNtEvpMJDMeBQKS0K7VXxYXFGt7hVLIlfL7LCHVl/ZEyunWOkfaFQrmIak1Vwatb5ft33AZPHOloEnOePbLS04QdAROimeJCjmTP/hw+Zc7giKUa2OlJvCEt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8EF514BF;
	Wed, 13 Aug 2025 05:01:30 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 638FF3F5A1;
	Wed, 13 Aug 2025 05:01:35 -0700 (PDT)
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
Subject: [PATCH v3 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Date: Wed, 13 Aug 2025 13:01:17 +0100
Message-Id: <20250813120118.3953541-5-yeoreum.yun@arm.com>
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
these registers.

Before, launching new kernel via kexec, initialise SCTLR2_EL1 explicitly.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/cpu-reset.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index c87445dde674..123564af345b 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -37,6 +37,12 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
 	 * regime if HCR_EL2.E2H == 1
 	 */
 	msr	sctlr_el1, x12
+
+alternative_if ARM64_HAS_SCTLR2
+	mov_q	x12, INIT_SCTLR2_EL1
+	msr_s	SYS_SCTLR2_EL1, x12
+alternative_else_nop_endif
+
 	isb
 
 	cbz	x0, 1f				// el2_switch?
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


