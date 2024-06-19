Return-Path: <linux-pm+bounces-9534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57690E1FA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66290282A70
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6041157323;
	Wed, 19 Jun 2024 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrURF4P9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B82139C7;
	Wed, 19 Jun 2024 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718767898; cv=none; b=OgZ4DXyzgrtwSsK0EoqPCtU2H/LZBAJ5OccKEddGbpcc6FzHr6xoxsxm1RQggGvImT+CyyumHSZWx6j+kjIM4QLsC9c0TaeLWVBqOLoRuLtucJ/3Z2QvrTjgnsTQus+Hkday9gPecpcHxZ+cDdqW7Vp3AXQK2vCiSnsq13g5ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718767898; c=relaxed/simple;
	bh=L3Agqx8KBfjUeqD0z7eZyby9TiHtKcMLxKVU3pjcaiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCxnRLym0Ed0F7TIwTGe52fO3O+ispQGcstfPZXo1BvFY8gRNSFMA5cBAtIhMJFt0i/pURJNAmcH8/sjwDzSE5BTifpOB1jAN2xINgC+Q49DwFlmUCcvHWJ9zu9jcXnayPJpOXaPwkyk+XEjguRIsSXAhjshlQ6eu2+IuCEKq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrURF4P9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718767896; x=1750303896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L3Agqx8KBfjUeqD0z7eZyby9TiHtKcMLxKVU3pjcaiU=;
  b=MrURF4P9YGSAAMMxwnO2e/Svi5PJq6WTecCz2zQnju+kFnfmPP67esaI
   1kP/K37LpU9YBoTCvATupzn4oMA+hhZ75uNF725K4k0EFHHD11IIV8YYC
   rDcZNG/HsWqoUMZ/I28cNbUp8rNxLYmBc0ZZdJ5ub7slIiiPmPr6bIfUx
   I7eNoOLkfHnO07yXDg4WGi6otEcJCKl3CE5SKwRPGiRTbGUOSoE/tdHf4
   B1jbDH/NCh+NO9L75wDTeItVhqMo4iYkKRnOCnM+bFGF78AVHzuWauwIn
   Ab/KTxMNa5GS4jI0w0E8kxgJgNzFKewVc4Eg08DAT06b+lgFJwRyQcpdT
   w==;
X-CSE-ConnectionGUID: Rru7XicaQVCyhnVIkMBvSg==
X-CSE-MsgGUID: ETuy7RvBSQKp1/DfLpk7Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33226705"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="33226705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 20:31:33 -0700
X-CSE-ConnectionGUID: DbkMGVtASk6nZmqKOH8n7w==
X-CSE-MsgGUID: aBF2ySp7RRaKXW/WWTH50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="46327824"
Received: from cgroden-mobl.amr.corp.intel.com (HELO desk) ([10.209.70.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 20:31:34 -0700
Date: Tue, 18 Jun 2024 20:31:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240619033126.irudoer3pw4fb5be@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
 <20240618212801.GJZnH74Q4yknT-4X12@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618212801.GJZnH74Q4yknT-4X12@fat_crate.local>

On Tue, Jun 18, 2024 at 11:28:01PM +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2024 at 02:11:26AM -0700, Pawan Gupta wrote:
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -95,6 +95,9 @@ struct cpuinfo_topology {
> >  	// Core ID relative to the package
> >  	u32			core_id;
> >  
> > +	// CPU-type e.g. performance, efficiency etc.
> > +	u8			cpu_type;
> > +
> >  	// Logical ID mappings
> >  	u32			logical_pkg_id;
> >  	u32			logical_die_id;
> > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > index abe3a8f22cbd..b28ad9422afb 100644
> > --- a/arch/x86/include/asm/topology.h
> > +++ b/arch/x86/include/asm/topology.h
> > @@ -41,6 +41,14 @@
> >  /* Mappings between logical cpu number and node number */
> >  DECLARE_EARLY_PER_CPU(int, x86_cpu_to_node_map);
> >  
> > +#define X86_CPU_TYPE_INTEL_SHIFT	24
> > +
> > +enum x86_topo_cpu_type {
> > +	X86_CPU_TYPE_UNKNOWN		= 0,
> > +	X86_CPU_TYPE_INTEL_ATOM		= 0x20,
> > +	X86_CPU_TYPE_INTEL_CORE		= 0x40,
> 
> Can we unify those core types and do our own (our == Linux) defines instead of
> using Intels or AMDs?

As Dave pointed out in the other email, atleast mitigations have a use case
to match the raw CPU type defined by the vendor. It could get tricky if
ever there will be different types of performance cores, with different
hardware characteristics.

> There will be AMD variants too soon:
> 
> https://lore.kernel.org/r/7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com
> 
> so can we have generic defines like
> 
> PERF_CORE
> EFF_CORE
> bla_CORE
> 
> and so on
> 
> ?
> 
> And then map each vendor's types to the Linux types?

I am no expert, but I do think generic Linux types could also be useful in
future. Hypothetically speaking, these can be used to make better
scheduling decisions. For example, CPU bound processes can be scheduled
more on performance cores and I/O bound on efficiency cores.

To accommodate for that we can name the vendor specific types in this
series as vendor_cpu_type. And if we ever need to add generic types, we can
call them cpu_type?

