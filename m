Return-Path: <linux-pm+bounces-14928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DED989C97
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1461F21695
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DF174EF0;
	Mon, 30 Sep 2024 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh7CbrtV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECF1865FA;
	Mon, 30 Sep 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684397; cv=none; b=PDhPx6Pnjs2WOy0lBHcitpmAQyPPBKqI90QcyNObZDdSGITz5l49Uj6jmMKS4JUI3olN3ibeGJ8hnYM0AW9/e7jmNPCAidOFHZjn6igsGoO019BMGHVCUqSNYTZ3D0ti5tzU/QZcO6cH+HJef9H0pktp34mF5P9OQoHAE5pBKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684397; c=relaxed/simple;
	bh=G1F3xKKqYqFRkpf4/9hLMQCgirSonqyikM+KdGa0CCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lN9Co/UUYlxxczsQBHYKmbOzD8eEqwnkF5zTApccID0vAnIMGvxdRh4AvT9fWXokxqSLgAUw9fG6F1fRlCQL0gyREUfGgwgpPoMdq5f+bE3OnOlQGbaJStzgb1zi9et6WkuTxRmfBh5mDDBtlWkYNO3a9pRlr9GtV+V7txTAZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh7CbrtV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684395; x=1759220395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G1F3xKKqYqFRkpf4/9hLMQCgirSonqyikM+KdGa0CCk=;
  b=Yh7CbrtVDvGfp1ntxOyMe+q9UMJjiak2aNC4JSbkpYJIv06Z3A5xaYrq
   LStZvNDC8e+INAg+2mEAoL3Vm+h0d2tB4nm+7NU28BFvA8HnI/WB0oSPl
   DfYg7gwTRo5p+wcnP5NQjLk1/hxBSa8EGY99laonSmD7oS7Xh/gwHWEaX
   DrdCbrI/bi+107WK+wMNljFH/En3TkcxwAJ1UsME+QOGy3YsppvJVQMH+
   mhj6MCHjXh1PNv0vi0G3Ny1Y0VmpxXd4JU149YyQgQed2b6P0C9QteliF
   SF0WWZw8Smv300/BPRArnxLQQpiAiVeM1sh8L/ANbdDx7SeMUJCDwkqoq
   A==;
X-CSE-ConnectionGUID: 3/aVEVAcSkifSfnTbipvyA==
X-CSE-MsgGUID: khm7z/ppRs6udpCPfH1a0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638976"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638976"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:35 -0700
X-CSE-ConnectionGUID: hxFe0sJWSy+FeogIkFDpqQ==
X-CSE-MsgGUID: DlgVrjrrRmqKZS3TgwQLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549491"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:33 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 6/6] thermal: proc_thermal: Add MMIO RAPL PL4 support
Date: Mon, 30 Sep 2024 16:18:01 +0800
Message-Id: <20240930081801.28502-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to MSR RAPL interface, MMIO RAPL also has PL4 support.

Add PL4 support for MMIO RAPL. As a result, the powercap sysfs for MMIO
RAPL will show a new "peak power" constraint.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_rapl.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 769510e748c0..bde2cc386afd 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -13,9 +13,9 @@ static struct rapl_if_priv rapl_mmio_priv;
 
 static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
-	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
+	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930, 0x59b0},
 	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2) | BIT(POWER_LIMIT4),
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
-- 
2.34.1


