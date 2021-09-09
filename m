Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFF4059B7
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhIIOyS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:54:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:59540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236798AbhIIOyQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 10:54:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220486530"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="220486530"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 07:53:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="450002774"
Received: from njani-mobl1.gar.corp.intel.com ([10.213.113.5])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 07:52:57 -0700
Message-ID: <9586d66802138dc144836b310ef5b20394c59695.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP
 forced by BIOS
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Thu, 09 Sep 2021 07:52:54 -0700
In-Reply-To: <CAAYoRsVX76Ey9FHhZXdwKWiMdmf0Oi6SKrP2J=XnNgB92sZW1A@mail.gmail.com>
References: <20210909034802.1708-1-dsmythies@telus.net>
         <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
         <CAAYoRsVX76Ey9FHhZXdwKWiMdmf0Oi6SKrP2J=XnNgB92sZW1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-09-09 at 06:30 -0700, Doug Smythies wrote:
> On Wed, Sep 8, 2021 at 11:33 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > If HWP has been already been enabled by BIOS, it may be
> > > necessary to override some kernel command line parameters.
> > > Once it has been enabled it requires a reset to be disabled.
> > > 
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index bb4549959b11..073bae5d4498 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > >                  */
> > >                 if ((!no_hwp &&
> > > boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > >                     intel_pstate_hwp_is_enabled()) {
> > > -                       hwp_active++;
> > > +                       hwp_active = 1;
> > Why this change?
> 
> It was just to keep it at 1, but I agree not absolutely needed.
> 
> > 
> > >                         hwp_mode_bdw = id->driver_data;
> > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > 
> > >  static int __init intel_pstate_setup(char *str)
> > >  {
> > > +       /*
> > > +        * If BIOS is forcing HWP, then parameter
> > > +        * overrides might be needed. Only print
> > > +        * the message once, and regardless of
> > > +        * any overrides.
> > > +        */
> > > +       if(!hwp_active
> > This part of code is from early_param, Is it possible that
> > hwp_active is not 0?
> 
> Not at this point, in any testing I did.
> But I do not know the authoritative answer
> to your question.
> 
But as you explained you want to prevent repeated print of
"HWP enabled by BIOS". So you need this.

> > 
> > > && boot_cpu_has(X86_FEATURE_HWP))
> > > +               if(intel_pstate_hwp_is_enabled()){
> > > +                       pr_info("HWP enabled by BIOS\n");
> > > +                       hwp_active = 1;
> > > +               }
> > >         if (!str)
> > >                 return -EINVAL;
> > > 
> > > -       if (!strcmp(str, "disable"))
> > > +       if (!strcmp(str, "disable") && !hwp_active)
> > >                 no_load = 1;
> > > -       else if (!strcmp(str, "active"))
> > > +       if (!strcmp(str, "active"))
> > >                 default_driver = &intel_pstate;
> > > -       else if (!strcmp(str, "passive"))
> > > +       if (!strcmp(str, "passive"))
> > >                 default_driver = &intel_cpufreq;
> > 
> > Why "else if" changed to "if" ?
> 
> Because it doesn't matter anyway and I would
> have had to figure out another qualifier.
> This way, and given that this executes once per
> intel_pstate command line parameter, the code
> executes the way it used to, overall.
If someone specified intel_pstate=active, it will also compare with
"passive" with this change.

Thanks,
Srinivas

> 
> > 
> > 
> > Thanks,
> > Srinivas
> > 
> > > -
> > > -       if (!strcmp(str, "no_hwp")) {
> > > +       if (!strcmp(str, "no_hwp") && !hwp_active) {
> > >                 pr_info("HWP disabled\n");
> > >                 no_hwp = 1;
> > >         }
> > 
> > 


