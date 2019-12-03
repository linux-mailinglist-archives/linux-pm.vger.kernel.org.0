Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D639A11201E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 00:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLCXPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 18:15:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36148 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfLCXPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 18:15:51 -0500
Received: by mail-io1-f68.google.com with SMTP id l17so5846754ioj.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5N8xuYTj0GgvD198/e1+H8K6bZ7sCNSvnWCQ2+axlc=;
        b=QknO7mhz+/qhaiIDXSvph+l99x0XMFOH/QYiAIG9UUUx8AnYJSLWxSt6uNLzTf81wM
         NBt4moSr2gmA+Pw8oZXrq1huKoj3lv0Ch8ADPGXXw6obziEWmXDYgabuDjDW+yzcctOP
         U/G+pj3uAy9EZc5pvwD20JpEmUxztCpvCXNTB2IgfrbtFnxQsLZ0UWBYEWXXPMTYf6De
         epA2iLGi7+lLPG+fBfjS2AQoEKP/EiVpjJGAbvimmGGKZTs6pORAgUVQ/laH6sbQWf7H
         EeXUkaPy81c91Lc7JRktz3TFT3vD4F3dbEujDqJihBgcGtqTHCUzuQFY99lA/r20yGBY
         XWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5N8xuYTj0GgvD198/e1+H8K6bZ7sCNSvnWCQ2+axlc=;
        b=ASzhnz8feu3Q6cY846TXkUJMJ4A7kqgmFA6WWlMmOAS6EfOQBkqx9EcWLSppyI3s46
         ZPjSgnZrxdbZbv1aeg5CU9ZUeirMtvarPeaU+dmqD8oZbM8jhq8Jsnf+yiOQZdp98X63
         fVK3YA68DeSA/c6aCtN5ikZUHFS+BcIryLeG8jA49rWzLDaoE9KEZXOdOnryu4Sbmjh/
         +p/PhrISiXEzeK5BO2WpfLVW6AJ9zQFWWq+uc7mNp+k2QZbMGNdaMwj7dWz5KJ05TJEL
         iIeh2XeTjvvsoXnplQ+5djwSN+EbmZVobbiZY2r1iUjQHZbuMMz2/5zvmpYNTsqkW51l
         rYMw==
X-Gm-Message-State: APjAAAVT926+GL/eUJk0u61ViV2rZzxwwdat3Vuye3+WATZE6YhFSq0e
        3DBdjtm8JETVVEkgfwxLq8CG+DOzt+zRSnzaXTiVZIUO
X-Google-Smtp-Source: APXvYqx6Gl3OnD9ZWwYlokeHqc+euLOGbJF+4U96iYP55RPgfdv2vmwDudd+PILluvRsUXvPvsS4nuAb26CcPvd8Nn8=
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr570013iog.169.1575414949712;
 Tue, 03 Dec 2019 15:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20191120210049.254548-1-semenzato@google.com>
In-Reply-To: <20191120210049.254548-1-semenzato@google.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 3 Dec 2019 15:15:38 -0800
Message-ID: <CAA25o9T4NhAkGiQ5JJvM5A1TX2D9eBfXCpXZo=aJz80s_PNwqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] power: clarify limitations of hibernation
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Any comments on this?

I'd like to point out that this isn't just a righteous nitpick.  I've
seen decisions being taken based on the reasonable assumption that
hibernation can be used under the same circumstances as
suspend-to-RAM. These decisions involved serious time and money.
Things may have moved differently with a clearer understanding of
these limitations.  It does us (Linux) no good to omit these warnings.

On Wed, Nov 20, 2019 at 1:01 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> Entering hibernation (suspend-to-disk) will fail if the kernel
> cannot allocate enough memory to create a snapshot of all pages
> in use; i.e., if memory in use is over 1/2 of total RAM.  This
> patch makes this limitation clearer in the documentation.  Without
> it, users may assume that hibernation can replace suspend-to-RAM
> when in fact its functionality is more limited.
>
> Signed-off-by: Luigi Semenzato <semenzato@google.com>
> ---
>  Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
>  kernel/power/snapshot.c                       | 16 +++++++++++-----
>  2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
> index cd3a28cb81f4..fd0072eb8c03 100644
> --- a/Documentation/admin-guide/pm/sleep-states.rst
> +++ b/Documentation/admin-guide/pm/sleep-states.rst
> @@ -112,7 +112,9 @@ Hibernation
>  This state (also referred to as Suspend-to-Disk or STD) offers the greatest
>  energy savings and can be used even in the absence of low-level platform support
>  for system suspend.  However, it requires some low-level code for resuming the
> -system to be present for the underlying CPU architecture.
> +system to be present for the underlying CPU architecture.  Additionally, the
> +current implementation can enter the hibernation state only when memory
> +pressure is low (see "Limitations" below).
>
>  Hibernation is significantly different from any of the system suspend variants.
>  It takes three system state changes to put it into hibernation and two system
> @@ -149,6 +151,20 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
>  configuration option is set.  However, this option can only be set if support
>  for the given CPU architecture includes the low-level code for system resume.
>
> +Limitations of Hibernation
> +==========================
> +
> +When entering hibernation, the kernel tries to allocate a chunk of memory large
> +enough to contain a copy of all pages in use, to use it for the system
> +snapshot.  If the allocation fails, the system cannot hibernate and the
> +operation fails with ENOMEM.  This will happen, for instance, when the total
> +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> +
> +One possible workaround (besides terminating enough processes) is to force
> +excess anonymous pages out to swap before hibernating.  This can be achieved
> +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> +operation is not guaranteed to succeed.
>
>  Basic ``sysfs`` Interfaces for System Suspend and Hibernation
>  =============================================================
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 83105874f255..9f3228f1ee26 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1698,16 +1698,20 @@ int hibernate_preallocate_memory(void)
>         ktime_t start, stop;
>         int error;
>
> -       pr_info("Preallocating image memory... ");
> +       pr_info("Preallocating hibernation image memory\n");
>         start = ktime_get();
>
>         error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
> -       if (error)
> +       if (error) {
> +               pr_err("Cannot allocate original bitmap\n");
>                 goto err_out;
> +       }
>
>         error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
> -       if (error)
> +       if (error) {
> +               pr_err("Cannot allocate copy bitmap\n");
>                 goto err_out;
> +       }
>
>         alloc_normal = 0;
>         alloc_highmem = 0;
> @@ -1797,8 +1801,11 @@ int hibernate_preallocate_memory(void)
>                 alloc -= pages;
>                 pages += pages_highmem;
>                 pages_highmem = preallocate_image_highmem(alloc);
> -               if (pages_highmem < alloc)
> +               if (pages_highmem < alloc) {
> +                       pr_err("image allocation is %lu pages short\n",
> +                               alloc - pages_highmem);
>                         goto err_out;
> +               }
>                 pages += pages_highmem;
>                 /*
>                  * size is the desired number of saveable pages to leave in
> @@ -1835,7 +1842,6 @@ int hibernate_preallocate_memory(void)
>         return 0;
>
>   err_out:
> -       pr_cont("\n");
>         swsusp_free();
>         return -ENOMEM;
>  }
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
