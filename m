Return-Path: <linux-pm+bounces-10557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F309A9267D0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 20:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307EA1C22CEC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73471862B1;
	Wed,  3 Jul 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2y2abge"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA518628C;
	Wed,  3 Jul 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030173; cv=none; b=LHWfLsqe26RMwGf2Q5wBo+IERI+KsE0SE43CA5Rn774foWu0JDmN8veDAoswOpAj0CY5Eeq/WXmEpC5OGYyOG0oR9l31BEdiSCop8BRg4Bjss3CUYGIADVJMdtTEZBydoSDNceabBvW31VdiukwqnDWNI1oqz1Jt70JZsuJdpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030173; c=relaxed/simple;
	bh=ly+zdbaT1osIlNv/3aqRM3D0Eq/FlhdjnXjVeuOFpps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQfnI06k8mEr6gBOZWFMsShSjYquMcUhKoeuhJpERUzWLgNI1N4vnc7PBmpyhNnbo0JQWOkahOjGwfi5dOFC9iuqwMnd6L3ZqqSVzhaMkHZS6ViMf50YzXJq4DXTrribRsal7dKK3OT5I0ezIGuW9lqjGndnVr/0Fc/Z+roC5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2y2abge; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720030172; x=1751566172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ly+zdbaT1osIlNv/3aqRM3D0Eq/FlhdjnXjVeuOFpps=;
  b=R2y2abgejbdr2YwJx3Gg02LNHyd+fuyESIcffiKfszf47vZfXFaehFh2
   Ld/vBjFfs8ONA/TvU0aA3yql1iijotQn40FIo1xm+BfnqdTqy80DXFq6S
   aislqyKAWYj3zRFRee4k1n5CTHIwEoVQ2Nmx7bdjXxM6neiNGqZnH7o4E
   +2TUH7VCPQ9/oHsQItYmKolRovhvWi9Zex83n60ZZxeQmy/i9ADmp2hSM
   4tOFN+PQkfflNBpYABmccePkPruVsz2Khy9nZdkK4oNyaQ8vpiO2Nb9W9
   pf0cNVyvFsRp1KVOJW62u8cHyP2BUCYrKoU530egqpOj/MaA09SV5gWcc
   A==;
X-CSE-ConnectionGUID: 6LGUO/5RTh+9NLaeM60rYA==
X-CSE-MsgGUID: 963Vfbe0Q6q5/HKcVUU6kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17003271"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17003271"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 11:09:29 -0700
X-CSE-ConnectionGUID: BdzLNe5OQraCHrOFUXa1kg==
X-CSE-MsgGUID: BBz2WTcYS2u1WIxpKn1SGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="47001484"
Received: from plborg-mobl.amr.corp.intel.com (HELO desk) ([10.209.72.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 11:09:29 -0700
Date: Wed, 3 Jul 2024 11:09:21 -0700
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
Subject: Re: [PATCH PATCH v2 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240703180921.gsfqdupitha22nz5@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-8-f927bde83ad0@linux.intel.com>
 <20240703010018.qov5lxldvou7fhhl@treble>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703010018.qov5lxldvou7fhhl@treble>

On Tue, Jul 02, 2024 at 06:00:18PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 27, 2024 at 01:44:48PM -0700, Pawan Gupta wrote:
> > The affected processor table has a lot of repetition and redundant
> > information that can be omitted. For example:
> > 
> >   VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
> > 
> > can easily be simplified to:
> > 
> >   VULNBL_INTEL(IVYBRIDGE,	SRBDS),
> > 
> > Apply this to all the entries in the affected processor table.
> > 
> > No functional change. Disassembly of arch/x86/kernel/cpu/common.o does not
> > show any difference before and after the change.
> 
> This patch only changes data, not code.  So there's not much point in
> diffing the disassembly ;-)

You are right.

> A diff of the .init.rodata sections actually shows one (non-functional)
> difference in cpu_vuln_blacklist[].
> 
> The COMETLAKE_L entries were moved to a new section below the rest of
> the entries:
> 
> 	/* Match more than Vendor/Family/Model */
> 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
> 	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
> 
> While that's functionally correct, it breaks the visual sorting, which
> is confusing and even a bit dangerous.  One would reasonably expect the
> COMETLAKE_L entries to come immediately after COMETLAKE, so it would be
> quite possible for somebody to come along later and add a new
> COMETLAKE_L there which conflicts with the later entries.
> 
> I'd much rather leave the STEPPINGS entry in the original list where it
> belongs.  Something like:
> 
> 	...
> 	VULNBL_INTEL(ICELAKE_L,			MMIO | MMIO_SBDS | RETBLEED | GDS),
> 	VULNBL_INTEL(ICELAKE_D,			MMIO | GDS),
> 	VULNBL_INTEL(ICELAKE_X,			MMIO | GDS),
> 	VULNBL_INTEL(COMETLAKE,			MMIO | MMIO_SBDS | RETBLEED | GDS),
> 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,
> 			       X86_STEPPINGS(0x0, 0x0),
> 			       MMIO | RETBLEED),
> 	VULNBL_INTEL(COMETLAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> 	VULNBL_INTEL(TIGERLAKE_L,		GDS),
> 	VULNBL_INTEL(TIGERLAKE,			GDS),
> 	...
> 
> Yes, that's a little ugly, but at least the sorting is correct so it's
> less confusing and more robust overall.

That makes sense, I will make that change.

