Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE1242C47
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438157AbfFLQ3Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 12:29:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:1846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438142AbfFLQ3Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 12:29:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 09:29:24 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2019 09:29:20 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hb67i-0003WD-Rj; Wed, 12 Jun 2019 19:29:18 +0300
Date:   Wed, 12 Jun 2019 19:29:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [Patch v2] x86/cpu: Add Ice Lake NNPI to Intel family
Message-ID: <20190612162918.GP9224@smile.fi.intel.com>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
 <20190612095233.GE9224@smile.fi.intel.com>
 <73eb1ba5-dc29-53ee-487d-d22700b874a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73eb1ba5-dc29-53ee-487d-d22700b874a1@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 12, 2019 at 07:51:26AM -0700, Dave Hansen wrote:
> On 6/12/19 2:52 AM, Andy Shevchenko wrote:
> >>  #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
> >> +#define INTEL_FAM6_ICELAKE_NNPI		0x9D
> > What "I" stands for?
> > 
> > For me sounds like it's redundant here or something like NNP_DLI would be
> > better (because somewhere we have _NP as for Network Processor).
> 
> Let's not bikeshed this too much.  These things aren't used that widely
> and mostly they're just used for figuring out the processor generation.
>  It's exceedingly rare to have something like:
> 
> 
> 	if (model == INTEL_FAM6_ICELAKE_MOBILE)
> 		foo();
> 	else if (model == INTEL_FAM6_ICELAKE_NNPI)
> 		bar();
> 
> where what you suggest would matter.
> 
> Preserving the ability to google "ice lake nnpi" is pretty important, so
> preserving the Intel name makes a lot of sense here when possible.

What I'm talking is a consistency among suffixes. If there is a real
abbreviation (NNPI) which anybody can google, I'm totally for it to be used.

> Do we *HAVE* an Ice Lake network processor?

Not Ice Lake, something else.

-- 
With Best Regards,
Andy Shevchenko


