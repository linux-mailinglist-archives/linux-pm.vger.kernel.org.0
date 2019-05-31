Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700D13117A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEaPlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaPlX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 May 2019 11:41:23 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88326218D1;
        Fri, 31 May 2019 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559317283;
        bh=BxGnRRyjsJ2ho3R155gccJhBEQUfHmioJfLv8ziidDU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MQ71Jgjq0+N+7J+4gRi7i6TKqN9b2w1EPDyf8QSzCgcpqDVvqe3Tsm+BSszQGMPPn
         /ftq/7Jo0p/gIRQTHJ3DS4pK5LmXCLzMJcphtO12dKq/Nin7SsZKYoOTNVD/JL1oMs
         YU64CS6nEtiunbTg0imU8NUzfcqrVHB0ixPAjsOE=
Date:   Fri, 31 May 2019 17:41:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Andy Lutomirski <luto@amacapital.net>,
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
In-Reply-To: <20190531152626.4nmyc7lj6mjwuo2v@treble>
Message-ID: <nycvar.YFH.7.76.1905311739510.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net> <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm> <20190531152626.4nmyc7lj6mjwuo2v@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 May 2019, Josh Poimboeuf wrote:

> The only question I'd have is if we have data on the power savings 
> difference between hlt and mwait.  mwait seems to wake up on a lot of 
> different conditions which might negate its deeper sleep state.

hlt wakes up on basically the same set of events, but has the 
auto-restarting semantics on some of them (especially SMM). So the wakeup 
frequency itself shouldn't really contribute to power consumption 
difference; it's the C-state that mwait allows CPU to enter.

Thanks,

-- 
Jiri Kosina
SUSE Labs

