Return-Path: <linux-pm+bounces-31882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF72B1A126
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A6F17E321
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B125B1D8;
	Mon,  4 Aug 2025 12:17:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B0258CDC;
	Mon,  4 Aug 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309875; cv=none; b=rSH66aLC0OiRAM8J2n3uXiaesi9KwPW6Y2fXNgErVF/hd0V7CzUoQAs7+HhGF2yKL9KTjLAJA6Vqsnn+T/ihNdhmzlpEbfZSGGjtIXqsUTQpluEaYBBPlilaDQJU9LdsHKRH+OadyShtvKDiPy8OJ6f1ZjRRy+tLadnkfjzKahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309875; c=relaxed/simple;
	bh=s9v3VM+08uNNQ+6rqA+ZSQyiAlpXneS/q99uSHleGzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhbk5zHKv7sIugE+E15bjQif5uLkjLm8CrF8C1Urvi7ZJA+h6N0voI32ehl19spP+17pLRIB9cO3iSGVyDnyp2o6fSoMsemAKkAbGpg8EEqNa26G1N4EFcBA+Xv5fm8FmQWeVJBAGU/+kYMZnPl/+E6IHs3xslmuqyil68QuICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89D9150C;
	Mon,  4 Aug 2025 05:17:45 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D93D3F738;
	Mon,  4 Aug 2025 05:17:49 -0700 (PDT)
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
Subject: [PATCH 06/11] arm64: init SCTLR2_EL1 at cpu_soft_restart()
Date: Mon,  4 Aug 2025 13:17:19 +0100
Message-Id: <20250804121724.3681531-7-yeoreum.yun@arm.com>
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

Initailize SCTLR2_EL1 at cpu_soft_restart().

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


