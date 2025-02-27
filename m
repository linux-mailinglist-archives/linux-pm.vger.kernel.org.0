Return-Path: <linux-pm+bounces-23128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D0A4870B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC83B851B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB31EA7E2;
	Thu, 27 Feb 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lie+yC6z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53F1D5CD3;
	Thu, 27 Feb 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678703; cv=none; b=YX1cyMdSRnrqTt82nUCOHQ9KFS7hn3CEWM3hzNcVMLJWHPJwuxagMThXrfF0DaKo/acziDxKgMFApXHZG9Psyopg4t57UDfzCMsNcCnOiXj1F6/IJJsixXuHqaGMH94WF10jDK01l/ghDfFT0EC2Ggl1ATLD1VH/sS/97c8+5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678703; c=relaxed/simple;
	bh=ysZL8S/jNIL2iPLyV02DWvITqHSrQoDwzQA1YEfJy/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAw8zwX+mTEL5eh4vftLX3cVrVIP4W7ZZUH33JXbmcJ3JTTInMIgSr1dGF7va+OYEp5TC1RspHmaZ+SsBlEwhUhQEjaI83mn0GJlcIi65ZuDEmv9PuOZJoz8RzLu+jFp9C/HExdS4eQHaZXTuj/2AJTN60eUY5zQ0M8UUK/h4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lie+yC6z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740678703; x=1772214703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysZL8S/jNIL2iPLyV02DWvITqHSrQoDwzQA1YEfJy/8=;
  b=Lie+yC6zcu2e0Z16h9c/BhTCPpGGkYiVc/aI+qyB7RT4fe8RApfVlvEc
   Y+KECx4nUA9f3fSyCqyb2utjjIjoXMJ1pPKgoXG7DURhJ3ef10uk6IbbT
   OFf10321TBrfW4XNZt71E54qEj/yjGL3kJBaFVftj0o2HfoDi5c1k4EXj
   v5Js1Mp5HNV1hS4jfOnSS9VjnoS2IaioW5Qo8XMYFevDDZp2mWpmgzdi7
   pBjfV2XYRbzWugXWl6pnYB3YOBBTvg8xKTwbFio6vKAO9uVGBiYHLt/QZ
   KQNzNCbiz0H+ihFPoLgmU3CHzKq+UHGPzOnwS7bybpoPLHan708YrWVXH
   Q==;
X-CSE-ConnectionGUID: Kj/KbTw6RGmojlELt3WxPQ==
X-CSE-MsgGUID: HcS42Qt1TgWF0R67MP3h3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52980067"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52980067"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:51:37 -0800
X-CSE-ConnectionGUID: Ou74OnD+RhqmlHKRC2u9BQ==
X-CSE-MsgGUID: ia0fBqBcTRi2vG8EuxhsQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118019220"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:51:35 -0800
Date: Thu, 27 Feb 2025 09:51:29 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 0/9] Utilize cpu-type for CPU matching
Message-ID: <20250227175129.v23sm56tkxcnlqvz@desk>
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
 <Z8BdVzJKbxheqvme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8BdVzJKbxheqvme@gmail.com>

On Thu, Feb 27, 2025 at 01:40:55PM +0100, Ingo Molnar wrote:
> 
> * Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> > Pawan Gupta (9):
> >       x86/cpu: Prepend 0x to the hex values in cpu_debug_show()
> >       cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
> >       perf/x86/intel: Use cache cpu-type for hybrid PMU selection
> >       x86/cpu: Remove get_this_hybrid_cpu_*()
> >       x86/cpu: Name CPU matching macro more generically (and shorten)
> >       x86/cpu: Add cpu_type to struct x86_cpu_id
> >       x86/cpu: Update x86_match_cpu() to also use cpu-type
> >       x86/bugs: Declutter vulnerable CPU list
> >       x86/rfds: Exclude P-only parts from the RFDS affected list
> 
> So it looks like this series, despite being complete, fell between the 
> cracks during the usual end-of-year distractions.
> 
> To get the ball rolling I have applied the first 4 patches to 
> tip:x86/cpu - the cpufreq one needed a small conflict resolution, and I 
> have adjusted the debug output of the first one to not break 
> pre-existing vertical tabulation.

Thanks for picking this up.

> Mind double checking the result in tip:x86/cpu and submit the remaining 
> 5 patches on top of it?

I had quick look, fixes and merge resolution LGTM. I will submit the
remaining 5 patches soonish.

