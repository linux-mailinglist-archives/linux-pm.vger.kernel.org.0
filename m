Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239BB4C21A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFSUJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 16:09:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39889 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSUJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 16:09:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so572086qta.6
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYmFmG4TpawNp09vdL6LXIaDPak4zLGr0HHIZFTbmtA=;
        b=pW3gA94B/z9qhXMAlgheBp+vMpbKqGNV7NYwzp3wIbCARSxjpAkkIxfjEzyvtKahih
         fl553bWmOLGG4gcAjB2019He0APjuub04Fp4EpcsIpeeF2rYxthKQt3eu3Vd2CKiyiJJ
         QfYcXKfsT5+e1t0LduWdZYlZZ68JE4kKLt5ZBcobE7YsoKCzcI1gBBUqTxgVnwyfGMg8
         AcU4d7jOl/bdDqgNb8AnpwzS/AWaMXbkzTHYAd0j9uPhWunPMMUFS3h/0KC11ki9JONs
         SpSI7F6da/M3g8V4qHccL0XvvVbRuNc1poKEqTX9LFGS5tdA+NWE2IKbjWRXMdD9ELvf
         xnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYmFmG4TpawNp09vdL6LXIaDPak4zLGr0HHIZFTbmtA=;
        b=s2MLAz4IGlbW+vpOSEDvVCxgF2UgByuK+4XJLcWgbDJEcNMoYA1EzuXzsdWEbiAHny
         +ak7g/d3Pkiqatdi6o+4/XaqW/CCVWfyApZkGEF0kQPdsdWL4flr4ffHIZJw0n9/wRDa
         JgBy6Arlor6omro/aMAvB7oOeK2xUuko8mO7YTEAdcDF8w7VVlODlAY5m1Hq5k4PHrts
         zsuMOuEf33duXZnu201yuB2IFiD1enm5nFxlZsNtbdSzVzmpYReMCUQcqH9H1TSSm6E/
         Ybi41U7lz69492EzUec2BPkih4VibpAxKMI0FG02qcjJcX/OIyPqwNRP5RVB/XqhmGY/
         IV5g==
X-Gm-Message-State: APjAAAXOWClkKVFBzk/BhvuMJf2fD3/POw50U6g6ZWW50QT2toC7VMXg
        dbbeGU8WX6r1xHbvfUEwaLKHnjNrn6hL1tHHJcsuzg==
X-Google-Smtp-Source: APXvYqz2Mx7aXRaQfmtaL0LPd92iDwHneKP/GOfS4eIiUNPypejgOu/LBU4i/PggPEmy6rtGohURIxh38vDy0PyyLbQ=
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr18947501qtj.176.1560974958605;
 Wed, 19 Jun 2019 13:09:18 -0700 (PDT)
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
In-Reply-To: <CAGETcx-ZZRc_jtBws2cFTe1wjiWeBowdqfqOhcCJV_7AUyBEVw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 16:09:07 -0400
Message-ID: <CAJWu+ooaDBCF06QAeddFig5myfUABd6qebJ14nd6pKaBwQq8MA@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 3:59 PM 'Saravana Kannan' via kernel-team
<kernel-team@android.com> wrote:
>
>
>
> On Wed, Jun 19, 2019, 11:55 AM 'Joel Fernandes' via kernel-team <kernel-team@android.com> wrote:
>>
>> On Wed, Jun 19, 2019 at 2:35 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > On Wed, Jun 19, 2019 at 02:01:36PM -0400, Joel Fernandes wrote:
>> > > On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
>> > > <gregkh@linuxfoundation.org> wrote:
>> > > >
>> > > > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
>> > > > > > It is conceivable to have a "wakeup_sources" directory under
>> > > > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
>> > > > >
>> > > > > One of the "issues" with this is, now if you have say 100 wake up
>> > > > > sources, with 10 entries each, then we're talking about a 1000 sysfs
>> > > > > files. Each one has to be opened, and read individually. This adds
>> > > > > overhead and it is more convenient to read from a single file. The
>> > > > > problem is this single file is not ABI. So the question I guess is,
>> > > > > how do we solve this in both an ABI friendly way while keeping the
>> > > > > overhead low.
>> > > >
>> > > > How much overhead?  Have you measured it, reading from virtual files is
>> > > > fast :)
>> > >
>> > > I measured, and it is definitely not free. If you create and read a
>> > > 1000 files and just return a string back, it can take up to 11-13
>> > > milliseconds (did not lock CPU frequencies, was just looking for
>> > > average ball park). This is assuming that the counter reading is just
>> > > doing that, and nothing else is being done to return the sysfs data
>> > > which is probably not always true in practice.
>> > >
>> > > Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
>> > > CPU scheduling competion reading sysfs can hurt the deadline. There's
>> > > also the question of power - we definitely have spent time in the past
>> > > optimizing other virtual files such as /proc/pid/smaps for this reason
>> > > where it spent lots of CPU time.
>> >
>> > smaps was "odd", but that was done after measurements were actually made
>> > to prove it was needed.  That hasn't happened yet :)
>> >
>> > And is there a reason you have to do this every 16ms?
>>
>> Not every, I was just saying whenever it happens and a frame delivery
>> deadline is missed, then a frame drop can occur which can result in a
>> poor user experience.
>
>
> But this is not done in the UI thread context. So some thread running for more than 16ms shouldn't cause a frame drop. If it does, we have bigger problems.
>

Not really. That depends on the priority of the other thread and other
things. It can obviously time share the same CPU as the UI thread if
it is not configured correctly. Even with CFS it can reduce the time
consumed by other "real-time" CFS threads. I am not sure what you are
proposing, there are also (obviously) power issues with things running
for long times pointlessly. We should try to do better if we can. As
Greg said, some study/research can be done on the use case before
settling for a solution (sysfs or other).
