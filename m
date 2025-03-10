Return-Path: <linux-pm+bounces-23779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965AA59ADE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A433116D43C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE822FDF1;
	Mon, 10 Mar 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlZ+lzak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7F22D4FA;
	Mon, 10 Mar 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623859; cv=none; b=tnGWUpY+EmdXI6W7tYrmmzcA2CbHAnHxBnSV7wFjaaEYOEFeC+HpGMpq37vboG91yJW+wD6H41zT8W8d81XzZ/SHujwatiUqcvRfpF22e6uzMfF3Lz38W8uqmkvnRxgfS/bF2Ms206P8+BoBx0gpmNt8RPQG5FTAntx3R1sb8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623859; c=relaxed/simple;
	bh=s+wjRBUMqIcGIqIJM5croAQ+6hfrceKBMzBSBv4TLDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/YMFSmhiTQ3H8oC24gcRv2yRChsP6ADZzsR7BvgENptC1C9sO+x2mZMVv0QgpbdiaAoYjcHT0oxEob2ZAWN+g+loV350cvkxfTmpfJ57fuJDXnFuYFAxY9lPaA/m+x3XJcMUynb4YWrDjiNJzZtK3sBAuywOWYhgx1x5fyGJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlZ+lzak; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741623857; x=1773159857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+wjRBUMqIcGIqIJM5croAQ+6hfrceKBMzBSBv4TLDE=;
  b=BlZ+lzakLdl17JdBxOMNsv95JcrUVBHUCEL2gfFCcTEVzTbj6BzvO9Cw
   m+sKkKcfxkRMxGiWO1jr+S5eSsuj0EOgTrkQs3aqwVuA5eSQp69Tf3/rs
   DAzGsEJ2mFgTv1peKw1vW4nV6ElAYPyWqeiILiVyhEc548+jkMVUCuWtx
   gnXl69vSESUx5taqKqqlGVIEpaQsGrNWlSHoARvXSrVF7UpHTk9IloQlk
   3r2uFQQ5b5Lw0NVa04IeB8Vnkl1hmatKmIhkTueUfrEBxSRWc6tjJA9WU
   74wwPxE4irthgkvD68JgEJAiRxHSW8jtUtX8K56DCln9TA00PxhrLYwAg
   Q==;
X-CSE-ConnectionGUID: Vy6qCJfwSLWLNYmW12R2LA==
X-CSE-MsgGUID: 2OMSKKpERlCWDaeejLVLuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42508525"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42508525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:24:16 -0700
X-CSE-ConnectionGUID: zuvTN6jrSJemMHXBIeGbQg==
X-CSE-MsgGUID: DIZRdAo2RKKHwhexYGDqSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120931977"
Received: from msridhar-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:24:16 -0700
Date: Mon, 10 Mar 2025 09:24:09 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v7 3/4] x86/cpu: Update x86_match_cpu() to also use
 cpu-type
Message-ID: <20250310162409.5gnesmcz4fdon5al@desk>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-3-f903fb022fd4@linux.intel.com>
 <20250310104844.GDZ87DjFQef8GaREqg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310104844.GDZ87DjFQef8GaREqg@fat_crate.local>

On Mon, Mar 10, 2025 at 11:48:44AM +0100, Borislav Petkov wrote:
> On Thu, Mar 06, 2025 at 06:18:36PM -0800, Pawan Gupta wrote:
> > +static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
> > +{
> > +	if (m->cpu_type == X86_CPU_TYPE_ANY)
> > +		return true;
> > +
> > +	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
> > +	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
> 
> check_for_deprecated_apis: WARNING: arch/x86/kernel/cpu/match.c:25: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

Will do. Thanks for the review.

