Return-Path: <linux-pm+bounces-9356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232790B9B1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0585B263DD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AF198E7E;
	Mon, 17 Jun 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf40vmQd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA070198856;
	Mon, 17 Jun 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647756; cv=none; b=H6+YNRVlZmUxA1tGKKFdHCi7H4flWXByLMx2cwRpvH+7rHlFNKhTMisKCGAiwvvymvEQJqcJC0X20zaOUrWq61ZjSJOXcYCBYgf0G7xSao/KXGiZaXLGy+AsUYL2YUU8ELTeE2WRdhMK4Aaxu1o3fHUiB9XkvcUHLh7FU2m10ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647756; c=relaxed/simple;
	bh=eTmhoimpvd+XmjL34WKAkgkEP8GEWbc3ZlhhhpMyxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwZobNH7IkXzqDH3EeuXaNolbJnCs+bu0mLFW0eC+Vh6OJdy/SimP2af0WfFKx0tqQ0QA0TgxE/8Dqas7mxCSdxeRp5vtX85wecBFP5CVGBhT09RuXboSqRPMc/mUcRylZaqVWqLrhz3yzVyEEOq1wtqGLKefF5SXS0DZKNrE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf40vmQd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718647754; x=1750183754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eTmhoimpvd+XmjL34WKAkgkEP8GEWbc3ZlhhhpMyxTA=;
  b=Mf40vmQdR1ilcW6mLSFsjjUiPj1wICMzuRy10RvO1lV7PZan18MqVU19
   VhH13FK+dsuu63PsQxJo+0N4i097lILxvMHnfKdS8s6pQvcG+H6pg0JtU
   qEG7IWxPmoeBWhglH08W/7EIszu9xtEIRTvmqNxicufViSa2DCJOMJ6ZV
   MN8gSWip139TBCkoNJy09vJnrqnGjGFmd9EwStC4c4wcp6x91Uyn7A1ch
   T3hGm6H3tacmGs2qUMxJjdo0cynC4tOlp967LpuCLM5zFNvbt2FhJNplI
   N4TJysCwgkVX65nK+PJWOXI/1h6HLj8uuBV2/hgnJYXYB0reyUdAgDZFy
   g==;
X-CSE-ConnectionGUID: ft64qMONSjanE6cHFAEg7A==
X-CSE-MsgGUID: AxkOwRBOTjGLEpYmtrNzsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15259316"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15259316"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:09:13 -0700
X-CSE-ConnectionGUID: hfBZzyoiSFqjiUQGu3/IBQ==
X-CSE-MsgGUID: wdxrYlbbRKaMT5DnPNtKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="46390025"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 11:09:13 -0700
Date: Mon, 17 Jun 2024 11:09:05 -0700
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
Subject: Re: [PATCH PATCH 3/9] perf/x86/intel: Use topology_cpu_type() to get
 cpu-type
Message-ID: <20240617180905.7ao623w6eyu64hs2@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-3-b88998c01e76@linux.intel.com>
 <7c4978b4-ac69-480e-b8cf-a473b64ed917@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4978b4-ac69-480e-b8cf-a473b64ed917@intel.com>

On Mon, Jun 17, 2024 at 07:50:53AM -0700, Dave Hansen wrote:
> On 6/17/24 02:11, Pawan Gupta wrote:
> > find_hybrid_pmu_for_cpu() uses get_this_hybrid_cpu_type() to get the CPU
> > type, but it returns an invalid cpu-type when X86_FEATURE_HYBRID_CPU is not
> > set. Some hybrid variants do enumerate cpu-type regardless of
> > X86_FEATURE_HYBRID_CPU.
> 
> I'm not fully sure what point this is trying to make.

Sorry it was not clear. I will rephrase it.

> Is this trying to make the case that get_this_hybrid_cpu_type() and
> topology_cpu_type() are equivalent or pointing out a difference?

Pointing out a difference. get_this_hybrid_cpu_type() misses a case when
cpu-type is enumerated regardless of X86_FEATURE_HYBRID_CPU. I don't think
checking for the hybrid feature is necessary here, because there is an
existing fixup for this case:

  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
  {
          u8 cpu_type = topology_cpu_type(smp_processor_id());
          int i;

          /*
           * This is running on a CPU model that is known to have hybrid
           * configurations. But the CPU told us it is not hybrid, shame
           * on it. There should be a fixup function provided for these
           * troublesome CPUs (->get_hybrid_cpu_type).
           */
          if (cpu_type == HYBRID_INTEL_NONE) {
                  if (x86_pmu.get_hybrid_cpu_type)
                          cpu_type = x86_pmu.get_hybrid_cpu_type();
                  else
                          return NULL;
          }

