Return-Path: <linux-pm+bounces-18409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E449E1488
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B7B224D7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5341A08DB;
	Tue,  3 Dec 2024 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wvh0BUMU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3C192D7B;
	Tue,  3 Dec 2024 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211861; cv=none; b=GTXp+RAqOIZTEi0+gcLEmns8yf48mVBSNyRBWqnEIKuRBBcLcJ6t6TBvFiRc/tIlIePX4mnEr6v9IPw+Q+ThG9r9Bke0/y+CjWua4/mbBSpNvOrmIq3bV46vG6PFMDg4FhZ1sCjL+Lc7O8bsxCvWLBSgALgOs+76Odt6Jn6naLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211861; c=relaxed/simple;
	bh=Iij/w6Z1/zujyhOBV2/AuNewHDIKByEmuBySC8c7vSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pyje6esySGSVzgO4TRPn+mIFloq+FPg/9NJLA0MQMDV5vEN+FXhYlPezNIxjJzzJ9rayA0OyKK5Eg00HLVrzf8xMn97JS/tVYZEWk3morJiGvy4NKetw6Gsw9vEARTSDHtl7tYNV/1tlt0hmzPUf5U+JA+NseKPyGi38kTJ/igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wvh0BUMU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733211860; x=1764747860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iij/w6Z1/zujyhOBV2/AuNewHDIKByEmuBySC8c7vSM=;
  b=Wvh0BUMUo3R/gxuKkAOSKzhpWvggeiaI8qTHN1rF61WSaiCZ2+nhFO9d
   99STL94q95Z57k+2S7HMk8/JSI6hPvI3EQB4mHL9HlkYRbGTUQxgT/F1Q
   U5laLa9QJxgpKIafHHKBxRTP8j2EEoJ2UOcu/EvF+f8tp+m00OzYdASNM
   k//9y3+Dx01XspcrNDxjB/XL8eAwJe5IaUVO1N0qnzQBCUyWc0sMBrGxH
   4MeqIRAQTsYPv6prws1id8WidLc8LyiJh0/Jo2vCD6XWd9wksgyx9db0w
   QL4O/IDuqEK+gsS2GxOLFZc5ieQyoljS4jYt2dIZN6rsoB5XS+frL7PJj
   A==;
X-CSE-ConnectionGUID: 8bqrIrguROCCkd66xNOquQ==
X-CSE-MsgGUID: PRiBRzNASSenbgQsPxLj1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33541418"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33541418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:44:19 -0800
X-CSE-ConnectionGUID: fuaZtL7pQrmpp7waWqaJeg==
X-CSE-MsgGUID: Qh35EiOvSXadVPPK0edRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97423581"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by fmviesa003.fm.intel.com with ESMTP; 02 Dec 2024 23:44:18 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] tools/power turbostat: Add initial support for ClearwaterForest
Date: Tue,  3 Dec 2024 15:44:18 +0800
Message-ID: <20241203074418.583457-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203074418.583457-1-rui.zhang@intel.com>
References: <20241203074418.583457-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for ClearwaterForest.
It shares the same features with SierraForest.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 540336138ce9..e203f109dd2e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1037,6 +1037,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ATOM_GRACEMONT, &adl_features },
 	{ INTEL_ATOM_CRESTMONT_X, &srf_features },
 	{ INTEL_ATOM_CRESTMONT, &grr_features },
+	{ INTEL_ATOM_DARKMONT_X, &srf_features },
 	{ INTEL_XEON_PHI_KNL, &knl_features },
 	{ INTEL_XEON_PHI_KNM, &knl_features },
 	/*
-- 
2.43.0


