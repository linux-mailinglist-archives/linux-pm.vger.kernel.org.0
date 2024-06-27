Return-Path: <linux-pm+bounces-10144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695AA91B0B3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC745B24398
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306001A0B08;
	Thu, 27 Jun 2024 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIPp/VNU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A01A08DC;
	Thu, 27 Jun 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521044; cv=none; b=GKNijbW/p2F3718BDxEBsfqXs3dLJvoBhbslq45ukUMXWtbb5sPGiEReD5uoks5/Q6rPQNcDBYHb6YiHpKOtQxTRVFysIXB7tQDDVnoEnfTPUF/z4F8fdD6iVcSVCFD2f1KsyB1Z848jlRuSVXefZ2fMQblsvdxxX0TJu62WN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521044; c=relaxed/simple;
	bh=L7S2iIHXOFLzfLMAPa1fWF74VBRK6JJh9ZoKxTmb66M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pBhBN0/jLKGn2FOGC9DGvpaglE1eS1K0/IiSDOMVto85EVWuO/M3Jlaiz5f9kOq/5Mp1ggdsojJFV2rhmW5qj4/nTl2KULBHIvwpJ7/sGJZJPqKpldyZiKkjxsTrlS7Tz2htVlJh5dfAy0z2BJEnlrPtt+wnvzlcG4eA93FcIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIPp/VNU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521042; x=1751057042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L7S2iIHXOFLzfLMAPa1fWF74VBRK6JJh9ZoKxTmb66M=;
  b=dIPp/VNUO42nffuqds6NR/wjyDfxCmpy1uvgW+NhjfuHDMzZB1Mc3bXO
   vhLdgKyR2biaHDVb0m+BYyH8zaFqQhQFYrwnxyqlvU1Z3JROA+O6L77dt
   HZwXP7/E8aR5VDLjeKvMDqmyckYS8SFA+zM3L6Pm1zpnqQ/UM+on5kWBL
   fa9XOmvHKY7rRFUMaEG5KVot1G67oB9csHiO+mL6hMMZF8/uOKQUei3ct
   TGz7lUpKr4yXHgD9cNZNumBqkfe99zMHQ8Mq82LrwTU/pDyQ7qyP1gYiY
   Ely7GnEyKzrWM9OEBjVqyomqIDiH8jfZ78t9kK1j0QR0eeph+i17HPsIj
   g==;
X-CSE-ConnectionGUID: lFT7hkiwQbW15+7zP048tQ==
X-CSE-MsgGUID: riEuzdE2TkmLTXqspItc4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27816173"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27816173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:01 -0700
X-CSE-ConnectionGUID: xfNG5JCFREGJRSwwBFel5g==
X-CSE-MsgGUID: BPwqrB/xTWWCmXoJQ69LOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44913214"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:02 -0700
Date: Thu, 27 Jun 2024 13:44:00 -0700
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
Subject: [PATCH v2 0/9] Add CPU-type to topology
Message-ID: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAL/OfWYC/22NsQ6CMBRFf4W82UdaghScMC6ODm6GAduHvAQLa
 YFACP9uw+x47s09dwNPjsnDJdrA0cyeexsgOUWg29p+CNkEhkQkqcikwtoY1MOE4zoQpuZMqaJ
 GS6kgTAZHDS+H7gWP6/N2hyrELfuxd+txMsuj/O+bJQp853lR5FpIUlnZsZ2WmO1IXaz7L1T7v
 v8AislRhrUAAAA=
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2:
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

* Patch 1 adds hardware cpu-type to CPU topology structure and introduces
  topology_hw_cpu_type().

* Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
  topology_hw_cpu_type().

* Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.

* Patch 8 cleans up the affected CPU list.

* Patch 9 uses the CPU-type to exclude P-only parts from the RFDS affected
  list.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (9):
      x86/cpu/topology: Add CPU type to struct cpuinfo_topology
      cpufreq: intel_pstate: Use topology_cpu_type()
      perf/x86/intel: Use topology_hw_cpu_type()
      x86/cpu: Remove get_this_hybrid_cpu_type()
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/bugs: Declutter vulnerable CPU list
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/include/asm/cpu.h                         |   6 -
 arch/x86/include/asm/cpu_device_id.h               | 117 +++++++----------
 arch/x86/include/asm/processor.h                   |   3 +
 arch/x86/include/asm/topology.h                    |   9 ++
 arch/x86/kernel/cpu/common.c                       | 138 +++++++++++----------
 arch/x86/kernel/cpu/debugfs.c                      |   1 +
 arch/x86/kernel/cpu/intel.c                        |  16 ---
 arch/x86/kernel/cpu/match.c                        |  22 ++++
 arch/x86/kernel/cpu/topology_common.c              |   9 ++
 drivers/cpufreq/intel_pstate.c                     |  14 +--
 include/linux/mod_devicetable.h                    |   2 +
 13 files changed, 168 insertions(+), 179 deletions(-)
---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Thanks,
Pawan



