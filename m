Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105EB3146D
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 20:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEaSLh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 14:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfEaSLg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 14:11:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7588A3086228;
        Fri, 31 May 2019 18:11:36 +0000 (UTC)
Received: from treble (ovpn-124-142.rdu2.redhat.com [10.10.124.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7CA31017E30;
        Fri, 31 May 2019 18:11:32 +0000 (UTC)
Date:   Fri, 31 May 2019 13:11:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190531181130.afwizqcwibm5dmml@treble>
References: <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher>
 <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
 <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
 <20190531152626.4nmyc7lj6mjwuo2v@treble>
 <nycvar.YFH.7.76.1905311739510.1962@cbobk.fhfr.pm>
 <20190531161952.dps3grwg4ytrpuqw@treble>
 <CALCETrXFx4eV5ajMxOeM2UN=Ss9h3sGRLpd_4t33VAMXyPODiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXFx4eV5ajMxOeM2UN=Ss9h3sGRLpd_4t33VAMXyPODiw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 31 May 2019 18:11:36 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 09:51:09AM -0700, Andy Lutomirski wrote:
> Just to clarify what I was thinking, it seems like soft-offlining a
> CPU and resuming a kernel have fundamentally different requirements.
> To soft-offline a CPU, we want to get power consumption as low as
> possible and make sure that MCE won't kill the system.  It's okay for
> the CPU to occasionally execute some code.  For resume, what we're
> really doing is trying to hand control of all CPUs from kernel A to
> kernel B.  There are two basic ways to hand off control of a given
> CPU: we can jump (with JMP, RET, horrible self-modifying code, etc)
> from one kernel to the other, or we can attempt to make a given CPU
> stop executing code from either kernel at all and then forcibly wrench
> control of it in kernel B.  Either approach seems okay, but the latter
> approach depends on getting the CPU to reliably stop executing code.
> We don't care about power consumption for resume, and I'm not even
> convinced that we need to be able to survive an MCE that happens while
> we're resuming, although surviving MCE would be nice.

I'd thought you were proposing a global improvement: we get rid of
mwait_play_dead() everywhere, i.e. all the time, not just for the resume
path.

Instead it sounds like you were proposing a local improvement to the
resume path, to continue doing what
hibernate_resume_nonboot_cpu_disable() is already doing, but use an INIT
IPI instead of HLT to make sure the CPU is completely dead.

That may be a theoretical improvement but we'd still need to do the
whole "wake and play dead" dance which Jiri's patch is doing for offline
CPUs.  So Jiri's patch looks ok to me.

-- 
Josh
