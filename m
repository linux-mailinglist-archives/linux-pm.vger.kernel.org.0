Return-Path: <linux-pm+bounces-19096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F129EDFB3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FEA188B9B0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D853204F79;
	Thu, 12 Dec 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH2tGkHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BACF204C2D;
	Thu, 12 Dec 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986693; cv=none; b=QqvVJBEGoDXSf3E1a5x/nBGRzA0BOxjUnU3SrwSLGNZava2/74rNoUhDCGKfACn/ypkKLVffmm4WFGGFig2do+zjEVqxflRy5tZr3aSN1vlTbT09hrCLnklRV3wLFB4azOFeeXP5YIeri5YeO2sjBdogSMoztXnIZhNRMDPyrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986693; c=relaxed/simple;
	bh=VhCYiqyYvaqC3KiVmWV3iXEcW4mzn2QL662FFwdB0gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItPj40n4tIP14DKp0t1QBCo8B68faHZcpk3bcwC7lpjDW0U0flvWjpi9zy++C4p0Q+OVNh3fHaTlJY2bQoJafD8uJw8LO407ppBmfH04jgqoQNPAYXioM1WQN9mFgZ6ovZFtLVmYDCvMo5VoD8UqpfhcarKgpXi9Ru28tpEaqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH2tGkHZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986692; x=1765522692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VhCYiqyYvaqC3KiVmWV3iXEcW4mzn2QL662FFwdB0gg=;
  b=VH2tGkHZLX+qWDZFjzJxqeBZ9afdWUDbHrgvQ6wpCtZnY69cnKSyc4WV
   cOf4yjLTe/IcOqOHW++dETZDi19OVkiEtwQe4rLor5ofVm+0Je6duarDj
   UjI6KrvrWfW1j+qwp7Q7oVP0mVCvdk3ic7IEG60gnxKTXt9M2gVUGHhsd
   EIYbndj7AGguPSPYDDDM28c1a3aJx961yHM1yMjfvYOQDQemXROA7d+Gt
   yCEafNyRYGtp9imMwE8OO9jZXQ/1BQ1//MXwoNgcYDjX5jgfFUhu5k9+t
   Jgj70ZZjblCGIr1LJw1EHklN4KlOZ8Q1PTNLxXMjxl8Lx3wcFwKxJ9ad2
   w==;
X-CSE-ConnectionGUID: iWVQH/MfSy+UJHs22kjMww==
X-CSE-MsgGUID: 4ASbv9jpQAifrHP/SC7MYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37231041"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="37231041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:58:11 -0800
X-CSE-ConnectionGUID: qDCc1EIfQI2BpWkROLzIOw==
X-CSE-MsgGUID: BloVe2i4RwG3tFszWvxFaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127127232"
Received: from unknown (HELO desk) ([10.125.145.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:58:09 -0800
Date: Wed, 11 Dec 2024 22:58:09 -0800
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
Subject: [PATCH v5 9/9] x86/rfds: Exclude P-only parts from the RFDS affected
 list
Message-ID: <20241211-add-cpu-type-v5-9-2ae010f50370@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>

RFDS only affects Atom parts. Vendor/Family/Model matching in the affected
processor table makes Alderlake and Raptorlake P-only parts affected (which
are not affected in reality). This is because the affected hybrid and
E-only parts have the same Family/Model as the unaffected P-only parts.

Match CPU-type as Atom to exclude P-only parts as RFDS affected.

Note, a guest with the same Family/Model as the affected part may not have
leaf 1A enumerated to know its CPU-type, but it should not be a problem as
guest's Family/Model can anyways be inaccurate. Moreover, RFDS_NO or
RFDS_CLEAR enumeration by the VMM decides the affected status of the guest.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst | 8 --------
 arch/x86/kernel/cpu/common.c                                 | 9 +++++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
index 0585d02b9a6c..ad15417d39f9 100644
--- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -29,14 +29,6 @@ Below is the list of affected Intel processors [#f1]_:
    RAPTORLAKE_S            06_BFH
    ===================  ============
 
-As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
-RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
-vulnerable in Linux because they share the same family/model with an affected
-part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
-CPUID.HYBRID. This information could be used to distinguish between the
-affected and unaffected parts, but it is deemed not worth adding complexity as
-the reporting is fixed automatically when these parts enumerate RFDS_NO.
-
 Mitigation
 ==========
 Intel released a microcode update that enables software to clear sensitive
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6c45b8bed9fc..a82d6184e1d0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1207,6 +1207,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
 	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)			\
+	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm,				\
+			       INTEL_CPU_TYPE_##cpu_type,	\
+			       issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1255,9 +1260,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL(		TIGERLAKE,		GDS),
 	VULNBL_INTEL(		LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL(		ROCKETLAKE,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(		ALDERLAKE,		RFDS),
+	VULNBL_INTEL_TYPE(	ALDERLAKE,	ATOM,	RFDS),
 	VULNBL_INTEL(		ALDERLAKE_L,		RFDS),
-	VULNBL_INTEL(		RAPTORLAKE,		RFDS),
+	VULNBL_INTEL_TYPE(	RAPTORLAKE,	ATOM,	RFDS),
 	VULNBL_INTEL(		RAPTORLAKE_P,		RFDS),
 	VULNBL_INTEL(		RAPTORLAKE_S,		RFDS),
 	VULNBL_INTEL(		ATOM_GRACEMONT,		RFDS),

-- 
2.34.1



