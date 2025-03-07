Return-Path: <linux-pm+bounces-23582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76FA55D83
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6136D18956B7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAA142E67;
	Fri,  7 Mar 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxUZ/ttj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935B168B1;
	Fri,  7 Mar 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313871; cv=none; b=qBXHL0sIIcZEflUhWTKJzXTo+YWUuKwzNLWBMB9gETKsbBSx6hR2yybvn7+eub0EUy8H2gqmigyLMNeyG6Y3qEW6GIBiAaZv6zNvnaUGwGOvyySMefqspruWKMkWsgMYOEFUz7NX+3etwHtG2RUIFV7ldH0KgCjke/0Tfeg11gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313871; c=relaxed/simple;
	bh=kOu4rvG78Qt/Vnqc24VAFu7oWPCqfeyYuF+ofgHto8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lc2O7HYW9EpAn+QnFMt2ytVVgcNQRWCIwV2x3DyFUWcVrG1eul/7d+/AiTtnZYFBnSkrDwyx6sZGT86aYkMmxK2l6zIonNImmCpkjXV1oO7Z0F5W4jP4VnZ6maeEn5UWlK6U1EvO5M/ozn9Jcizj3/H2bXz6QsxkMudejiFtmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxUZ/ttj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741313869; x=1772849869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kOu4rvG78Qt/Vnqc24VAFu7oWPCqfeyYuF+ofgHto8c=;
  b=IxUZ/ttjmwS4DlUPIkOVMcSd8sa4HdMqjnQVAnxXNcJG3C4MiUWqleOp
   LB+iBFXktVAGf1f3dttY5smFFsaV5gK2O4r35XW2sOhijNuMJOeH9HiHT
   UQBcbFkHNnFl3AZ+JAp7dsrVCqJxR/Z9cPHgV+nMwBNYJ8vw4Ie2jYqYR
   8pog3mdzVdMrVsvhDbpy9Fy7l85n5ElvMVAPZb+2xy5PPyVeXA8OuB8gj
   gX+1DKtbxR2GYF1boTDoMeDX8vNTKTaf+QcHNGGl9DUFDkd+n8P26bFzr
   mV8/1UmB3Mvz7JX2hirADASU/OrolAyRvkFDubtJf1y0I4t7r/g8DCnag
   w==;
X-CSE-ConnectionGUID: kpB2Lp44SR2p2hPR9Q8ypA==
X-CSE-MsgGUID: Z3NQd9i5Szuw8hFmpx8sQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64795131"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="64795131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:17:49 -0800
X-CSE-ConnectionGUID: R/6qAsNtRkyMJO75vIANDA==
X-CSE-MsgGUID: W7SV5KTnQuC5uJzU6swTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="123788075"
Received: from ylan1-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.179])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:17:48 -0800
Date: Thu, 6 Mar 2025 18:17:47 -0800
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
Subject: [PATCH v7 0/4] Utilize cpu-type for CPU matching
Message-ID: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAC5WymcC/6XQPU/DMBAG4L8Sea6rO3/kkk4gFkYGNsSQ2Bdqq
 SRRkkatqvx3TJAoSsMC4/n0Pq91F9FzF7gXu+QiOh5DH5o6DrRJhNsX9RvL4OMsFCgDKZIsvJe
 uPcrh3LI03rIhrhwiiRhpO67CaeZexNP988OjeI3P+9APTXeeS0acl+veiBJkmWV5njlApvTuE
 OrjaRvqgQ9b17zP3Kh+EGpJqEhUuaLSc6YLD+uEvhIZ2gWhI6G0wVRpq8DSDbFJ/hyd2821Pde
 wIEwkEEyWq5KK0lbrhP0mUCEuCPv5i4IBobKg6ZcbpP8ivm4Qd7C8QRqjhgyStqXzZG/bp2n6A
 KFf0056AgAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v7:
- Moved the CPU table cleanup patch out of the series, it does not relate
  to cpu-type detection. Will send it separately.

v6:
- Use the recently added macro VULNBL_INTEL_STEPS() in the affected CPU
  list cleanup patch.
- Rebased to tip/x86/cpu.

This series is now the remaining last 5 patches from the original
series. Below are previously merged patches:

- upstream:
  45239ba39a52 ("x86/cpu: Add CPU type to struct cpuinfo_topology")

- tip:
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
Pawan Gupta (4):
      x86/cpu: Name CPU matching macro more generically (and shorten)
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/rfds: Exclude P-only parts from the RFDS affected list

 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 --
 arch/x86/include/asm/cpu_device_id.h               | 115 ++++++++-------------
 arch/x86/kernel/cpu/common.c                       |   7 +-
 arch/x86/kernel/cpu/match.c                        |  30 ++++++
 include/linux/mod_devicetable.h                    |   2 +
 5 files changed, 80 insertions(+), 82 deletions(-)
---
base-commit: 4f2a0b765c9731d2fa94e209ee9ae0e96b280f17
change-id: 20240617-add-cpu-type-4d5e47efc117

Best regards,
-- 
Pawan



