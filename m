Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4145C47E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351858AbhKXNtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 08:49:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:35860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351607AbhKXNrv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 08:47:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222500121"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="222500121"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 05:43:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="497677345"
Received: from kaiwang3-mobl2.ccr.corp.intel.com ([10.249.172.130])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 05:43:07 -0800
Message-ID: <4d8621a923adf4268a2120f517f0897fd4df6b80.camel@intel.com>
Subject: Re: [PATCH 3/3] intel_idle: fix cpuidle_device unregistration
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date:   Wed, 24 Nov 2021 21:43:04 +0800
In-Reply-To: <CAJZ5v0juUmxM5gRa5WW=fXo18idRrKGpYmNTF=JFVf5hmscW2Q@mail.gmail.com>
References: <20211027082237.26759-1-rui.zhang@intel.com>
         <20211027082237.26759-3-rui.zhang@intel.com>
         <CAJZ5v0juUmxM5gRa5WW=fXo18idRrKGpYmNTF=JFVf5hmscW2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-11-24 at 14:20 +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > cpuidle_device is allocated as percpu data, and it is registered
> > for every
> > CPU that has ever been onlined.
> > When unregistering, checking current online CPUs is not sufficient,
> > because some cpu may be offlined later with its cpuidle_device
> > registered.
> 
> But the unregistration happens only in the error code path of
> intel_idle_init(), doesn't it?

yes.
> 
> While I agree that doing a for_each_present_cpu() walk for that is
> more prudent', I'm not sure if that makes any difference in practice.

And yes, exactly.
This is not a problem as long as intel_idle driver can not be unloaded.

There is no technical gap either to unregister the intel_idle cpuidle
driver, or to unload the intel_idle module. And this potential issue
will be exposed only when we decided to do so.

If you prefer to describe this *potential* issue more precisely, I
totally agree.
If you want to fix it only when really needed, that's also okay to me.

> 
> > Fix this by using for_each_present_cpu() instead, and unregistering
> > all
> > the cpuidle_devices that have been registered.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/idle/intel_idle.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index e7f2a5f85bf9..9e916e2adc89 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1687,8 +1687,13 @@ static void __init
> > intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
> > 
> >         if (intel_idle_cpuhp_state > 0)
> >                 cpuhp_remove_state(intel_idle_cpuhp_state);
> > -       for_each_online_cpu(i)
> > -               cpuidle_unregister_device(per_cpu_ptr(intel_idle_cp
> > uidle_devices, i));
> > +       for_each_present_cpu(i) {
> > +               struct cpuidle_device *dev;
> > +
> > +               dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
> > +               if (dev->registered)
> 
> dev->registered is checked by cpuidle_unregister_device().

right, this check is not needed.

thanks,
rui
> 
> > +                       cpuidle_unregister_device(dev);
> > +       }
> >         cpuidle_unregister_driver(drv);
> >         free_percpu(intel_idle_cpuidle_devices);
> >  }
> > --

