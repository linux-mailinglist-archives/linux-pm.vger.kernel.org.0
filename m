Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E077362
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfGZVY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 17:24:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33234 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfGZVYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 17:24:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so49811652qtt.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owpXJzkwRhTQpFv3YFYd1YLSHkq3ebxH7N/mkMxT22w=;
        b=aMJ/j5Za4QMl8Pf2M7kaOR415fQRH6rbjYvIyS/i6JoHNO1516z0Q7L7CjFPJ7OSS1
         51Tf7qtTEW9o3QxpAl09Ian0zWGVtbbD0nG+Um3baSMk8x4ZwW46HfklJgWl9rFAmdxC
         wOIhrnvM2feyVB+D596KSvP2fwa183EZXUZsR09c5+V9awonePLsdUEd9pE+vVyhKSl4
         dLsxG2Cd86+m28G2I5cieWpy294e4O+naTmRX3y3ThmoJ7iWdyCdI1EvgPueMmA5RgwT
         sq/HsxDn/okq7PDtBIalb+vyn7ZR4elNjex9aOv4MTGiRGn9pQe0NeSPFFZAvApATh8c
         GZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owpXJzkwRhTQpFv3YFYd1YLSHkq3ebxH7N/mkMxT22w=;
        b=WtXmH2XDiM8UglTQhHix8lkFLmtxQ7ZodxsbbV3M2XwSq0Qm7DdwQ979nWeHF2gZ5+
         /jUBB0oIGyNRRguZ68y520o+uAy+UYCn7ewl8IcLk0f1GuO4/8brYAUWkm1FGM39e98u
         JqCeJfoXMxhRM2SvTRLfLPsOLeOgOcxTDgcBVHOrfSBLnXDUqeBw87T4v40JQp6MQeVR
         JueeMxNdEFP6EIaqL4cE5B6yWFOuqR/03rIiYdQkc2JWh1EBbR4RYgnoGXfKXSyvRFkY
         lYUtYlElp/ChjEEwDy5s1mbWrnV//igyftyjezPw+ajrxhrtXGee5YBVdREk7s4igPLG
         ss8Q==
X-Gm-Message-State: APjAAAV0Y3qiCk9Sm7IE11sXsxpTDjn5f5RCiOfh+a1K+iJQWnRFjWiH
        d1M7M31vQywnuTMp7qv4aT1HgwPy08CwnVFeRUgtbw==
X-Google-Smtp-Source: APXvYqwE2TYMffQJtT7kl52cvJrjGWqA9vEUfORVMtMAylZHsE47npdSnAmrQgan5ft+zsV9NfDaKeUFkLTLYLHvv0Q=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr70919945qvf.200.1564176258418;
 Fri, 26 Jul 2019 14:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7> <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
 <20190725030712.lx3cjogo5r7kc262@vireshk-i7> <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
 <20190725051742.mn54pi722txkpddg@vireshk-i7> <CAGETcx9yO7HCz-rvqRMQf6srN_9-O_wc1bb7HadL+4QxvuqyWA@mail.gmail.com>
