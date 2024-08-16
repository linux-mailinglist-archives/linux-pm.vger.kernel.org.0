Return-Path: <linux-pm+bounces-12288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC70954053
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F333F1C21F05
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAD8172D;
	Fri, 16 Aug 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnBggVm9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5E83CA3;
	Fri, 16 Aug 2024 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781172; cv=none; b=JZuPuuseeUozb4yfFf81I/0yblLw5DqSH36Zj0CENunxiEdIpqC2R8XRueD/5FllA8V8XX4OOezUYIDBacWA1RBCiS76Pw7E0MEAuh3bXJxAwT0XlX69NIhl//Duic45w5mnEiU88U38Pz0KG0dmVE+p2otjQb9LEBRb5eG01DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781172; c=relaxed/simple;
	bh=n0ruelWa1K0RdX6HHukYBNyGt1SotlYfimIxVFx98c8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bJ/aZSS8rfQqxuKsspuqrXDsqIlD/90a/I1aG0q+/3XkLfRSPHrJsUygoVM7FZB6r54pg/jk3sYRKcR8qMvuY8BppgkVfVVNoj4fix2QqjxKvqYV+WydvT7yjKzFAnrB0LKXOpMCwWOI99PCWwn8FJdxEoj6yybtogO6pmmp/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnBggVm9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781171; x=1755317171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n0ruelWa1K0RdX6HHukYBNyGt1SotlYfimIxVFx98c8=;
  b=bnBggVm9Jk//GLW9bhHjATc/kwHpUQ9S6BwkdpxWhcn01w/9UXpYp4gA
   9WmH2uKoBZZSMm7BWy2RZCWgxS2UF4bNFjyynelTbb3rW0HQcyWzm6hv3
   ryxNO5DfyhigyZALGdA7qx6L/fscwDtDSXoGMDrWpUXB+b6NijOhz/YFx
   /pWN9xsuwsXPnC4b84gQRlcV5rNyH0wDNGGx3XeBYmYPSKwYVhArcT5Ce
   q8o14aE8ZH9DanAwUML0o4Z67RiX6DfVYVJnMoPSLLTSA5wICFxRLwt4z
   1cI64znz+D81MjYGsvQZl9A5xYpBXo6dN/3XhqmPscIc8bMT5r/qvPUEk
   w==;
X-CSE-ConnectionGUID: 5hLo1d37RTKHa3eH9MPMQQ==
X-CSE-MsgGUID: OxDuPOnCQ0CbJyl4JuLFsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21947240"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21947240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:09 -0700
X-CSE-ConnectionGUID: ViH7tl/5QYSdSIKX19zBPA==
X-CSE-MsgGUID: I8tC1bTxSVKKUQZsa6xvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59237001"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:07 -0700
Date: Thu, 15 Aug 2024 21:06:07 -0700
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
Subject: [PATCH v3 00/10] Add CPU-type to topology
Message-ID: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAMjPvmYC/23NsQ6CMBQF0F8hnS1pC9LipHFxdHAzDtA+pAkW0
 kIDIfy7TSejjvfdvHNX5MBqcOiQrMiC1073JoRslyDZVuYJWKuQESMsJwXluFIKy2HC4zIAztU
 ecg6NpJSj8DJYaPQcuTu6nm7nC3qEc6vd2Nsljngay/+ep5jgWoiyFJJQ4MWx02aaU21G6FLZv
 yLn2QfBvgkWiKZkvFYgskqRX2Lbtjcai+pI+AAAAA==
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v3:
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
Pawan Gupta (10):
      x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
      x86/cpu/topology: Add CPU type to struct cpuinfo_topology
      cpufreq: intel_pstate: Use topology_hw_cpu_type()
      perf/x86/intel: Use topology_hw_cpu_type()
      x86/cpu: Remove get_this_hybrid_cpu_type()
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/bugs: Declutter vulnerable CPU list
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/events/intel/core.c                       |   3 +-
 arch/x86/include/asm/cpu.h                         |   4 +-
 arch/x86/include/asm/cpu_device_id.h               | 117 ++++++----------
 arch/x86/include/asm/processor.h                   |  11 ++
 arch/x86/include/asm/topology.h                    |   8 ++
 arch/x86/kernel/cpu/common.c                       | 148 +++++++++++----------
 arch/x86/kernel/cpu/debugfs.c                      |   5 +-
 arch/x86/kernel/cpu/intel.c                        |  15 +--
 arch/x86/kernel/cpu/match.c                        |  22 +++
 arch/x86/kernel/cpu/topology_common.c              |  11 ++
 drivers/cpufreq/intel_pstate.c                     |  14 +-
 include/linux/mod_devicetable.h                    |   2 +
 13 files changed, 188 insertions(+), 180 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Thanks,
Pawan



