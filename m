Return-Path: <linux-pm+bounces-23849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D539A5C462
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17081898EF9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC925DCEA;
	Tue, 11 Mar 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+TjEsLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59725DB0B;
	Tue, 11 Mar 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705316; cv=none; b=DU10BNjga9DwSoHKfOsl82DqNm/sS0y7vmp+yUwY/jbRwFNKBB2hRcTlZpwG9XHHtHHtRtbMyidvKUe+d2TQgneb9AH7xYs6kgSwdLyXoNCkdcjJyAFGV4dbH/D7PoIdGXPDZu+Jn7yu5DQ5Z8Ts1X2ByNwu8cQWoLD7/CyBgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705316; c=relaxed/simple;
	bh=fuWRE5LahWg9e+Ft/lsdND0Y6JC1QqXUC2BZ/1jEt/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ph0o8lte8SWWEnSy61AGFL73TCho6g9fCTejoVXxyTFwQZgcUBJj5SY/rZhykuyCzoKX9VcpRS7VAYZveeOE2edZ8zREyNop33IeXajcze5zCr8cV9DNhem60xgiWDDOLPaI1Tu69qeLaefYvuUKsvKo+u61f+Kofnt/aW2e9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+TjEsLe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705314; x=1773241314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fuWRE5LahWg9e+Ft/lsdND0Y6JC1QqXUC2BZ/1jEt/s=;
  b=R+TjEsLe7ZHnzmh9VA6n+DupPf7+EvIqOHVxRu/yeXVF81fhodbD2PyY
   +KAzJfqFC2BubmlAA11zij8nFcHr9oS8dqT5nHxZifcn7QSh0NHGMfFoK
   LZu/Ng/NFAOXIxyq3E36Odk+qVh8Ti9Hzz/EI2C60/YsF/BPqAWseNT7d
   QGnT0gzxJ5VDz14ntm0ojyJdyPPgApQbQaHJ17Y1AD7YBpynEX3w8d4in
   921rbktCVh4XD4lLqpyLFVKRpPQtAsoYz733KNNcQOBkrTFYlzw9Gd5P3
   ItrO85ugBXdRHau9bdg716cD7EBlKVkiB1JZCH28WXkvcBdNyjx3QwsBd
   w==;
X-CSE-ConnectionGUID: jZrqZvKtTbqo7FD1LI6R+Q==
X-CSE-MsgGUID: sSwba3otS56nRevpWP/b/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="68112561"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="68112561"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:01:53 -0700
X-CSE-ConnectionGUID: IgI9R/mFTye5HfzOOYQwtA==
X-CSE-MsgGUID: dM44kLvEQsmfYM22H1LVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120850498"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:01:50 -0700
Date: Tue, 11 Mar 2025 08:01:49 -0700
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
Subject: [PATCH v8 0/5] Utilize cpu-type for CPU matching
Message-ID: <20250311-add-cpu-type-v8-0-e8514dcaaff2@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADdP0GcC/6XRwU7DMAwG4FeZcl4m20nqdCcQF44cuCEObZOwS
 KOb2q7aNPXdyYpgqCsXODqWvz+yz6L1TfStWC/OovF9bOOuToVdLkS1Keo3L6NLtSAgDRmyLJy
 T1f4gu9PeS+2M1+xDhcgijewbH+Jx5F7E0/3zw6N4Tc+b2Ha75jSG9Dg2570eJcjS2jy3FaDn7
 G4b68NxFevOb1fV7n3kevpB0JSgRIScuHTeqsLBPKGuhEUzIVQiSGnMSBkCwzfEcvHn0TFdX9N
 zBRNCJwJB25xKLkoT5gnzTSAhTghz+UXhASEYUPzLDrJ/EZ87SD2Y7iBLo5o1sjJl5djMp/NX+
 oXIJgSPRwQVSiAKTt8SwzB8AChunb29AgAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v8:
- Zap the unused macro X86_MATCH_VENDOR_FAM_MODEL_FEATURE() (Borislav).
- s/cpu_type/type/ in struct x86_cpu_id (Borislav).
- s/boot_cpu_has/cpu_feature_enabled/ in x86_match_vendor_cpu_type() (Borislav).
- Added patch to fix X86_MATCH_VFM_STEPS() documentation.
- Rebased to tip/x86/cpu.

v7: https://lore.kernel.org/r/20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com
- Moved the CPU table cleanup patch out of the series, it does not relate
  to cpu-type detection. Will send it separately.

v6: https://lore.kernel.org/r/20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com
- Use the recently added macro VULNBL_INTEL_STEPS() in the affected CPU
  list cleanup patch.
- Rebased to tip/x86/cpu.

This series is now the remaining last 4 patches from the original series.
Other parts are:

  Part-1: 45239ba39a52 ("x86/cpu: Add CPU type to struct cpuinfo_topology")
          is merged upstream.

  Part-2: Is below list of patches that are in tip tree branch x86/cpu:

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
      x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/include/asm/cpu_device_id.h               | 130 +++++++--------------
 arch/x86/kernel/cpu/common.c                       |   7 +-
 arch/x86/kernel/cpu/match.c                        |  30 +++++
 include/linux/mod_devicetable.h                    |   2 +
 5 files changed, 81 insertions(+), 96 deletions(-)
---
base-commit: 55d9f0b05e1ca53c0884545445b7e29466679a33
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Pawan



