Return-Path: <linux-pm+bounces-25382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855DA888C5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752FD17AD92
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A757288CA7;
	Mon, 14 Apr 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8L6O3n8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF62820AF;
	Mon, 14 Apr 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648872; cv=none; b=d65r+QVfdyWI5BnEAX1CBkuUxuMQUptcqNJWK4l4l21vmV5+9rxwxan0sDE0EnoOcAWgPxw6rwgi99DM8Z3CYAHcYBzYWL0v5Lp5INUFPfJwvAGL9E6ru3qC7npCe5UynxLqTbvkrerDq8wJKDFBhcSqQXnUn8IfvZ54xLsKC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648872; c=relaxed/simple;
	bh=7OhxpBuonXoqqwgHU4YnELp3MYl43EUyqa8tiP/vePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMdxMj6D3uJPqDbHqdcSQubsgi6PdXAktN3bO74D2e06Whvr9MOJ2F+6Jy76+r7r/0Jzj601ikNb27XNFZ41WkWfp558dJdjArRX1+UjFyLwlemmA5Z7prVH+g0v8E/FVe3XoYp24FTGsd8THycU9yb93SzIVSh+wVkQwfngLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8L6O3n8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744648871; x=1776184871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OhxpBuonXoqqwgHU4YnELp3MYl43EUyqa8tiP/vePk=;
  b=Q8L6O3n8/x2vgpajESBoLx4dEppCaJUAbR09DOCWmzvTEa7RlHbJIDaJ
   Xt40/ruF5G2xw9i78b330S9IjdBzkUrtR/f8dP7Ba+jgfe63uWOUjcv9C
   Uih+VV59vZ8H5HjrabYv2m1mbrX3wEHyOqhYvnW2HVbFAo3hBxuzXS80U
   osPuGruDmNpsSu+0lFdV6Jw2fBjBzJdlK/pwbzTkoi/wr9toYLiTLwhRl
   2UtbNLSdjnrM9tBSm3xnVIhqyZAFGbtNF9Szmc9KGKMPRfqz30+/4f8jx
   NDS6/f5IHKFYvpevt6A6UsytLXO15nPvnX0SwZxTw+KPt1YnAsXxUak/B
   w==;
X-CSE-ConnectionGUID: yyRnbnXeS8qhq18t7bL/sA==
X-CSE-MsgGUID: ANzuMlkvTrSP2xlI034BRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46260513"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46260513"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:41:10 -0700
X-CSE-ConnectionGUID: uVWiwWU4Tm6Heaolflslng==
X-CSE-MsgGUID: nzXHcC1fQQ2MQIFr/vkTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129868035"
Received: from jamart5x-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.223])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:41:09 -0700
Date: Mon, 14 Apr 2025 09:41:02 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	Xi Ruoyao <xry111@xry111.site>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in
 hwp_get_cpu_scaling()
Message-ID: <20250414164102.vfk64a44mvutg4dh@desk>
References: <20250412103434.5321-1-xry111@xry111.site>
 <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
 <12659608.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12659608.O9o76ZdvQC@rjwysocki.net>

On Mon, Apr 14, 2025 at 05:19:04PM +0200, Rafael J. Wysocki wrote:
> On Sunday, April 13, 2025 4:44:56 PM CEST srinivas pandruvada wrote:
> > On Sat, 2025-04-12 at 18:34 +0800, Xi Ruoyao wrote:
> > > Use raw_smp_processor_id() instead of plain smp_processor_id() in
> > > hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo
> > > Thinkpad
> > > T14P Gen 2:
> > > 
> > >     BUG: using smp_processor_id() in preemptible [00000000] code:
> > > swapper/0/1
> > >     caller is hwp_get_cpu_scaling+0x7f/0xc0
> > > 
> > > Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> > > cpu-type")
> > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> >
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> It's still broken after this patch though because the function should
> use the cpu_data() of the target CPU and not of the CPU running the code.

Sorry for missing that.

I noticed that find_hybrid_pmu_for_cpu() doesn't take the cpu argument.
Does it suffer from the same problem?

init_hybrid_pmu(int cpu)
{
	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
	struct x86_hybrid_pmu *pmu = find_hybrid_pmu_for_cpu();

