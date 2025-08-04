Return-Path: <linux-pm+bounces-31877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19CCB1A11B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468FF3A3AD5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8FB2586C8;
	Mon,  4 Aug 2025 12:17:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB7254873;
	Mon,  4 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309855; cv=none; b=ujq1REH+CIbqLoDX+77jumeF/ab1IaSC1S19VPqDlT713mBsme7csecQVLI63rN5GtxVj0aFTcTKqN0159rO9Xv4NTZxCAXrY715U/5Q8Xcv1RDVAEVy9ij6SgoX1lWUgxRgvnsLCBr2ND2KTtstPfGohelMVRDCZmjVjMxTUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309855; c=relaxed/simple;
	bh=vFmn6pAZaTv+3d/5Db+uWeo66kMJH8vLhtdgclnxEMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1WXVbygjU8ivLoG3BzFIoZDOtWo5UliufRNVYPdAOsMZTDJqQrPtmLg3Ndtu+m5EJc/USohT55IJ+KILDOgvkQI4WuLETpTmI4igcBCdvePc5t2WFVX0E80TXc/4tjfbRgrYd+nGt55NR57e0+tpx6qc1FAh5Y+pYF+FXDzQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2D51E32;
	Mon,  4 Aug 2025 05:17:25 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E33A3F738;
	Mon,  4 Aug 2025 05:17:30 -0700 (PDT)
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
Subject: [PATCH 01/11] arm64/sysreg: add system registers SCTLR2_EL2
Date: Mon,  4 Aug 2025 13:17:14 +0100
Message-Id: <20250804121724.3681531-2-yeoreum.yun@arm.com>
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

Add definitions of SCTLR2_EL2.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/tools/sysreg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..ae655672a944 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2469,6 +2469,23 @@ Sysreg	SCTLR2ALIAS_EL1 3	0	1	4	7
 Mapping	SCTLR2_EL1
 EndSysreg

+Sysreg SCTLR2_EL2       3	4	1	0	3
+Res0    63:13
+Field   12      CPTM0
+Field   11      CPTM
+Field   10      CPTA0
+Field   9       CPTA
+Field   8       EnPACM0
+Field   7       EnPACM
+Field   6       EnIDCP128
+Field   5       EASE
+Field   4       EnANERR
+Field   3       EnADERR
+Field   2       NMEA
+Field   1       EMEC
+Res0    0
+EndSysreg
+
 Sysreg	SCTLR2MASK_EL1	3	0	1	4	3
 Res0	63:13
 Field	12	CPTM0
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