In-Reply-To: <CAGETcx9yO7HCz-rvqRMQf6srN_9-O_wc1bb7HadL+4QxvuqyWA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Jul 2019 14:23:41 -0700
Message-ID: <CAGETcx9UAAc6u=qFPN49Pn2u4xiMCroL-PhHqLZrBPRSXBbHBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 25, 2019 at 6:52 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jul 24, 2019 at 10:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-07-19, 21:09, Saravana Kannan wrote:
> > > On Wed, Jul 24, 2019 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > We should be doing this whenever a new OPP table is created, and see
> > > > if someone else was waiting for this OPP table to come alive.
> > >
> > > Searching the global OPP table list seems a ton more wasteful than
> > > doing the lazy linking. I'd rather not do this.
> >
> > We can see how best to optimize that, but it will be done only once
> > while a new OPP table is created and putting stress there is the right
> > thing to do IMO. And doing anything like that in a place like
> > opp-set-rate is the worst one. It will be a bad choice by design if
> > you ask me and so I am very much against that.
> >
> > > > Also we
> > > > must make sure that we do this linking only if the new OPP table has
> > > > its own required-opps links fixed, otherwise delay further.
> > >
> > > This can be done. Although even without doing that, this patch is
> > > making things better by not failing silently like it does today? Can I
> > > do this later as a separate patch set series?
> >
> > I would like this to get fixed now in a proper way, there is no hurry
> > for a quick fix currently. No band-aids please.
> >
> > > > Even then I don't want to add these checks to those places. For the
> > > > opp-set-rate routine, add another flag to the OPP table which
> > > > indicates if we are ready to do dvfs or not and mark it true only
> > > > after the required-opps are all set.
> > >
> > > Honestly, this seems like extra memory and micro optimization without
> > > any data to back it.
> >
> > Again, opp-set-rate isn't supposed to do something like this. It
> > shouldn't handle initializations of things, that is broken design.
> >
> > > Show me data that checking all these table
> > > pointers is noticeably slower than what I'm doing. What's the max
> > > "required tables count" you've seen in upstream so far?
> >
> > Running anything extra (specially some initialization stuff) in
> > opp-set-rate is wrong as per me and as a Maintainer of the OPP core it
> > is my responsibility to not allow such things to happen.
>
> Doing operations lazily right before they are needed isn't something
> new in the kernel. It's done all over the place (VFP save/restore?).
> It's not worth arguing though -- so I'll agree to disagree but follow
> the Maintainer's preference.
>

I was taking a closer look at the OPP framework code to try and do
what you ask above, but it's kind of a mess. The whole "the same OPP
table can be used by multiple devices without the opp-shared flag set"
is effectively breaking "required-opps" at a minimum and probably a
lot more cases. I don't think I can rewrite my patch the way you want
it without fixing the existing bugs.

Let's take this example DT (leaving out the irrelevant part):

OPP table 1:
    required-opps = <OPP table 2 entry>;

OPP table 2:
    <opp-shared property not set>

Device A:
    operating-points-v2 = <&OPP table 1>

Device B:
    operating-points-v2 = <&OPP table 2>

Device C:
    operating-points-v2 = <&OPP table 2>

Let's say device B and C add their OPP tables. They both get their own
"in-memory" copy of the OPP table. They can then enabled/disable
different OPP entries (rows) and not affect each other's OPP table.
Which is how it's expected to work.

Now if device A adds its OPP table 1, the "in-memory"
required_opp_tables pointer of OPP table 1 can end up pointing to
either Device A's copy of the OPP table or Device B's copy of the OPP
table depending on which happens to be added first. This effectively
random linking of OPP tables is mutually exclusive to the point of
required-opps.

Also, at a DT definition level, OPP table 1 pointing to OPP table 2
when OPP table 2 is used by more than one device doesn't make any
sense. Which device/genpd is OPP table 1 saying it "requires to
operate at a certain level"?

So I propose that we should consider the OPP table DT configuration
invalid if one OPP table points to another OPP tables that's NOT
shared but is ALSO pointed to by multiple devices. Basically the
example above would be considered an invalid DT configuration. Does
that sound okay to you? If I make changes to enforce that, will that
be acceptable?

If this sounds okay to you, then in the example above, assume Device C
isn't present. Then when OPP table 1 is added by device A, if OPP
table 2 hasn't been added already, I can just go ahead and allocate
OPP table 2. And then when device B tries to add OPP table 2, I can
just tie device B to OPP table 2 and fill up any of the missing
pieces.

This sounds better than trying to loop through existing OPP tables and
seeing if any other table is waiting for the newly added table and
marking the waiting tables as "linked". Especially because it gets a
lot more complicated and inefficient when you consider a chain of OPP
tables and many-to-many linking of OPP tables.

-Saravana
