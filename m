Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B734470D9
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhKFWEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Nov 2021 18:04:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:10545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhKFWEt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 6 Nov 2021 18:04:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10160"; a="219270362"
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="scan'208";a="219270362"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 15:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="scan'208";a="502449763"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2021 15:02:05 -0700
Date:   Sat, 6 Nov 2021 15:01:21 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] x86: Add definitions for the Intel Hardware Feedback
 Interface
Message-ID: <20211106220121.GA29613@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-3-ricardo.neri-calderon@linux.intel.com>
 <YYZZWzNWdmeCFBAd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYZZWzNWdmeCFBAd@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 06, 2021 at 11:30:51AM +0100, Borislav Petkov wrote:
> On Fri, Nov 05, 2021 at 06:33:07PM -0700, Ricardo Neri wrote:
> > Add the CPUID feature bit and the model-specific registers needed to
> > identify and configure the Intel Hardware Feedback Interface.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  arch/x86/include/asm/msr-index.h   | 6 ++++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index d0ce5cfd3ac1..d76d8daf1b2b 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -325,6 +325,7 @@
> >  #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
> >  #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
> >  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
> > +#define X86_FEATURE_INTEL_HFI		(14*32+19) /* Hardware Feedback Interface */
> 
> X86_FEATURE_HFI
> 
> i.e., without the vendor name is perfectly fine.

Thank you very much for looking at the patch Boris! Sure, I can rename
the feature name.

BR,
Ricardo
