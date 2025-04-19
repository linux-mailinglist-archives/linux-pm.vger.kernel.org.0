Return-Path: <linux-pm+bounces-25739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04306A94121
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 04:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11108461B6C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E814AD2D;
	Sat, 19 Apr 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKXh/Ejx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2513C914;
	Sat, 19 Apr 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030992; cv=none; b=qujSauoReaLvhRyE6+CYghw9U4inhpBJgXV6hgFkhH0S1a5xeKarx/Dn1BfKryZEhaOjHLbTtRJNcWpzRyBm08r27EVjDlNcIF3ksB+iJXoX59w01iefjkfVfbDVxKTiJusH1HGvNVioLYZAoIl6VOWPdpa/hMC9bN+6iGU2g24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030992; c=relaxed/simple;
	bh=DWr1M3/1WFJWYL+2i47OY+FQX2kpR5SCGJNTqk1oR3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vD9ai4XQ9eizj53c42+piXGYS9IBZ0e4z4HVw8St1Qvr/1weBo1uK5Vg3SZmroSkQOGUsIYGnrUfWda8cr6XRrD1peAjMwFFo2M6pZIoAjnMCsqOo0q2sraMKxuZaZafo4jUCgpbdqXPd+eHDg4MulHcvU9GLpknO8Ipbh1QMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKXh/Ejx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745030991; x=1776566991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DWr1M3/1WFJWYL+2i47OY+FQX2kpR5SCGJNTqk1oR3k=;
  b=nKXh/EjxEcpS43dcdZVNJLZRUh+dRS4PJzuw5/mUaC4IqOTh3dPgWF8i
   H7RfBSzM2KLCBKbSxPV/cViFqwb1ypQ/ugv+FZPbq0S7PKnrVQGgJCLmH
   NToemBaf5WGTuV/Bwzkynh+dHznel2cseeMrlgk4xAJfUIEdzzduCzhCP
   Ln6mBDnvMAdFbie9WHuNkLdkoHhjYZRimSD/98qIcCZ7RGZR9j8GMwXKS
   GZ4KDSBYDqWbGglXd7sejGLeF7v5OPWlqn1Ufc4wWM9P4kWyGb1s+MWaX
   reJ7VeGBG2c3E0O481mZyt7bWqN2nUL838PBDnygn8BwnY8A/Rp/wEK/T
   Q==;
X-CSE-ConnectionGUID: bV3Y6dpxR764AwOta1tQEQ==
X-CSE-MsgGUID: KTonbXOFQ0CzLMOsltbfJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50490439"
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="50490439"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:49:48 -0700
X-CSE-ConnectionGUID: +P+se+pHR2mdjGxD+q3xQw==
X-CSE-MsgGUID: ZDB6M73jSYS2ozYNqlusuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="162308324"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP; 18 Apr 2025 19:49:48 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Populate the cpu_capacity sysfs entries
Date: Fri, 18 Apr 2025 19:55:04 -0700
Message-Id: <20250419025504.9760-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
References: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Intel hybrid processors have CPUs of different capacity. Populate the
interface /sys/devices/system/cpu/cpuN/cpu_capacity.

This interface uses the per-CPU variable `cpu_scale`. On x86 this variable
has no other use besides feeding the sysfs entries. Initialize it when
setting CPU capacity for the scheduler and scale-invariant code. Feed it
with arch_scale_cpu_capacity() as it gives capacity normalized to the
interval [0, SCHED_CAPACITY_SCALE].

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4aad79d26c64..c32312843f19 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -952,6 +952,8 @@ static void hybrid_set_cpu_capacity(struct cpudata *cpu)
 			      cpu->capacity_perf,
 			      cpu->pstate.max_pstate_physical);
 
+	topology_set_cpu_scale(cpu->cpu, arch_scale_cpu_capacity(cpu->cpu));
+
 	pr_debug("CPU%d: perf = %u, max. perf = %u, base perf = %d\n", cpu->cpu,
 		 cpu->capacity_perf, hybrid_max_perf_cpu->capacity_perf,
 		 cpu->pstate.max_pstate_physical);
-- 
2.43.0


