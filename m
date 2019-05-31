Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925DB31308
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEaQvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 12:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaQvX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 12:51:23 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A39026C84
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559321482;
        bh=BT2rWzXi62oKFaPqb3HSutdmVFL9XTsT6SBXBhkv8gc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I7BdUEm+hjcpnDjsG+GYN2Nyfi5D2eKdobP3NLAABX8nTHcVTqbROJ7qTy2JlcW0b
         a/4FU28Bqnc4m+Hwh5KsHASekzIpOXCMVvjAEktbDhdu+JZ9+BqiLn83ZvfdN7CHGt
         qW6RoJ4XwgUebKMsJRS2taUtvR2t/2ivlFG+EviU=
Received: by mail-wm1-f43.google.com with SMTP id d17so6461777wmb.3
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 09:51:22 -0700 (PDT)
X-Gm-Message-State: APjAAAXX8lQyl2NjrNTYc9sXQMai89StVZTKs32qa9fGaGYkwXQ+nu5Q
        rU0DwRW5RH4cXAPPllRoWbk6+j7n7w6FtVUU910GbQ==
X-Google-Smtp-Source: APXvYqy22t6wXQHhuEqBn7zcdo5FpsE02deJ5D6fjJSyAfwJ3fAdojmAWRIl5f+9jtSYJ9ZYsOHYNdCgHHP/OK0g244=
X-Received: by 2002:a1c:6242:: with SMTP id w63mr1856759wmb.161.1559321480595;
 Fri, 31 May 2019 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm> <20190531152626.4nmyc7lj6mjwuo2v@treble>
 <nycvar.YFH.7.76.1905311739510.1962@cbobk.fhfr.pm> <20190531161952.dps3grwg4ytrpuqw@treble>
In-Reply-To: <20190531161952.dps3grwg4ytrpuqw@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 May 2019 09:51:09 -0700
X-Gmail-Original-Message-ID: <CALCETrXFx4eV5ajMxOeM2UN=Ss9h3sGRLpd_4t33VAMXyPODiw@mail.gmail.com>
Message-ID: <CALCETrXFx4eV5ajMxOeM2UN=Ss9h3sGRLpd_4t33VAMXyPODiw@mail.gmail.com>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 9:19 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 31, 2019 at 05:41:18PM +0200, Jiri Kosina wrote:
> > On Fri, 31 May 2019, Josh Poimboeuf wrote:
> >
> > > The only question I'd have is if we have data on the power savings
> > > difference between hlt and mwait.  mwait seems to wake up on a lot of
> > > different conditions which might negate its deeper sleep state.
> >
> > hlt wakes up on basically the same set of events, but has the
> > auto-restarting semantics on some of them (especially SMM). So the wakeup
> > frequency itself shouldn't really contribute to power consumption
> > difference; it's the C-state that mwait allows CPU to enter.
>
> Ok.  I reluctantly surrender :-)  For your v4:
>
>   Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> It works as a short term fix, but it's fragile, and it does feel like
> we're just adding more duct tape, as Andy said.
>

Just to clarify what I was thinking, it seems like soft-offlining a
CPU and resuming a kernel have fundamentally different requirements.
To soft-offline a CPU, we want to get power consumption as low as
possible and make sure that MCE won't kill the system.  It's okay for
the CPU to occasionally execute some code.  For resume, what we're
really doing is trying to hand control of all CPUs from kernel A to
kernel B.  There are two basic ways to hand off control of a given
CPU: we can jump (with JMP, RET, horrible self-modifying code, etc)
from one kernel to the other, or we can attempt to make a given CPU
stop executing code from either kernel at all and then forcibly wrench
control of it in kernel B.  Either approach seems okay, but the latter
approach depends on getting the CPU to reliably stop executing code.
We don't care about power consumption for resume, and I'm not even
convinced that we need to be able to survive an MCE that happens while
we're resuming, although surviving MCE would be nice.

So if we don't want to depend on nasty system details at all, we could
have the first kernel explicitly wake up all CPUs and hand them all
off to the new kernel, more or less the same way that we hand over
control of the BSP right now.  Or we can look for a way to tell all
the APs to stop executing kernel code, and the only architectural way
I know of to do that is to sent an INIT IPI (and then presumably
deassert INIT -- the SDM is a bit vague).

Or we could allocate a page, stick a GDT, a TSS, and a 1: hlt; jmp 1b
in it, turn off paging, and run that code.  And then somehow convince
the kernel we load not to touch that page until it finishes waking up
all CPUs.  This seems conceptually simple and very robust, but I'm not
sure it fits in with the way hibernation works right now at all.
