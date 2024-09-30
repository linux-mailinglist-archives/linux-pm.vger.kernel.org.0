Return-Path: <linux-pm+bounces-14951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32798A7BC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A81C23568
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A54199FBB;
	Mon, 30 Sep 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haEWuo9W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542C199FA5;
	Mon, 30 Sep 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707703; cv=none; b=u0OKglSqL7Ct4Iun/AaBPC4fcXHioWaeviPXmdrHzFhEnNlL78E6mA1K0tMj2DONTYJJRzYvrLodrjZUcuVXIMrQBxbjWm7u8ErBcHwJcSWF+OxAz6Pbrv/AuJMPM/EedqzoV+9ZZRbsCChvcHlTc9mtQKdISPgkUnPpKxDm0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707703; c=relaxed/simple;
	bh=WsrtqRsW+CdF1MWynYgjI+sF26Pl/Z+ufYsz3dzGmg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzEcOnpWw7qgk5i8btW4b8vaYPhOM5djp/nWHowx1AgcVXaDobj1iNJmN6LQ9Xsc5pIZd2c2JGbC94uB25M5KvEAGXNJ/qPZR+jjzEXJlUoUrEAmhO36JEiT+Z7Z6aq/j8MNrc0x0Z6YEsAYab/f3Zxxvez5goNo7h23hDsdaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haEWuo9W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707702; x=1759243702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsrtqRsW+CdF1MWynYgjI+sF26Pl/Z+ufYsz3dzGmg0=;
  b=haEWuo9WGB9US/3mVrU2xiMyG5CL9yXyJJyTKTzuOYcg6fW9vAnsx4Zw
   sE3qCIoNdwhHg011f5t5nmlYbtQ/qeRFHcs5sJmTcG6NfwaJuGzGUrHoV
   Hy+gzSbMpzV3eNf2SIfQd0UA4PsKVoKeqvlbbcl/XPuplioB30oJ0hSXi
   v9yKrtO0pBvYTo/b7m/szTeBQlbe0oHKt5bl0ovRXEC5tWgO+a9ueo31f
   xADkq05dB0tbztDl1Z9N/4hNykn/Xd2uKBQT5NNJ8UQf4gVQBILJ88IOn
   3rfIFPvo4sDdFClEDZa/44I81Lm++N8Wx5LzASS2Br29tbq8q+tcHyTNZ
   Q==;
X-CSE-ConnectionGUID: WUqbgPB+RNKqydECllAnbA==
X-CSE-MsgGUID: bCt8KY/dQzCmHgj6lkEHlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44262346"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44262346"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:20 -0700
X-CSE-ConnectionGUID: ATHOIvWITuqEG9+cgnljdg==
X-CSE-MsgGUID: BWWlZNtSTu+8q9fh06wFOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73455221"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:17 -0700
Date: Mon, 30 Sep 2024 07:48:16 -0700
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
Subject: [PATCH v4 10/10] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240930-add-cpu-type-v4-10-104892b7ab5f@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>

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
index 66f691db5ec6..04695f74919e 100644
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



