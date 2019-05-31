Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2942830AE0
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfEaI5U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 04:57:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55615 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfEaI5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 04:57:19 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 4045aae7eaa9fce0; Fri, 31 May 2019 10:57:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during resume
Date:   Fri, 31 May 2019 10:57:17 +0200
Message-ID: <5564116.e9OFvgDRbB@kreacher>
In-Reply-To: <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 31, 2019 10:47:21 AM CEST Jiri Kosina wrote:
> On Fri, 31 May 2019, Josh Poimboeuf wrote:
> 
> > > I disagree with that from the backwards compatibility point of view.
> > > 
> > > I personally am quite frequently using differnet combinations of 
> > > resumer/resumee kernels, and I've never been biten by it so far. I'd guess 
> > > I am not the only one.
> > > Fixmap sort of breaks that invariant.
> > 
> > Right now there is no backwards compatibility because nosmt resume is
> > already broken.
> 
> Yeah, well, but that's "only" for nosmt kernels at least.
> 
> > For "future" backwards compatibility we could just define a hard-coded 
> > reserved fixmap page address, adjacent to the vsyscall reserved address.
> > 
> > Something like this (not yet tested)?  Maybe we could also remove the
> > resume_play_dead() hack?
> 
> Does it also solve cpuidle case? I have no overview what all the cpuidle 
> drivers might be potentially doing in their ->enter_dead() callbacks. 
> Rafael?

There are just two of them, ACPI cpuidle and intel_idle, and they both should
be covered.

In any case, I think that this is the way to go here even though it may be somewhat
problematic to start with.

Cheers,
Rafael



