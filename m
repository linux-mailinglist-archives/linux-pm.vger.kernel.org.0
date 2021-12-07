Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690046B2D5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 07:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhLGG0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 01:26:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:5572 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhLGG0C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Dec 2021 01:26:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224376750"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224376750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 22:22:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="515141253"
Received: from yli76-mobl.ccr.corp.intel.com ([10.255.28.216])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 22:22:31 -0800
Message-ID: <12a4f14dcec84c9492138126c719a3547cfc1d2e.camel@intel.com>
Subject: Re: [PATCH 2/3] intel_idle: cleanup cpuhotplug setup
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date:   Tue, 07 Dec 2021 14:22:28 +0800
In-Reply-To: <CAJZ5v0hnPX13tFYjgT7PhY-MYjmYuipXPxCHoaLbPKREnhvX2A@mail.gmail.com>
References: <20211027082237.26759-1-rui.zhang@intel.com>
         <20211027082237.26759-2-rui.zhang@intel.com>
         <CAJZ5v0hnPX13tFYjgT7PhY-MYjmYuipXPxCHoaLbPKREnhvX2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-11-24 at 14:29 +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > Only limited number of CPUHP_AP_ONLINE_DYN callbacks can be
> > registered,
> > thus cpuhp_remove_state() should be invoked to release the resource
> > when
> > it is not used.
> > 
> > Fixes: fb1013a01673 ("intel_idle: Convert to hotplug state
> > machine")
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/idle/intel_idle.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index ae9d8c43e6a5..e7f2a5f85bf9 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1676,6 +1676,8 @@ static int intel_idle_cpu_online(unsigned int
> > cpu)
> >         return 0;
> >  }
> > 
> > +static enum cpuhp_state intel_idle_cpuhp_state;
> > +
> >  /**
> >   * intel_idle_cpuidle_unregister - unregister from cpuidle
> > framework
> >   */
> > @@ -1683,6 +1685,8 @@ static void __init
> > intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
> >  {
> >         int i;
> > 
> > +       if (intel_idle_cpuhp_state > 0)
> > +               cpuhp_remove_state(intel_idle_cpuhp_state);
> 
> It would be more straightforward to do that directly in
> intel_idle_init(), because intel_idle_cpuhp_state could be a local
> variable in that function then.

I rechecked the code.
in intel_idle_init(), cpuhp_setup_state() is the last step, so either
it succeeds and we never unload the driver, or it fails and the
intel_idle_init() fails directly.
So nothing needs to be fixed if we don't support intel_idle driver
module unload.

thanks,
rui
> 
> >         for_each_online_cpu(i)
> >                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cp
> > uidle_devices, i));
> >         cpuidle_unregister_driver(drv);
> > @@ -1710,11 +1714,11 @@ static int __init
> > intel_idle_cpuidle_register(struct cpuidle_driver *drv)
> >                 return retval;
> >         }
> > 
> > -       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > "idle/intel:online",
> > -                               intel_idle_cpu_online, NULL);
> > -       if (retval < 0) {
> > +       intel_idle_cpuhp_state =
> > cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +               "idle/intel:online", intel_idle_cpu_online, NULL);
> > +       if (intel_idle_cpuhp_state < 0) {
> >                 intel_idle_cpuidle_unregister(drv);
> > -               return retval;
> > +               return intel_idle_cpuhp_state;
> >         }
> >         return 0;
> >  }
> > --
> > 2.17.1
> > 

