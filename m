Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC451F7B11
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLPp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 11:45:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:10047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFLPp6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Jun 2020 11:45:58 -0400
IronPort-SDR: 6NESIibgOnlhwWwplCLGumUQh+2R/zILy2HJ99Ouu7AUtWZw7h+P2GnlXifW2wpl7v0EDId3rH
 YLZz0L4N4yhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 08:45:57 -0700
IronPort-SDR: vEpkrF0S0lkXZ+9C/LiR7LbQmJWHluZyADAKAuHQdlxvLZxNKfEHDS0Ua5ZGj+VLc8K4FR5v1i
 4X04R3ix94nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="380731890"
Received: from amritada-mobl.amr.corp.intel.com (HELO spandruv-mobl3.amr.corp.intel.com) ([10.254.106.203])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2020 08:45:55 -0700
Message-ID: <89e856e6c76b460c1515b70677e44bc50033bc17.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add additional OOB enabling bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>, lenb@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jun 2020 08:45:54 -0700
In-Reply-To: <000301d640c3$4e6d61c0$eb482540$@net>
References: <20200611174838.2822533-1-srinivas.pandruvada@linux.intel.com>
         <000301d640c3$4e6d61c0$eb482540$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-06-12 at 07:11 -0700, Doug Smythies wrote:
> On 2020.06.11 10:49 Srinivas Pandruvada wrote:
> 
> > Add additional bit for OOB (Out of band) enabling of P-states. In
> > this
> > case intel_pstate shouldn't load. Currently, only "BIT(8) == 1" of
> > the
> > MSR MSR_MISC_PWR_MGMT is considered as OOB. Also add "BIT(18) == 1"
> > as
> > OOB condition.
> 
> Shouldn't those bits be defined in these files:
> arch/x86/include/asm/msr-index.h
> and
> tools/arch/x86/include/asm/msr-index.h
> 
> ?
The rule from arch-x86 maintainers requires use in more than one place
to go there.

> 
> By the way, I couldn't find those bits defined in Intel docs that I
> have.
Usually, they end up in data sheets.

>  
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 8e23a698ce04..f21761443c90 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2686,8 +2686,8 @@ static bool __init
> > intel_pstate_platform_pwr_mgmt_exists(void)
> >  	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
> >  	if (id) {
> >  		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
> > -		if (misc_pwr & (1 << 8)) {
> > -			pr_debug("Bit 8 in the MISC_PWR_MGMT MSR
> > set\n");
> > +		if ((misc_pwr & BIT(8)) || (misc_pwr & BIT(18))) {
> 
> And then those bit definitions used above.
I didn't understand the comment.

> 
> > +			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR
> > set\n");
> 
> And then some insight also printed  with the debug message.
> At least say "Out of Band".
We can.

Thanks,
Srinivas

> 
> >  			return true;
> >  		}
> >  	}
> > --
> > 2.24.1
> 
> 

