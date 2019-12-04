Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3D11209B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLDAZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 19:25:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46338 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLDAZd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 19:25:33 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so4971653ilm.13
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 16:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+W6AxTkWhIkwVxDnAVmmSn6afSJQLTJ2uq9QYHHkb5Q=;
        b=HzhBaPyH5+KWYbhuU00SRiD+7GcPnwAclDxWQg0bYEr38ZAV2CTPWNY1LnMjPYxax3
         6ctVOdwUBnUdcf4ZXUkKiINA6imitZ9zMSdX4qL1+krM2Dn8DF+siuf4jymlahNJPJ5S
         5Xj8jImaaa51mD20+/ewkkjggq/VuXb18KvE++66JFJf8aTgjytflcJEOqwYYlnCkmLP
         k5GJk5eJMiRomAZOyCx7wVrLg+oWg7xFB60UvtyHuL8ngK1VN+V0M0TCJCmuTafx5fVb
         e3I3Yvex6lW6LLM9kV1n0nsu3QsICEO2F4INAas5uUsIySKVqbQnCLUxMMjkROndDzhJ
         3JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W6AxTkWhIkwVxDnAVmmSn6afSJQLTJ2uq9QYHHkb5Q=;
        b=Tvfr9KSB3f42vUbdgdknCyjo6Gz6dFoZsznXbzDDliBo915vkMRVD1fdrr2c5uTuof
         cEbVxnfeSc4Cq6kK1UtedeAoLgllbRtxm3dekc4UStsZvHarjuVcCWKMFVUk6pxpeKGT
         a79XcuhHnjHWYxLs0mIHpfpyQx+Mfk6kyMBHEMPmtrpU+bEmuQM2FFgR7z8qjsbrAkPo
         Evl0ARY0GaRe1duXmMvW21HFcSDujBMcsxJDay7R7++ndIyT7pgQP+9chRIH88ldOUu5
         3ZF7tVro/zGZ6vpgB09GVn1Sz5o8/Qu1SE9+BSMHMOgEFBQ3Fc3+UMUayAyQnKPxlo/J
         n4EA==
X-Gm-Message-State: APjAAAWkysoH9Fd8nB1YV2+ZvXxD8b3z5evKbN6Ed7PxjGWNx888Yi8S
        7wH3QMLbetQ2A1+i8s608eVZJ3AI3NVawJv9VAOcZw==
X-Google-Smtp-Source: APXvYqxrSbL5zBGWf1rUqutH8bcibBHbgRAyXCwrqU5zxIyOHG7omwfPeaeyhr1iwwMcVNNPgVxZ/rUf3f2x/D8K/cQ=
X-Received: by 2002:a92:884e:: with SMTP id h75mr975672ild.199.1575419132387;
 Tue, 03 Dec 2019 16:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120210049.254548-1-semenzato@google.com> <CAA25o9T4NhAkGiQ5JJvM5A1TX2D9eBfXCpXZo=aJz80s_PNwqQ@mail.gmail.com>
 <CAJZ5v0h28NMTQZQit59uKteCRUg91_Lo2jF02jw_fBBq9Nedkg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h28NMTQZQit59uKteCRUg91_Lo2jF02jw_fBBq9Nedkg@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 3 Dec 2019 16:25:21 -0800
Message-ID: <CAA25o9SOfV9BKUA2foo7GJfNdOq_cgb5RhYX8HzgSRdLL42Q8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] power: clarify limitations of hibernation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks.  I'll split it into two then.

