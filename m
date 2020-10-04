Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37457282A03
	for <lists+linux-pm@lfdr.de>; Sun,  4 Oct 2020 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgJDJ7t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sun, 4 Oct 2020 05:59:49 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDJ7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 05:59:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5CFD41C0B76; Sun,  4 Oct 2020 11:59:44 +0200 (CEST)
Date:   Sun, 4 Oct 2020 11:59:43 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Roman Kiryanov <rkir@google.com>
Cc:     Pavel Machek <pavel@denx.de>, Borislav Petkov <bp@alien8.de>,
        rjw@rjwysocki.net, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20201004095942.GD1104@bug>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic>
 <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
 <20200918222531.GD7443@duo.ucw.cz>
 <CAOGAQepVWwMvA_m_kZpwQ4UN+ziR+=w2auiL1euFyuGvyCU7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAOGAQepVWwMvA_m_kZpwQ4UN+ziR+=w2auiL1euFyuGvyCU7SQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > > > > I believe the kernel makes a questionable assumption on how clang
> > > > > uses registers (gs will not be used if stack protection is disabled).
> > > > > Both kernel and clang behaves unfortunate here.
> > > >
> > > > If the kernel is at fault here and this same thing happens with GCC,
> > > > sure, but this is a clang-specific fix.
> > >
> > > This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
> > > fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> > > (maybe some more registers) before "jmp restore_processor_state".
> >
> > That would certainly be nicer / more acceptable solution than patch
> > being proposed here.
> >
> > Code was written with assumption compiler random C code would not use
> > %gs. If that's no longer true, fixing it in wakeup_64.S _with comments
> > explaining what goes on_ might be solution.
> 
> I looked and restore_processor_state is referenced in several places,
> so changing
> wakeup_64.S is not enough. Is moving the beginning of restore_processor_state
> to an .S file ok? I see restore_processor_state initializes CR registers first,
> do you know if there is a reason to do so (can I init segment
> registers before CR ones)?

Yes, moving to .S file should be okay.

CR first... makes sense to me, they really select how segment registers will be
interpretted, etc. If it will work the other way... not sure.

I'd keep existing code if I were you. This is tricky to debug.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
