Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59D272A52
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIUPgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 11:36:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41802 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgIUPgn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 11:36:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id x69so17395178oia.8;
        Mon, 21 Sep 2020 08:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP2Z3oRhK3eHSoO4BzbyEvH/PYDM17b6EUAJ8a+UJbY=;
        b=bCbDalZehF7uENL8Dz/p2w9yMkk4PDvmJFs1oNEraVgy4UuS5fki3SWr6ffJmk0mRN
         OedPeSLJ9QvtKXNGGecSFhzDbs7/5dzC8rlLKJEMUyTKzHM3NtXP5XTKR220x/iuCzOe
         ONAZ/5KMI5GyIXYKjqzXlANAUmOIpsmfmR01jeFx910Cpy04A5MUqkvwKkKtALsn8HHT
         0jqNyNMZx/1/E6bUy3uBBH8Rz/2YvscSR1EYfg42RqUWqqkGpB5uUQ4yLrWTjFc+uFUT
         0isz6hUysZSNSO5UoVLwsHEtCNklQt1S271SjPvyYSByd1XD1TtJUwQOvm2HxOLs2myi
         cZ0Q==
X-Gm-Message-State: AOAM531UZZCksrh/keX4/H25iiTyPzmDnQ+XzjSk1V5M3rsY/zbGOyB1
        nESxry34vsVHeIksJTB1nh4j1yB9Fkd6jT4WUdU=
X-Google-Smtp-Source: ABdhPJww9oxNxeRQH2N770Y4aJZAy5wWFPihKynYSdxaeVByKSUNpuumDTSh7xvGVB++b11h6B4FGSMBlhz9smJmGBo=
X-Received: by 2002:aca:df84:: with SMTP id w126mr63347oig.103.1600702601836;
 Mon, 21 Sep 2020 08:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
 <20200609061931.GH8413@xps-13>
In-Reply-To: <20200609061931.GH8413@xps-13>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 17:36:30 +0200
Message-ID: <CAJZ5v0jWvQssoajoz2qh3Rbw8gNJSnRxg3NW6R6ayXYeHxodOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory reclaim
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrea,

On Tue, Jun 9, 2020 at 8:19 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Mon, Jun 08, 2020 at 03:23:22PM -0700, Luigi Semenzato wrote:
> > Hi Andrea,
> >
> > 1. This mechanism is quite general.  It is possible that, although
> > hibernation may be an important use, there will be other uses for it.
> > I suggest leaving the hibernation example and performance analysis,
> > but not mentioning PM or hibernation in the patch subject.
>
> I was actually thinking to make this feature even more generic, since
> there might be other potential users of this forced "memory reclaim"
> feature outside hibernation. So, instead of adding the new sysfs files
> under /sys/power/mm_reclaim/, maybe move them to /sys/kernel/mm/ (since
> it's more like a mm feature, rather than a PM/hibernation feature).
>
> >
> > 2. It may be useful to have run_show() return the number of pages
> > reclaimed in the last attempt.  (I had suggested something similar in
> > https://lore.kernel.org/linux-mm/CAA25o9SxajRaa+ZyhvTYdaKdXokcrNYXgEUimax4sUJGCmRYLA@mail.gmail.com/).
>
> I like this idea, I'll add that in the next version.
>
> >
> > 3. It is not clear how much mm_reclaim/release is going to help.  If
> > the preloading of the swapped-out pages uses some kind of LIFO order,
> > and can batch multiple pages, then it might help.  Otherwise demand
> > paging is likely to be more effective.  If the preloading does indeed
> > help, it may be useful to explain why in the commit message.
>
> Swap readahead helps a lot in terms of performance if we preload all at
> once. But I agree that for the majority of cases on-demand paging just
> works fine.
>
> My specific use-case for mm_reclaim/release is to make sure a VM
> that is just resumed is immediately "fast" by preloading the swapped-out
> pages back to memory all at once.
>
> Without mm_reclaim/release I've been using the trick of running swapoff
> followed by a swapon to force all the pages back to memory, but it's
> kinda ugly and I was looking for a better way to do this. I've been
> trying also the ptrace() + reading all the VMAs via /proc/pid/mem, it
> works, but it's not as fast as swapoff+swapon or mm_reclaim/release.
>
> I'll report performance numbers of mm_reclaim/release vs ptrace() +
> /proc/pid/mem in the next version of this patch.

Sorry for the huge delay.

I'm wondering what your vision regarding the use of this mechanism in
practice is?

In the "Testing" part of the changelog you say that "in the
5.7-mm_reclaim case a user-space daemon detects when the system is
idle and triggers the opportunistic memory reclaim via
/sys/power/mm_reclaim/run", but this may not be entirely practical,
because hibernation is not triggered every time the system is idle.

In particular, how much time is required for the opportunistic reclaim
to run before hibernation so as to make a significant difference?

Thanks!
