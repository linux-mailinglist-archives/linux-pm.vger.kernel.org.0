Return-Path: <linux-pm+bounces-8400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938F8D4500
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 07:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F1B1C20FE6
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42D142E8C;
	Thu, 30 May 2024 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGm07yiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8142D792;
	Thu, 30 May 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048437; cv=none; b=D1X5uSLvlUKwEmqPqicYf1XY3MfA9BXIsNTPqZJQu+LQAfLwd/p+wnuy/HBsAC+B/yUuYSff6VRSm6NM90NoJzNsMNjWv8vGk4KpVesa90y89whtkBmvN7a4RFoPNYJEawyuA+oMX3wE2BzMpFX4KiKTHopJKYfw0ateNz10dDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048437; c=relaxed/simple;
	bh=pv7tQF2VXlehw/a5OV5HZ5dqYAvhntJPqQt7dKF48MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtpP3IvqBG5fTlUd1nEcIuqe0dSAC0XGM8UN4yvwLdrndUJbK5AkMte81Mg+Gu/FuwQSVvg/dvndbPIKbKPSQrSq4OyOnPCNBTwNXboNEOWyJ5yGkTFj6rKadt99zxEjL9w0aRkWZLqpDeyAOj1Ae7pG5/Noo0b5ga1j1owd86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGm07yiO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717048436; x=1748584436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pv7tQF2VXlehw/a5OV5HZ5dqYAvhntJPqQt7dKF48MM=;
  b=gGm07yiODf6VKrEuXkVuSS0urjiN5kAwhRZIj9t3b8lfWPyOGyFEzf1h
   7ChLxaYeC1xccvjoVvJN3U76/1XcC76i8O/h7On5YuiDzyrFfYxws9ntE
   xvxFkQIA0/gtiY//1pt+OrRNTh1cgP3GtuFqHYWDjqDiQ9dPh4nfkuWTj
   W43g3NArLPKtBLyhjC9jsnsHicpunSZ6V2ZXDkzuusa5SR73EdpNKOzhg
   kqOuB6Xp8YcKrBJ8ziXWs5bc7vX/F7ndihGO3CVLNhjqhFeac1M2jm0EL
   SZIts+cS7+b/WG6brSs4wYq/vqOq8xHaU9PNa//adPu4jnyZL1pVhm0Vc
   Q==;
X-CSE-ConnectionGUID: i5EZsrR/R3q47OXf13r09g==
X-CSE-MsgGUID: dJ2qmt6ATXab4aR/zKI/Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17296456"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17296456"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 22:53:56 -0700
X-CSE-ConnectionGUID: i0+ToGMfQk6+wsnZ+IpKOg==
X-CSE-MsgGUID: 9Vi8g3xJQMKB59JXkE/gDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35638589"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 22:53:54 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Support Emerald Rapids OOB mode
Date: Wed, 29 May 2024 22:53:30 -0700
Message-ID: <20240530055330.1279381-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent intel_pstate to load when OOB (Out Of Band) P-states mode is
enabled in Emerald Rapids. The OOB identifying bits are same as the
prior generation CPUs like Sapphire Rapids servers. So, also add Emerald
Rapids to intel_pstate_cpu_oob_ids list.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4b986c044741..6b6d47d3ec02 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2404,6 +2404,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(SKYLAKE_X,		core_funcs),
 	X86_MATCH(ICELAKE_X,		core_funcs),
 	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
+	X86_MATCH(EMERALDRAPIDS_X,	core_funcs),
 	{}
 };
 #endif
-- 
2.40.1


