Return-Path: <linux-pm+bounces-33064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF81B3525D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 05:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941CB1A86DAF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 03:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF32D29D8;
	Tue, 26 Aug 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXJ5Hw5J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011B221555;
	Tue, 26 Aug 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180123; cv=none; b=eZpGuKZRby3Z+w3Hd3b2+IckZHTjCT2iBOuLzfDR3uWhOOhQGBZPficKZ9qvyL8Kgsd27mlCp4H5y4IQaREFKxDntEgbmi4+zUVJbg2lbRyiCBj68ixahEOWIPVf1VGi98rtk+/C189OWhJmd78PCqtVWY1HPuBi/F10+4AXGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180123; c=relaxed/simple;
	bh=kdQrN3Exz+If6GXV/yoBbkLICbBDkRKr987eNd/lBo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GfuPmZQIxq2voUa3DCGSHYlSxxshpPoOdvxkc5r8WeNLtvLFsoLojdV47aYyXOEEToVwlJC1NlPNeMddT6Iw2pQ+9Nt5GfgXKZM3t1ThIXVpR62Rm+pOE4Dv3JlPu0KmJTDR5kwFfmEVc3kgV1PtlqCG7cFvdjfKK2wNNPvBCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXJ5Hw5J; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756180122; x=1787716122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kdQrN3Exz+If6GXV/yoBbkLICbBDkRKr987eNd/lBo4=;
  b=AXJ5Hw5J6CWtK5WLeGGsFWrQWLineoxLAXgePQ28QJix8kpb9MIFiYO1
   7aC1QqlUexQuUszMPXSXJSPS1ePtqckAJWw67afbAGVZunUFddPwHt5CX
   bC9KB+LOqrz/z+i5i3zSjYtnOxYDA0SVncOkIss7CrwzogKAUL87scc5g
   Gvb+ZKtV3V9PddvhMDStydO08ZS18eC5j6zC/6e8AJkHyxVYcRN1vzD8U
   q2aVQBwWa1C+6VfMpxsvWa++Ltm7I5hzMK3G6zBDBDI3Dm9hRrvmAbTTG
   QHJ8TAVIwJz7CjocKgFjX1YcepDIL1WPbQxr2w+hDW7quiss7c/XD2xFN
   g==;
X-CSE-ConnectionGUID: wC4fKeWET9Oz8fboB9r7bw==
X-CSE-MsgGUID: /G/c/P01RQmfZEBLFFd4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="83814478"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="83814478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 20:48:41 -0700
X-CSE-ConnectionGUID: B+qH/LhmQN2AUEn/jH+6kA==
X-CSE-MsgGUID: lhXwQ4hAR4u/obFcaWvylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173862084"
Received: from liyifan1-desk.bj.intel.com ([10.238.156.127])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 20:48:38 -0700
From: Li Yifan <yifan2.li@intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: yifan2.li@intel.com,
	xi.pardee@intel.com,
	Xi Pardee <xi.pardee@linux.intel.com>
Subject: [PATCH] platform/x86/intel/pmc: Add Bartlett Lake support to intel_pmc_core
Date: Mon, 25 Aug 2025 23:45:50 -0400
Message-Id: <20250826034550.2284738-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Bartlett Lake P-core only product support to intel_pmc_core
driver. Bartlett Lake hybrid product reuses Raptor Lake model name
so it is already enabled.

Acked-by: Xi Pardee <xi.pardee@linux.intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 540cd2fb0673..d040290e80ff 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1625,6 +1625,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&tgl_l_pmc_dev),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&adl_pmc_dev),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_pmc_dev),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,       &adl_pmc_dev),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_pmc_dev),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&arl_pmc_dev),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&arl_h_pmc_dev),
-- 
2.25.1


