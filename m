Return-Path: <linux-pm+bounces-9376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8F90B99D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4852C1C20A87
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF0198826;
	Mon, 17 Jun 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oh487Xe+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF85196C96;
	Mon, 17 Jun 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648703; cv=none; b=iuONWRa/0tId0kZQS/C3ZR6Hk9uYxSosqEOL1y/aq+r4GWgXwlJmEabe0npeclVmR6oc7Y5ra8+7efp9pWA2IiBVwGWyU9EsyNEYzz0dppSGtA4Rx0b0Pr9hcNfkidfJS4PCUF+Xvo2jANo23Jry4WDc0VD+I32VDYkyFIZoAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648703; c=relaxed/simple;
	bh=TX48ZnMfYfNnFjSCvlxIsN49/7BeLn7IXafjJ5Z0PeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhpKzvwjdaRAuXR6FbMVofeHerg2N5xADMDaII4VoHyL6NpVnx8uscCQCpkT7+oLOjnyRUularRXAo3mYrRjydy41SP83o7hIwpM7Ti4CcWJSx+bXvsdEqsBmRw7Brp8nfmseLMMZHxA/F30uNUvHtmnRSHvuw8TUToe8zQahzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oh487Xe+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718648702; x=1750184702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TX48ZnMfYfNnFjSCvlxIsN49/7BeLn7IXafjJ5Z0PeU=;
  b=Oh487Xe+7SrWiT6Yd6gS6awPkZA/91fqJpJ17Jwr7uTbA1BLqoHpTbaz
   zDnBmoAiylWz+Xavbl+kEaS2pHDN6If8BJnJqeBdA0AH01g0rQiQFZBPf
   c+CmQw4CILhFXWVvPkqyKlFaeduzrUtSlEa9VvXxd7eahS2dcb7jhHnBZ
   Z4Y+Dv3eLaxo/dM90Jte15i4f52oi/CoYlF9ZDgQTszO67gcGYugS4z9J
   rXxx72INhG61VL9fETrNv8t+M5dQs7km29ULBzUUO7b/9trBywx0mxqvS
   l752oLfyWtQJcNKDgJxY4lY64kSINIlVB989mtlfnVbU1hsnHtI7Lxty5
   g==;
X-CSE-ConnectionGUID: 0NufqpZqSUGy4SgKtPDplg==
X-CSE-MsgGUID: cAuk5sRxSYy9rxSSn0ERUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19347140"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="19347140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:25:01 -0700
X-CSE-ConnectionGUID: iauFo114RQKW3wc4Kqj93Q==
X-CSE-MsgGUID: A2yPGSjbT6e8LEaQwZgMng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41211134"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:25:01 -0700
Date: Mon, 17 Jun 2024 11:24:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH PATCH 9/9] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240617182454.lpdh2yop32mefic6@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-9-b88998c01e76@linux.intel.com>
 <b34d6b95-64ec-4647-9eab-374dbcc25f8a@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34d6b95-64ec-4647-9eab-374dbcc25f8a@intel.com>

On Mon, Jun 17, 2024 at 07:33:13AM -0700, Dave Hansen wrote:
> On 6/17/24 02:12, Pawan Gupta wrote:
> > +#define VULNBL_INTEL_CPU_TYPE(vfm, cpu_type, issues)	\
> > +	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm, cpu_type, issues)
> > +
> ...
> >  	/* Match more than Vendor/Family/Model */
> >  	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
> >  	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
> > +	VULNBL_INTEL_CPU_TYPE (RAPTORLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
> > +	VULNBL_INTEL_CPU_TYPE (ALDERLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
> 
> Could we tweak this a bit to make it more compact?  For instance, if we
> did this:
> 
> #define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)	\
> 		X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm,	\
> 		X86_CPU_TYPE_INTEL_##cpu_type,		\	
> 		issues)
> 
> We'd end up with entries like this:
> 
> 	VULNBL_INTEL_TYPE (ALDERLAKE,	ATOM,	RFDS),
> 
> I guess "TYPE" is a _bit_ ambiguous.  But it's also pretty patently
> obvious what's going on versus something like this:
> 
> 	VULNBL_INTEL	  (COMETLAKE_L,	MMIO | MMIO_SBDS | RETBLEED...),
> 
> Getting rid of the "X86_CPU_TYPE_INTEL_" string in the table is low
> hanging fruit.  I don't feel as strongly about changing the new macro name.

It makes sense to me, atleast getting rid of X86_CPU_TYPE_INTEL_ in
X86_CPU_TYPE_INTEL_ATOM.

