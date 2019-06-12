Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC45442D03
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfFLRIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 13:08:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:17836 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfFLRIz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 13:08:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:08:54 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2019 10:08:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hb6jw-00041X-WF; Wed, 12 Jun 2019 20:08:49 +0300
Date:   Wed, 12 Jun 2019 20:08:48 +0300
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
Message-ID: <20190612170848.GQ9224@smile.fi.intel.com>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
 <20190612095233.GE9224@smile.fi.intel.com>
 <73eb1ba5-dc29-53ee-487d-d22700b874a1@intel.com>
 <20190612162918.GP9224@smile.fi.intel.com>
 <414a8fe8-4c85-f323-d71c-16b231823ffe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414a8fe8-4c85-f323-d71c-16b231823ffe@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 12, 2019 at 09:33:30AM -0700, Dave Hansen wrote:
> On 6/12/19 9:29 AM, Andy Shevchenko wrote:
> > What I'm talking is a consistency among suffixes. If there is a real
> > abbreviation (NNPI) which anybody can google, 
> 
> There is and you can. :)

Good, I have no objections.

-- 
With Best Regards,
Andy Shevchenko


