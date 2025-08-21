Return-Path: <linux-pm+bounces-32822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AFB300F5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECF188FE60
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BC31DDBB;
	Thu, 21 Aug 2025 17:24:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F41306D2B;
	Thu, 21 Aug 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797060; cv=none; b=a0A4exRA+23i+hTHrAuojJAWoIIeC1jp2otPtcC837S81mwZlR+QowpOauWiSUWStg4SFuwAZa78eg1QrP8yTTjkAt23EVQEg+zgkR9Z4zjEsIo+VtkqnSKgd3Q84I/cFMPHu0qdQgKfiXqj9i5+GsIOqrjDQ8xFJ85rXegS5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797060; c=relaxed/simple;
	bh=GZS8B5riWrRAALkBlvJ27EMS9EH/NTGI1JAuqMGKfoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCdE2BsEcqmB6HWWFMerUsI+TarA3bOO7QfECcGf/VQaTZbMwlqhkS0ny27HJ1wWZA+ulNZh/NFt4Nej4mRpnRW/9cuMc+4xtPvK8DjbNmo60bN2Zha0YoKNy3qzdgsiv1gc2x/WxjxYnPxBzMHFARPtu63z881YTMn2qmx70aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FE0168F;
	Thu, 21 Aug 2025 10:24:09 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89D5A3F59E;
	Thu, 21 Aug 2025 10:24:14 -0700 (PDT)
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
Subject: [PATCH v4 1/5] arm64: make SCTLR2_EL1 accessible
Date: Thu, 21 Aug 2025 18:24:04 +0100
Message-Id: <20250821172408.2101870-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821172408.2101870-1-yeoreum.yun@arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel runs at EL1, and yet is booted at EL2,
HCRX_EL2.SCTLR2En must be set to avoid trapping SCTLR2_EL1 accesses
from EL1 to EL2.

Ensure this bit is set at the point of initialising EL2.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..d9529dfc4783 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -57,10 +57,16 @@
         /* Enable GCS if supported */
 	mrs_s	x1, SYS_ID_AA64PFR1_EL1
 	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
-	cbz	x1, .Lset_hcrx_\@
+	cbz	x1, .Lskip_hcrx_GCSEn_\@
 	orr	x0, x0, #HCRX_EL2_GCSEn
 
-.Lset_hcrx_\@:
+.Lskip_hcrx_GCSEn_\@:
+	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
+	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
+	cbz	x1, .Lskip_hcrx_SCTLR2En\@
+	orr	x0, x0, #HCRX_EL2_SCTLR2En
+
+.Lskip_hcrx_SCTLR2En\@:
 	msr_s	SYS_HCRX_EL2, x0
 .Lskip_hcrx_\@:
 .endm
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


