Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE1222212
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPMAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:00:25 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38943 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgGPMAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:00:25 -0400
Received: by mail-oo1-f68.google.com with SMTP id c4so1115185oou.6
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 05:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxcK9AG4MsjEnVWUbvo4102pCNg4f3SNGrtezPCAgvo=;
        b=Y+I6gEr2mIrPMtS1qYz3s28HZKrVbTvUU2n3pRamrLoj6025XZqEQV4yi4lueVQoF+
         Vo4tkmfUFzo7ijHtvmuxMmfdiegmiB9J6tCf4BMxAzM2WmdDduhfEb59QaopBD1aicmi
         tmzRfg01Ozi3ZR7tuvlZB0/OaD5fTFQp7QokYr/JMyqb7njbP3t8lyKfY+lLyn5Ipe3d
         utCq/Qz8ckRSnRDGXvcYFpez+XXzjO8TUHjBivUkIGgFu2IINDm1oDOHcP9kiCksOdaX
         5U1kWy7Nf3APMHWfpRihtouM5m6VCQ7iEru5+rXqfrnjhOxwzTjUVDFgdawlBtz+x5Qa
         pXiA==
X-Gm-Message-State: AOAM533sUX7DbWEpWmSzRzb5blLwpVbMpsC1nDM6tan0oSPKUew4aNUJ
        mE/zDDpejVk41I0WAmXkQZpCHhV8OThqjQ512O0=
X-Google-Smtp-Source: ABdhPJyZFIWOCU1ylUoMi+GXaqiLLWvkhVwn/fDV8ts+woTdI2lZgfGQ/1pdVwiSqtfVon+tnkfIJGzg3yCz8s+ctTE=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr3782670oov.75.1594900824317;
 Thu, 16 Jul 2020 05:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <000701d656be$c48083e0$4d818ba0$@net> <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com>
 <001d01d65af9$6dd46180$497d2480$@net>
In-Reply-To: <001d01d65af9$6dd46180$497d2480$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jul 2020 14:00:10 +0200
Message-ID: <CAJZ5v0gvqhfHDDzVHNP4ODMfujaWA8Y8OuLF_i4JoM_1jVh=2w@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: EPB with performance governor
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Thu, Jul 16, 2020 at 12:44 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Thank you for your reply.
>
> On 2020.07.15 09:47 Rafael J. Wysocki wrote:
> > On Fri, Jul 10, 2020 at 3:34 PM Doug Smythies <dsmythies@telus.net> wrote:
> > >
> > > Hi Srinivas and/or Rafael,
> > >
> > > Can you please confirm or deny that an older
> > > commit:
> > >
> > > commit 8442885fca09b2d26375b9fe507759879a6f661e
> > > cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
> > >
> > > has been superseded by:
> > >
> > > arch/x86/kernel/cpu/intel_epb.c
> >
> > No, it hasn't.
> >
> > However, intel_pstate only touches the EPB if EPP is not supported,
> > which should become a non-issue after this patch posted by me
> > yesterday: https://patchwork.kernel.org/patch/11663315/
> >
> > If EPP is supported, intel_pstate will use it and it will never look
> > at the EPB even.
> >
> > > and that now there is no way to have some default EPB (say 6) for
> > > governors other than performance, while still getting an EPB of 0
> > > for the performance governor.
> >
> > If EPP is supported, what happens to the EPB is completely orthogonal
> > to cpufreq etc.
>
> Yes, I know.
> I am talking about when HWP is disabled.

I see.

> And I do not understand your reference to that patch from yesterday,
> as it seems unrelated to me.

If you are referring to when HWP is disabled, then it is not related indeed.

> > So it is possible to have the EPB different from 0, but it should be
> > the same for all governors unless changed via energy_perf_bias.
>
> And I am saying that contradicts the earlier referenced patch.
> We want EPB set to 0 for performance mode,

The "performance" governor in cpufreq (or the active-mode
"performance" scaling algorithm in intel_pstate) covers the CPU
performance scaling only, while the EPB potentially affects the other
system components too.  Thus driving the EPB from the CPU performance
scaling subsystem is not the right approach IMO.

> otherwise I challenge the name "performance" governor.

In that case "performance" means the maximum CPU capacity at the given
EPB level.

> Yes, EPB can be whatever for the other governors.

CPU performance scaling governors and the EPB should not be directly
related to each other.  The EPB is system-wide, which generally means
more than just CPUs (the uncore and memory may be affected by it in
principle, for example).

> >
> > If EPP is not supported, though, then without the patch mentioned
> > above, intel_pstate may fiddle with the EPB.
> >
> > > Additional notes:
> > > Both my test computers have EPB as 0 upon startup,
> >
> > That is before intel_epb_init() runs, because it will change the EPB
> > to "normal" (6).
>
> Yes, I know.
>
> >
> > > But I also tried this:
> > >
> > > diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> > > index f4dd73396f28..b536e381cd56 100644
> > > --- a/arch/x86/kernel/cpu/intel_epb.c
> > > +++ b/arch/x86/kernel/cpu/intel_epb.c
> > > @@ -74,7 +74,8 @@ static int intel_epb_save(void)
> > >
> > >  static void intel_epb_restore(void)
> > >  {
> > > -       u64 val = this_cpu_read(saved_epb);
> > > +//     u64 val = this_cpu_read(saved_epb);
> > > +       u64 val = 6;
> > >         u64 epb;
> > >
> > >         rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> > >
> > > which did get rid of this message:
> > > kernel: [    0.102158] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> >
> > Which is exactly what happens when this message is printed.
> >
> > Instead of commenting out the line of code above, which is not a
> > correct thing to do in general,
>
> Yes, of course. That was just a test, and the only way I could think of
> to prove that the system started with it as 0.
>
> > you can simply set the EPB to 0 via
> > energy_perf_bias for all CPUs and it should stick.
>
> And I am saying I should not have to do that, or even know about it,
> when I want to use the performance governor.

Again, cpufreq governors are on top of the EPB.

> But yes, I expect the driver to remember the default, or otherwise set,
> value of EPB for all the other governors.

We clearly don't agree here.

Also in the passive mode of intel_pstate, when the regular cpufreq
"performance" governor is in use, it's all about setting the frequency
to the max alone through min = max without touching any other knobs
which need to be adjusted separately.  That's how it's been always
working and changing it now may confuse the users who have learned to
rely on this behavior.

Thanks!
