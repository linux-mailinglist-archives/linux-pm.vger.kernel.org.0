Return-Path: <linux-pm+bounces-12298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D913F95407C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4B1F25499
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845BA1527AC;
	Fri, 16 Aug 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejyYdVRk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9ED14F9ED;
	Fri, 16 Aug 2024 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781235; cv=none; b=TXL7U6trrh+xkT6pFXUGeGA8mAl51yQzaxyfiDu5C8pmOBJSZF7mW+5z8hdl4xQIj4qd2SyA8iAR0Ti5NgHJT3Yovm5rijpW3NZK+KCW3+wbduIzUOGgFrNIRYXsaiKgSKp1ND9LA+gVTJmXTjN5svWO+S1qM8t5TV/YC40rJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781235; c=relaxed/simple;
	bh=GPH5+AKjVhCVAAo1mt/IMnLos6wWQSjQVK2chlYrAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQnubKTZ7LVZLrrpD6Vjajgmiq5CAGJCbStYfd6O64WDayQRrLY5plm450FCVruOPB5G+9gvYxMmPWqTmFtBYY8gr7ZGTpZP0X3mtfxZrDTqUR6hYQayqZAhOZDkFkMDLUNenlsj8yqzGEL401eTgqYzmQmPeHsoBCw3gQDxDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejyYdVRk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781234; x=1755317234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPH5+AKjVhCVAAo1mt/IMnLos6wWQSjQVK2chlYrAWk=;
  b=ejyYdVRkV8EFS8owlfQtu2mq1TxTj/EqafDkaMCyYF/cckwH8bAhj3Es
   TXgwGKQL9hlZhBaEEEsQwqE0yU+bTSqP2zyJ9LGPyNcJc1XG95uwzeQTR
   guUO3zaO28aTTdDVjnvndMiWl/zODVtD49zBaZ6SeGG3yHrY3nUfFvYDZ
   kjMQb+/kFzJwSKL/ban15glZyjmHFHXHi0EIekjfx5vo37iTdNdowkCvE
   rEEu5k0SXjt20JJm/iCHkSRTWnRN31qiHKJy9EkDYBywI2HzFjaYHa/xR
   RQDvgQrBp5L0hxLOFJD+/jV9rfO1wU0gnM4KI2rso3dOXEx/IeI8pGee/
   A==;
X-CSE-ConnectionGUID: c6pYbIojRKGrNThky7VPlQ==
X-CSE-MsgGUID: 7EIaE/I+Q6ajFjehqMUl0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21617850"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21617850"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:07:14 -0700
X-CSE-ConnectionGUID: w+/yu9oNQhuyc5BmO56cHA==
X-CSE-MsgGUID: 6v+B7AIIQPO89mNp8xfCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="82758968"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:07:12 -0700
Date: Thu, 15 Aug 2024 21:07:11 -0700
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
Subject: [PATCH v3 10/10] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240815-add-cpu-type-v3-10-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

RFDS only affects Atom parts. Vendor/Family/Model matching in the affected
processor table makes Alderlake and Raptorlake P-only parts affected (which
are not affected in reality). This is because the affected hybrid and
E-only parts have the same Family/Model as the unaffected P-only parts.

Match CPU-type as Atom to exclude P-only parts as RFDS affected.

Note, a guest with the same Family/Model as the affected part may not have
leaf 1A enumerated to know its CPU-type, but it should not be a problem as
guest's Family/Model can anyways be inaccurate. Moreover, RFDS_NO or
RFDS_CLEAR enumeration by the VMM decides the affected status of the guest.

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
index 68115240eea9..4bff1de1b40e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1209,6 +1209,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
 	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)			\
+	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm,				\
+			       TOPO_HW_CPU_TYPE_INTEL_##cpu_type,	\
+			       issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1257,9 +1262,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
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



