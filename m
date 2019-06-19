Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828DE4C06D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfFSSBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 14:01:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40814 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSSBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 14:01:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so57316qtn.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czuVT35co/UKsceghDoTiQ4oToGLTSbKhMCQO4t0nUE=;
        b=t0FlsK0r8Bx/f9E7kd+SWF3OofIkorm0DUUph6+DeKYxZhH1U3WrRKGKsUCk/Pyopt
         ZCT4v3iUv9Slj1G3/LFS8XXYQScHawo96l+KvR62BUI+LZW4DW0mmeWApJs9FDNP++8I
         hFpVtgUjorb6GvON/zvOaNk274fAgQ610pRPN2d8a4ZKqk8kp+mg4CWTC6mpLM86PjQ8
         XQAQR8lUeFq+t9e937A5exioDrUzLZyGlsUA3MmCnYYQGGAAR8l4OPQOKfPU5Y4qSyMC
         eK0t9B/HM1zZyai4w8BO0Uovj73EoB72CeT5TBW4CNjFngXdTBAOLDwWPhtfkUyXyZmW
         reXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czuVT35co/UKsceghDoTiQ4oToGLTSbKhMCQO4t0nUE=;
        b=s0DosQI+zwr5Phs+LWPenOh+kCsfRboqOvB28FNzOzjWc2ZI451PLNfLMaN0h1Il70
         RDZV2zRnseLllDmJCcsj53HanNsrR41cTEcGJMA1biI85QcNttIYwVeKN7VGy50Ou3Pr
         zCSmFemEupsid8VDcUSQk7fXI3XlVIL2rrhcd6EdhgB7v3+tdhmAVj6aSV7QjW9mag7Q
         Psvxy0IM25bfk6EzQCrxnmFAt5h9llsHNyn0LRbsdFz4Fp61bwsf6kN3Sj/MWyrNAgMi
         IU7x0TJaaiFPtO1JKCr4WyfleGIyBFryjf8/mMNLqpbsU4TkXRwwEVXdqTLXRqPITF3s
         eayg==
X-Gm-Message-State: APjAAAWNrvF5AKrSjQpGnhNoGB4NBTMQOAnl4fSLlxF+YAdKR1ado2x3
        vOuHOdfm3UC+twFFiwXQXP7ae47/day7XcEDMqFshA==
X-Google-Smtp-Source: APXvYqxeZ4O/kaqZoo3nciU9wlzuTKsySBSeoLaF/GcKUrg0k12S8Nc/w6joJpYVh9NOpJ72bTjl+T69A/gi1ERuRUk=
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr18306346qtj.176.1560967308199;
 Wed, 19 Jun 2019 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com> <20190619170750.GB10107@kroah.com>
In-Reply-To: <20190619170750.GB10107@kroah.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 14:01:36 -0400
Message-ID: <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > > It is conceivable to have a "wakeup_sources" directory under
> > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> >
> > One of the "issues" with this is, now if you have say 100 wake up
> > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > files. Each one has to be opened, and read individually. This adds
> > overhead and it is more convenient to read from a single file. The
> > problem is this single file is not ABI. So the question I guess is,
> > how do we solve this in both an ABI friendly way while keeping the
> > overhead low.
>
> How much overhead?  Have you measured it, reading from virtual files is
> fast :)

I measured, and it is definitely not free. If you create and read a
1000 files and just return a string back, it can take up to 11-13
milliseconds (did not lock CPU frequencies, was just looking for
average ball park). This is assuming that the counter reading is just
doing that, and nothing else is being done to return the sysfs data
which is probably not always true in practice.

Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
CPU scheduling competion reading sysfs can hurt the deadline. There's
also the question of power - we definitely have spent time in the past
optimizing other virtual files such as /proc/pid/smaps for this reason
where it spent lots of CPU time.

> And how often does this happen?  Does it _need_ to happen?

These are good questions and we should find out. I am not saying that
sysfs will not work, I am just saying we need to consider all the
things. I will let Tri look into this since he is working on it, I
don't know off the top.

> Parsing files is also hard, and not for sysfs files, you can't have it
> both ways.

I don't think we are concerned with a parsing issue here, or are
discussing it in this thread.

> So try it this way, and if there really is a performance issue, we can
> then talk about it...

Sure that sounds good to me, again I am not saying we should do sysfs.
But we should consider all the issues and chose the right solution.

thanks!

 - Joel
