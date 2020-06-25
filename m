Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6875209956
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 07:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgFYFOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 01:14:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:60997 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgFYFOe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 01:14:34 -0400
IronPort-SDR: 2HemDhHIziST6J5M3L/+sqJSIp+Mb8hna5oxCQRGMKX6CATTkfdz7opc+hYk+63tLEK4i6rkqc
 YOGQFOPCoaOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142990619"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="142990619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 22:14:33 -0700
IronPort-SDR: 4o09eHyp3wmNSZzI3NtwxSxBiCe3Vk3cL/R1SjaNUZ8Pl78eaIUbVeYzqmdgGAk2U/wDNMfqBR
 GFRdzGrgC8fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="479518432"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2020 22:14:31 -0700
Date:   Thu, 25 Jun 2020 13:15:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2][v3] PM / s2idle: Code cleanup to make s2idle
 consistent with normal idle path
Message-ID: <20200625051534.GA22907@chenyu-office.sh.intel.com>
References: <cover.1592892767.git.yu.c.chen@intel.com>
 <a00278cc5db9f4845006cff130fd91a58c0d92d1.1592892767.git.yu.c.chen@intel.com>
 <15473183.xuek0xzqYe@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15473183.xuek0xzqYe@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,
On Tue, Jun 23, 2020 at 07:57:59PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpuidle: Rearrange s2idle-specific idle state entry code
> 
> Implement call_cpuidle_s2idle() in analogy with call_cpuidle()
> for the s2idle-specific idle state entry and invoke it from
> cpuidle_idle_call() to make the s2idle-specific idle entry code
> path look more similar to the "regular" idle entry one.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |    6 +++---
>  kernel/sched/idle.c       |   15 +++++++++++----
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -96,6 +96,15 @@ void __cpuidle default_idle_call(void)
>  	}
>  }
>  
> +static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> +			       struct cpuidle_device *dev)
> +{
> +	if (current_clr_polling_and_test())
> +		return -EBUSY;
> +
> +	return cpuidle_enter_s2idle(drv, dev);
> +}
> +
>  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		      int next_state)
>  {
> @@ -171,11 +180,9 @@ static void cpuidle_idle_call(void)
>  		if (idle_should_enter_s2idle()) {
>  			rcu_idle_enter();
>  
> -			entered_state = cpuidle_enter_s2idle(drv, dev);
> -			if (entered_state > 0) {
> -				local_irq_enable();
> +			entered_state = call_cpuidle_s2idle(drv, dev);
I guess this changes the context a little bit that(comparing to [1/2 patch],
after this modification, when we found that TIF_NEED_RESCHED is set we can have
a second chance in the following call_cpuidle to do a second s2idle try. However
in [1/2 patch], it might exit the s2idle phase directly once when we see
TIF_NEED_RESCHED is set(because entered_state is postive we treat it as a successful
s2idle). In summary I think the change (patch [2/2]) is more robust.
Acked-by: Chen Yu <yu.c.chen@intel.com>

Thanks,
Chenyu
