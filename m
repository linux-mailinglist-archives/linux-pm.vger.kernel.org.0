Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65876406E41
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhIJPgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 11:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbhIJPgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Sep 2021 11:36:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91AC061574
        for <linux-pm@vger.kernel.org>; Fri, 10 Sep 2021 08:35:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id l10so4847505lfg.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Sep 2021 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnvzNi+rxgycVJiXwuyBHq+TROY+i/0lp8Qo1/L/oj4=;
        b=f7vwDM02YJYqezAPda9pI/Ba+C+u+2E6w2Q8tGtD4Sg16wjEf9XSYgkk+VjBIcoo90
         Pro4xK3pQH+UlvBJFlnPqiOBHem4pxqUbmPwNyhuABqiv8voFNG2ozAU+tQJpHV/QCPB
         3dneg5DsbRjeSKuGXdmw5uVT3aCO6GD3GHP8y5aFghHoReTAYMcwRk0awxfYVvGaYjcC
         XyjOkZJrBRJ6ChWG7iZFDxDEXvxlPb4TzFFLrgO9Ejpr6iEzXY1GnuO4H97hc+J0aOKA
         5R5G8gwAs/6cbuGcqHX/0DVag+43oqy+uI/4IS+HxY7pRI8Z4nF6aLkK/EFGiTBNQt+V
         BSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnvzNi+rxgycVJiXwuyBHq+TROY+i/0lp8Qo1/L/oj4=;
        b=l9Ilf/Dc1A+h2RyyRTbUOq/TPD81PoB5Jcgb8TWG9pKrpEKi2comNV722RjwBQvN/2
         GUW1hMqvj9BnehS4qF/bVqWfiR2lAUbHaF7NjrwRxmPe/B2/wAs2XCOVFM8+kR+gZpJK
         pMCbS/8hR9Dz4l/lKbyJCEz/QkIr2oDW5JH+BTUvBb3ron5xKvfHMh+yU/rqx21JG58S
         k9kjmEAno8wkpwbihSmB2nliFV4TsvgIRQNJC37UHm0MqeQj7/0XEnV0pVMAham6J78b
         71tqEL3E8or0dhnTuuW7uh7in4+UktIWOe1hi1RfUbErLawNVoVxfCzJen72mDauZG9A
         db1A==
X-Gm-Message-State: AOAM531guegr4EtjBmpBg5xL6aOve7p3EOk3KNAw2cNxzMtzmER/JAPP
        d6c+R6XibBaOz9lg/hYdhBxVQ6uieQpqQ7jrwJjXSQ==
X-Google-Smtp-Source: ABdhPJw0lOG+xuw1e6VT3qS6a8EP7AGldsfwe4OsgG6rKePYoIbKObw5NUyA8SvX//Md5AYH168JvHVEWkYNIWh3tW8=
X-Received: by 2002:a05:6512:4003:: with SMTP id br3mr4352150lfb.465.1631288110669;
 Fri, 10 Sep 2021 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
 <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
 <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com>
 <CAJZ5v0j1JjLr0co06yJCCNV2p06e91Zh7tkMXoGTE=waB5Xo1Q@mail.gmail.com>
 <CAAYoRsUun0_tXTEGi6m1L0A9ffRWZ8FbLs1kFEZ0d0QQi+ssQw@mail.gmail.com> <CAJZ5v0jMDbxXt_EWN-GUOGBDCpDGHUoqRoTtfR8-rUOQjDBUyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jMDbxXt_EWN-GUOGBDCpDGHUoqRoTtfR8-rUOQjDBUyw@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 10 Sep 2021 08:34:59 -0700
Message-ID: <CAAYoRsVOh+TxZK8BWfM=u6YqEhSY-Pgpt+aavZGBLogVTEocKw@mail.gmail.com>
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

