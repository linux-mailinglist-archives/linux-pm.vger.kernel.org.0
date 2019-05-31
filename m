Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906863104E
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEaOd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfEaOd4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 10:33:56 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730B326AB4;
        Fri, 31 May 2019 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559313235;
        bh=1nBozZjo2hDOp1xXAXOBbApH4GiAlFWbKx6C42s2Cks=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PkxOkx58565Eq22i/BEn1YC29YYECsCDhoKy3ADpy8tiE60wXcfiYgCIIk+9ihLx4
         ydGw3fjzOieA1GAArshst6SzTAx5aoVVnxWdnrY0j/UDwm0unnfcJou5l/HbMpGtR1
         mwgDJ/P6xMrt84IqVzvkzUfweKpX6JaZniDThWJ8=
Date:   Fri, 31 May 2019 16:33:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
In-Reply-To: <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905311633310.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 May 2019, Jiri Kosina wrote:

> On Fri, 31 May 2019, Andy Lutomirski wrote:
> 
> > 2. Put the CPU all the way to sleep by sending it an INIT IPI.
> > 
> > Version 2 seems very simple and robust.  Is there a reason we can't do
> > it?  We obviously don't want to do it for normal offline because it
> > might be a high-power state, but a cpu in the wait-for-SIPI state is
> > not going to exit that state all by itself.
> > 
> > The patch to implement #2 should be short and sweet as long as we are
> > careful to only put genuine APs to sleep like this.  The only downside
> > I can see is that an new kernel resuming and old kernel that was
> > booted with nosmt is going to waste power, but I don't think that's a
> > showstopper.
> 
> Well, if *that* is not an issue, than the original 3-liner that just 
> forces them to 'hlt' [1] would be good enough as well.

Actually no, scratch that, I misunderstood your proposal, sorry.

-- 
Jiri Kosina
SUSE Labs

