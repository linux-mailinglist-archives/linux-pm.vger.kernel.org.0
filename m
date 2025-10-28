Return-Path: <linux-pm+bounces-36962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E4C1415C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 492BA504068
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D925A62E;
	Tue, 28 Oct 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQqOUwi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4D2DEA96
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646820; cv=none; b=EqIyAqE3EiKIDiovk0r1BUv3QsjCyKKUFulsT6SkqAD0RAN+L8PVpr+oQy0Q7PImgyTHOdw6GFILJJ8u9s9i/DOPC8dSvq6dUPFS8TkyGKRDa+4rDUVEZ6LF4AKOAuNZ2pd9Gena2IZ3DP0Bi8BOc50vu+yK1qEp7IYYBKhGRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646820; c=relaxed/simple;
	bh=Vl1j57jXtXhUa2GRAymom0Mo7vM9mu7tOok55FIUdlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPguXvmm4oWCY7b5XZnEXMfOmdto82uEkgvXCMs7T6FD9B4hTiFQ88ZFIrlVdLzO7E70MJ7gD1Izd/tkZ5cSw6bny2ve4XQAeQ1kGSPZz/tfzj/JHcsufYkCkmvzLGIPfVY3iukgWKO8KcsqYMEUv788R2CtozL1IKhjVF7UDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQqOUwi4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761646818; x=1793182818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vl1j57jXtXhUa2GRAymom0Mo7vM9mu7tOok55FIUdlw=;
  b=YQqOUwi4MHpcuglLdVOtZ0zeddByEd1Cntamwu9+qF1EWR6bhsP8LfkC
   zT0KsIP8/1uT04qzKYN5TSxdpvnDws/T3x+NgYcZ15cO9Aq0+xk16XiGY
   x9t8Z5c5b+Hiy16GWqIc9a3fwwU49E0vx65bRqUV/yeFJsVIMAeq7+jYJ
   hJu+S5P+A4i7vs8TlYfQcoyiPPAyn+XAhuTiAx7HWU9iggTgJBTT/v0VL
   SgNBCFNBAtHK3etSEr31Xh0yudsyf+yX7aBlZ3OzGdZsNzTXP22Uhcg1T
   1OZXvJKQhhNR/f0XGnm5ZKqfI3sV5/n6saDML1l84mh1jhD6ALcaj31p4
   Q==;
X-CSE-ConnectionGUID: dhYh5kLLSIalRyiNGeMyqA==
X-CSE-MsgGUID: +awnA4qKTaeflYp+4Ecm2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75189761"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75189761"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:20:18 -0700
X-CSE-ConnectionGUID: 0B3lnssBTbCyH6w2CJwNZg==
X-CSE-MsgGUID: WrVxxs+CQiCnIREdt7L85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185397329"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa008.jf.intel.com with ESMTP; 28 Oct 2025 03:20:17 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] powercap: intel_rapl: Add support for NOVALAKE processors
Date: Tue, 28 Oct 2025 15:48:14 +0530
Message-Id: <20251028101814.3482508-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RAPL support for Intel NOVALAKE and NOVALAKE_L processors using
the core defaults configuration.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 ++
 drivers/powercap/intel_rapl_msr.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c7e7f9bf5313..8ea55e167b1a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1284,6 +1284,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&rapl_defaults_core),
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 4ed06c71a3ac..7421648917d1 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -151,6 +151,8 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
 	{}
 };
 
-- 
2.34.1


