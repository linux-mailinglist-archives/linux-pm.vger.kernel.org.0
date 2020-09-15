Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4143226B048
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIOWGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:06:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42914 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgIOUVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 16:21:21 -0400
Received: from zn.tnic (p200300ec2f0e42002ec71013b50744b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:2ec7:1013:b507:44b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A46AB1EC02B9;
        Tue, 15 Sep 2020 22:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600201240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m1zeLlW+IDog00PQVGph/rOz8zmBb7aC18qc50BuwbI=;
        b=KTtC5vZ7VLJvpMSdFhpGdy+qzsvIIE4abCCCEfXxgdbMRVmjGvteIOw0ic7X72Eq0CPbBI
        V+40Ui/aq4WvZ4cEu5KmgmlHUPtISYwqIDEj7dvFstGPbR7YFnA9S7Hbxx8i0uEjDNdcz3
        VTCmIFLK3LKpddDHeNNYyZSievhJXGE=
Date:   Tue, 15 Sep 2020 22:20:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     Roman Kiryanov <rkir@google.com>,
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915202034.GZ14436@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
 <20200915182530.GV14436@zn.tnic>
 <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 12:51:47PM -0700, Nick Desaulniers wrote:
> I agree; I also would not have sent the patch though.

Maybe google folks should run stuff by you before sending it up... :-)

> Until LTO has landed upstream, this is definitely somewhat self
> inflicted. This was only debugged last week; even with a compiler fix
> in hand today, it still takes time to ship that compiler and qualify
> it; for other folks on tighter timelines, I can understand why the
> patch was sent,

... because they have the requirement that a patch which gets backported
to a kernel used at google needs to be upstream? Because I'm willing to
bet a lot of cash that no one runs bleeding egde 5.9-rcX in production
over there right now :-)

> and do genuinely appreciate the effort to participate more upstream
> which I'm trying to encourage more of throughout the company (we're
> in a lot of technical debt kernel-wise; and I'm not referring to
> Android...a story over beers perhaps, or ask Greg).

Beers? Always. But I can imagine the reasons: people working on projects
and then those projects getting done and no one cares about upstreaming
stuff after the fact or no one has time ... or policy ... but let's keep
that for beers. :-)

> It's just that this isn't really appropriate since it works around
> a bug in a non-upstream feature, and will go away once we fix the
> toolchain.

Hohumm.

> It would be much nicer if we had the flexibility to disable stack
> protectors per function, rather than per translation unit.  I'm going
> to encourage you to encourage your favorite compile vendor ("write to
> your senator") to support the function attribute
> __attribute__((no_stack_protector)) so that one day,

I already forgot why gcc doesn't do that... Martin, do you know?

> we can use that to stop shipping crap like a9a3ed1eff360 ("x86: Fix
> early boot crash on gcc-10, third try"). Having had that, we could
> have used a nicer workaround until the toolchain was fixed (and one
> day revert a9a3ed1eff360, and d0a8d9378d16, and probably more hacks in
> the kernel).

Yap, agreed. I guess with those new compiler features it is always a
couple of releases - both kernel, i.e., the user of that feature, and
compiler, i.e., the provider of the feature, to both figure out what
the proper use cases are, to experiment a bit and then to adjust stuff,
change here and there and then cast in stone. Oh well.

> And the case that's causing the compiler bug in question is something
> all compiler vendors will need to consider in their implementations.

Are you talking to gcc folks about it already so that they DTRT too?

Btw, if it is any consolation, talking to compiler folks is like a charm
in comparison to talking to hardware vendors and trying to get them
to agree on something because they seem to think that the kernel is
software and sure, can be changed to do whatever. But that's another
story for the beers... :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
