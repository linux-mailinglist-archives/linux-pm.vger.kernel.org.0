Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF8369E62
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDXBbB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 21:31:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:5544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDXBa6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 21:30:58 -0400
IronPort-SDR: FKY4dnIo9Jz4Vd8Sj6gT2k/giu3lQDLf+b0TzwInp8Gg7cS6IeNf0kGNVCMyC7Qu3/vfC0QtuV
 kJ0Vn9VWbmRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="216842661"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="216842661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:30:17 -0700
IronPort-SDR: /s4x2t3D7mrvOz1DX7bj+Vybnle2r3lG7F47Skqr7EEa2MNQz4ncikTzleiTpCa3F+m6lAZhE7
 JSlvi2WfQNmg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="464504518"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:30:13 -0700
Date:   Sat, 24 Apr 2021 09:34:01 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210424013401.GA432412@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
 <20210423121934.GC24710@zn.tnic>
 <23f75aaf3d37cbad6f8ed7bd970434e4a2dc388e.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23f75aaf3d37cbad6f8ed7bd970434e4a2dc388e.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 10:00:14AM -0400, Calvin Walton wrote:
> On Fri, 2021-04-23 at 14:19 +0200, Borislav Petkov wrote:
> > On Fri, Apr 23, 2021 at 08:16:07PM +0800, Chen Yu wrote:
> > > From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00
> > > 2001
> > > From: Calvin Walton <calvin.walton@kepstin.ca>
> > > Date: Fri, 23 Apr 2021 17:32:13 +0800
> > > Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow
> > > issue in index
> > >  converting
> > > 
> > > The idx_to_offset() function returns type int (32-bit signed), but
> > > MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
> > > interpreted as a negative number). The end result is that it hits
> > > the if (offset < 0) check in update_msr_sum() resulting in the
> > > timer
> > > callback for updating the stat in the background when long
> > > durations
> > > are used to not happen. The similar issue exists in offset_to_idx()
> > > and update_msr_sum().
> > > 
> > > This patch fixes this issue by converting the 'int' type to 'off_t'
> > > accordingly.
> > > 
> > > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL
> > > display")
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > 
> > This patch's authorship is weird: it says From: Calvin but doesn't
> > have
> > his SOB here - only yours.
> 
> I think this patch is adapted from one of my earlier submissions? I
> don't think I can really say that I wrote it, but I'll certainly review
> it.
> 
> > 
> > > ---
> > >  tools/power/x86/turbostat/turbostat.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/power/x86/turbostat/turbostat.c
> > > b/tools/power/x86/turbostat/turbostat.c
> > > index a211264b57fd..77557122b292 100644
> > > --- a/tools/power/x86/turbostat/turbostat.c
> > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > @@ -296,9 +296,9 @@ struct msr_sum_array {
> > >  /* The percpu MSR sum array.*/
> > >  struct msr_sum_array *per_cpu_msr_sum;
> > >  
> > > -int idx_to_offset(int idx)
> > > +off_t idx_to_offset(int idx)
> > 
> > And this is silly. MSRs are unsigned int. Fullstop.
> > 
> > So that function should either return u32 or unsigned int or so.
> 
> So, there's two problems with that:
>    1. This function needs to be able to return an error value that cannot be
>       confused with a valid MSR. This is currently done by returning a
>       negative number. If an unsigned value is used, a different way of
>       indicating errors needs to be written.
>    2. We are not using CPU instructions to access MSRs direction. Instead
>       they are being read from /dev/msr. So the "offset" value is actually a
>       seek into the /dev/msr file (using pread), and thus is of type off_t.
>
I see, I misunderstood it with kernel's rdmsr() and ... I'll use the original version.

thanks,
Chenyu
> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
> 
