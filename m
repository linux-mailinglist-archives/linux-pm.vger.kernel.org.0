Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8877C112083
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 01:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLDAJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 19:09:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36113 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLDAJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 19:09:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so5183962oic.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 16:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjEYCDaUPUpSpT7c9HukHsXkG9MFhX10UFhR0G7QbhY=;
        b=H+6wyUjpwrBMn3H9u+roBBHPmkpmu6BhcLwbnNtBoDsM1BewCVG2A9G3qCem6x1ipG
         Wn18Ylq3dpw03/zTwN+2mm9VtDv0ihdlOvsFLUQGKT0S+/tZDqXyHTA7deNn3AQ9ZtR/
         9jNFAvGUDdjBW1bzRPTCZIHO3vYvw/FfmkVqraORErpLgZ201O2O9AEUQqXSBFlANUZS
         XdczHP29H8o1G0UNrec+ZizJXKjLxcdNTR7UWvUveW++io9i/yK7qgplhRq+50A/1cIr
         OItZf7Zrx40RI/YjCBgu8T7+pfQX95pH1E9VsmsbrYFrYmldyLqHJBHhtUwqPs3paTRx
         ItCg==
X-Gm-Message-State: APjAAAXCjf5zySmc8TkTJyKBXW0KJTVmNXENFpcYFsdtaxUkOZw6nyDf
        gFJlCEdiqNbtcoTx5KUZPX9ZqBEqFKG2nDMOkdFgaw==
X-Google-Smtp-Source: APXvYqzQuEXc3AXxPVvTj7CKjWRoriboxj71xkdus78lEGEYKE8+SLIeM9YbNE6A2TWT9b5hv/7a6q+ovbt0RIMSrts=
X-Received: by 2002:a54:488d:: with SMTP id r13mr288831oic.115.1575418152909;
 Tue, 03 Dec 2019 16:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20191120210049.254548-1-semenzato@google.com> <CAA25o9T4NhAkGiQ5JJvM5A1TX2D9eBfXCpXZo=aJz80s_PNwqQ@mail.gmail.com>
In-Reply-To: <CAA25o9T4NhAkGiQ5JJvM5A1TX2D9eBfXCpXZo=aJz80s_PNwqQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Dec 2019 01:09:01 +0100
Message-ID: <CAJZ5v0h28NMTQZQit59uKteCRUg91_Lo2jF02jw_fBBq9Nedkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] power: clarify limitations of hibernation
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 4, 2019 at 12:15 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> Any comments on this?

Nothing fundamental.

I would prefer two patches, though, one adding the messages to
snapshot.c and the other to update the documentation.

> I'd like to point out that this isn't just a righteous nitpick.  I've
> seen decisions being taken based on the reasonable assumption that
> hibernation can be used under the same circumstances as
> suspend-to-RAM. These decisions involved serious time and money.
> Things may have moved differently with a clearer understanding of
> these limitations.  It does us (Linux) no good to omit these warnings.

Fair enough.

> On Wed, Nov 20, 2019 at 1:01 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Entering hibernation (suspend-to-disk) will fail if the kernel
> > cannot allocate enough memory to create a snapshot of all pages
> > in use; i.e., if memory in use is over 1/2 of total RAM.  This
> > patch makes this limitation clearer in the documentation.  Without
> > it, users may assume that hibernation can replace suspend-to-RAM
> > when in fact its functionality is more limited.
> >
> > Signed-off-by: Luigi Semenzato <semenzato@google.com>
> > ---
> >  Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
> >  kernel/power/snapshot.c                       | 16 +++++++++++-----
> >  2 files changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
> > index cd3a28cb81f4..fd0072eb8c03 100644
> > --- a/Documentation/admin-guide/pm/sleep-states.rst
> > +++ b/Documentation/admin-guide/pm/sleep-states.rst
> > @@ -112,7 +112,9 @@ Hibernation
> >  This state (also referred to as Suspend-to-Disk or STD) offers the greatest
> >  energy savings and can be used even in the absence of low-level platform support
> >  for system suspend.  However, it requires some low-level code for resuming the
> > -system to be present for the underlying CPU architecture.
> > +system to be present for the underlying CPU architecture.  Additionally, the
> > +current implementation can enter the hibernation state only when memory
> > +pressure is low (see "Limitations" below).
> >
> >  Hibernation is significantly different from any of the system suspend variants.
> >  It takes three system state changes to put it into hibernation and two system
> > @@ -149,6 +151,20 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
> >  configuration option is set.  However, this option can only be set if support
> >  for the given CPU architecture includes the low-level code for system resume.
> >
> > +Limitations of Hibernation
> > +==========================
> > +
> > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > +enough to contain a copy of all pages in use, to use it for the system
> > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > +
> > +One possible workaround (besides terminating enough processes) is to force
> > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > +operation is not guaranteed to succeed.
> >
> >  Basic ``sysfs`` Interfaces for System Suspend and Hibernation
> >  =============================================================
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 83105874f255..9f3228f1ee26 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -1698,16 +1698,20 @@ int hibernate_preallocate_memory(void)
> >         ktime_t start, stop;
> >         int error;
> >
> > -       pr_info("Preallocating image memory... ");
> > +       pr_info("Preallocating hibernation image memory\n");
> >         start = ktime_get();
> >
> >         error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
> > -       if (error)
> > +       if (error) {
> > +               pr_err("Cannot allocate original bitmap\n");
> >                 goto err_out;
> > +       }
> >
> >         error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
> > -       if (error)
> > +       if (error) {
> > +               pr_err("Cannot allocate copy bitmap\n");
> >                 goto err_out;
> > +       }
> >
> >         alloc_normal = 0;
> >         alloc_highmem = 0;
> > @@ -1797,8 +1801,11 @@ int hibernate_preallocate_memory(void)
> >                 alloc -= pages;
> >                 pages += pages_highmem;
> >                 pages_highmem = preallocate_image_highmem(alloc);
> > -               if (pages_highmem < alloc)
> > +               if (pages_highmem < alloc) {
> > +                       pr_err("image allocation is %lu pages short\n",
> > +                               alloc - pages_highmem);
> >                         goto err_out;
> > +               }
> >                 pages += pages_highmem;
> >                 /*
> >                  * size is the desired number of saveable pages to leave in
> > @@ -1835,7 +1842,6 @@ int hibernate_preallocate_memory(void)
> >         return 0;
> >
> >   err_out:
> > -       pr_cont("\n");
> >         swsusp_free();
> >         return -ENOMEM;
> >  }
> > --
> > 2.24.0.432.g9d3f5f5b63-goog
> >
