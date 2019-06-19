Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74F44C279
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFSUlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 16:41:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44668 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSUlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 16:41:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so388467otl.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpUwpi6ZiT7FkXDLHkwFe14AauTrVYWRjFSVpnxhQLU=;
        b=c0ZMTdcaJyks4wdvB1Rq6tA62+E/+cF9RAhLcN8ezYFiuZO0A1AhbhNzo3aUy8/mxZ
         dArKgmGkPzr7O2lBUDil6B3eBsM0BB4dK4DGNZmH/LzTRzkB90DRkHm3j5AtUJdlXx2d
         ZZQ11DcrVCVbxpalH09fZ5FXcHGLu1fKuLNeRYN+gnsBxq+QSw7dagXluvH/eYjNqZBr
         DFJ66MjwcJz68EvR6cX9N9qOqdvi7c5p6mnDbdbH4shTgfhrquK868NVivke/+xGUjf4
         +msp8t2w1TcfLgAsw5P50Fqq7LK3m6YcFfGcy51AWI5rZPILzqY78BCzmClq9Pvd8/D6
         ec1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpUwpi6ZiT7FkXDLHkwFe14AauTrVYWRjFSVpnxhQLU=;
        b=Lw+XI8pbwpAJsDQN6W321N1Tct9Euc9nthyi+Hwk3RdtW/ogGCdXxX9gSRqPVK3Fdk
         ZrtXl4hjoHnn6ZIxWENpHiFoJkkN8PNQq4x/ZUWnet7XsIDG8RDwfmeeZxHvmTV7EiWd
         RA+SXGjX85/o0eRiVG5qIxe971mdkN0DhIFpY5zH6ez6LwoPeP3d/2/GJkOCREBBKnBD
         brPWowAYsjWgRkDOfFkTek9XSTJfj5DTXdhRMvOYIhAZJcHakIpBrEIiDNwXIM4xY0bl
         0ivvHnkhkg5lldCg0XW4Of6tGyXBhlXRrNiJ+Uw1umoP1wXUNP7pkAx8TZMRCfpsuVd6
         NKXA==
X-Gm-Message-State: APjAAAVE6jYtPDQ92vyzU8adqcidVZfSkwwHbcrdvXo1T8k37Fj9B0Zk
        PiMIrcIheIrkyLQBwpMYDy3YlZi8c7L8JEHGDEE1Nw==
X-Google-Smtp-Source: APXvYqzc1Dd4mob2T+s748nFLXyfVx+1T/mxSLN1akN+bwaEyK8Ck6yOMYt6tEnCE//WRs66k+/EcydYCR0SJstxyAw=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr5350706ota.139.1560976874737;
 Wed, 19 Jun 2019 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
 <20190619170750.GB10107@kroah.com> <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
 <20190619183523.GA7018@kroah.com> <CAJWu+opk+9j8=AtBFggbBn+nYZnCv2jS+mD=Vri9foN2rjvo8A@mail.gmail.com>
 <CAGETcx-ZZRc_jtBws2cFTe1wjiWeBowdqfqOhcCJV_7AUyBEVw@mail.gmail.com> <CAJWu+ooaDBCF06QAeddFig5myfUABd6qebJ14nd6pKaBwQq8MA@mail.gmail.com>
In-Reply-To: <CAJWu+ooaDBCF06QAeddFig5myfUABd6qebJ14nd6pKaBwQq8MA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Jun 2019 13:40:38 -0700
Message-ID: <CAGETcx9yWAvp0UYHQxfCkPi1ooBuYA1ZzZXVUvfyBh8XUTcbMg@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Joel Fernandes <joelaf@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 1:09 PM 'Joel Fernandes' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed, Jun 19, 2019 at 3:59 PM 'Saravana Kannan' via kernel-team
> <kernel-team@android.com> wrote:
> >
> >
> >
> > On Wed, Jun 19, 2019, 11:55 AM 'Joel Fernandes' via kernel-team <kernel-team@android.com> wrote:
> >>
> >> On Wed, Jun 19, 2019 at 2:35 PM Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> >
> >> > On Wed, Jun 19, 2019 at 02:01:36PM -0400, Joel Fernandes wrote:
> >> > > On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
> >> > > <gregkh@linuxfoundation.org> wrote:
> >> > > >
> >> > > > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> >> > > > > > It is conceivable to have a "wakeup_sources" directory under
> >> > > > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> >> > > > >
> >> > > > > One of the "issues" with this is, now if you have say 100 wake up
> >> > > > > sources, with 10 entries each, then we're talking about a 1000 sysfs
> >> > > > > files. Each one has to be opened, and read individually. This adds
> >> > > > > overhead and it is more convenient to read from a single file. The
> >> > > > > problem is this single file is not ABI. So the question I guess is,
> >> > > > > how do we solve this in both an ABI friendly way while keeping the
> >> > > > > overhead low.
> >> > > >
> >> > > > How much overhead?  Have you measured it, reading from virtual files is
> >> > > > fast :)
> >> > >
> >> > > I measured, and it is definitely not free. If you create and read a
> >> > > 1000 files and just return a string back, it can take up to 11-13
> >> > > milliseconds (did not lock CPU frequencies, was just looking for
> >> > > average ball park). This is assuming that the counter reading is just
> >> > > doing that, and nothing else is being done to return the sysfs data
> >> > > which is probably not always true in practice.
> >> > >
> >> > > Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
> >> > > CPU scheduling competion reading sysfs can hurt the deadline. There's
> >> > > also the question of power - we definitely have spent time in the past
> >> > > optimizing other virtual files such as /proc/pid/smaps for this reason
> >> > > where it spent lots of CPU time.
> >> >
> >> > smaps was "odd", but that was done after measurements were actually made
> >> > to prove it was needed.  That hasn't happened yet :)
> >> >
> >> > And is there a reason you have to do this every 16ms?
> >>
> >> Not every, I was just saying whenever it happens and a frame delivery
> >> deadline is missed, then a frame drop can occur which can result in a
> >> poor user experience.
> >
> >
> > But this is not done in the UI thread context. So some thread running for more than 16ms shouldn't cause a frame drop. If it does, we have bigger problems.
> >
>
> Not really. That depends on the priority of the other thread and other
> things. It can obviously time share the same CPU as the UI thread if
> it is not configured correctly. Even with CFS it can reduce the time
> consumed by other "real-time" CFS threads. I am not sure what you are
> proposing, there are also (obviously) power issues with things running
> for long times pointlessly. We should try to do better if we can. As
> Greg said, some study/research can be done on the use case before
> settling for a solution (sysfs or other).
>

Agree, power and optimization is good. Just saying that the UI example
is not a real one. If the UI thread is that poorly configured that
some thread running for a second can cause frame drops in a multicore
system, that's a problem with the UI framework design.

-Saravana

> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
