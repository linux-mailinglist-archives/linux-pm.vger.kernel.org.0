Return-Path: <linux-pm+bounces-21571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF87A2D111
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326A43AA200
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533D1DCB24;
	Fri,  7 Feb 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVneCaNa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A91D61B5;
	Fri,  7 Feb 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968984; cv=none; b=A0ePvn8/ji0EQJGGSEumSg264H1K4xD2pLZ87ArbYn1lgUJmdSCRmO9sm7Uklzv1fzckhC5yp/z3Q0LN+LdB8VlH/BIczQYF/1PR7hok6yCDtuT/g4I9vJvX++enMRWaIS+C+UA6QcJrSps+6Zm2qY0tu0JlK6clSAsph7SY7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968984; c=relaxed/simple;
	bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhqZ/B/diHrNMyUEO/h59Nqrcu5BPhWBbFpfP9PtVKj+fMpsQ5EC0WlZeTATvZXTtsa8y00LpSGEvFZHkjyTMRdbJt13KBEurf5329cp20erxFsmCbU5sCFm1S3HgQgmuQF4eUGXwE3Mopn1CdjmKmuRu76807PdWS4Yca3Xh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVneCaNa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968982; x=1770504982;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yNjKm0ryVmsmgF8cOHIgjNV/kYzW222nLIGfjCHjwdM=;
  b=AVneCaNaZq5lIgrvPozfBK1CM63iSAv/FIXvbxLbCQ2Jzuakj7aBNhYe
   TuNp72nwRtcYj3cmDgVdhW2meJ4jgsEAeWa5wYkO5DSwae5fgx3CBjC3E
   drpwuoWebpU687K3X7wMArFbD9gdWauTOM1c8BkYuzaXzeXBGsz51IX69
   lIo8LoSoAErgNMdRwNrVSH9kT4U+TDDOJFIkOzPIHMN2TxL137rhUMP66
   FxBiE0SMbwGlu7VVFLkq2WL6jHDXAj1YQO65rOPtQ4npmskdyoCU2OkbF
   +Zsl5vk6qWed8Yx6+aXBNDrjm5ZEmDVWUKcYilbMuOkZSivUcX017dJS5
   A==;
X-CSE-ConnectionGUID: HPBEmNEwRfGyqmseRnTdmg==
X-CSE-MsgGUID: QojMc5fATlu2JIb51DcLBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855812"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:22 -0800
X-CSE-ConnectionGUID: S/8HpEXOSjKwAOGnrLXqmA==
X-CSE-MsgGUID: /60u2ozPRGSdovlIY+9RNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111421994"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:20 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 2/6] platform/x86/intel/pmc: Remove duplicate enum
Date: Fri,  7 Feb 2025 14:56:08 -0800
Message-ID: <20250207225615.401235-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207225615.401235-1-xi.pardee@linux.intel.com>
References: <20250207225615.401235-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate enum PMC_IDX_SOC. PMC_IDX_SOC has the same value
as PMC_IDX_MAIN. Replace it with PMC_IDX_MAIN to avoid confusion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 1 -
 drivers/platform/x86/intel/pmc/lnl.c  | 2 +-
 drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 05dec4f5019f3..ad976cc83ecae 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -693,7 +693,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
 
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 0;
 	bool ssram_init = true;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a1886d8e1ef3e..a0f6cc427ddca 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -430,7 +430,6 @@ struct pmc_dev {
 
 enum pmc_index {
 	PMC_IDX_MAIN,
-	PMC_IDX_SOC = PMC_IDX_MAIN,
 	PMC_IDX_IOE,
 	PMC_IDX_PCH,
 	PMC_IDX_MAX
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index be029f12cdf40..09b13df90d685 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -553,7 +553,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 
 	lnl_d3_fixup();
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 02949fed76e91..07687a3e436d5 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -992,7 +992,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 	int func = 2;
 	bool ssram_init = true;
-- 
2.43.0


