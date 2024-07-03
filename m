Return-Path: <linux-pm+bounces-10558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E38926824
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E3EB25278
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB04188CB4;
	Wed,  3 Jul 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU4yiZl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D1186E2D;
	Wed,  3 Jul 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031185; cv=none; b=MLZdW3NHgJzQMusLSbJbxhyM0t60XGv4ueCyiBW6rWKOr7nSBStH35IxJ9xDgHbRyhKTyeSQqh02xdjvitVMiq8fAEtyuXlVz0BpHxqL/bjsokitUS/qC3b2sOb3qleBnst9F5+oU8L7IUMXItQ+umjJPRcvUdx261Zqo9CjeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031185; c=relaxed/simple;
	bh=kDiFr3LS44KFV/bUqmFkypl2ccLtwWG6zvp6fckmWZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m64lMhmwDx49HseU/bYsysze01YIWWo6jEMKzrTHe3mGrvk/3PTa1HSyqaPBeb4BXaJcufjYPK3pIo+AbTfQektsBC+CCiDPDt/FHpPWsiOz/X1iY0otTXWLpGgPaQBtxEnsT1WKqQMZneUjzURLrutXw66zOHQdyKIo7C0I0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU4yiZl9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720031184; x=1751567184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kDiFr3LS44KFV/bUqmFkypl2ccLtwWG6zvp6fckmWZ8=;
  b=AU4yiZl96ZkgKR2yWc80IiEXEIUXIw9/ssco4u9EJ3Hjy91mLNMS9FSn
   f/8RwlCcKkmlh0wo8DheVVRUWlAJx7JW7VBd+/mA4uhBGIQ71hfciSHtN
   +1x565CznNDoTmm0aBP11OEU5WUeH8uCGz7q6PunCoc/oh3cKhoHY0hLk
   yXkrJBunlh9WKBmGVuuC7gA5wS7OhdmO0yXudGxXQWWIp/Q2+y3O5mzre
   RwUqTcLwDA7Kz5YK6udLy4U78VIPImzhEcCzLt9FevKJI1mBv6foSMWMJ
   YxHUVEOxYLyM65scqJvnh/O1z+RutLr+M+QJFjsB22AVHI3GaPt55HGq1
   A==;
