Return-Path: <linux-pm+bounces-9375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A290B995
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB96B1C210F5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192D198A2C;
	Mon, 17 Jun 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/CQIh/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B8198A20;
	Mon, 17 Jun 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648389; cv=none; b=mdWPO0OWX4C/3kBar3F+lZsnpzhjQHBUWawUprRMh2McnyPYHCaUcfcrHVRD/gHwybLdS1hE7KNrMBNUO0rFwipI/BlLO5sS3yOPPZ3liGD9VgaAc0RqlRVFWFV/f5z/e9+5u95AZrLVwSD2IHwJ9MTljKZBlH6ioVdbdiv0srA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648389; c=relaxed/simple;
	bh=XXsUHvP7AGXNm012Rg79qcH4utzUgd2E/fRDGjz30QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2r4E1/HL1gsD9quTzeqs40f6oFNU3pm7nKbdjuuBlr4LheVRpZtotzD9GS94+aXHr6WyEraobSi0X0ayu+b6Au9v+DTi9QWF9nuqWf8wAIayzFG0GjiRvKErmuFbMxUbdZ7tQ0p3zRJxCH0hFOAxSsP8I+Edw02j3qfXYKHSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/CQIh/i; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718648389; x=1750184389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXsUHvP7AGXNm012Rg79qcH4utzUgd2E/fRDGjz30QY=;
  b=W/CQIh/i0q4+hxBgPO0O64we1FrCdiq9J/YiaIn6uMWMOn1ndx2Ot++h
   8ec39rVnEU5nl8qKtMKakBxdpg6JwW1dXMWUExRZrOGaq/CaDipQs/1cH
   p8Edvw18ImXwfD33i6Y2n9DJuR9/4dhZRN09zzSE8Poc/+WPBN1EA0Q7D
   FrQsKXcMeY85d6cVEI1P0HBrwGvv+aJWAisBwO9URhJaEBSJ6OCADrOC/
   LwWbcGKXVY1rxDbth5mOpFKTVu+uO4ycOWvAtAjujmcVLdJsVb2Fiijvc
   Gt1L56E2Cd9efXFUbPYAlDZMdVEH+rHZyUZU2JjSZer8rG+a9C/QRKEkS
   A==;
X-CSE-ConnectionGUID: Uw2PSK+GQM+ozhwbIYUlgA==
X-CSE-MsgGUID: TIAfhfvMSjKjMjGeB4VUkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15330953"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15330953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:19:48 -0700
X-CSE-ConnectionGUID: 420FBZXhR9OR/vx18T0yPA==
X-CSE-MsgGUID: YWp5pRpZQ0Sux8PHwVjVXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41147004"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:19:47 -0700
Date: Mon, 17 Jun 2024 11:19:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH PATCH 9/9] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240617181940.aojl7etznk4h5zdm@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-9-b88998c01e76@linux.intel.com>
 <d7c70d92-4d19-4c1e-81c9-d4c0cd34eda8@citrix.com>
 <805fa8d2-c920-415c-8db5-f073607f9e6a@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805fa8d2-c920-415c-8db5-f073607f9e6a@intel.com>

On Mon, Jun 17, 2024 at 07:34:22AM -0700, Dave Hansen wrote:
> On 6/17/24 02:43, Andrew Cooper wrote:
> > On 17/06/2024 10:12 am, Pawan Gupta wrote:
> >> +	VULNBL_INTEL_CPU_TYPE (RAPTORLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
> >> +	VULNBL_INTEL_CPU_TYPE (ALDERLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
> > 
> > How does this work?
> > 
> > Being __initconst, this is only evaluated on the BSP.
> > 
> > P-only and mixed P/E systems won't see X86_CPU_TYPE_INTEL_ATOM, even if
> > there are ATOM APs to bring up later.
> 
> The X86_CPU_TYPE_* is only used on the boot CPU on non-hybrids.  Hybrids
> (independent of the boot CPU type) should be considered vulnerable no
> matter what.

Yes. This is done in x86_match_cpu_type(), that matches all cpu-types on hybrids:

  static bool x86_match_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id)
  {
     if (m->cpu_type == X86_CPU_TYPE_ANY)
         return true;

     /* Hybrid CPUs are special, they are assumed to match all cpu-types */
     if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
         return true;

     return c->topo.cpu_type == m->cpu_type;
  }

