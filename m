Return-Path: <linux-pm+bounces-8493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4E8D6C9F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 01:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D252897C9
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBD82D72;
	Fri, 31 May 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3Y7BDn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A22824BD;
	Fri, 31 May 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196417; cv=none; b=Y6SLu9WuQIjGSMU1TxWtn7XNYD4E/pWwyFxykYRM5uLXCYlsxBlsCJprR5VUBigFM+BSuh+0Fl0yh2XcupqU5UYdTi7Gg2JVt1S7ADj12x4mDssu8yWNcR0OpZPoRoa5WuDxbkGht9vqghzmcTQaLZnfzAkeTGqmFZ4PQ5ijwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196417; c=relaxed/simple;
	bh=UBKKEvM9H27lQntnnS2zBRYXzaOTwI7iiVKSj/re3/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyWPqcxf4brdD8xeML2r7Tphj1M8XYwGQ2YvUPNNCwscHskPlkp0sBX+FAE/gSav2CtZGMuSabdMzlaIt9e0qu6fyuu79ZTRM17jCY9kr+4ybhwpBEtBl8X05V4my6sfOKyJqMM5woR27iO4tkjBPyoq5WYriIqpgdsjnHAUtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3Y7BDn/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717196412; x=1748732412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UBKKEvM9H27lQntnnS2zBRYXzaOTwI7iiVKSj/re3/E=;
  b=a3Y7BDn/tzgIoMEPgQyXFyKmPZdnEctDzOxbNxcC37XWUXbco6dbHUj4
   blYcOoN/SaFUHviitBZa0HEA/W3N/5M6LJxa9V68sdTOQD83W/vf+ZjWI
   2Qw1HYfHWUySOHWx6r+kpaFyuXNI2Az4VoCMU+lY/WF6K7ogWpbrDn1K8
   xhqL2K4JxRKMH47jjVLKKeoi4PrD+yiDd1ciF0yOKjyO/aJyBCUeibEFj
   bbhGQ1lzEALCHchEPa+E5yBWSaRI14nNDYl10XhQkma2kOVJJgDuBJc17
   ApRrUDSuWRijR9xl0deUQK54wDRGOXKNaPf0dNtjZ9qGV995hMCkDhLI4
   w==;
X-CSE-ConnectionGUID: qO0d2jO4TbiMx6GH0xzu7Q==
X-CSE-MsgGUID: eGATJ6nWSlygH5XJdv16NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13514278"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13514278"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 16:00:11 -0700
X-CSE-ConnectionGUID: Q352bnSrRZi8XXTsWTcQTA==
X-CSE-MsgGUID: ViEn5M/oRPm/8BztsJPpEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="41226739"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2024 16:00:10 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cpufreq: intel_pstate: Fix unchecked HWP MSR access
Date: Fri, 31 May 2024 16:00:04 -0700
Message-ID: <20240531230004.1334127-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix unchecked MSR access error for processors with no HWP support. On
such processors, maximum frequency can be changed by the system firmware
using ACPI event ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED. This results
in accessing HWP MSR 0x771.

Call Trace:
	<TASK>
	generic_exec_single+0x58/0x120
	smp_call_function_single+0xbf/0x110
	rdmsrl_on_cpu+0x46/0x60
	intel_pstate_get_hwp_cap+0x1b/0x70
	intel_pstate_update_limits+0x2a/0x60
	acpi_processor_notify+0xb7/0x140
	acpi_ev_notify_dispatch+0x3b/0x60

HWP MSR 0x771 can be only read on a CPU which supports HWP and enabled.
Hence intel_pstate_get_hwp_cap() can only be called when hwp_active is
true.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linux-pm/20240529155740.Hq2Hw7be@linutronix.de/
Fixes: e8217b4bece3 ("cpufreq: intel_pstate: Update the maximum CPU frequency consistently")
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4b986c044741..65d3f79104bd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1153,7 +1153,8 @@ static void intel_pstate_update_policies(void)
 static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
 					   struct cpufreq_policy *policy)
 {
-	intel_pstate_get_hwp_cap(cpudata);
+	if (hwp_active)
+		intel_pstate_get_hwp_cap(cpudata);
 
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
-- 
2.25.1


