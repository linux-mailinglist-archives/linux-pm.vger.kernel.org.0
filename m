Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E22365B3D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhDTOem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 10:34:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:23488 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232726AbhDTOem (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 10:34:42 -0400
IronPort-SDR: u/xTcM59UOxfwD9sNITotDI+HDMaJ7HJDee/RIRkBcqejatidNblW5eZyPTP/Yf7K7i/9k/iIs
 NCD104AnuHig==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256828751"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="256828751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:34:07 -0700
IronPort-SDR: K1o0zalZ4cUXSadw15kHqkPsEOweDsAyOLNmONKLvsyQGW4QshShaIiSN1A62YxMGRSPIDDg42
 +Prwi9xynI+Q==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="420457564"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:34:03 -0700
Date:   Tue, 20 Apr 2021 22:37:54 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Borislav Petkov <bp@suse.de>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210420143754.GA390118@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 09:28:06AM -0400, Calvin Walton wrote:
> On Tue, 2021-04-20 at 21:15 +0800, Chen Yu wrote:
> > 
> > Okay. I would vote for the the patch from Bas as it was a combined
> > work from two
> > authors and tested by several AMD users. But let me paste it here too
> > for Artem to
> > see if this also works for him:
> > 
> > 
> > From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00
> > 2001
> > From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Date: Fri, 12 Mar 2021 21:27:40 +0800
> > Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen
> > CPUs
> > 
> > 
> > @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
> >  
> >         switch (idx) {
> >         case IDX_PKG_ENERGY:
> > -               offset = MSR_PKG_ENERGY_STATUS;
> > +               if (do_rapl & RAPL_AMD_F17H)
> > +                       offset = MSR_PKG_ENERGY_STAT;
> > +               else
> > +                       offset = MSR_PKG_ENERGY_STATUS;
> >                 break;
> >         case IDX_DRAM_ENERGY:
> >                 offset = MSR_DRAM_ENERGY_STATUS;
> 
> This patch has the same issue I noticed with the initial revision of
> Terry's patch - the idx_to_offset function returns type int (32-bit
> signed), but MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather,
> would be interpreted as a negative number)
> 
> The end result is, as far as I can tell, that it hits the if (offset <
> 0) check in update_msr_sum() resulting in the timer callback for
> updating the stat in the background when long durations are used to not
> happen.
> 
> For short durations it still works fine since the background update
> isn't used.
> 
Ah, got it, nice catch. How about an incremental patch based on Bas' one
to fix this 'overflow' issue? Would converting offset_to_idx(), idx_to_offset() and
update_msr_sum() to use off_t instead of int be enough? Do you or Terry have interest
to cook that patch? For Terry's version, I'm not sure if spliting
the code into different CPU vendor would benefit in the future, except
that we would have plenty of new MSRs to be introduced in the future.

thanks,
Chenyu
> 
> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
> 
