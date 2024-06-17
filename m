Return-Path: <linux-pm+bounces-9298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D490A92F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F86228929D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93719069E;
	Mon, 17 Jun 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgscpUQe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D902191474;
	Mon, 17 Jun 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615484; cv=none; b=VLtBIWX7bPtM+t4d4qqRmTES3ptujBg7cAjkSjP2EZYnV5GUc5W5aaJF8U5Fq16tyegr9+avyC4Xhx9KCZDX1okkqMp4fhl+YWGOfoqWBtHk6QnXIW3y86LM1SUIglo8ZnWp542+K+V8OjuZWcX4BTz9o6JttXUmmI6EViOhIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615484; c=relaxed/simple;
	bh=yDkDY+atxj6/iCmlp8Kvft2mlR0abXZ103PkF5fgC40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hU8EwdlJ8MVgB+QFNLYCdzUy7qsL8qTJs9CO4xoU4OvymtjXtbRUp3wNC9+S2Bd88uV07kpImAIIodTqbANcthIHyjw/64u6PvEPwaqXEkongoHGmEViy4X1p6HlzPxx5gup9wBkUS8yZ5Wh+Yq83PQnYVfYH/GyjQIb1N/3Slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgscpUQe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615482; x=1750151482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yDkDY+atxj6/iCmlp8Kvft2mlR0abXZ103PkF5fgC40=;
  b=FgscpUQepxVHW8+MIuU1Yqa5j+LCFqUTv5YHL07/iDQ+9JiHryvvHteW
   RlVIlKFyr5v26ZePEaK5ZFtXd7WYkW1OQrEL7GXaz1WLXeAKpxt/X9zIO
   Ssk8biNPikbYhTuVxr4R7bbEfUq8BSp/5pZ1+Bk+KtSS0PVR3CWeGSnYp
   RoPIH/MO4yyMlHuxJLHX5BFtjcaq1HdBHT7TJLadPkF4mj6zZ9jI74d/f
   wt7eUX5mIxUXOS7X53kEooW2bke1Dig2Go/cTS3mXvhdbMBD2On2isldY
   G5ekR9Rk33XvEMkSYBcZAXSJ5uISM2+QKooJ7xp3ULZbls1kpEIeG1Z7t
   g==;
X-CSE-ConnectionGUID: bmZGH1K9Sry/L36Ss5hcZg==
X-CSE-MsgGUID: BWiebSziQ0iQn5gDgTcozw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="12106309"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="12106309"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:21 -0700
X-CSE-ConnectionGUID: 8hfOCDk8QwiZurPXAFrmiw==
X-CSE-MsgGUID: kfz0Wi+1RnqfEZvO+9vGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41852124"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:22 -0700
Date: Mon, 17 Jun 2024 02:11:20 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 0/9] Add CPU-type to topology
Message-ID: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAMv8b2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3cSUFN3kglLdksqCVF2TFNNUE/PUtGRDQ3MloJaCotS0zAqwcdF
 KAY4hzh5KsbW1AL+AQQtlAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
differentiate between hybrid variants P+E, P-only, E-only that share the
same Family/Model/Stepping. One of the use case for CPU-type is the
affected CPU table for CPU vulnerabilities, which can now use the CPU-type
to filter the unaffected variants.

* Patch 1 adds cpu-type to CPU topology structure and introduces
  topology_cpu_type() to get the CPU-type.

* Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
  topology_cpu_type().

* Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.

* Patch 8 cleans up the affected CPU list.

* Patch 9 uses the CPU-type to exclude P-only parts from the RFDS affected
  list.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (9):
      x86/cpu/topology: Add x86_cpu_type to struct cpuinfo_topology
      cpufreq: intel_pstate: Use topology_cpu_type() to get cpu-type
      perf/x86/intel: Use topology_cpu_type() to get cpu-type
      x86/cpu: Remove get_this_hybrid_cpu_type()
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/bugs: Declutter vulnerable CPU list
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/include/asm/cpu.h                         |   6 -
 arch/x86/include/asm/cpu_device_id.h               | 117 +++++++-----------
 arch/x86/include/asm/processor.h                   |   3 +
 arch/x86/include/asm/topology.h                    |   9 ++
 arch/x86/kernel/cpu/common.c                       | 136 +++++++++++----------
 arch/x86/kernel/cpu/debugfs.c                      |   1 +
 arch/x86/kernel/cpu/intel.c                        |  16 ---
 arch/x86/kernel/cpu/match.c                        |  22 ++++
 arch/x86/kernel/cpu/topology_common.c              |   9 ++
 drivers/cpufreq/intel_pstate.c                     |  14 +--
 include/linux/mod_devicetable.h                    |   2 +
 13 files changed, 166 insertions(+), 179 deletions(-)
---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Thanks,
Pawan



