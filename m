Return-Path: <linux-pm+bounces-19088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C89EDFA0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38A3161695
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C551D8A0B;
	Thu, 12 Dec 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq/bKdJh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F43201;
	Thu, 12 Dec 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986642; cv=none; b=d4TiLjxrG+kRpyYRMBTyNMJQyvhPDLunJCRGmGREebGQFjj6AtPorISVttCxfCDkJnB+ywfsF9N/raWBSMJSWLm+tYo/LW5tUKymijFmlcyI2t40yhpe5zEdLFmTBlMeRQ1yYi/y7x1ftBh4gEXayb+IaNFzlHeDoOoqoYe4W+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986642; c=relaxed/simple;
	bh=zemprK3Ajf40OMdp0zYE61ZyRPe9NnFdl3r3eBNqvYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QjwR/xKQDGF+y9B6Z4KBjj2Sg4sVh/K7mJUCrikc4zW4Cde1mg5WQIgUm6WOxdaSmGxBYFAUxySpd3XLwvc1ypNuXZIKEBZADq4H+hO7/oPGlK3D5XKZt/Dtr/LxRJ7AfDURcCo/yZZ8Z+RVuL8gd30f6XoDNzMSQmgDuyTJq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq/bKdJh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986640; x=1765522640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zemprK3Ajf40OMdp0zYE61ZyRPe9NnFdl3r3eBNqvYU=;
  b=jq/bKdJhZSSFY5k8FrT3U2JsjMY5BZV5k5eQf6mLbaNlbJXgQi8o0agp
   A8mRBzTP/qkffmJR/CxBXg1QJVS0yTmYyG8PxNHTA5akn0LYux5Db0FNs
   CyByJPLL+rLYr9iLGvFkwu9ATcuJrY8M5tVMHgj2PQLQ+qQG2wOtds0UE
   7Guj1xPK6gTlvwawhXTYdR5ALK2WzJvVblDRTFvC8YHwM+4QcpZ2nof+t
   KXOw7RiXrIOluJx4tOIiqpAo3dzOXnsx3fAuYjRIvfsV0d1DXrfh4nNGx
   R/2QqRGKrNKhWa3yo1Ivsw8YnbAU5o0dh4fWdaQ8oUlCExMSdAl7/sKdX
   g==;
