Return-Path: <linux-pm+bounces-34882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FCB805E3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1C21BC045D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70B3705A3;
	Wed, 17 Sep 2025 14:56:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E073705A1;
	Wed, 17 Sep 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121009; cv=none; b=EzBHwSL+nfYRvxQYyRNEXkAEcyvtCZIN8eWwRMv6gO2hxSw1188l/fie1dfrHhhOontKtNjP0t8lpreQ7uYEeSNMZDfF7RbvG6Fvzqeq0ZlgLhZPH/Osf4GRBo1COX5KP+Ylfcvr44TqerhaRf8TxTTsCJGh+BszuB2vdPvd5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121009; c=relaxed/simple;
	bh=N8YLYPkl4tKVv6OcchZf05oQ0VXHePRCzLklXY2vJXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWtArjlyw0D/TWyYZpmMX6deUnVVy4Z7rzUv8GT2NygSsV5RlGZdABwYm2Q6DjnjhGALZG+JSiKFI3d8ynFZKsnJ5lJRoTOFvTkEaUJrFDyVtTuJjDE3y4/RVLBQUCu/UMVZptrFp8+58cnw/SFMKAJhd0eM/j4pn8sWFTz245U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E05F3267F;
	Wed, 17 Sep 2025 07:56:38 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98C6C3F66E;
	Wed, 17 Sep 2025 07:56:43 -0700 (PDT)
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
Subject: [PATCH v5 6/6] docs: arm64: Document booting requirements for FEAT_SCTLR2
Date: Wed, 17 Sep 2025 15:56:18 +0100
Message-Id: <20250917145618.1232329-7-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917145618.1232329-1-yeoreum.yun@arm.com>
References: <20250917145618.1232329-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Martin <Dave.Martin@arm.com>

Support for FEAT_SCTLR2 imposes some requirments on the configuration
of traps at exception levels above the level at which the kernel is
booted.

Document them.

For now, don't document requirements on the initial state of SCTLR2_ELx
at the kernel boot exception level.  The general wording under "System
registers" appiles.  (SCTLR_ELx is similarly undocumented.)

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 Documentation/arch/arm64/booting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 2f666a7c303c..e8fe1b2023a9 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -545,6 +545,16 @@ Before jumping into the kernel, the following conditions must be met:
 
    - MDCR_EL3.TPM (bit 6) must be initialized to 0b0
 
+  For CPUs with the SCTLR2_ELx registers (FEAT_SCTLR2):
+
+  - If EL3 is present:
+
+    - SCR_EL3.SCTLR2En (bit 44) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HCRX_EL2.SCTLR2En (bit 15) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


