Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B376239DA8D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFGLE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 07:04:56 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45783 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFGLEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 07:04:55 -0400
Received: by mail-ot1-f42.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso3252867oto.12;
        Mon, 07 Jun 2021 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PwEOhhSgqcDZBccS2qEUl6w+mHR3TrhOJ8GYWHqr8k=;
        b=Vv72F61pOdy43bSOAo02JOdeatweILpN5RDVKHy7/ksKYe9Jq/aJPTFEVPFc7AqriL
         9NN9UT57a0jh6kRQYal0O3aI75uDxnP63+bhjccMvGaXOJa+fByvuSAelIkflQvFkglA
         UDpUSwSDbvRTJxSrwnfQx9N4v8giZ802knd1+5FPy38jD+KsK0t9qw/qv2Mos1DVP3yu
         XZu3BIJHd5BC1pDuomf+rBcaprGyM6Yw/ru02clb9OOAnuKfzK1e99kq//Ts8AUF1v/l
         DypFulHpImlXinTjP57E7kAXLCvj4L38uhCXafqZMoNZhOKnmJ5koj7PEmAaEg5G94pz
         F2MA==
X-Gm-Message-State: AOAM5330M0tkGqO2agunF26PZMy8DWACPfr/7undCHyH+D1pLRm04kv1
        D4eBYIFqmlpigGCfgTzknNJNmmwHWbbZrj5CWY0=
X-Google-Smtp-Source: ABdhPJx0vTAAkAXC/7vq4L1/cquuDBIgdiJwnp5HSGhecElAafjL4hrPr0xNCKmZpnyVm6ZpLmVLwsU8YMuo22bWtro=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr10038001otq.321.1623063784342;
 Mon, 07 Jun 2021 04:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221906.199436-1-kyle.meyer@hpe.com> <CAJZ5v0iJUhUyucYEDHXKqXrsy6=3dGUz0uy1pDpx+kKOi_NB2w@mail.gmail.com>
 <CAOh2x==tXk2Lt_f14_azHNYG2mZzMb9-1b2YUVj=+i=-JLemdg@mail.gmail.com>
In-Reply-To: <CAOh2x==tXk2Lt_f14_azHNYG2mZzMb9-1b2YUVj=+i=-JLemdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 13:02:46 +0200
Message-ID: <CAJZ5v0g-NMLa1UVYKpF2ehgk=6dJkKRonUY0AGw6HyRCDaQMmw@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Kyle Meyer <kyle.meyer@hpe.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-acpi@vegr.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 7, 2021 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> On Mon, May 24, 2021 at 7:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Sat, May 22, 2021 at 12:19 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > > index 7e7450453714..e79a945369d1 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
> > >
> > >         /* don't keep reloading if cpufreq_driver exists */
> > >         if (cpufreq_get_current_driver())
> > > -               return -EEXIST;
> > > +               return 0;
> > >
> > >         pr_debug("%s\n", __func__);
> > >
> > > --
> >
> > Applied as 5.14 material with some edits in the subject and changelog, thanks!
>
> I am not sure how this is supposed to work. If we return 0 from
> acpi_cpufreq_init(),
> then the driver will never be used, since it's acpi_cpufreq_init()
> will never get
> called again later.

Unless the module is unloaded and loaded again, that is.

> cpufreq drivers don't follow the generic device/driver model where a driver gets
> probed again if a device appears and so this is broken.

It is broken anyway as per the changelog of this patch.

On systems with several hundred logical CPUs this really can be troublesome.

> Please revert this patch.

Well, you can argue that the problem at hand is outside the kernel and
so it's not a kernel's business to address it.

After all, systemd-udevd could learn to avoid attempting to load the
module again if it fails with -EEXIST, but I'm not sure how different
that really would be from what this patch does, in practice.
