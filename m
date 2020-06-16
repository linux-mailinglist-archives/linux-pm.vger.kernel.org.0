Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED76A1FA714
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFPDfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 23:35:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:52889 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPDfL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jun 2020 23:35:11 -0400
IronPort-SDR: qrSRGl4HxCHfMbhbthB2zx4G1tFIlwgrEeupE16Kr8Cdj9w6E3gWBNesAFWYHE/+25dkrUzpl+
 V/MvJoxZVfjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 20:35:11 -0700
IronPort-SDR: 4bJt/MCnL6bzAU78afso5FW3yO3Ka6xGQi7hHHorxubxslqyLyG0spDfIyZ39w6VKu2d+l8URQ
 c9YieamPPi2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="476275786"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2020 20:35:09 -0700
Date:   Tue, 16 Jun 2020 11:36:18 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
Message-ID: <20200616033618.GA20959@chenyu-office.sh.intel.com>
References: <20200615173611.15349-1-yu.c.chen@intel.com>
 <20200615184041.GG2531@hirez.programming.kicks-ass.net>
 <20200615193154.GJ2554@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615193154.GJ2554@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 09:31:54PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 08:40:41PM +0200, Peter Zijlstra wrote:
> 
> > > @@ -186,8 +187,10 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > >  	 * be frozen safely.
> > >  	 */
> > >  	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > > -	if (index > 0)
> > > +	if (index > 0) {
> > > +		__current_clr_polling();
> > >  		enter_s2idle_proper(drv, dev, index);
> > > +	}
> > >  
> > >  	return index;
> > >  }
> > 
> > So how is that commit 08e237fa56a1 not suffient? That makes
> > mwait_idle_with_hints() DTRT for this 'functionally challenged' piece of
> > hardware.
> > 
> > AFAICT intel_enter_s2idle() uses mwait_idle_with_hints().
> > 
> > What am I missing?
> 
> What's missing is that cpuidle_enter_s2idle() doesn't properly match
> call_cpuidle().
>
Right.
> Something like so then. Your version is racy, if someone already set
> TIF_NEED_RESCHED you just clear POLLING and go to sleep.
> 
Got it, I'll test the patch below.

Thanks,
Chenyu
> ---
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c149d9e20dfd..81bee8d03c6d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -133,8 +133,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -static void enter_s2idle_proper(struct cpuidle_driver *drv,
> -				struct cpuidle_device *dev, int index)
> +static void s2idle_enter(struct cpuidle_driver *drv,
> +			 struct cpuidle_device *dev, int index)
>  {
>  	ktime_t time_start, time_end;
>  
> @@ -168,6 +168,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
>  	dev->states_usage[index].s2idle_usage++;
>  }
>  
> +static int call_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +		       int index)
> +{
> +	if (!current_clr_polling_and_test())
> +		s2idle_enter(drv, dev, index);
> +
> +	return index;
> +}
> +
>  /**
>   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
>   * @drv: cpuidle driver for the given CPU.
> @@ -187,7 +196,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 */
>  	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
>  	if (index > 0)
> -		enter_s2idle_proper(drv, dev, index);
> +		call_s2idle(drv, dev, index);
>  
>  	return index;
>  }
