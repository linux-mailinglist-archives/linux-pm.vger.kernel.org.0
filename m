Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5248C404924
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhIILU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 07:20:27 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43671 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhIILT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 07:19:56 -0400
Received: by mail-ot1-f44.google.com with SMTP id x10-20020a056830408a00b004f26cead745so1982469ott.10;
        Thu, 09 Sep 2021 04:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB4OAq1FA2ibjg5GPYhy0r8vL3pcy4KSo6N7CuRv9t0=;
        b=rPT8Ht9djkYZO7tpf/XG4G6u4N0u3x69s3X31gq8kSp0Jezqv0AmxopmRUbJW3dg2T
         ZQgQNnonZ7XRVeMWkDwUMGAOlmJv/NFG9O69NNOl3ytyku0xpfwM6Zfws65a/N8a4sCG
         hQa2j5f7vG0eqLZilBBq4Z3zOxU58YflXG8zZf0hhgE83E3y/936SOyZKzX2zC0UySYX
         KSWtZ03TvtiPd+9ZYkuzWVeviGUK4mk1IVUQTNkGqonm9NIcRTTpffIIigxFEy3//zEs
         Ijzi1kwdGmIkhvoJKgqt4JJ2Jw0F2mikE5RiJ8IpmqPzDi2tyNnp9WcvWFGW0xknbRto
         KDPw==
X-Gm-Message-State: AOAM530T6vh6//zPqJK2fXjlc8muUdstfF/1zXwuKetnrm0it+hPLWMc
        zeCfZALhfM3BifPOnPtPR1+KM9fm1XjfL+IjYtM=
X-Google-Smtp-Source: ABdhPJz9VuZXyIc9RMeckXxDqTc7BW4njRZot0Sok+1ydJryCzKVqARZ0F5XmXgWRueJFJliuGfdqVBpgcb9plJweBg=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr2006848ote.319.1631186326826;
 Thu, 09 Sep 2021 04:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
In-Reply-To: <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Sep 2021 13:18:35 +0200
Message-ID: <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <doug.smythies@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > If HWP has been already been enabled by BIOS, it may be
> > necessary to override some kernel command line parameters.
> > Once it has been enabled it requires a reset to be disabled.
> >
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index bb4549959b11..073bae5d4498 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> >                  */
> >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> >                     intel_pstate_hwp_is_enabled()) {
> > -                       hwp_active++;
> > +                       hwp_active = 1;
> Why this change?

I think hwp_active can be changed to bool and then it would make sense
to update this line.

> >                         hwp_mode_bdw = id->driver_data;
> >                         intel_pstate.attr = hwp_cpufreq_attrs;
> >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> >
> >  static int __init intel_pstate_setup(char *str)
> >  {
> > +       /*
> > +        * If BIOS is forcing HWP, then parameter
> > +        * overrides might be needed. Only print
> > +        * the message once, and regardless of
> > +        * any overrides.
> > +        */
> > +       if(!hwp_active
> This part of code is from early_param, Is it possible that
> hwp_active is not 0?

Well, it wouldn't matter even if it were nonzero.  This check is just
pointless anyway.

> > && boot_cpu_has(X86_FEATURE_HWP))
> > +               if(intel_pstate_hwp_is_enabled()){

This should be

if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {

> > +                       pr_info("HWP enabled by BIOS\n");
> > +                       hwp_active = 1;
> > +               }
> >         if (!str)
> >                 return -EINVAL;
> >
> > -       if (!strcmp(str, "disable"))
> > +       if (!strcmp(str, "disable") && !hwp_active)
> >                 no_load = 1;
> > -       else if (!strcmp(str, "active"))
> > +       if (!strcmp(str, "active"))
> >                 default_driver = &intel_pstate;
> > -       else if (!strcmp(str, "passive"))
> > +       if (!strcmp(str, "passive"))
> >                 default_driver = &intel_cpufreq;
>
> Why "else if" changed to "if" ?
>
> > -
> > -       if (!strcmp(str, "no_hwp")) {
> > +       if (!strcmp(str, "no_hwp") && !hwp_active) {
> >                 pr_info("HWP disabled\n");
> >                 no_hwp = 1;
> >         }
>
