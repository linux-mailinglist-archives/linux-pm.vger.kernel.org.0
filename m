Return-Path: <linux-pm+bounces-9372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCE90B976
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0421C212B1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7671991A5;
	Mon, 17 Jun 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA5WsBDv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2319D076;
	Mon, 17 Jun 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648005; cv=none; b=rSSwsL9bQG8Icl56XIjsQC7wDFR2G38d2nn9sOghzNNQ+gOx5DWmVtf/CfWuDBfd17OAqhWhpvdVWndyFeVlWd9jbHD4gIH/yzTcmkpbE2T0C+jUO9ZrAg70FaLOShYlUPc9CmS3LrqO3E1hYBMxW94TW4Vofa2AsS8MhpJrW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648005; c=relaxed/simple;
	bh=ojRbcXMAcD1hhCMCV6YEMc1FKR66O4C+wbO5n22upEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzfvEi1TvNmXWjmRj5o78rhZ3BHV81qzIdUM/pWK7YM8fgPfnsdr37NA+hAak4oDjqw3/9bl9ApyrG5Pgu8fqn2skjRkP1PLA0Qa8wMkHKc0aIsejfq2DmRX0FyTHzox9s0Vh5dP8FiUTzC4iVZ1jKkdNwJD4IzIxpbUmElyDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA5WsBDv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718648003; x=1750184003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojRbcXMAcD1hhCMCV6YEMc1FKR66O4C+wbO5n22upEU=;
  b=iA5WsBDvbCd0v6GHdpZJtgZPz6/aKbxzKwbRkjvrC8Zeezp/qYMOh3Zq
   KoMb231+4xrPFwN9aJwsQS7ybwnz6t3emF0XC4O+1V+4FLz53ofjpRTnj
   kkoiJBM6ZmRZi8DlU8LK9AG7ouW+3MjMm4foiGk1Mplx8HGNqk1i10WCR
   HxT+Jq4ggpr06PYhFpaqfq7juAhbcmuDvXss3NLyOsOe5EuZLEEC7h+mb
   2U5BxI59bfJR+Xg6cN5F5lhh+jTE2fBkEfTHkILMi8JVKJ1BkUnO6aPdo
   +lS2ZDvhAIHFq4/97NwAyHBfzMkej/W2A0cNUJPmE9oxITFQL67f+8iB6
   A==;
X-CSE-ConnectionGUID: tX0XyucpRYKLWTtyNMicaw==
X-CSE-MsgGUID: oSfoTl6DT2mgv+HTSOdxNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15259712"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15259712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:13:22 -0700
X-CSE-ConnectionGUID: iJ6LKUecRfOwivxKplNFyg==
X-CSE-MsgGUID: 6FEFvl53TWS0tVisgxPUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41145570"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:13:22 -0700
Date: Mon, 17 Jun 2024 11:13:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
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
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240617181315.z3mbmv6hv5frtu6a@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
 <14d5ed1b-db72-4676-bce2-1ff3637a7e56@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d5ed1b-db72-4676-bce2-1ff3637a7e56@citrix.com>

On Mon, Jun 17, 2024 at 10:38:32AM +0100, Andrew Cooper wrote:
[...]
> > +	VULNBL_INTEL(IVYBRIDGE,		SRBDS),
> > +	VULNBL_INTEL(HASWELL,		SRBDS),
> > +	VULNBL_INTEL(HASWELL_L,		SRBDS),
> > +	VULNBL_INTEL(HASWELL_G,		SRBDS),
> > +	VULNBL_INTEL(HASWELL_X,		MMIO),
> > +	VULNBL_INTEL(BROADWELL_D,	MMIO),
> > +	VULNBL_INTEL(BROADWELL_G,	SRBDS),
> > +	VULNBL_INTEL(BROADWELL_X,	MMIO),
> > +	VULNBL_INTEL(BROADWELL,		SRBDS),
> > +	VULNBL_INTEL(SKYLAKE_X,		MMIO | RETBLEED | GDS),
> > +	VULNBL_INTEL(SKYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
> > +	VULNBL_INTEL(SKYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> > +	VULNBL_INTEL(KABYLAKE_L,	MMIO | RETBLEED | GDS | SRBDS),
> > +	VULNBL_INTEL(KABYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> > +	VULNBL_INTEL(CANNONLAKE_L,	RETBLEED),
> > +	VULNBL_INTEL(ICELAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> > +	VULNBL_INTEL(ICELAKE_D,		MMIO | GDS),
> > +	VULNBL_INTEL(ICELAKE_X,		MMIO | GDS),
> > +	VULNBL_INTEL(COMETLAKE,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> > +	VULNBL_INTEL(TIGERLAKE_L,	GDS),
> > +	VULNBL_INTEL(TIGERLAKE,		GDS),
> > +	VULNBL_INTEL(LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
> > +	VULNBL_INTEL(ROCKETLAKE,	MMIO | RETBLEED | GDS),
> > +	VULNBL_INTEL(ALDERLAKE,		RFDS),
> > +	VULNBL_INTEL(ALDERLAKE_L,	RFDS),
> > +	VULNBL_INTEL(RAPTORLAKE,	RFDS),
> > +	VULNBL_INTEL(RAPTORLAKE_P,	RFDS),
> > +	VULNBL_INTEL(RAPTORLAKE_S,	RFDS),
> > +	VULNBL_INTEL(ATOM_GRACEMONT,	RFDS),
> > +	VULNBL_INTEL(ATOM_TREMONT,	MMIO | MMIO_SBDS | RFDS),
> > +	VULNBL_INTEL(ATOM_TREMONT_D,	MMIO | RFDS),
> > +	VULNBL_INTEL(ATOM_TREMONT_L,	MMIO | MMIO_SBDS | RFDS),
> > +	VULNBL_INTEL(ATOM_GOLDMONT,	RFDS),
> > +	VULNBL_INTEL(ATOM_GOLDMONT_D,	RFDS),
> > +	VULNBL_INTEL(ATOM_GOLDMONT_PLUS, RFDS),
> 
> Take the opportunity to realign and fix this ?

I assume by also adding a tab to all the other entries?

