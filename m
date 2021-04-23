Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05F53691DF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhDWMUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:20:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242273AbhDWMUP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 08:20:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E62BB124;
        Fri, 23 Apr 2021 12:19:38 +0000 (UTC)
Date:   Fri, 23 Apr 2021 14:19:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>,
        Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.huang2@amd.com, aros@gmx.com, rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210423121934.GC24710@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423121607.GA426003@chenyu-desktop>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 08:16:07PM +0800, Chen Yu wrote:
> From b2e63fe4f02e17289414b4f61237da822df115fb Mon Sep 17 00:00:00 2001
> From: Calvin Walton <calvin.walton@kepstin.ca>
> Date: Fri, 23 Apr 2021 17:32:13 +0800
> Subject: [PATCH 3/5] tools/power turbostat: Fix offset overflow issue in index
>  converting
> 
> The idx_to_offset() function returns type int (32-bit signed), but
> MSR_PKG_ENERGY_STAT is greater than INT_MAX (or rather, would be
> interpreted as a negative number). The end result is that it hits
> the if (offset < 0) check in update_msr_sum() resulting in the timer
> callback for updating the stat in the background when long durations
> are used to not happen. The similar issue exists in offset_to_idx()
> and update_msr_sum().
> 
> This patch fixes this issue by converting the 'int' type to 'off_t'
> accordingly.
> 
> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

This patch's authorship is weird: it says From: Calvin but doesn't have
his SOB here - only yours.

> ---
>  tools/power/x86/turbostat/turbostat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index a211264b57fd..77557122b292 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -296,9 +296,9 @@ struct msr_sum_array {
>  /* The percpu MSR sum array.*/
>  struct msr_sum_array *per_cpu_msr_sum;
>  
> -int idx_to_offset(int idx)
> +off_t idx_to_offset(int idx)

And this is silly. MSRs are unsigned int. Fullstop.

So that function should either return u32 or unsigned int or so.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