X-CSE-ConnectionGUID: 04kGaoXGSDqhwGxvEj0PEA==
X-CSE-MsgGUID: g82i9p5GQA2JFfM8PmIXKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="59786294"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="59786294"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:19 -0800
X-CSE-ConnectionGUID: uXW7xcUGQFaLQCWqazDVZw==
X-CSE-MsgGUID: FF14Z7zMSa6in/N2fCQxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96372101"
Received: from unknown (HELO desk) ([10.125.145.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:18 -0800
Date: Wed, 11 Dec 2024 22:57:17 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 0/9] Utilize cpu-type for CPU matching
Message-ID: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANGIWmcC/53NMW/CMBAF4L8SecbId7Zjm6lVl44dulUdEvsCl
 iCJkhCBUP57LS9UgYnx3el978ZGGiKNbFfc2EBzHGPXpqA3BfOHqt0TjyFlhgKVKMHwKgTu+zO
 frj1xFTQpQ40HMCxV+oGaeMncD/t6//74ZL/pfIjj1A3XPDJDfj73ZuCC19Y6Z70AMuXbMbbny
 za2Ex23vjtlbsZ/BK4JTETj0NSBrKyCeE7IO2FBrwiZCJQKSpQahTYPxKZ4uZrX1X3dSbEiVCJ
 AKOuwNlWtm0diWZY/u0wQobkBAAA=
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

45239ba39a52 ("x86/cpu: Add CPU type to struct cpuinfo_topology") is
already upstream, this series now adds the usages of cpu-type.

v5:
- Replace usages of get_this_hybrid_cpu_native_id() with its cached value
  in CPU topology structure.
- s/x86_match_cpu_type/x86_match_vendor_cpu_type and add vendor checks
  in the function.
- Some cleanups in intel_pstate.c.
- Collected tags.
- Rebased to v6.13-rc1.

v4: https://lore.kernel.org/r/20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com
- Series doesn't apply to upstream cleanly anymore, rebased to v6.12-rc1,
  resolved the merge conflict in files:
	arch/x86/include/asm/cpu_device_id.h
	arch/x86/kernel/cpu/common.c
- Remove redundant "hw_" in intel_hw_native_model_id().

v3: https://lore.kernel.org/r/20240815-add-cpu-type-v3-0-234162352057@linux.intel.com
- Add a patch to prepend "0x" to hex values in cpu_debug_show() (Borislav).
- Add support to to also get Intel Native Model ID (Dapeng).
- Keep similar models together in the affected processor list (Josh).
- Add a comparison of .init.data in commit message for cpu_vuln_blacklist
  before and after decluttering patch for affected processor list (Josh).
- Drop the debugfs file reference in the commit message (Borislav).
- s/cpu_type/hw_cpu_type/ (Borislav).
- Add a union for hw_cpu_type for easy retrieval of intel_core_type and
  intel_native_model_id.
- Updated commit messages, collected tags.
- Rebased to v6.11-rc3.

Note, I will be off work till Tuesday, will reply to any comments then.

v2: https://lore.kernel.org/r/20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com
- Move CPU-type to the end of the CPU topology structure (Andrew).
- Use c->cpuid_level instead of cpuid_eax(0) (Andrew).
- Move CPU-type enum out of ifdef CONFIG_NUMA (kernel test robot).
- Rename cpu_type to hw_cpu_type (Borislav).
- Explain replacing get_this_hybrid_cpu_type() with topology_hw_cpu_type()
  in the commit message (Dave).
- Fix the alignment in cpu_vuln_whitelist (Andrew).
- Add the obj compare note in the commit message (Dave/Tony).
- s/X86_CPU_TYPE_INTEL_ATOM/ATOM/ in cpu_vuln_whitelist (Dave).

v1: https://lore.kernel.org/r/20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com

Hi,

This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
differentiate between hybrid variants P+E, P-only, E-only that share the
same Family/Model/Stepping. One of the use case for CPU-type is the
affected CPU table for CPU vulnerabilities, which can now use the CPU-type
to filter the unaffected variants.

* Patch 1 fixes a minor formatting issue in cpu_debug_show().

* Patch 2 adds hardware cpu-type to CPU topology structure and introduces
  topology_hw_cpu_type().

* Patch 3-5 replaces usages of get_this_hybrid_cpu_type() with
  topology_hw_cpu_type().

* Patch 6-8 Updates CPU-matching infrastructure to use CPU-type.

* Patch 9 cleans up the affected CPU list.

* Patch 10 uses the CPU-type to exclude P-only parts from the RFDS affected
  list.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (9):
      x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
      cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
      perf/x86/intel: Use cache cpu-type for hybrid PMU selection
      x86/cpu: Remove get_this_hybrid_cpu_*()
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/bugs: Declutter vulnerable CPU list
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/events/intel/core.c                       |  19 +--
 arch/x86/events/perf_event.h                       |  19 +--
 arch/x86/include/asm/cpu.h                         |  14 --
 arch/x86/include/asm/cpu_device_id.h               | 113 ++++++----------
 arch/x86/include/asm/intel-family.h                |  15 ++-
 arch/x86/kernel/cpu/common.c                       | 148 +++++++++++----------
 arch/x86/kernel/cpu/debugfs.c                      |   4 +-
 arch/x86/kernel/cpu/intel.c                        |  31 -----
 arch/x86/kernel/cpu/match.c                        |  30 +++++
 drivers/cpufreq/intel_pstate.c                     |  15 +--
 include/linux/mod_devicetable.h                    |   2 +
 12 files changed, 183 insertions(+), 235 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Thanks,
Pawan



