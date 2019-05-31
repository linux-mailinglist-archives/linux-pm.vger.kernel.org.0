Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1722731018
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaOZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfEaOZK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 10:25:10 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F6E26A91
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559312709;
        bh=xuMjoe5EkMqnrBnt5MUNgIfNL6mvB94WhsCDAFAE2Qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vk5d/bOTWDIPFtmxhazofl2WKQckD1fwGoMDgkgb80Wde1p7rC9R61yxj9vBs76J7
         2RAa22GazhJvDyceEyZa0CQGamgmphP1BeSM5A5BlYNCUywni5lYUMJ0FXVZU2fq+R
         dx3vO40hdrDv/JN7QD5Iej6oz4aMg8rVZLnme7EE=
Received: by mail-wr1-f45.google.com with SMTP id n4so3612762wrs.3
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 07:25:09 -0700 (PDT)
X-Gm-Message-State: APjAAAX57SbcI/d7zIhWxk8iapzyHYDKlsA4Jm65kBxaL7cLUwpazXUE
        khgIEUzVe+Jse0KzwG2uZ/k0yPoWL6I/jq06dYkuQQ==
X-Google-Smtp-Source: APXvYqwFkqnsZ0FYt+7FEq+HOK5hJc0qmxlJZ5QPh+aCNExJkn5+yXhY+PXnZYbs4sZVZk1ZAqqffkdbreWf7yuO4HI=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr6479585wru.265.1559312707738;
 Fri, 31 May 2019 07:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher>
In-Reply-To: <5564116.e9OFvgDRbB@kreacher>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 May 2019 07:24:56 -0700
X-Gmail-Original-Message-ID: <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
Message-ID: <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 1:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, May 31, 2019 10:47:21 AM CEST Jiri Kosina wrote:
> > On Fri, 31 May 2019, Josh Poimboeuf wrote:
> >
> > > > I disagree with that from the backwards compatibility point of view.
> > > >
> > > > I personally am quite frequently using differnet combinations of
> > > > resumer/resumee kernels, and I've never been biten by it so far. I'd guess
> > > > I am not the only one.
> > > > Fixmap sort of breaks that invariant.
> > >
> > > Right now there is no backwards compatibility because nosmt resume is
> > > already broken.
> >
> > Yeah, well, but that's "only" for nosmt kernels at least.
> >
> > > For "future" backwards compatibility we could just define a hard-coded
> > > reserved fixmap page address, adjacent to the vsyscall reserved address.
> > >
> > > Something like this (not yet tested)?  Maybe we could also remove the
> > > resume_play_dead() hack?
> >
> > Does it also solve cpuidle case? I have no overview what all the cpuidle
> > drivers might be potentially doing in their ->enter_dead() callbacks.
> > Rafael?
>
> There are just two of them, ACPI cpuidle and intel_idle, and they both should
> be covered.
>
> In any case, I think that this is the way to go here even though it may be somewhat
> problematic to start with.
>

Given that there seems to be a genuine compatibility issue right now,
can we design an actual sane way to hand off control of all CPUs
rather than adding duct tape to an extremely fragile mechanism?  I can
think of at least two sensible solutions:

1. Have a self-contained "play dead for kexec/resume" function that
touches only few well-defined physical pages: a set of page tables and
a page of code.  Load CR3 to point to those page tables, fill in the
code with some form of infinite loop, and run it.  Or just turn off
paging entirely and run the infinite loop.  Have the kernel doing the
resuming inform the kernel being resumed of which pages these are, and
have the kernel being resumed take over all CPUs before reusing the
pages.

2. Put the CPU all the way to sleep by sending it an INIT IPI.

Version 2 seems very simple and robust.  Is there a reason we can't do
it?  We obviously don't want to do it for normal offline because it
might be a high-power state, but a cpu in the wait-for-SIPI state is
not going to exit that state all by itself.

The patch to implement #2 should be short and sweet as long as we are
careful to only put genuine APs to sleep like this.  The only downside
I can see is that an new kernel resuming and old kernel that was
booted with nosmt is going to waste power, but I don't think that's a
showstopper.
