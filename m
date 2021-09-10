Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4254065E6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 05:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhIJDPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJDPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 23:15:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0CCC061574
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 20:14:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m4so880886ljq.8
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK6B6siFp2R2BM6TUH8N5ysmF7Y0kDKTEjp3215w9rk=;
        b=DlEJ5nSm/ZhKscb+pNcv6KnbMvBSCCb9eTc4Ih068mteoJAspRHhD7KJWCKEilAfCG
         Hjr+NxxgsNvEYqgE307gAaqkrJL8FY5MDmwJYkU+IbeItk1zVP+5Y0BCNePpqKg1VcmU
         oS3vtS4mEcdOaBpW+9VMTJZF677zvY4fzi55PA9U/RvXgxpvTFXCG5aaM03fpXPMegP7
         ghveEmDQiwaNUbJVoidl1ecQiJmlXQbvUEz5L/jiCp0p5zL8Wo98NiImsodDKHjIGI9S
         a4oCkD75r1U5Id4KxIbLTmjv5OwpksKfOzkk2w6HsfnqjV2du/uhHyN0SaikcZAtXXwy
         klRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK6B6siFp2R2BM6TUH8N5ysmF7Y0kDKTEjp3215w9rk=;
        b=GbUEWqZ2r1lQG/1hffvp0n8ClDEKFLp2kLmBR+z/1w2Fga5UNdReN7WBOU7PyFj70e
         96cmYKU7l50HgPjwm+HZFm7Zr+wPSpO0nMGizcHEbf+wVSMJwcjKZx2kTMr6V7itn0qv
         8d1gni9B7SyNoaFIzrYZWSrlTAPafzkKfJBLm/khuq3ScFk8eKToVdIjEbgSmbURxyPb
         8tg0EWbAz/JOryXK+cAvBNFsgwSFiyyO5BsnGyA5MT4d17Afhrt1nrTolrn1P4WZpBaZ
         tBqQgiGxutemNxPPenPWOWoEmTkOEN+CsWun9BGoiPyXLi/NGHx3cbKyeQc6lE8j7Wjq
         pKVA==
X-Gm-Message-State: AOAM532+cSofabXJ7Wh/Bhg4F09ePXQBdZXPgluM/qS+MQQKJC69HgzZ
        dhBmAbGgqJVb96GKFaKH1nXHvUAcpuXvBNQZZiw0Xw==
X-Google-Smtp-Source: ABdhPJzsegz12iU3PL/5ChduSNONBpMkLy61dVlrLsIGtLttfkSy0+juinSUIkyfA2MoA87aJk+WZyosG8zQamT/UEA=
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr2382322ljq.472.1631243649088;
 Thu, 09 Sep 2021 20:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
 <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
 <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com> <CAJZ5v0j1JjLr0co06yJCCNV2p06e91Zh7tkMXoGTE=waB5Xo1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1JjLr0co06yJCCNV2p06e91Zh7tkMXoGTE=waB5Xo1Q@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 9 Sep 2021 20:14:01 -0700
Message-ID: <CAAYoRsUun0_tXTEGi6m1L0A9ffRWZ8FbLs1kFEZ0d0QQi+ssQw@mail.gmail.com>
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

On Thu, Sep 9, 2021 at 10:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Sep 9, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Sep 9, 2021 at 3:20 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > > > > If HWP has been already been enabled by BIOS, it may be
> > > > > > necessary to override some kernel command line parameters.
> > > > > > Once it has been enabled it requires a reset to be disabled.
> > > > > >
> > > > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > > > ---
> > > > > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > > > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > > index bb4549959b11..073bae5d4498 100644
> > > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > > > > >                  */
> > > > > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > > > >                     intel_pstate_hwp_is_enabled()) {
> > > > > > -                       hwp_active++;
> > > > > > +                       hwp_active = 1;
> > > > > Why this change?
> > > >
> > > > I think hwp_active can be changed to bool and then it would make sense
> > > > to update this line.
> > > >
> > > > > >                         hwp_mode_bdw = id->driver_data;
> > > > > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > > > > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > > > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > > > >
> > > > > >  static int __init intel_pstate_setup(char *str)
> > > > > >  {
> > > > > > +       /*
> > > > > > +        * If BIOS is forcing HWP, then parameter
> > > > > > +        * overrides might be needed. Only print
> > > > > > +        * the message once, and regardless of
> > > > > > +        * any overrides.
> > > > > > +        */
> > > > > > +       if(!hwp_active
> > > > > This part of code is from early_param, Is it possible that
> > > > > hwp_active is not 0?
> > > >
> > > > Well, it wouldn't matter even if it were nonzero.  This check is just
> > > > pointless anyway.
> > > >
> > > > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > > > +               if(intel_pstate_hwp_is_enabled()){
> > > >
> > > > This should be
> > > >
> > > > if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {
> > >
> > > Disagree.
> > > This routine gets executed once per intel_pstate related grub command
> > > line entry. The purpose of the "if(!hwp_active" part is to prevent the
> > > printing of the message to the logs multiple times.
> >
> > Ah OK.  Fair enough.
> >
> > You can do all of the checks in one conditional, though.  They will be
> > processed left-to-right anyway.
> >
> > But then it would be good to avoid calling
> > intel_pstate_hwp_is_enabled() multiple times if it returns false.
> >
> > And having said all that I'm not sure why you are trying to make
> > no_hwp depend on !hwp_active?  I will not be taken into account anyway
> > if intel_pstate_hwp_is_enabled() returns 'true'?
> >
> > So if no_hwp is covered regardless, you may move the
> > intel_pstate_hwp_is_enabled() inside the no_load conditional.
> >
> > Alternatively, and I would do that, intel_pstate_hwp_is_enabled()
> > could be evaluated earlier in intel_pstate_init() and if it returned
> > 'true', both no_load and no_hwp would be disregarded.
>
> Something like the attached, for the record.

O.K. and Thanks.
I was trying to avoid this line getting into the log:

[    0.000000] intel_pstate: HWP disabled

only to overridden later by, now, these lines:

[    0.373742] intel_pstate: HWP enabled by BIOS
[    0.374177] intel_pstate: Intel P-state driver initializing
[    0.375097] intel_pstate: HWP enabled

Let me see if I can go with your suggestion and get to
what I had hoped to get in the logs.

By the way, my current command line options are:

[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-5.14.0-ipstate9
root=UUID=0ac356c1-caa9-4c2e-8229-4408bd998dbd
ro ipv6.disable=1 consoleblank=314 intel_pstate=force
intel_pstate=active intel_pstate=no_hwp
msr.allow_writes=on cpuidle.governor=teo

... Doug
