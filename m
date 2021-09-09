Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300340590C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhIIOa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhIIOaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:30:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81AC14114A
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 06:20:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h16so3662526lfk.10
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhLDAgLz2Ns2LxKgq91jjelAjLVn8rnv2rxAxrObxNY=;
        b=EZbNiLk6QT/lInWHMhAJpHF8jEuu6FDWlWjLNo6BfRNMmpqmEXsxuIN1DP2BhdlKmv
         EGiIRpPenm/DvgX81YBa2XN++Eg4ivMCQROUQyjjZOCtcBv2VeLzqLvhmuafdih1TC5y
         oT3TUc0wDuguRPVzrNnFpe7IxWU2Xgo+nGfEW9n1Z1+Gi0FuhQM9PA1g72qFzMSOaqKV
         LT5Ro2nuSiQoNS1HUdj6HS34s/MVbunJuETqYH7gyiD9hEd4L1FHyNgECc4qQPPDe0N2
         3dV1GRVB1n+4wDSgKvX3bdsmU3Wpeh2P8RiGZg88ZBvT8E/sigHgOpoNd1VFQvs4gtzr
         tSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhLDAgLz2Ns2LxKgq91jjelAjLVn8rnv2rxAxrObxNY=;
        b=xbuc+nt+F9mzRmQ+/K+SeuHrtAFlo3Us+RqOKPOmrBTBj1Y+Wtbq+CMWRRbzjmIZKl
         GX+thF56AnIt7rOwh10AkPHFx9jte50ERPzC3pG5iR50TCYwJZ2xzjRYnL8byHGO8N+d
         tjd8fNQ7GibE5rJeVKqJvpcrD/2/EP4XX4kajGo/nwl/gUL2L7ddNiUC1YTbqDoYjyla
         v5OHr0KKTVUwqfI4wisfkxaZisthK3WL+jtLvHUWiNRtQeA/nRC9+UR5OD6ymswfHL3P
         PuxfgsfAUcMRYI3HV6X+kdGtZt1VYCDjPCOs3NGEhTqCLbpp2TfEF4HlgR9ULJPIO7Nn
         YR7g==
X-Gm-Message-State: AOAM532Vwtr3M0NAObQWRMOxYcf5eeGKKc8UqC/4KMyA7rapOWzcXPTq
        BBAcH28kjly703jIVF14PikoCRZ4TDX//bcxnGWRBQ==
X-Google-Smtp-Source: ABdhPJzFMwW0LknShTWoOxG0dXjECyZ6gv0trd1ZifraCHGqs4Km5GClKkXYMJAM/YVYM2IowgbxvebsqinCnJploVU=
X-Received: by 2002:a05:6512:3a86:: with SMTP id q6mr2334594lfu.4.1631193655837;
 Thu, 09 Sep 2021 06:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 9 Sep 2021 06:20:45 -0700
Message-ID: <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > If HWP has been already been enabled by BIOS, it may be
> > > necessary to override some kernel command line parameters.
> > > Once it has been enabled it requires a reset to be disabled.
> > >
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index bb4549959b11..073bae5d4498 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > >                  */
> > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > >                     intel_pstate_hwp_is_enabled()) {
> > > -                       hwp_active++;
> > > +                       hwp_active = 1;
> > Why this change?
>
> I think hwp_active can be changed to bool and then it would make sense
> to update this line.
>
> > >                         hwp_mode_bdw = id->driver_data;
> > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > >
> > >  static int __init intel_pstate_setup(char *str)
> > >  {
> > > +       /*
> > > +        * If BIOS is forcing HWP, then parameter
> > > +        * overrides might be needed. Only print
> > > +        * the message once, and regardless of
> > > +        * any overrides.
> > > +        */
> > > +       if(!hwp_active
> > This part of code is from early_param, Is it possible that
> > hwp_active is not 0?
>
> Well, it wouldn't matter even if it were nonzero.  This check is just
> pointless anyway.
>
> > > && boot_cpu_has(X86_FEATURE_HWP))
> > > +               if(intel_pstate_hwp_is_enabled()){
>
> This should be
>
> if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {

Disagree.
This routine gets executed once per intel_pstate related grub command
line entry. The purpose of the "if(!hwp_active" part is to prevent the
printing of the message to the logs multiple times.

>
> > > +                       pr_info("HWP enabled by BIOS\n");
> > > +                       hwp_active = 1;
> > > +               }
> > >         if (!str)
> > >                 return -EINVAL;
> > >
> > > -       if (!strcmp(str, "disable"))
> > > +       if (!strcmp(str, "disable") && !hwp_active)
> > >                 no_load = 1;
> > > -       else if (!strcmp(str, "active"))
> > > +       if (!strcmp(str, "active"))
> > >                 default_driver = &intel_pstate;
> > > -       else if (!strcmp(str, "passive"))
> > > +       if (!strcmp(str, "passive"))
> > >                 default_driver = &intel_cpufreq;
> >
> > Why "else if" changed to "if" ?
> >
> > > -
> > > -       if (!strcmp(str, "no_hwp")) {
> > > +       if (!strcmp(str, "no_hwp") && !hwp_active) {
> > >                 pr_info("HWP disabled\n");
> > >                 no_hwp = 1;
> > >         }
> >
