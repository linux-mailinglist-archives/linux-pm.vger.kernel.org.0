Return-Path: <linux-pm+bounces-23536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B15A54359
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 08:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD853A8EE5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB031A8F79;
	Thu,  6 Mar 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEHlhcWK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537819DF4D;
	Thu,  6 Mar 2025 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245155; cv=none; b=fw+6dGrPE7HI/RUHt9lcBSf1C80Y+wcfpk5KZxMygZSlE4cy9lFugfmNcGSXNwXFrUsevSjUQ4bme7Hkj2UE1v2XsVYqY9lr4HSr4yCSMj+pJkHgGNZ78ChA5i6gLbBY9F9dVWeZXj80e3FVnPfyNDE0Gd8ELO1dsXAhBAirNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245155; c=relaxed/simple;
	bh=XVyqCYItYefM7maFPhyRQZzBwu4TRqmF91dX8ytWVSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EhCk35OP+nGAEVY4Lxmg6g3F7/eyp1BZinD+nIzsqmAy06fmddrbR537AtI1WwGKd77/RogP6CDdaoNPTqi+KAuWv/HHCxiNJt9zO5yXpt0SAwbe5F8QMthRWBkbzx+jtOwTFE/TVSlPmrP3GkGt2M4iU2izK1re+GzI0xrYzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEHlhcWK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741245153; x=1772781153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XVyqCYItYefM7maFPhyRQZzBwu4TRqmF91dX8ytWVSo=;
  b=OEHlhcWKnMAwyG/NehKyxyIhuln24UWFQXv0hYX5E76143Z9SLJhpCOf
   qkM1WNYq6KCdpJ9jX1mOZe+evgmYhBCWm1X5zXhdTNYOenfes2hLyT0j9
   ujDSoH0KO+xVsto56/fXIG6WIKbHwbIwnhIF28twwK6Tw4gHliVFWkWm5
   IqiDustL+S8Man6f/YpckNikzwVolLjg/d7De2HWxWkxLxg/bUyZb/MxC
   1DY/zPLurt5RC9AI388XjlyA/w0pGpoZOUVGL7YakO8o2VrYQe05nc6ZF
   gYPTCeieqlBED/M/gJY7YmiwRxYXDIrZmbGi2GPFypBJRR72rnvreiEWm
   g==;
X-CSE-ConnectionGUID: W0bwzQruROy1zV+EWub6kw==
X-CSE-MsgGUID: WxKamqpxRFWxMtd4fqptgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41490137"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41490137"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:12:33 -0800
X-CSE-ConnectionGUID: 6ZOLmcTPSoyAwGRlO7hv1w==
X-CSE-MsgGUID: Wdwtya0nTJWROTJZ83ocjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="124032112"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:12:31 -0800
Date: Wed, 5 Mar 2025 23:12:31 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v6 0/5] Utilize cpu-type for CPU matching
Message-ID: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIACpGyWcC/6XQwW6DMAwG4FdBOTeV7SQk9LRplx572G3aAYhZI
 3WAgKJWFe++jMM6MXbZjrbl77d8Ez13gXuxS26i4zH0oaljkW4SUR7z+o1l8LEWBKQhRStz72X
 ZnuVwbVlqb1hbrkpEK+JK23EVLjP3Ig6Pz0978Rrbx9APTXedQ0ach+veiBJk4VyWuRKQbfpwC
 vX5sg31wKdt2bzP3EjfCFoSFIkqI1t4dir3sE6oO+HQLAgVCVIaU1KGwNgfxCb58+qcru/pmYI
 FoSOBoF1Ghc0LU60T5otAQlwQ5vOKnAGhMqDsLz9I/0dM0/QBtG2LXj8CAAA=
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v6:
- Use the recently added macro VULNBL_INTEL_STEPS() in the affected CPU
  list cleanup patch.
- Rebased to tip/x86/cpu.

This series is now the remaining last 5 patches from the original
series. Below are previously merged patches:

- Upstream:
  45239ba39a52 ("x86/cpu: Add CPU type to struct cpuinfo_topology")

- Tip:
  x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
  cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
  perf/x86/intel: Use cache cpu-type for hybrid PMU selection
  x86/cpu: Remove get_this_hybrid_cpu_*()

v5: https://lore.kernel.org/r/20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com
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
Pawan Gupta (5):
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/bugs: Declutter vulnerable CPU list
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/include/asm/cpu_device_id.h               | 115 ++++++----------
 arch/x86/kernel/cpu/common.c                       | 148 +++++++++++----------
 arch/x86/kernel/cpu/match.c                        |  30 +++++
 include/linux/mod_devicetable.h                    |   2 +
 5 files changed, 153 insertions(+), 150 deletions(-)
---
base-commit: 4f2a0b765c9731d2fa94e209ee9ae0e96b280f17
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Pawan



