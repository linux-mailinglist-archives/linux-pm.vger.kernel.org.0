Return-Path: <linux-pm+bounces-23572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2DA55225
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCF718976CF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64825269AEA;
	Thu,  6 Mar 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kE2TqQgr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8825C6F7;
	Thu,  6 Mar 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280287; cv=none; b=I+Kag+Q5AquBXKOa8H3BS+OSDX0JY5MXXNCIdPd2ncjiBUIWw5TuC+r294zWU+v/nCHcV5vFhDIQ09W7+Vh4SWAJ8JpljTPOU+fujrav6SkjeCHWWX84RJsiEHjaG7XefSq0RwswFTqyGx687x/gmF7Hm807OXMdzAUeJ2UDekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280287; c=relaxed/simple;
	bh=iye/SSIddxiY8mSsOHtwpzr/U8xVr9GpyZGHUWgmDAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtihvCXmOBEjtGU+I6nt/1MlmmRTqWFDLK1z/Kvotv/eTsNq0NDqUBwwe1cdDfqN/v1XiFy/bFO9fBqpNGtlTlxr1H/mKVvsRcrF3GXrDEedktgr2mEBSe4bBClrnSvaAKGnqJUAttQVf1ARG6MSBZHt2k3ocp/BlJ98Avo8vQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kE2TqQgr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741280286; x=1772816286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iye/SSIddxiY8mSsOHtwpzr/U8xVr9GpyZGHUWgmDAI=;
  b=kE2TqQgrHPMiIww8/j3eNQzcLvf7NDgTa44zOtNvLsbzBBOba/DieSvZ
   UVDDzzwNf7Mw4XLplT2ZKrlCWT4Qx+lRGCf+6nfYxpseJXQQZSy9Xf8l/
   kWPEfHzt0eMEhxu2dWzWcFEEaheEos0p2yjDZPRX8D4vhPz8OgPNYiBQT
   vJDjqlwTpvtN7u8stsaGwzQBsFLJUFYFgItrk2Z6f5v5haulJutViaNus
   Bnd906QGRJBYzoZrbrMmybpPTjqZW1nTHBExWG9dDyAkzn1SqxEuY2KqG
   LkB45bjlHr4L+20VpIMaKzSof0EgwdpyRYMf0/jifVvSIMnhlaO440OTF
   Q==;
X-CSE-ConnectionGUID: nTvGVPz4SD69csXyOtI9IQ==
X-CSE-MsgGUID: MB6sbF/yQTmzltyHa2ihtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52942743"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52942743"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 08:58:05 -0800
X-CSE-ConnectionGUID: uAIDf/VsTtO0dQ/Xd2EERA==
X-CSE-MsgGUID: bCZGL2y2SnGL9qhLf1QKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="142307035"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 08:58:04 -0800
Date: Thu, 6 Mar 2025 08:57:57 -0800
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v6 4/5] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20250306165757.sh6azitvazhq5lxj@desk>
References: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>
 <20250305-add-cpu-type-v6-4-4741735bcd75@linux.intel.com>
 <542cfd1b-65f8-4fa9-811e-d70850d0cf9a@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542cfd1b-65f8-4fa9-811e-d70850d0cf9a@intel.com>

On Thu, Mar 06, 2025 at 07:18:55AM -0800, Dave Hansen wrote:
> On 3/5/25 23:13, Pawan Gupta wrote:
> ...
> >  #define VULNWL_INTEL(vfm, whitelist)		\
> > -	X86_MATCH_VFM(vfm, whitelist)
> > +	X86_MATCH_VFM(INTEL_##vfm, whitelist)
> 
> I think the new VFM code may have thrown you off here. Doing HASWELL_X
> is not as nice as INTEL_HASWELL_X because, while you can grep for it, it
> won't work when you're looking for full identifiers like with ctags or
> cscope.
> 
> Also, this is just putting the "INTEL" in the macro instead of the VFM.
> I'm not sure there's much value in doing:
> 
> 	VULNWL_INTEL(ALDERLAKE_L, ...)	
> 
> over:
> 
> 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, ...)

Ahh, right. I will fix that. Thanks for pointing this out.

As one of the goal of the patch is to shorten the macro names and follow
the VULNWL_<> pattern, would it make sense to rename VULNWL_INTEL to:

#define VULNWL_VFM(vfm, whitelist)		\
	X86_MATCH_VFM(vfm, whitelist)

Then the table would look like:

	VULNWL_VFM(INTEL_TIGERLAKE,	NO_MMIO),

Simlarly for cpu_vuln_blacklist the macros become:

#define VULNBL_VFM(vfm, issues)			\
	VULNBL_VFM_STEPS(vfm, X86_STEP_MAX, issues)

#define VULNBL_VFM_STEPS(vfm, max_stepping, issues)		   \
	X86_MATCH_VFM_STEPS(vfm, X86_STEP_MIN, max_stepping, issues)

#define VULNBL_VFM_TYPE(vfm, cpu_type, issues)			\
	X86_MATCH_VFM_CPU_TYPE(vfm,				\
			       INTEL_CPU_TYPE_##cpu_type,	\
			       issues)

And the table would look like:

	VULNBL_VFM(INTEL_COMETLAKE,			MMIO | MMIO_SBDS | RETBLEED | GDS),
	VULNBL_VFM_STEPS(INTEL_COMETLAKE_L,	0x0,	MMIO | RETBLEED),
	...
	VULNBL_VFM_TYPE(INTEL_ALDERLAKE,	ATOM,	RFDS),

