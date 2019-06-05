Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E935A74
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfFEKcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:32:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:12403 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEKcr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:32:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 03:32:46 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2019 03:32:42 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hYTDm-0001RK-5f; Wed, 05 Jun 2019 13:32:42 +0300
Date:   Wed, 5 Jun 2019 13:32:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
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
Message-ID: <20190605103242.GU9224@smile.fi.intel.com>
References: <20190530123827.8218-1-rajneesh.bhardwaj@linux.intel.com>
 <20190604160914.GN9224@smile.fi.intel.com>
 <79e33a93-6180-5a58-0d8c-b34276e710f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e33a93-6180-5a58-0d8c-b34276e710f3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 05, 2019 at 12:54:12AM +0530, Bhardwaj, Rajneesh wrote:
> Hi Andy
> 
> On 04-Jun-19 9:39 PM, Andy Shevchenko wrote:
> > On Thu, May 30, 2019 at 06:08:27PM +0530, Rajneesh Bhardwaj wrote:
> > > Add the CPUID model number of Icelake Neural Network Processor for Deep
> > I believe we spell "Ice Lake".
> 
> I referred to https://patchwork.kernel.org/patch/10812551/ , https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e394376ee89233508fa21d006546357f8efee31
> and many others where it mentioned Icelake. I am fine to change it the way
> you are suggesting, please confirm if its still needed and i will send a v2.

I think the references have a mistake as well.

-- 
With Best Regards,
Andy Shevchenko