X-CSE-ConnectionGUID: Gv6glxa6TbeuNUyg08EKfw==
X-CSE-MsgGUID: s/GOw0sqRcKUE9Yxqyz1/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27883917"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27883917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 11:26:22 -0700
X-CSE-ConnectionGUID: S8eQpLGDQcyLlK/0K00Vkg==
X-CSE-MsgGUID: nJter5zjQjmYULtEa4dLAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="51201072"
Received: from plborg-mobl.amr.corp.intel.com (HELO desk) ([10.209.72.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 11:26:21 -0700
Date: Wed, 3 Jul 2024 11:26:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH PATCH v2 9/9] x86/rfds: Exclude P-only parts from the
 RFDS affected list
Message-ID: <20240703182613.4vfaoxl344mdanxn@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-9-f927bde83ad0@linux.intel.com>
 <20240703010433.2ymzh5g7osth5ch5@treble>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703010433.2ymzh5g7osth5ch5@treble>

On Tue, Jul 02, 2024 at 06:04:33PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 27, 2024 at 01:44:55PM -0700, Pawan Gupta wrote:
> > @@ -1255,9 +1260,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
> >  	VULNBL_INTEL(TIGERLAKE,			GDS),
> >  	VULNBL_INTEL(LAKEFIELD,			MMIO | MMIO_SBDS | RETBLEED),
> >  	VULNBL_INTEL(ROCKETLAKE,		MMIO | RETBLEED | GDS),
> > -	VULNBL_INTEL(ALDERLAKE,			RFDS),
> >  	VULNBL_INTEL(ALDERLAKE_L,		RFDS),
> > -	VULNBL_INTEL(RAPTORLAKE,		RFDS),
> >  	VULNBL_INTEL(RAPTORLAKE_P,		RFDS),
> >  	VULNBL_INTEL(RAPTORLAKE_S,		RFDS),
> >  	VULNBL_INTEL(ATOM_GRACEMONT,		RFDS),
> > @@ -1271,6 +1274,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
> >  	/* Match more than Vendor/Family/Model */
> >  	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
> >  	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
> > +	VULNBL_INTEL_TYPE     (ALDERLAKE,	ATOM,				RFDS),
> > +	VULNBL_INTEL_TYPE     (RAPTORLAKE,	ATOM,				RFDS),
> 
> Same comment here, these should be inline with the main list.  Maybe
> there's some way to structure the indentations so they align better
> vertically with the STEPPINGS/TYPE variants.

This is how it is turning out to be:

---
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 151c2377df21..75bbdf0cf8ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1237,45 +1237,43 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL(IVYBRIDGE,			SRBDS),
-	VULNBL_INTEL(HASWELL,			SRBDS),
-	VULNBL_INTEL(HASWELL_L,			SRBDS),
-	VULNBL_INTEL(HASWELL_G,			SRBDS),
-	VULNBL_INTEL(HASWELL_X,			MMIO),
-	VULNBL_INTEL(BROADWELL_D,		MMIO),
-	VULNBL_INTEL(BROADWELL_G,		SRBDS),
-	VULNBL_INTEL(BROADWELL_X,		MMIO),
-	VULNBL_INTEL(BROADWELL,			SRBDS),
-	VULNBL_INTEL(SKYLAKE_X,			MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(SKYLAKE_L,			MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL(SKYLAKE,			MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL(KABYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL(KABYLAKE,			MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL(CANNONLAKE_L,		RETBLEED),
-	VULNBL_INTEL(ICELAKE_L,			MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL(ICELAKE_D,			MMIO | GDS),
-	VULNBL_INTEL(ICELAKE_X,			MMIO | GDS),
-	VULNBL_INTEL(COMETLAKE,			MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL(TIGERLAKE_L,		GDS),
-	VULNBL_INTEL(TIGERLAKE,			GDS),
-	VULNBL_INTEL(LAKEFIELD,			MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL(ROCKETLAKE,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(ALDERLAKE_L,		RFDS),
-	VULNBL_INTEL(RAPTORLAKE_P,		RFDS),
-	VULNBL_INTEL(RAPTORLAKE_S,		RFDS),
-	VULNBL_INTEL(ATOM_GRACEMONT,		RFDS),
-	VULNBL_INTEL(ATOM_TREMONT,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL(ATOM_TREMONT_D,		MMIO | RFDS),
-	VULNBL_INTEL(ATOM_TREMONT_L,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL(ATOM_GOLDMONT,		RFDS),
-	VULNBL_INTEL(ATOM_GOLDMONT_D,		RFDS),
-	VULNBL_INTEL(ATOM_GOLDMONT_PLUS,	RFDS),
-
-	/* Match more than Vendor/Family/Model */
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_TYPE     (ALDERLAKE,	ATOM,				RFDS),
-	VULNBL_INTEL_TYPE     (RAPTORLAKE,	ATOM,				RFDS),
+	VULNBL_INTEL(		IVYBRIDGE,		SRBDS),
+	VULNBL_INTEL(		HASWELL,		SRBDS),
+	VULNBL_INTEL(		HASWELL_L,		SRBDS),
+	VULNBL_INTEL(		HASWELL_G,		SRBDS),
+	VULNBL_INTEL(		HASWELL_X,		MMIO),
+	VULNBL_INTEL(		BROADWELL_D,		MMIO),
+	VULNBL_INTEL(		BROADWELL_G,		SRBDS),
+	VULNBL_INTEL(		BROADWELL_X,		MMIO),
+	VULNBL_INTEL(		BROADWELL,		SRBDS),
+	VULNBL_INTEL(		SKYLAKE_X,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL(		SKYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		SKYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		KABYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		KABYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		CANNONLAKE_L,		RETBLEED),
+	VULNBL_INTEL(		ICELAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL(		ICELAKE_D,		MMIO | GDS),
+	VULNBL_INTEL(		ICELAKE_X,		MMIO | GDS),
+	VULNBL_INTEL(		COMETLAKE,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(	COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
+	VULNBL_INTEL(		COMETLAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL(		TIGERLAKE_L,		GDS),
+	VULNBL_INTEL(		TIGERLAKE,		GDS),
+	VULNBL_INTEL(		LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL(		ROCKETLAKE,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_TYPE(	ALDERLAKE,	ATOM,	RFDS),
+	VULNBL_INTEL(		ALDERLAKE_L,		RFDS),
+	VULNBL_INTEL_TYPE(	RAPTORLAKE,	ATOM,	RFDS),
+	VULNBL_INTEL(		RAPTORLAKE_P,		RFDS),
+	VULNBL_INTEL(		RAPTORLAKE_S,		RFDS),
+	VULNBL_INTEL(		ATOM_GRACEMONT,		RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT_D,		MMIO | RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT_L,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT,		RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT_D,	RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT_PLUS,	RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),

