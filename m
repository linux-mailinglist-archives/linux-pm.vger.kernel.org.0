Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF34216D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437702AbfFLJwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 05:52:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:48959 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437415AbfFLJwl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 05:52:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 02:52:40 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2019 02:52:35 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hazvl-0007ql-Rx; Wed, 12 Jun 2019 12:52:33 +0300
Date:   Wed, 12 Jun 2019 12:52:33 +0300
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
Subject: Re: [Patch v2] x86/cpu: Add Ice Lake NNPI to Intel family
Message-ID: <20190612095233.GE9224@smile.fi.intel.com>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 06, 2019 at 06:54:19AM +0530, Rajneesh Bhardwaj wrote:
> Add the CPUID model number of Ice Lake Neural Network Processor for Deep
> Learning Inference (ICL-NNPI) to the Intel family list. Ice Lake NNPI uses
> model number 0x9D and this will be documented in a future version of Intel
> Software Development Manual.

>  #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
> +#define INTEL_FAM6_ICELAKE_NNPI		0x9D

What "I" stands for?

For me sounds like it's redundant here or something like NNP_DLI would be
better (because somewhere we have _NP as for Network Processor).

-- 
With Best Regards,
Andy Shevchenko


