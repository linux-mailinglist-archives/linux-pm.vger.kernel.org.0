Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D85406645
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 06:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhIJENG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhIJENG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Sep 2021 00:13:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B3C061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 21:11:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h16so1328786lfk.10
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 21:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxuUJjYQzcMig7TJzqeQbDiwDXMeQY4AlFQzmAL8BFo=;
        b=caV35vZBF/+tv+N/twTyQQIepPYKrU77+eUwAhhJt3yzpY3fZR+jg6Vj0KzNx1wMlG
         khJyigYpp6RzraAOG24s+SRBLCuqBhIjY7ndBQ5GL05US8rXNihBIvuEIX2pK4RieWjG
         6Oma/I6gIdr/zl/fcrcU85RJXRGJOekaW7423Xyfi+lyYoqWbNJSnZowbQOW0g/PO8dB
         Ip9MKNP9KqFk9e0puoqir2yz4xIKFi6wxSX5IOc1PAdQaFaBE1S6Ud9QaNAmx1MgV/pn
         OQeQiz/Ap2LiVmj6CAUlJuKzapQNJWxX0fvvO5nkN2r9//rFyQLpLHsbCSRiVgSPwI4L
         uCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxuUJjYQzcMig7TJzqeQbDiwDXMeQY4AlFQzmAL8BFo=;
        b=IfnDmJJBsHo1T+A5oBAkGeLnNUK8/C/aWhTrtd/VoDQK4iHJNltPlE5X8+HPP+tqyA
         9EwarGrOrGQmK7RhKmDhCngLcnRW5uRMT8hprb30Ec5MTraYBvsnlo+TKJlp0kT3vPZC
         qQGGeUktWThTfmyiDZ+BB7aRxZMZsrtQIw/DuMZx6KlIDyHosJmct0MqHeVQQBmVIJxh
         ptbUP7pf+SDQtKFCIXohReBFDCyz0CaHS9JyRUa1MxRAA4b7W5xk6G0gGlM7oDx2OV+5
         Ps3zZWl6lxtDYDEmYrHaOJo7s8OA7EVXy/UApEJfnMuSKYJT5n9kw5Gh7GTEICCsBog0
         9Beg==
X-Gm-Message-State: AOAM531JgX0CC9k9UB3FS07keJpXZoYWD4fe4y0wOPXruwzded07zB+d
        +WJ3+tRkj2xZgvtwIGIqeOIhquLTZaHyR2ojE55p9Q==
X-Google-Smtp-Source: ABdhPJzczePxiiiUKaYgpWec1VQ/FQlfTM5oaUvNp5X1nEy/SYSL5rijb8rTiNIik6aTvN83Y9O38gJxtOgp4JBOqSU=
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr2316218lfe.157.1631247113923;
 Thu, 09 Sep 2021 21:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAAYoRsVX76Ey9FHhZXdwKWiMdmf0Oi6SKrP2J=XnNgB92sZW1A@mail.gmail.com> <9586d66802138dc144836b310ef5b20394c59695.camel@linux.intel.com>
In-Reply-To: <9586d66802138dc144836b310ef5b20394c59695.camel@linux.intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 9 Sep 2021 21:11:46 -0700
Message-ID: <CAAYoRsUHQoFH4rb2cu5ZgMc8=e7WWZt8qQwZ6eFAtVSD1kghoA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 9, 2021 at 7:53 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:

> On Thu, 2021-09-09 at 06:30 -0700, Doug Smythies wrote:
> > On Wed, Sep 8, 2021 at 11:33 PM Srinivas Pandruvada
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
> > > >                 if ((!no_hwp &&
> > > > boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > >                     intel_pstate_hwp_is_enabled()) {
> > > > -                       hwp_active++;
> > > > +                       hwp_active = 1;
> > > Why this change?
> >
> > It was just to keep it at 1, but I agree not absolutely needed.
> >
> > >
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
> > Not at this point, in any testing I did.
> > But I do not know the authoritative answer
> > to your question.
> >
> But as you explained you want to prevent repeated print of
> "HWP enabled by BIOS". So you need this.
>
> > >
> > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > +               if(intel_pstate_hwp_is_enabled()){
> > > > +                       pr_info("HWP enabled by BIOS\n");
> > > > +                       hwp_active = 1;
> > > > +               }
> > > >         if (!str)
> > > >                 return -EINVAL;
> > > >
> > > > -       if (!strcmp(str, "disable"))
> > > > +       if (!strcmp(str, "disable") && !hwp_active)
> > > >                 no_load = 1;
> > > > -       else if (!strcmp(str, "active"))
> > > > +       if (!strcmp(str, "active"))
> > > >                 default_driver = &intel_pstate;
> > > > -       else if (!strcmp(str, "passive"))
> > > > +       if (!strcmp(str, "passive"))
> > > >                 default_driver = &intel_cpufreq;
> > >
> > > Why "else if" changed to "if" ?
> >
> > Because it doesn't matter anyway and I would
> > have had to figure out another qualifier.
> > This way, and given that this executes once per
> > intel_pstate command line parameter, the code
> > executes the way it used to, overall.
> If someone specified intel_pstate=active, it will also compare with
> "passive" with this change.

Disagree.
As far as I can tell, and I tested, it works as expected.

... Doug

> > > > -
> > > > -       if (!strcmp(str, "no_hwp")) {
> > > > +       if (!strcmp(str, "no_hwp") && !hwp_active) {
> > > >                 pr_info("HWP disabled\n");
> > > >                 no_hwp = 1;
> > > >         }
> > >
> > >
>
>
