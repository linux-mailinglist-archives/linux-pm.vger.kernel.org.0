Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7334CDD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfFDQJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 12:09:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:22656 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfFDQJU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 12:09:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:09:19 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2019 09:09:15 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hYBzu-0000nb-Qw; Tue, 04 Jun 2019 19:09:14 +0300
Date:   Tue, 4 Jun 2019 19:09:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de,
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
Subject: Re: [PATCH] x86/cpu: Add Icelake-NNPI to Intel family
Message-ID: <20190604160914.GN9224@smile.fi.intel.com>
References: <20190530123827.8218-1-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530123827.8218-1-rajneesh.bhardwaj@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 06:08:27PM +0530, Rajneesh Bhardwaj wrote:
> Add the CPUID model number of Icelake Neural Network Processor for Deep

I believe we spell "Ice Lake".

> Learning Inference (ICL-NNPI) to the Intel family list. Icelake NNPI uses

Ditto.

> model number 0x9D and this will be documented in a future version of Intel
> Software Development Manual.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Cc: Linux PM <linux-pm@vger.kernel.org>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 9f15384c504a..087de5d3b93a 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -53,6 +53,7 @@
>  #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
>  
>  #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
> +#define INTEL_FAM6_ICELAKE_NNPI		0x9D
>  
>  /* "Small Core" Processors (Atom) */
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