On Fri, Sep 10, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Sep 10, 2021 at 5:14 AM Doug Smythies <dsmythies@telus.net> wrote:
> > On Thu, Sep 9, 2021 at 10:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Sep 9, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Thu, Sep 9, 2021 at 3:20 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > > On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> > > > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > > > > > > If HWP has been already been enabled by BIOS, it may be
> > > > > > > > necessary to override some kernel command line parameters.
> > > > > > > > Once it has been enabled it requires a reset to be disabled.
> > > > > > > >
> > > > > > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > > > > > ---
> > > > > > > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > > > > > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > > > > index bb4549959b11..073bae5d4498 100644
> > > > > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > > > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > > > > > > >                  */
> > > > > > > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > > > > > >                     intel_pstate_hwp_is_enabled()) {
> > > > > > > > -                       hwp_active++;
> > > > > > > > +                       hwp_active = 1;
> > > > > > > Why this change?
> > > > > >
> > > > > > I think hwp_active can be changed to bool and then it would make sense
> > > > > > to update this line.
> > > > > >
> > > > > > > >                         hwp_mode_bdw = id->driver_data;
> > > > > > > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > > > > > > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > > > > > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > > > > > >
> > > > > > > >  static int __init intel_pstate_setup(char *str)
> > > > > > > >  {
> > > > > > > > +       /*
> > > > > > > > +        * If BIOS is forcing HWP, then parameter
> > > > > > > > +        * overrides might be needed. Only print
> > > > > > > > +        * the message once, and regardless of
> > > > > > > > +        * any overrides.
> > > > > > > > +        */
> > > > > > > > +       if(!hwp_active
> > > > > > > This part of code is from early_param, Is it possible that
> > > > > > > hwp_active is not 0?
> > > > > >
> > > > > > Well, it wouldn't matter even if it were nonzero.  This check is just
> > > > > > pointless anyway.
> > > > > >
> > > > > > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > > > > > +               if(intel_pstate_hwp_is_enabled()){
> > > > > >
> > > > > > This should be
> > > > > >
> > > > > > if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {
> > > > >
> > > > > Disagree.
> > > > > This routine gets executed once per intel_pstate related grub command
> > > > > line entry. The purpose of the "if(!hwp_active" part is to prevent the
> > > > > printing of the message to the logs multiple times.
> > > >
> > > > Ah OK.  Fair enough.
> > > >
> > > > You can do all of the checks in one conditional, though.  They will be
> > > > processed left-to-right anyway.
> > > >
> > > > But then it would be good to avoid calling
> > > > intel_pstate_hwp_is_enabled() multiple times if it returns false.
> > > >
> > > > And having said all that I'm not sure why you are trying to make
> > > > no_hwp depend on !hwp_active?  I will not be taken into account anyway
> > > > if intel_pstate_hwp_is_enabled() returns 'true'?
> > > >
> > > > So if no_hwp is covered regardless, you may move the
> > > > intel_pstate_hwp_is_enabled() inside the no_load conditional.
> > > >
> > > > Alternatively, and I would do that, intel_pstate_hwp_is_enabled()
> > > > could be evaluated earlier in intel_pstate_init() and if it returned
> > > > 'true', both no_load and no_hwp would be disregarded.
> > >
> > > Something like the attached, for the record.
> >
> > O.K. and Thanks.
> > I was trying to avoid this line getting into the log:
> >
> > [    0.000000] intel_pstate: HWP disabled
> >
> > only to overridden later by, now, these lines:
> >
> > [    0.373742] intel_pstate: HWP enabled by BIOS
> > [    0.374177] intel_pstate: Intel P-state driver initializing
> > [    0.375097] intel_pstate: HWP enabled
> >
> > Let me see if I can go with your suggestion and get to
> > what I had hoped to get in the logs.
>
> It would be sufficient to put the "disabled" printk() after the
> "no_hwp" if () statement in intel_pstate_init().  See attached.

Agreed, thanks. Yes, I was thinking similar.

> BTW, I've changed the message to "HWP not enabled", because that's
> what really happens to be precise.

Agreed. Good idea.

Give me a fews days to create and test a formal patch.
I currently have limited access to a computer that doesn't force
HWP via BIOS.

... Doug
