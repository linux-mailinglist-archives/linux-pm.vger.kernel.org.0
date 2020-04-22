Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB341B4B6C
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVRPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 13:15:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:3619 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVRPI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 13:15:08 -0400
IronPort-SDR: o8ICLe/aL8A6wR+RMfccwy0/fhLlZe+ZbLHjpbIjoZSlzu+KLzGgLzSPfGTkVW904Sjq0LjWeb
 cRta8Wtjcd7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 10:15:08 -0700
IronPort-SDR: N5x4Qb012Gmm4XMbo6ZgeVHE6RK4/gQTut3EZNq6/LLka0GFNpFTG7SZJBjcWOBqxmRcCxTfqS
 NwGm1D0svKfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="280097166"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2020 10:15:07 -0700
Date:   Wed, 22 Apr 2020 10:15:47 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/4] x86, sched: Bail out of frequency invariance if base
 frequency is unknown
Message-ID: <20200422171547.GA11942@ranerica-svr.sc.intel.com>
References: <20200416054745.740-1-ggherdovich@suse.cz>
 <20200416054745.740-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416054745.740-2-ggherdovich@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 07:47:42AM +0200, Giovanni Gherdovich wrote:
> Some hypervisors such as VMWare ESXi 5.5 advertise support for
> X86_FEATURE_APERFMPERF but then fill all MSR's with zeroes. In particular,
> MSR_PLATFORM_INFO set to zero tricks the code that wants to know the base
> clock frequency of the CPU (highest non-turbo frequency), producing a
> division by zero when computing the ratio turbo_freq/base_freq necessary
> for frequency invariant accounting.
> 
> It is to be noted that even if MSR_PLATFORM_INFO contained the appropriate
> data, APERF and MPERF are constantly zero on ESXi 5.5, thus freq-invariance
> couldn't be done in principle (not that it would make a lot of sense in a
> VM anyway). The real problem is advertising X86_FEATURE_APERFMPERF. This
> appears to be fixed in more recent versions: ESXi 6.7 doesn't advertise
> that feature.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> ---
>  arch/x86/kernel/smpboot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index fe3ab9632f3b..3a318ec9bc17 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1985,6 +1985,15 @@ static bool intel_set_max_freq_ratio(void)
>  	return false;
>  
>  out:
> +	/*
> +	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
> +	 * but then fill all MSR's with zeroes.
> +	 */
> +	if (!base_freq) {
> +		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> +		return false;
> +	}

It may be possible that MSR_TURBO_RATIO_LIMIT is also all-zeros. In
such case, turbo_freq will be also zero. If that is the case,
arch_max_freq_ratio will be zero and we will see a division by zero
exception in arch_scale_freq_tick() because mcnt is multiplied by
arch_max_freq_ratio().

Hence, you should also check for !turbo_freq.

Thanks and BR,
Ricardo

