Return-Path: <linux-pm+bounces-16112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A869A6F34
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1558E1C2247C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222819923D;
	Mon, 21 Oct 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvgyGxKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC5178395;
	Mon, 21 Oct 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527498; cv=none; b=KyhvShDAM4+maLEgZxwDTwNXVMS7kAQGbNk2IE4iCMXlJ9o9ucHPZLXWh7S4KeHVOveYEbOgxVEUC5OyOpGyEw0DUZ6aWP9K+tHe6NPr0XiBYK0J2PN5BAQ2k6yGC2o2XZgaqWLl6CVk4UytqnG0JOtxyD4OGgE1ZGN80zibnWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527498; c=relaxed/simple;
	bh=UA8DMdA9ExWRyddpZQ7CnN8ViJmO/LyOSjr+tas7ijg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnE+2S/dyZY+qv7kgOTQV1BeqhFcA0WSk1EW9DtLmKXvHM8GoodOR/CIpa43jxbOnOwNbcUdb3R8AJCHVuo1CfxS+jXdORX8fTXoGLFZa4pGABlRzVn8k3eryAvc0U+aGUhh4Q/HolV90lsuIgB452OwGAhsAWSC2xV2Jy6TtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvgyGxKY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729527497; x=1761063497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UA8DMdA9ExWRyddpZQ7CnN8ViJmO/LyOSjr+tas7ijg=;
  b=GvgyGxKYiHhV6jqbQ4z24IAJU+T+XKtRSIHHhX9xSDnR8496d2P0VAz+
   aLIGL8fLoTA59df6b0cUsujXuuyh3Zz8Ku1I5AfuvGy4FxXi1eZHra2tx
   2cU4wq4O15lHAsQ3r1qhYEQD7SU6G++EYcrV5ioxbYXyK/0DfpnZORjZu
   q2Be/hBFcaDg8cKjbxz8HcBxAVSMXt7a/EMxv5ZY3tQ6PtcD7cIV0FPIZ
   RApS47MghbeYkHHAhHMm9EV45y7u7QepE0eVtnlo/ObgLVrUFy5Zz8ncb
   /fdX6Jha0BG2Ub+wFiqF+8ysi42tStmwIKpEwA5PkkuZukuuhtkZH4z1u
   Q==;
X-CSE-ConnectionGUID: 76jwGXBJT4Ss9RCRe5aVdw==
X-CSE-MsgGUID: T7ZCSuNIR6WCRISYbH5XKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16652508"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="16652508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:18:16 -0700
X-CSE-ConnectionGUID: kVuQ0PUiQjef6QVQBmCO4Q==
X-CSE-MsgGUID: w+Q5XNLKRSm2Pgs/jwb33w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79752437"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:18:04 -0700
Date: Mon, 21 Oct 2024 09:17:48 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 04/10] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20241021161748.67hnp4vexywdjdkq@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-4-104892b7ab5f@linux.intel.com>
 <e7de0a73-23de-4b79-95e2-8a6dd9addfe7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7de0a73-23de-4b79-95e2-8a6dd9addfe7@linux.intel.com>

On Mon, Oct 21, 2024 at 09:54:57AM -0400, Liang, Kan wrote:
> Hi Pawan,
> 
> On 2024-09-30 10:47 a.m., Pawan Gupta wrote:
> > get_this_hybrid_cpu_type() misses a case when cpu-type is populated
> > regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
> > variants that have P or E cores fused off.
> > 
> > Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
> > enumerate cpu-type. This can also help avoid the model-specific fixup
> > get_hybrid_cpu_type().
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/events/intel/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index d879478db3f5..80a2a307e678 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4906,7 +4906,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
> >  
> >  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
> >  {
> > -	u8 cpu_type = get_this_hybrid_cpu_type();
> > +	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
> > +	u8 cpu_type = topology_hw_cpu_type(c);
> >  	int i;
> >  
> >  	/*
> > 
> 
> Dapeng's patch to utilize the native model ID in perf has been merged.
> Please replace the get_this_hybrid_cpu_native_id() as well when you spin
> a new version.

Will do. Thanks for letting me know.

