Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1626E3103A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfEaOcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 10:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaOcB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 10:32:01 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A0526AA4;
        Fri, 31 May 2019 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559313121;
        bh=BJaq/gCxh2F9IzWlqp5lUeCK+g1V/HOJkpE9nZ5AYdw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dFv1PZB+n6hJGe+t4cqnp6mVtrYdBvkOqT/OVfG9dO3JxZk8GuQymNIIeWfcYKEEr
         V+Vay3NAquyI+exdd/LJCoi/TQ2JEuG6uSoT7FRuMeRkfHThGv7lpCVOwnfICZrVlP
         /OlQ3rUqKGcGKzn2hpqJzv9+HXkRpxX5+ygMSKls=
Date:   Fri, 31 May 2019 16:31:56 +0200 (CEST)
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
In-Reply-To: <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 May 2019, Andy Lutomirski wrote:

> 2. Put the CPU all the way to sleep by sending it an INIT IPI.
> 
> Version 2 seems very simple and robust.  Is there a reason we can't do
> it?  We obviously don't want to do it for normal offline because it
> might be a high-power state, but a cpu in the wait-for-SIPI state is
> not going to exit that state all by itself.
> 
> The patch to implement #2 should be short and sweet as long as we are
> careful to only put genuine APs to sleep like this.  The only downside
> I can see is that an new kernel resuming and old kernel that was
> booted with nosmt is going to waste power, but I don't think that's a
> showstopper.

Well, if *that* is not an issue, than the original 3-liner that just 
forces them to 'hlt' [1] would be good enough as well.

[1] https://lore.kernel.org/lkml/nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm/

Thanks,

-- 
Jiri Kosina
SUSE Labs

