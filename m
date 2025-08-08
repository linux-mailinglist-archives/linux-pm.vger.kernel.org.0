Return-Path: <linux-pm+bounces-32071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5DB1EAB4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4651C26236
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FD281368;
	Fri,  8 Aug 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfVt4dpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF802820DB;
	Fri,  8 Aug 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664688; cv=none; b=fx2ZCE8I9GUKW32VktYpY+PYWJti54QieY6CQt3cN75XU+9vsm108AQ0/uIW/QuQ7j8yK+K+roXFIMlVOWFpgOJzl6eojBx+r3/1aiwuIVRZDTGmNywtvcOj1glHV0kVHme2uoGlSRxR5/zsF6vCDGjuqIKIFO7/ZRyXscsTEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664688; c=relaxed/simple;
	bh=cL55OwtlGjrBS5hCIVcXHHF7EOSb2N5gSBr/Wd7QxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBYA5Nv10cOl49sSjBN7Ar+yognPo7P7j76N8rp+1VTnbN05YseQwXZ2DISvwyLa6bPX+x/kP5dnoKkBfbVyk1ExGh4i/fos1TFuoSZSwi3NjUGpaHjWpXwFLik3Vc9Pc/XXv68PsSLnP8auSnnyPq4Xl2oyB3LxODL9XRfCbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfVt4dpv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754664685; x=1786200685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cL55OwtlGjrBS5hCIVcXHHF7EOSb2N5gSBr/Wd7QxGU=;
  b=NfVt4dpvOsA3ejiSPlsG1PrBuPqsWmme4dv5WQLXUWye3q5Y+/IGXzk1
   vg2rV2shOf20frAT7Zz0aBHIJyqV80FVz0C0QbANZJoPUA1DFtGSvCAg2
   xZlqe78A87+pXpZLW/Nufj/DBQZwu/4V5agE1S44k9sx3FEva6dgj2Olw
   djFZXmtBCpPG3HYJbdLhPj3bxmMkNH6s+iv3HIp5Hj6qWFnBWrmPbv6sJ
   vdWUh0y1/BBo+OpnzCTkoBSLvnXNUzkRIj+kveYgypiLjnP9VeQk1Qx+8
   znMhKM3jaacTBEnKE8m/7/1+D05uPB5IUGRTpy3Jpf5aJVqTuZ5xfZ+UZ
   w==;
X-CSE-ConnectionGUID: kNSQgYMCTDKX/bCHzTuMmQ==
X-CSE-MsgGUID: 8QG7wZy3QfKFHu6TfwdPaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="82454760"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="82454760"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 07:51:24 -0700
X-CSE-ConnectionGUID: rVlP9pNzSi+F+bXyAh+u0w==
X-CSE-MsgGUID: F/qYz7usTsCpVwtsfSg3Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164854958"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa007.fm.intel.com with ESMTP; 08 Aug 2025 07:51:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Support Clearwater Forest OOB mode
Date: Fri,  8 Aug 2025 07:51:22 -0700
Message-ID: <20250808145122.4057208-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent intel_pstate from loading when OOB (Out Of Band) P-states mode is
enabled.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 06a1c7dd081f..f366d35c5840 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2793,6 +2793,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(INTEL_GRANITERAPIDS_X,	core_funcs),
 	X86_MATCH(INTEL_ATOM_CRESTMONT,		core_funcs),
 	X86_MATCH(INTEL_ATOM_CRESTMONT_X,	core_funcs),
+	X86_MATCH(INTEL_ATOM_DARKMONT_X,	core_funcs),
 	{}
 };
 #endif
-- 
2.43.0


