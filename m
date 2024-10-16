Return-Path: <linux-pm+bounces-15785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601119A0F08
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CE01C2299C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2304210C2C;
	Wed, 16 Oct 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzIUZBOe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846F215F43;
	Wed, 16 Oct 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093746; cv=none; b=KtQU/zgl0/ekZmeLyt4NbAZbPI7mLQV1OgfqBEmvLfp0/2DL/iX2Td1a5qbqK94yXHmLJ7Iq2jixsCvqJgmvi0ZvKG7vHY/6maJDBRjLzXGxf/RwVPz+0WRBIILPEreJh6aXe97lWGlqAhy6XaL2C1c6MdAYpoizlyrDsxBlDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093746; c=relaxed/simple;
	bh=azYBYsEL8TBwKLy2DqMkcAlok1XYNMnVrkAzCSDpOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFhTOrNOkZMts7GMKrVnE1VNg4diQz74ZL2r6cW0rHnTU/L4juOpZe2iPN4nyFpai5PjNKAlA8BDEFbiWf0C3XUcEdkYZB258rpdNHL5RUOVDyBwotV3rQVPAcY2p9JYF2VeOwr8SO87TnO4Xxorvb0zBDwVAfmpf6XUKUU/hyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzIUZBOe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729093745; x=1760629745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=azYBYsEL8TBwKLy2DqMkcAlok1XYNMnVrkAzCSDpOi4=;
  b=DzIUZBOeQj8kYxm1+K+g8AcLYP4BsJ1H8IdKRATIrAEsELvA2bMDP47r
   UC1RFWuYKuIFpU38q6y7SRZO4zQZzsCzHJFysMq3Vt4KhM5YsSKkhlivx
   qZ+7mLj7cvCLUMDLHeNpJ2+Vd6sX+cgPLJGX9hi1/UGaIvCXbEn5l6i71
   sqYdsCVYRdgYcUZHVOalDsEnA08+vsVg3HiCLfMxWYn5huwvISjWEYm69
   1Cv51xfeZgNBA4YpeyBEdrlYePOwBPSPpvefO8+fHQEJ7z5TD+R8LpOc0
   M0dhqUCfVNcaFT7UGCVHAhVsct2vehFRBPrf7N0wtLmtDqRjqsOYKUQ6M
   g==;
X-CSE-ConnectionGUID: lyON3SSbRvyG9gyGzY44MQ==
X-CSE-MsgGUID: tM3DZuGgTHKkLTnmYh8kMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="16167186"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="16167186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:49:04 -0700
X-CSE-ConnectionGUID: uehkeSnsTsSnE/0GvlFLVg==
X-CSE-MsgGUID: 8ctFh2bYS3+4C0vxO9S8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83091757"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 08:49:04 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] powercap: intel_rapl_msr: Add PL4 support for Arrowlake-H
Date: Wed, 16 Oct 2024 08:48:51 -0700
Message-ID: <20241016154851.1293654-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PL4 support for ArrowLake-H platform.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 1f4c5389676a..cbe07450de93 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -148,6 +148,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	{}
 };
 
-- 
2.45.0


