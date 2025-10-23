Return-Path: <linux-pm+bounces-36753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2FC02C90
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E70F4FCCDF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008734B1B1;
	Thu, 23 Oct 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1o99av/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA01E51FA;
	Thu, 23 Oct 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241551; cv=none; b=alMhtPpejdy34mZ6B5sK3BrbbNzLomIlM21JRthTT1xflAsQ8p+qI7obPYEfDQ0ONkL+EfAFrTnF8qsohn+oBq8Inp5whBApfXThAcdRSsVcrA2P6VElo/OqrAqSj2/I6U3OVYRIAqQ5EBPGdEBiJnd/wfuiRurQ9+XZ9WTNuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241551; c=relaxed/simple;
	bh=fo/oAnscwjde4LCMUKNl1gbrSUoCohsiDSRwkKBt0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seGFQTiJtQKcHaOh2oivOXQo2Wf961d0GrtsIQRsNi4fhhlYJc7ueLyJ3h4ElNK8Z40JxOylxrq21Lxk4qa7SjBXYiSuq9EUL3aNZCmApd+F1YexQnKOli7hJoyJYArsmjpMi94Fz2gFJctaX/OB9WbsExNbVxidC+QlGnurwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1o99av/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761241550; x=1792777550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fo/oAnscwjde4LCMUKNl1gbrSUoCohsiDSRwkKBt0xA=;
  b=g1o99av/jYlXDTNtbQ4oxT1qMrAgHSwVqnoRprsmQ6uqPQN8uaLSwBvL
   z4/k25Qsy/uVV46lVi2TaAVvnkxDHi2HtDePQaIotu0xenAIgWd+AtqCt
   WP8pQhu30rO0Df0ydPxvJdXPekOIj/Ekq/AyR0z/LUycTq+C60OYulhWv
   /GJDteSLoQ9cLPKPf2U120flRx9/+JvMmYsc4SZrPNIpDB+AG/AvX2OWK
   sbQ7T7p9Z1msW3Nl8KJEqnfyYCQlC7n0bS5UeXCVf5U0YMvkkuqqPpoep
   nEzj5PF8nv6VhFB4ReRc3RhjCg6Vs4zQyOPBysiomR5BP/8Xz31yFIcfl
   Q==;
X-CSE-ConnectionGUID: yaQzPf0kQxCuVKhb8N8AOg==
X-CSE-MsgGUID: j+Tm4YcTTUW3o7obcBWXLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86049089"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="86049089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:45:50 -0700
X-CSE-ConnectionGUID: 1JbWohCvRsGtqMWWhoYKIg==
X-CSE-MsgGUID: UI9CnhgbSjiiy1tD1nQYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184116352"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa007.jf.intel.com with ESMTP; 23 Oct 2025 10:45:49 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] powercap: intel_rapl: Add support for Wildcat Lake platform
Date: Thu, 23 Oct 2025 10:45:32 -0700
Message-ID: <20251023174532.1882008-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Wildcat Lake to the list of supported processors for RAPL.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 drivers/powercap/intel_rapl_msr.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c7e7f9bf5313..cdb4363589e9 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1284,6 +1284,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&rapl_defaults_core),
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 4ed06c71a3ac..c4d536c2f989 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -151,6 +151,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
 	{}
 };
 
-- 
2.51.0


