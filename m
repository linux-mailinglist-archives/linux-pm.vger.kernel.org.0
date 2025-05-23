Return-Path: <linux-pm+bounces-27547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69193AC1E3D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E2116E92B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C3284B5A;
	Fri, 23 May 2025 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+qsG56F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F5198E9B
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987654; cv=none; b=oez9F3gtshLqoP2pTmD8bK2fz1FEmnABiw9IlJSItXBFNncAgO2Eef/Sw4/q51UoMjUKb/tMbvepQznOfBhe9zMbscfdr67fyqoAnoymUfCTS/rDMF+GGeQ038HuIkyfPxppBvcGO95UiJHl1n4UdBDx9MESm1GsaX0VzUuujNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987654; c=relaxed/simple;
	bh=VFmPjQN1Vl6/z/UXxZDo9A9jN2A27i25NrDstJraglo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3oy9ERH79ZMszOg3HE6cdVK1fgZyuEIpBZ0YtQmG10ru05sYDdm9YT5H0hQdf/R+9ikm0vmJVP+zLIw9ka/4/V2X81GaO2PlKIiiTzhOLqlDiYvfJ3OM0qUBMO23vcoM+E/jBompEnPjLJyU+eNQW4tZr2QBT21c9SOAFvGzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+qsG56F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747987653; x=1779523653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VFmPjQN1Vl6/z/UXxZDo9A9jN2A27i25NrDstJraglo=;
  b=a+qsG56F0m2XSpUSXbz9NjOkdbZ8zz+91tqz28fkB/BBAMhp7sBYtM6Y
   2uBYDYnfSWBatjdgeKNZCn7I0UKcvZEZU1jrqyQF0+45FCSoBMHU9yV7J
   qndjzOqrs+AgudCpyd+xIaOKZkcITXVgzbxQIHwcokXGyTMVCCqxKutx8
   D9bAtXM5k5HlxCJh9cFj6ws/l8I7Z/oc8lPKdmI6e3+Sk3ztdMPOd8K2Y
   zAWNesO/+uk5VUEgS7JkwuSSBWOB0LBFxKG7S1Gm5VyvuGu5DCchdHrMN
   l/bvUJfR6qmdpY6Onk/J1EmSIjlZ8IFfQqZ9JZZiTiyFGeMuC580ERNH3
   w==;
X-CSE-ConnectionGUID: Aj3F9KYMQUqFrs0SNZUEbQ==
X-CSE-MsgGUID: yybJxyvEQn+dOizkOZrsEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50200269"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="50200269"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:07:32 -0700
X-CSE-ConnectionGUID: qTrbdYo0SX20E4t+YDFzEA==
X-CSE-MsgGUID: ggVyhp5gQGaQRg/RadTUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="146192960"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa005.jf.intel.com with ESMTP; 23 May 2025 01:07:32 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: turbostat: Correct RAPL_GFX_ALL macro to use RAPL_GFX_POLICY
Date: Fri, 23 May 2025 13:36:59 +0530
Message-Id: <20250523080659.3361452-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RAPL_GFX_ALL macro was incorrectly defined with RAPL_GFX_POLIGY,
which is not a valid identifier. This patch corrects the macro to use
RAPL_GFX_POLICY, as defined in the rapl_msrs enum, ensuring that all
GFX-related RAPL MSRs are properly grouped for feature checks and
platform support logic.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 089220aaa5c9..a8f9cf9206bb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -512,7 +512,7 @@ enum rapl_msrs {
 #define RAPL_PKG_ALL	(RAPL_PKG | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO)
 #define RAPL_DRAM_ALL	(RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_DRAM_POWER_INFO)
 #define RAPL_CORE_ALL	(RAPL_CORE | RAPL_CORE_POLICY)
-#define RAPL_GFX_ALL	(RAPL_GFX | RAPL_GFX_POLIGY)
+#define RAPL_GFX_ALL	(RAPL_GFX | RAPL_GFX_POLICY)
 
 #define RAPL_AMD_F17H	(RAPL_AMD_PWR_UNIT | RAPL_AMD_CORE_ENERGY_STAT | RAPL_AMD_PKG_ENERGY_STAT)
 
-- 
2.34.1


