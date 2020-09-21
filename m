Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B89272C1C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgIUQ1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 12:27:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39660 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgIUQ11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 12:27:27 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kKOey-0003Q6-Lv
        for linux-pm@vger.kernel.org; Mon, 21 Sep 2020 16:27:24 +0000
Received: by mail-wr1-f70.google.com with SMTP id j7so6110688wro.14
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 09:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thDClgHDaKGbmUezXRj7DdU1OZCmKXxi2A/KuiV5pMQ=;
        b=AA1ZTNb0RWWH+or2Ggbph8o4SiVCKd77nYxOSsV0/bERnosHZtdublkTKkp+au1rVj
         nN/P9gFp82neIV8YRHWGaghcj+lGEHEKkNaa2uvsZH5rCksOxoIbLM+hp8Ew3nyuPQEx
         ZYrv0Ngos0K7Qa+vT41jrRAu8CKJBWHsEZFUtiIjFfOX3t7PGKI//GkXuZBzaJb2Q5rV
         uAyrldV8ADrHGwnq/0oW28ZmjBb8/q4A5jLnEl+SQIYJBnDiA+BAZprZaTX60vPpnQrq
         UuuonRf5Yu5CyUH5IR+h3by0p4SFxdWfWutDN+Gx9dsOH0JD/ihytdW6dJsvjaIOAUCM
         YhOw==
X-Gm-Message-State: AOAM530b7HXuLU1wj5VQc380Om3wwk1zPi8d5pI1g/qfDJgc8BILvPRa
        riikt1IyjEOzscN0yoBky50OCpOarSGie8eGOoMruahUe2qCBzzj842VLyhP7uEqBEPDUzi8cF/
        lhZSiKfoIsk5+lgSt/jd9JUXcEw0QbSL2gS3e
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr574915wrw.75.1600705643860;
        Mon, 21 Sep 2020 09:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgJrK69H5PmmGl9KT2Fwv90aaZb1pxl44DuDt74XBRogjWPGU1j/n5jv6ePksnPSVZYiRRZg==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr574894wrw.75.1600705643549;
        Mon, 21 Sep 2020 09:27:23 -0700 (PDT)
Received: from localhost (host-79-50-195-5.retail.telecomitalia.it. [79.50.195.5])
        by smtp.gmail.com with ESMTPSA id q15sm21147833wrr.8.2020.09.21.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:27:22 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:27:21 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory
 reclaim
Message-ID: <20200921162721.GB3203@xps-13>
References: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
 <20200609061931.GH8413@xps-13>
 <CAJZ5v0jWvQssoajoz2qh3Rbw8gNJSnRxg3NW6R6ayXYeHxodOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jWvQssoajoz2qh3Rbw8gNJSnRxg3NW6R6ayXYeHxodOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 21, 2020 at 05:36:30PM +0200, Rafael J. Wysocki wrote:
...
> > > 3. It is not clear how much mm_reclaim/release is going to help.  If
> > > the preloading of the swapped-out pages uses some kind of LIFO order,
> > > and can batch multiple pages, then it might help.  Otherwise demand
> > > paging is likely to be more effective.  If the preloading does indeed
> > > help, it may be useful to explain why in the commit message.
> >
> > Swap readahead helps a lot in terms of performance if we preload all at
> > once. But I agree that for the majority of cases on-demand paging just
> > works fine.
> >
> > My specific use-case for mm_reclaim/release is to make sure a VM
> > that is just resumed is immediately "fast" by preloading the swapped-out
> > pages back to memory all at once.
> >
> > Without mm_reclaim/release I've been using the trick of running swapoff
> > followed by a swapon to force all the pages back to memory, but it's
> > kinda ugly and I was looking for a better way to do this. I've been
> > trying also the ptrace() + reading all the VMAs via /proc/pid/mem, it
> > works, but it's not as fast as swapoff+swapon or mm_reclaim/release.
> >
> > I'll report performance numbers of mm_reclaim/release vs ptrace() +
> > /proc/pid/mem in the next version of this patch.
> 
> Sorry for the huge delay.
> 
> I'm wondering what your vision regarding the use of this mechanism in
> practice is?
> 
> In the "Testing" part of the changelog you say that "in the
> 5.7-mm_reclaim case a user-space daemon detects when the system is
> idle and triggers the opportunistic memory reclaim via
> /sys/power/mm_reclaim/run", but this may not be entirely practical,
> because hibernation is not triggered every time the system is idle.
> 
> In particular, how much time is required for the opportunistic reclaim
> to run before hibernation so as to make a significant difference?
> 
> Thanks!

Hi Raphael,

the typical use-case for this feature is to hibernate "spot" cloud
instances (low-priority instances that can be stopped at any time to
prioritize more privileged instances, see for example [1]). In this
scenario hibernation can be used as a "nicer" way to stop low priority
instances, instead of shutting them down.

Opportunistic memory reclaim doesn't really reduce the time to hibernate
overall: performance wise regular hibernation and hibernation w/
opportunistic reclaim require pretty much the same time.

But the advantage of opportunistic reclaim is that we can "prepare" a
system for hibernation using some idle time, so when we really need to
hibernate a low priority instance, because a high priority instance
requires to run, hibernation can be significantly faster.

What do you think about it? Do you see a better way to achieve this
goal?

Thanks,
-Andrea

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-interruptions.html