On Tue, Dec 3, 2019 at 4:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 4, 2019 at 12:15 AM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Any comments on this?
>
> Nothing fundamental.
>
> I would prefer two patches, though, one adding the messages to
> snapshot.c and the other to update the documentation.
>
> > I'd like to point out that this isn't just a righteous nitpick.  I've
> > seen decisions being taken based on the reasonable assumption that
> > hibernation can be used under the same circumstances as
> > suspend-to-RAM. These decisions involved serious time and money.
> > Things may have moved differently with a clearer understanding of
> > these limitations.  It does us (Linux) no good to omit these warnings.
>
> Fair enough.
>
> > On Wed, Nov 20, 2019 at 1:01 PM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > Entering hibernation (suspend-to-disk) will fail if the kernel
> > > cannot allocate enough memory to create a snapshot of all pages
> > > in use; i.e., if memory in use is over 1/2 of total RAM.  This
> > > patch makes this limitation clearer in the documentation.  Without
> > > it, users may assume that hibernation can replace suspend-to-RAM
> > > when in fact its functionality is more limited.
> > >
> > > Signed-off-by: Luigi Semenzato <semenzato@google.com>
> > > ---
> > >  Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
> > >  kernel/power/snapshot.c                       | 16 +++++++++++-----
> > >  2 files changed, 28 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
> > > index cd3a28cb81f4..fd0072eb8c03 100644
> > > --- a/Documentation/admin-guide/pm/sleep-states.rst
> > > +++ b/Documentation/admin-guide/pm/sleep-states.rst
> > > @@ -112,7 +112,9 @@ Hibernation
> > >  This state (also referred to as Suspend-to-Disk or STD) offers the greatest
> > >  energy savings and can be used even in the absence of low-level platform support
> > >  for system suspend.  However, it requires some low-level code for resuming the
> > > -system to be present for the underlying CPU architecture.
> > > +system to be present for the underlying CPU architecture.  Additionally, the
> > > +current implementation can enter the hibernation state only when memory
> > > +pressure is low (see "Limitations" below).
> > >
> > >  Hibernation is significantly different from any of the system suspend variants.
> > >  It takes three system state changes to put it into hibernation and two system
> > > @@ -149,6 +151,20 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
> > >  configuration option is set.  However, this option can only be set if support
> > >  for the given CPU architecture includes the low-level code for system resume.
> > >
> > > +Limitations of Hibernation
> > > +==========================
> > > +
> > > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > > +enough to contain a copy of all pages in use, to use it for the system
> > > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > > +
> > > +One possible workaround (besides terminating enough processes) is to force
> > > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > > +operation is not guaranteed to succeed.
> > >
> > >  Basic ``sysfs`` Interfaces for System Suspend and Hibernation
> > >  =============================================================
> > > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > > index 83105874f255..9f3228f1ee26 100644
> > > --- a/kernel/power/snapshot.c
> > > +++ b/kernel/power/snapshot.c
> > > @@ -1698,16 +1698,20 @@ int hibernate_preallocate_memory(void)
> > >         ktime_t start, stop;
> > >         int error;
> > >
> > > -       pr_info("Preallocating image memory... ");
> > > +       pr_info("Preallocating hibernation image memory\n");
> > >         start = ktime_get();
> > >
> > >         error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
> > > -       if (error)
> > > +       if (error) {
> > > +               pr_err("Cannot allocate original bitmap\n");
> > >                 goto err_out;
> > > +       }
> > >
> > >         error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
> > > -       if (error)
> > > +       if (error) {
> > > +               pr_err("Cannot allocate copy bitmap\n");
> > >                 goto err_out;
> > > +       }
> > >
> > >         alloc_normal = 0;
> > >         alloc_highmem = 0;
> > > @@ -1797,8 +1801,11 @@ int hibernate_preallocate_memory(void)
> > >                 alloc -= pages;
> > >                 pages += pages_highmem;
> > >                 pages_highmem = preallocate_image_highmem(alloc);
> > > -               if (pages_highmem < alloc)
> > > +               if (pages_highmem < alloc) {
> > > +                       pr_err("image allocation is %lu pages short\n",
> > > +                               alloc - pages_highmem);
> > >                         goto err_out;
> > > +               }
> > >                 pages += pages_highmem;
> > >                 /*
> > >                  * size is the desired number of saveable pages to leave in
> > > @@ -1835,7 +1842,6 @@ int hibernate_preallocate_memory(void)
> > >         return 0;
> > >
> > >   err_out:
> > > -       pr_cont("\n");
> > >         swsusp_free();
> > >         return -ENOMEM;
> > >  }
> > > --
> > > 2.24.0.432.g9d3f5f5b63-goog
> > >
