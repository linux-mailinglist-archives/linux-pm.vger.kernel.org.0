Return-Path: <linux-pm+bounces-14941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5F98A793
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF051C20E34
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F41917E9;
	Mon, 30 Sep 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1zj5l4T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BC23D2;
	Mon, 30 Sep 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707635; cv=none; b=Xvj3sSyb1aSP0Txss4d6BcgNeePit4Ei9MoQENvIYR1XmxCpQHm8q6oorSJ72XNoZ3LYkGXj4/dgMyudeOeSqEJoFsl7l+6W6jsZA6VAqyul8N1RnAm2qkZS0Nsn14mGElwdP9GwKPUopqny8tv0Tu6YH5/rnEKVeT/XTMo9xfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707635; c=relaxed/simple;
	bh=Hry1X0VeuC1bEaNhwbkQROaJm0jnDNpE3hNkVrNT3vM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MqN4mL+CJQojwp2DraA5fDCwWh/9s38TvlYbIbgZy9Azrv8qSrwPYefJ0qvQzwvz1U9rjJv+p0vw4uJRnFetxI9yzxXP8ZsBWVbPV16bR/XaNThZPnqL4+cilT/mxHhSaftjBWu7F05wq4k+8l0W95YHdWKDf5OIcND+MhfDJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1zj5l4T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707633; x=1759243633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hry1X0VeuC1bEaNhwbkQROaJm0jnDNpE3hNkVrNT3vM=;
  b=K1zj5l4TYCuibheQwoJHL27HF+QzZUH9bdgwhT7+DsLgBX23bYaa8TDD
   iF/d815vnHNwQu5KrL3Xjgqjps+rp/0TdQmu9TDmRXq0Pl92DGCYiuPLH
   bcWUZ1zVLoa2lH3qNoNeezwqbbR212LfIWiaW/IPVB3f2H0nrnnWy+k+v
   1MY/SROwHU4jawqXoYHVSSFkow15mKExZp4cXFWr3ghSu4RgIzX/V+l59
   bP4pmkMIKPwKSx6DUVgMXCkPz6E36+GvFZQUd6IcT7k89j0xCE23n3gF9
   LMEUOi53i7LElI6zhW4cbcuSlVjPexkFiJb+E8HoYbbAFq4o0iHnpYz1s
   g==;
X-CSE-ConnectionGUID: R5cszCdfT1C2GBhbzrxVLg==
X-CSE-MsgGUID: zdlioCqIQZantuuEm0jGdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49324892"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="49324892"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:13 -0700
X-CSE-ConnectionGUID: uXd4xCleT7yf678RuJNi5w==
X-CSE-MsgGUID: ktDdk+KrSk+3CGy/2H8jwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78073452"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:12 -0700
Date: Mon, 30 Sep 2024 07:47:12 -0700
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
Subject: [PATCH v4 00/10] Add CPU-type to topology
Message-ID: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGa5+mYC/53NMQ+CMBAF4L9COlvSXgstThoXRwc3wwDtIU0UC
 CDREP67DYsGmRzfu7zvRtJh67Aj22AkLQ6uc3Xlg9wExJRZdUXqrM8EGEgWc0Uza6lpHrR/NUi
 ljVAqLAznivhJ02LhnjN3Iaf9+XAkqa9L1/V1+5qfDHw+rnsDp4zmWieJNoyjinc3Vz2eoat6v
 IWmvs/cAF8ELAnwRJGAyi1qkVm2TogPoXm0IIQnQEgeg4iAReqH2AR/T9Npmt4ZwoBsdgEAAA= =
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v4:
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
 arch/x86/include/asm/cpu_device_id.h               | 113 ++++++----------
 arch/x86/include/asm/processor.h                   |  11 ++
 arch/x86/include/asm/topology.h                    |   8 ++
 arch/x86/kernel/cpu/common.c                       | 148 +++++++++++----------
 arch/x86/kernel/cpu/debugfs.c                      |   5 +-
 arch/x86/kernel/cpu/intel.c                        |  15 +--
 arch/x86/kernel/cpu/match.c                        |  22 +++
 arch/x86/kernel/cpu/topology_common.c              |  11 ++
 drivers/cpufreq/intel_pstate.c                     |  14 +-
 include/linux/mod_devicetable.h                    |   2 +
 13 files changed, 186 insertions(+), 178 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Thanks,
Pawan



