Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E31F3400
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 08:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFIGTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 02:19:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgFIGTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 02:19:37 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jiXbi-0008Bk-Mp
        for linux-pm@vger.kernel.org; Tue, 09 Jun 2020 06:19:34 +0000
Received: by mail-wr1-f70.google.com with SMTP id i6so6558694wrr.23
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 23:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qjb8qEBmbuxNu1rg1xJE74o0cBFJkDEp4RqvXUvcj7g=;
        b=TorDzVlbs5Iosa+NxyS9Aq7LFkNms2MSVZ4vUFVEHOyq2iSoTKBDN0tJPZp2iRpaC0
         u2VKwSvbGmps1qof089w8pL4/IwBrH39kAPiXxA8lBl+Bp5f4HzmdK7HGYAdkIMlU8BC
         Ew4ey7KbC8uqHzSPdtakwkKmPxuDjSjD+Ge6LPJNfrZE29sDS7/VhWmE841ZppiGh+Io
         ivqsWPKTyu3Y7sHNgOGzE1nR97L3uuzmwsd7aMgSUNP5CysH1YqPnA1pxwDUzSdcdm4y
         Y5aR0OZWlKPGynzrD0KXtVva+gR7d41iZ/N6JN+UX/XIc0VuGU0As70WjcmUqjnzFy9y
         9F8Q==
X-Gm-Message-State: AOAM5322eFJ2Wmdn3S8HHePg3hCUOgyzDxbZ0GLAdfsx+RPgYOLd3f9J
        txSnn9pYboVOR+WAS1f+ZmmFsE/EroI76NIMgRhl/r0cEH6vFeD05YxIzOckwL1Ymje7kPvBX1i
        ddR+0jI/wtWzeUzyTUjk5skczYnAUcj+K+gxs
X-Received: by 2002:adf:f611:: with SMTP id t17mr2488214wrp.69.1591683574301;
        Mon, 08 Jun 2020 23:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHarr5VZT6oF9G6VEGI1D72bnLATgetDEJahbmVGkSpxTPq0pDEZ9cDRwC9XjCiXG/RArUkw==
X-Received: by 2002:adf:f611:: with SMTP id t17mr2488180wrp.69.1591683573984;
        Mon, 08 Jun 2020 23:19:33 -0700 (PDT)
Received: from localhost (host-79-43-135-105.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id s7sm2062721wrr.60.2020.06.08.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:19:33 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:19:31 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory
 reclaim
Message-ID: <20200609061931.GH8413@xps-13>
References: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 08, 2020 at 03:23:22PM -0700, Luigi Semenzato wrote:
> Hi Andrea,
> 
> 1. This mechanism is quite general.  It is possible that, although
> hibernation may be an important use, there will be other uses for it.
> I suggest leaving the hibernation example and performance analysis,
> but not mentioning PM or hibernation in the patch subject.

I was actually thinking to make this feature even more generic, since
there might be other potential users of this forced "memory reclaim"
feature outside hibernation. So, instead of adding the new sysfs files
under /sys/power/mm_reclaim/, maybe move them to /sys/kernel/mm/ (since
it's more like a mm feature, rather than a PM/hibernation feature).

> 
> 2. It may be useful to have run_show() return the number of pages
> reclaimed in the last attempt.  (I had suggested something similar in
> https://lore.kernel.org/linux-mm/CAA25o9SxajRaa+ZyhvTYdaKdXokcrNYXgEUimax4sUJGCmRYLA@mail.gmail.com/).

I like this idea, I'll add that in the next version.

> 
> 3. It is not clear how much mm_reclaim/release is going to help.  If
> the preloading of the swapped-out pages uses some kind of LIFO order,
> and can batch multiple pages, then it might help.  Otherwise demand
> paging is likely to be more effective.  If the preloading does indeed
> help, it may be useful to explain why in the commit message.

Swap readahead helps a lot in terms of performance if we preload all at
once. But I agree that for the majority of cases on-demand paging just
works fine.

My specific use-case for mm_reclaim/release is to make sure a VM
that is just resumed is immediately "fast" by preloading the swapped-out
pages back to memory all at once.

Without mm_reclaim/release I've been using the trick of running swapoff
followed by a swapon to force all the pages back to memory, but it's
kinda ugly and I was looking for a better way to do this. I've been
trying also the ptrace() + reading all the VMAs via /proc/pid/mem, it
works, but it's not as fast as swapoff+swapon or mm_reclaim/release.

I'll report performance numbers of mm_reclaim/release vs ptrace() +
/proc/pid/mem in the next version of this patch.

> 
> Thanks!

Thanks for your review!

-Andrea
