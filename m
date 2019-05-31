Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDB31141
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEaP0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaP0m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 11:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BD09307D9D0;
        Fri, 31 May 2019 15:26:36 +0000 (UTC)
Received: from treble (ovpn-124-142.rdu2.redhat.com [10.10.124.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6A95DE84;
        Fri, 31 May 2019 15:26:28 +0000 (UTC)
Date:   Fri, 31 May 2019 10:26:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190531152626.4nmyc7lj6mjwuo2v@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <20190531051456.fzkvn62qlkf6wqra@treble>
 <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm>
 <5564116.e9OFvgDRbB@kreacher>
 <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
 <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net>
 <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 31 May 2019 15:26:41 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 04:54:20PM +0200, Jiri Kosina wrote:
> On Fri, 31 May 2019, Andy Lutomirski wrote:
> 
> > For that matter, what actually happens if we get an SMI while halted?  
> > Does RSM go directly to sleep or does it re-fetch the HLT?
> 
> Our mails just crossed, I replied to Josh's mwait() proposal patch a 
> minute ago.

Good catch.  I agree that mwait seems unsafe across resume and my patch
is bogus.

Andy, in the short term it sounds like you're proposing to make
native_play_dead() use hlt_play_dead() unconditionally.  Right?

That would simplify things and also would fix Jiri's bug I think.  The
only question I'd have is if we have data on the power savings
difference between hlt and mwait.  mwait seems to wake up on a lot of
different conditions which might negate its deeper sleep state.

Andy, for your long term idea to use INIT IPI, I wonder if that would
work with SMT siblings?  Specifically I wonder about the Intel issue
that requires siblings to have CR4.MCE set.

-- 
Josh
