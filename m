Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1E26C063
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIPJXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 05:23:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIPJXN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Sep 2020 05:23:13 -0400
Received: from zn.tnic (p200300ec2f0c3e00d3c4597872eea104.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:d3c4:5978:72ee:a104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD7101EC03C9;
        Wed, 16 Sep 2020 11:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600248190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3TeVrXwZQcowPr3JVdy9o1Dg4I+EinWtvHyXdySMq5s=;
        b=Kw93KpWs1gavg5TpBawH9nRHEqEKgAyDnCI7ur5keketPJHiZyjLnweVmZLFtYEX7i+I0v
        FQjuTAh3wqRducl/P6hb2EaVVojrm6jDTgS4Xp9T82NbEPe1X/HsCBxZC6cYCoZ5XMLM2d
        IuXHfNpelWMVE2wgly9Ch15LsMjVL/k=
Date:   Wed, 16 Sep 2020 11:23:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
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
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200916092302.GC2643@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
 <20200915182530.GV14436@zn.tnic>
 <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
 <20200915202034.GZ14436@zn.tnic>
 <CAKwvOdmmXEu40m9bVL9zY5XyBRs2f15cs3FZQLCCh4u3i07pDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmmXEu40m9bVL9zY5XyBRs2f15cs3FZQLCCh4u3i07pDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 02:49:40PM -0700, Nick Desaulniers wrote:
> 1. they don't pay me enough for that.

They probably should - you're doing it anyway and it's not like they
have a shortage of cash. :-P

> 2. even if they did, I wouldn't want that responsibility

Too late, my friend. :-)

> 3. I'm probably least qualified for that.  Google has many strong
> upstream contributors with much longer contribution history than
> myself.  Maybe toolchain specific stuff though...

Sure, toolchain only, if you prefer. And others can take care of other
areas. And yes, those people should have some time allocated only to
upstream development. I think that's only fair...

> 4. you generally don't want people like that in any organization.
> More gatekeepers winds up being a synchronization/contention point.
> Remember, the goal is to train others to be self sufficient, so you
> can drink margaritas on the roof.  That suggestion goes against the
> ultimate goal.

Sure, but there's the community and we want to support that. Business
interest pays the bills but without the community to thrive around it,
it is just another crap software.

> 5. You'd think a multi-billion-dollar per quarter company could hire a
> few more people to help; instead stock buybacks are more attractive I
> guess?  Maybe better ROI? I suspect one too many managers
> internalized the Mythical Man Month's point about "adding more people
> to a late software project just makes it later" to mean "starve your
> projects for resources" and run a ghost-ship (ie. big boat, with
> little to no deck hands to ensure the boat doesn't "Costa Concordia"
> (noun-as-a-verb...oh well)).

LOL. And true. My experience with managers is that they have no clue
about how the open source community works. It is always the egotistic
and omnipresent take take take and little or no give.

> To be fair, hiring has been impacted by COVID; my point is more so
> being stretched incredibly thin. There's been what, 3 Clang related
> kernel bugs you and I have been CC'ed on today. Hard to fix compiler
> bugs AND triage from the fire hose. I should probably just put down
> LKML for today and start fixing the [haunted][damned] compiler.

Oh, welcome to drinking from the firehose. This never stops. Ever! So
yeah, even if you can hire more maintainers, there's always bottlenecks.

> That's a rule for stable, yes.  But also because we have folks that
> don't seem to understand (moreso maybe haven't considered) that
> "forking is not free" when upstream moves faster than you and you'd
> also like to rebase someday; as such acquiring technical debt at a
> rate that's impossible to pay off.

I guess you need an upstreaming team which takes over technology
produced by other projects - as those projects cannot slow down to
adapt to the upstream pace - so they give the code to the upstreaming
team after the project is done and they add it to the mainline kernel
eventually. I think that would make a lot of sense for *everybody*
involved.

> I guess you're paying for beers then.  "Android Common Kernels" run
> mainline.  (They're a bit esoteric in terms of "production" but
> cuttlefish virtual devices are running Android on mainline).

Only half of the beers - this "production" is a stretch - I mean
infrastructure machines, not some funky toys. And *virtual* at that. :-)

> Martin has patches for that, he has CC'ed me when sending them
> upstream for review.  Review was stalled, so I provided some feedback.
> I'll review a GCC patch (once it's updated with my previous feedback)
> if I have to; I'm not against it. w/e so long as we have a timeline
> for a kernel fix.

That's good. I guess it'll get there eventually. We'll still hold on
to that fix for years, for those gccs which don't have the function
attribute. Which is yet another reason for my aversion against compiler
workarounds.

> I CC'ed Martin on the LLVM bug, since this is a case I'm looking for
> his input on, or at least for him to be aware of the test case.

Cool.

> I look forward to it.

Ditto.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
