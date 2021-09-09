Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B32405A88
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhIIQNl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 12:13:41 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35736 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhIIQNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 12:13:38 -0400
Received: by mail-ot1-f54.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so3158447otf.2;
        Thu, 09 Sep 2021 09:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoZNtEwO18E+wllQ0SRyIrGKS1rcNDEPFO0Z95WK14Y=;
        b=WxG0ln3eE0AY5cjzonhjal6TtIoZ4ylochobThxF7JmclySumkw631eU5+HJ+L5fYD
         23YapcbkzHTsogPJvt+oemPZebZvXFcxuZ7oWUYHf0lokH8B1OXZTB1WjAzvmPJ7pPfl
         fTSAJ3MM4xH7/61V7K2JySwu1anuXbq0SwFBRgmnhbR4/IkoGyVvG2zxIGgi5B9VF1m0
         TyU7y2f6w1zdX71Cw4koqWiVGcnF1dt99cm51mVKbDekmm5/RiXYW0+psq1l2f7iG6uj
         ptgWlvFeGcO2eOvIdOsPqA05Zy446X10XeTTnMAMk8ROH1uP4kIEWdY+FK6uilHZFauq
         70ow==
X-Gm-Message-State: AOAM530BVAmx/NW3niSEUweGre59dFjwx7lKJsovP8seS8cLmLLDsj3B
        XeNYP1+Ldzr6OxphRUqSpzuyrwUSmFWgsjuivQo=
X-Google-Smtp-Source: ABdhPJzOFB42XBauWd2ZBpf63jL3d9OLRHTRGlthfEeFdcVqiwm6jRt5XRkPBClc7itLKanINQHlV7hb3RgKRFcABBU=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr520602oto.301.1631203948444;
 Thu, 09 Sep 2021 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com> <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
In-Reply-To: <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Sep 2021 18:12:17 +0200
Message-ID: <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 9, 2021 at 3:20 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > > If HWP has been already been enabled by BIOS, it may be
> > > > necessary to override some kernel command line parameters.
> > > > Once it has been enabled it requires a reset to be disabled.
> > > >
> > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > ---
> > > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c
> > > > index bb4549959b11..073bae5d4498 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > > >                  */
> > > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > >                     intel_pstate_hwp_is_enabled()) {
> > > > -                       hwp_active++;
> > > > +                       hwp_active = 1;
> > > Why this change?
> >
> > I think hwp_active can be changed to bool and then it would make sense
> > to update this line.
> >
> > > >                         hwp_mode_bdw = id->driver_data;
> > > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > >
> > > >  static int __init intel_pstate_setup(char *str)
> > > >  {
> > > > +       /*
> > > > +        * If BIOS is forcing HWP, then parameter
> > > > +        * overrides might be needed. Only print
> > > > +        * the message once, and regardless of
> > > > +        * any overrides.
> > > > +        */
> > > > +       if(!hwp_active
> > > This part of code is from early_param, Is it possible that
> > > hwp_active is not 0?
> >
> > Well, it wouldn't matter even if it were nonzero.  This check is just
> > pointless anyway.
> >
> > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > +               if(intel_pstate_hwp_is_enabled()){
> >
> > This should be
> >
> > if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {
>
> Disagree.
> This routine gets executed once per intel_pstate related grub command
> line entry. The purpose of the "if(!hwp_active" part is to prevent the
> printing of the message to the logs multiple times.

Ah OK.  Fair enough.

You can do all of the checks in one conditional, though.  They will be
processed left-to-right anyway.

But then it would be good to avoid calling
intel_pstate_hwp_is_enabled() multiple times if it returns false.

And having said all that I'm not sure why you are trying to make
no_hwp depend on !hwp_active?  I will not be taken into account anyway
if intel_pstate_hwp_is_enabled() returns 'true'?

So if no_hwp is covered regardless, you may move the
intel_pstate_hwp_is_enabled() inside the no_load conditional.

Alternatively, and I would do that, intel_pstate_hwp_is_enabled()
could be evaluated earlier in intel_pstate_init() and if it returned
'true', both no_load and no_hwp would be disregarded.
