Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623ED4C28F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFSUwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 16:52:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33038 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSUwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 16:52:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so495613qkc.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5rCzuSBrLaA6Op7MrdaVHZXcenmKCOz9zKA6giX+v0=;
        b=isEfq6jwPaqZYRufeqYVpJ4aUF6Eb6geHHhjFcA1KRzHKejvtKuLLqkcpIC5eGp9IL
         CL5KmPAcWju+EnTpWN3M64lTL/2QKtE/UZOmOn3pEn3cubJ+MUfD0QcGWyazytqFYmbZ
         d+H32Mpqyp8BdB9ZFBn9dRsK4qbKzYmySwFv/xBRxAHJ5vKUqA0NyC1t4FvA+HAY7l7K
         Rg5dLqeUzk2TFd+gkVR5XVmH9p/HijHY5ep7VD97WKpAUhk3ogXDCRdwCnC/1L6GZdgN
         +8hf6t60DlfUqIVIGTRQKBRLLHWG5b8KlCE5FFFv4WiAaViBYD5412kgCHPQz9X8vBOM
         Fmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5rCzuSBrLaA6Op7MrdaVHZXcenmKCOz9zKA6giX+v0=;
        b=eNKEOosSdAy7PHv+eLMWfNtc5ra9nx6yMeIxsXNd5GP/VXVSJBjsg0Ha+KNk3ubUyP
         wNT9myq4Ph9d2fYkv52ZIBcipp/aX6Ol4O3Asr0yYnGJwfacwipzTjOC1DwoN76jJLGd
         81kNjrolReldS5j1+2I6CdwZ9+Ch64rAg9b078wFIZcMsftEmHYob3vFs2PK07VUT2ya
         CrUTWYjMAsa4/Yn1QvlaQa/9BNh76TG+5R97sjlIFmlgBK0Uy0i4dK+pAaAK/CdgxgyS
         vyfqSS7u92Tn+/ISk6TdsvKzSE6mNqp6ClF5Er2sBTI13IELtSkpieT/Cf8CFDnlm0Oz
         FfOQ==
X-Gm-Message-State: APjAAAUcByfzHn/lMXpzYkXwZ/1aTpWl8npU5RTQ+Kj9leSRu7cvkSCN
        fBzcxVtRtTrCD6LRH36nRzYw4PEmMtq0eUtFacopEQ==
X-Google-Smtp-Source: APXvYqwkXi3xCG67StWJ97g9gbtDGdMv3fbCQX0ogpKxqIV6EucXjdPKsNGjHSyQ53Xs8SDPItZaYfdNbc5clFbMMoU=
X-Received: by 2002:a05:620a:15b3:: with SMTP id f19mr37627773qkk.314.1560977534249;
 Wed, 19 Jun 2019 13:52:14 -0700 (PDT)
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
 <CAGETcx-ZZRc_jtBws2cFTe1wjiWeBowdqfqOhcCJV_7AUyBEVw@mail.gmail.com>
 <CAJWu+ooaDBCF06QAeddFig5myfUABd6qebJ14nd6pKaBwQq8MA@mail.gmail.com> <CAGETcx9yWAvp0UYHQxfCkPi1ooBuYA1ZzZXVUvfyBh8XUTcbMg@mail.gmail.com>
In-Reply-To: <CAGETcx9yWAvp0UYHQxfCkPi1ooBuYA1ZzZXVUvfyBh8XUTcbMg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 16:52:02 -0400
Message-ID: <CAJWu+oqh4_MiVGpbuRpN1-RLd=HuS_uViTnfHbuhB3OZKJ8_Ng@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Saravana Kannan <saravanak@google.com>
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

On Wed, Jun 19, 2019 at 4:41 PM 'Saravana Kannan' via kernel-team
<kernel-team@android.com> wrote:
> > > On Wed, Jun 19, 2019, 11:55 AM 'Joel Fernandes' via kernel-team <kernel-team@android.com> wrote:
> > >>
> > >> On Wed, Jun 19, 2019 at 2:35 PM Greg Kroah-Hartman
> > >> <gregkh@linuxfoundation.org> wrote:
> > >> >
> > >> > On Wed, Jun 19, 2019 at 02:01:36PM -0400, Joel Fernandes wrote:
> > >> > > On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
> > >> > > <gregkh@linuxfoundation.org> wrote:
> > >> > > >
> > >> > > > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > >> > > > > > It is conceivable to have a "wakeup_sources" directory under
> > >> > > > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > >> > > > >
> > >> > > > > One of the "issues" with this is, now if you have say 100 wake up
> > >> > > > > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > >> > > > > files. Each one has to be opened, and read individually. This adds
> > >> > > > > overhead and it is more convenient to read from a single file. The
> > >> > > > > problem is this single file is not ABI. So the question I guess is,
> > >> > > > > how do we solve this in both an ABI friendly way while keeping the
> > >> > > > > overhead low.
> > >> > > >
> > >> > > > How much overhead?  Have you measured it, reading from virtual files is
> > >> > > > fast :)
> > >> > >
> > >> > > I measured, and it is definitely not free. If you create and read a
> > >> > > 1000 files and just return a string back, it can take up to 11-13
> > >> > > milliseconds (did not lock CPU frequencies, was just looking for
> > >> > > average ball park). This is assuming that the counter reading is just
> > >> > > doing that, and nothing else is being done to return the sysfs data
> > >> > > which is probably not always true in practice.
> > >> > >
> > >> > > Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
> > >> > > CPU scheduling competion reading sysfs can hurt the deadline. There's
> > >> > > also the question of power - we definitely have spent time in the past
> > >> > > optimizing other virtual files such as /proc/pid/smaps for this reason
> > >> > > where it spent lots of CPU time.
> > >> >
> > >> > smaps was "odd", but that was done after measurements were actually made
> > >> > to prove it was needed.  That hasn't happened yet :)
> > >> >
> > >> > And is there a reason you have to do this every 16ms?
> > >>
> > >> Not every, I was just saying whenever it happens and a frame delivery
> > >> deadline is missed, then a frame drop can occur which can result in a
> > >> poor user experience.
> > >
> > >
> > > But this is not done in the UI thread context. So some thread running for more than 16ms shouldn't cause a frame drop. If it does, we have bigger problems.
> > >
> >
> > Not really. That depends on the priority of the other thread and other
> > things. It can obviously time share the same CPU as the UI thread if
> > it is not configured correctly. Even with CFS it can reduce the time
> > consumed by other "real-time" CFS threads. I am not sure what you are
> > proposing, there are also (obviously) power issues with things running
> > for long times pointlessly. We should try to do better if we can. As
> > Greg said, some study/research can be done on the use case before
> > settling for a solution (sysfs or other).
> >
>
> Agree, power and optimization is good. Just saying that the UI example
> is not a real one. If the UI thread is that poorly configured that
> some thread running for a second can cause frame drops in a multicore
> system, that's a problem with the UI framework design.

We do know that historically there are problems with the UI thread's
scheduling and folks are looking into DL scheduling for that. I was
just giving UI thread as an example, there are also other low latency
threads (audio etc). Anyway, I think we know the next steps here so we
can park this discussion for now.
