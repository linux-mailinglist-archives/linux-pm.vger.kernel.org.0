Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8D26AFF1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgIOVvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgIOVty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:49:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29371C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:49:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z18so198136pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRpHw5zCBEIhYxwdkTdUPJPPtKwwg9WVoW0/dlXYOFU=;
        b=U2tjPWXOoaQZvfXCC/xDjl73VW3KlPBjDw0G8/0+99qDr1gTOXlYOv0Jdz321rbma7
         ORHpkjm+Yn18tZI9TzuQws7IUWw3eXPbETqjR6MoePsAyFDJ0FfOTLU6Asu4c6OQWw2t
         TG2rWc9SF6o2I8D55bxtMt2WAVhk6ZPRTMLL8jT9zGbtjqUu/WG850DsaJnqN5dVOxO/
         cYxXC6GDh94W1NuLcjjtua1FYsaurb7Evm1Z2752lxDUK3poyEw0ZutwNaWGFLxbGll3
         s06/rFWKxOYH4ZnDQZpy6N9Qqwy3lG9ATY2PKaNmOE0p6Ejt2CA+yfcL8NsHenfvjbdb
         gXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRpHw5zCBEIhYxwdkTdUPJPPtKwwg9WVoW0/dlXYOFU=;
        b=qbP6iuiPMXuFpqbXTdIGSZbLyrWxdo7aRB4QbA/mHPmtOjHaomECGapG0vVP9F9Njj
         OSGKMCbStOe8ZVEQCdA1CxuBIVnu/YWeELuFj0igZW5Ln6BJ+ETwb2ACU4Fx8x4/O/Nx
         Mf9o4BCaMwkms8hxuAY7yz12bm6QQSMuSRy9KxSMCuDWNw3mYUDGJpGswLDTjhp72TJ4
         U/rwB19gdg3WRT3W3NVjHniZ9dGPZnXgG02ePdmpvlv3/eV3ia3D+VYPtZG3ZD+nO/0O
         PpphTPpObi3eQD/tmojz1Yy+NSiLu4ZOy5Efn/MkrfSF6Gjb1Pl1vfE4bsLGhTUgHx7K
         ELsw==
X-Gm-Message-State: AOAM530OJOyAtErYMbWqiHA4HYNtcIBhiOXmG5/2s8tIn+owA2BPCOdD
        3Ckw6VduiwYrqVsmhFx41+U84hxzBmOdGeGSrFIcUA==
X-Google-Smtp-Source: ABdhPJxYUdP/+ZEn0ANnOVR2hOfK2Y2KqTaiOoe3ydR+wyKezAj/LWiQzFNxpWdxpQH7vyQDbl3Q9w2R5YWPGLrroDs=
X-Received: by 2002:a63:7882:: with SMTP id t124mr6423889pgc.381.1600206593276;
 Tue, 15 Sep 2020 14:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
 <20200915182530.GV14436@zn.tnic> <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
 <20200915202034.GZ14436@zn.tnic>
In-Reply-To: <20200915202034.GZ14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 14:49:40 -0700
Message-ID: <CAKwvOdmmXEu40m9bVL9zY5XyBRs2f15cs3FZQLCCh4u3i07pDA@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 1:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 12:51:47PM -0700, Nick Desaulniers wrote:
> > I agree; I also would not have sent the patch though.
>
> Maybe google folks should run stuff by you before sending it up... :-)

Ha!

1. they don't pay me enough for that.
2. even if they did, I wouldn't want that responsibility
3. I'm probably least qualified for that.  Google has many strong
upstream contributors with much longer contribution history than
myself.  Maybe toolchain specific stuff though...
4. you generally don't want people like that in any organization.
More gatekeepers winds up being a synchronization/contention point.
Remember, the goal is to train others to be self sufficient, so you
can drink margaritas on the roof.  That suggestion goes against the
ultimate goal.
5. You'd think a multi-billion-dollar per quarter company could hire a
few more people to help; instead stock buybacks are more attractive I
guess?  Maybe better ROI?  I suspect one too many managers
internalized the Mythical Man Month's point about "adding more people
to a late software project just makes it later" to mean "starve your
projects for resources" and run a ghost-ship (ie. big boat, with
little to no deck hands to ensure the boat doesn't "Costa Concordia"
(noun-as-a-verb...oh well)).  To be fair, hiring has been impacted by
COVID; my point is more so being stretched incredibly thin.  There's
been what, 3 Clang related kernel bugs you and I have been CC'ed on
today.  Hard to fix compiler bugs AND triage from the fire hose.  I
should probably just put down LKML for today and start fixing the
[haunted][damned] compiler.

>
> > Until LTO has landed upstream, this is definitely somewhat self
> > inflicted. This was only debugged last week; even with a compiler fix
> > in hand today, it still takes time to ship that compiler and qualify
> > it; for other folks on tighter timelines, I can understand why the
> > patch was sent,
>
> ... because they have the requirement that a patch which gets backported
> to a kernel used at google needs to be upstream?

That's a rule for stable, yes.  But also because we have folks that
don't seem to understand (moreso maybe haven't considered) that
"forking is not free" when upstream moves faster than you and you'd
also like to rebase someday; as such acquiring technical debt at a
rate that's impossible to pay off.

> Because I'm willing to
> bet a lot of cash that no one runs bleeding egde 5.9-rcX in production
> over there right now :-)

I guess you're paying for beers then.  "Android Common Kernels" run
mainline.  (They're a bit esoteric in terms of "production" but
cuttlefish virtual devices are running Android on mainline).

> > It would be much nicer if we had the flexibility to disable stack
> > protectors per function, rather than per translation unit.  I'm going
> > to encourage you to encourage your favorite compile vendor ("write to
> > your senator") to support the function attribute
> > __attribute__((no_stack_protector)) so that one day,
>
> I already forgot why gcc doesn't do that... Martin, do you know?

Martin has patches for that, he has CC'ed me when sending them
upstream for review.  Review was stalled, so I provided some feedback.
I'll review a GCC patch (once it's updated with my previous feedback)
if I have to; I'm not against it. w/e so long as we have a timeline
for a kernel fix.

> > And the case that's causing the compiler bug in question is something
> > all compiler vendors will need to consider in their implementations.
>
> Are you talking to gcc folks about it already so that they DTRT too?

I CC'ed Martin on the LLVM bug, since this is a case I'm looking for
his input on, or at least for him to be aware of the test case.

> Btw, if it is any consolation, talking to compiler folks is like a charm
> in comparison to talking to hardware vendors and trying to get them
> to agree on something because they seem to think that the kernel is
> software and sure, can be changed to do whatever. But that's another
> story for the beers... :-)

I look forward to it.
-- 
Thanks,
~Nick Desaulniers
