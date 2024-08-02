Return-Path: <linux-pm+bounces-11849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E23946358
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 20:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B3A2834A6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5601ABECF;
	Fri,  2 Aug 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij9vxw6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0513633A;
	Fri,  2 Aug 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624540; cv=none; b=NI94OGOAmevPkbBKFSuRnLtXhlgdkS+nx+X5/Smgg89TBz2rYGMAZyBDXbXOnG6qDu+eqGkmi+KdBG+4utb9qeY3cJ5de2J95M53M4NjOVbET3lnWRxkunePuRjmJ4X8n2dTIXcia8ZYNPd2Z4fhuU+Fa47nh19Id5ciJzrf4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624540; c=relaxed/simple;
	bh=iWlQYfhW630YQa0Rs6x9F+5yDlG5LmzZ1x/8Ul5aMmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nm5CfRCJTMBfRnzz5rV9GJIEhU+4fdKTOn/Yhk9nFemkTP8hxbhgNZlGomsleiHpGgklnYv+FzJyVZz2Dj0htxESySRf+gRhwrJXsNToXY5xLdBSOSS5rNLca7pq/xjl3GmU2n1dqAD4nXOV6l+r8WnYCfGJfWOfQQhiX501gsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij9vxw6u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722624539; x=1754160539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iWlQYfhW630YQa0Rs6x9F+5yDlG5LmzZ1x/8Ul5aMmk=;
  b=ij9vxw6uQlOZvFPPkOlMreyM180weE/KnCPljWsBAXw6gPWA3bgK1eZn
   O5miQw5AGtb+cM7i3WNjE9Jg1WHKCxusm5VqYjrdLFUMRtRxUTFYxFOue
   k4TA0Vc7zuycJEoXCI5sK6eTZc9eUDBtwcVqdQJxxX8lCLHPkN//uEMaw
   rsC45teT7GoE8JKvMSRygGQRTzOD01PAwvJuTgcoDJmFaU9jMIHNsYvck
   odtrddREtBGPUtCTQq2gbzV3EN2xArskvAPoTuhrwGxZ51fZIIFx6WQLr
   os617qT/ydNx3qtlB/zoHOUeXUVcOfQgWcOK1WAZDO55ns4+dbBbkwjc/
   w==;
X-CSE-ConnectionGUID: uFaWqLiZQfep3r0VOx0cFw==
X-CSE-MsgGUID: oftHOUx2RsCf2+O0YXcBzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20792897"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20792897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 11:48:58 -0700
X-CSE-ConnectionGUID: S0DADqZIT0OrZL/4gIWV0w==
X-CSE-MsgGUID: C5ET+3VmTCy6Ls92C0axJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55566368"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 11:48:57 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Support Granite Rapids and Sierra Forest OOB mode
Date: Fri,  2 Aug 2024 11:48:39 -0700
Message-ID: <20240802184839.1909091-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent intel_pstate from loading when OOB (Out Of Band) P-states mode is
enabled.

The OOB identifying bits are same as for the prior generation CPUs like
Emerald Rapids servers. Add Granite Rapids and Sierra Forest CPU models to
intel_pstate_cpu_oob_ids[].

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 392a8000b238..79b9c3c27dff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2425,6 +2425,10 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(INTEL_ICELAKE_X,		core_funcs),
 	X86_MATCH(INTEL_SAPPHIRERAPIDS_X,	core_funcs),
 	X86_MATCH(INTEL_EMERALDRAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_D,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_ATOM_CRESTMONT,		core_funcs),
+	X86_MATCH(INTEL_ATOM_CRESTMONT_X,	core_funcs),
 	{}
 };
 #endif
-- 
2.43.0


