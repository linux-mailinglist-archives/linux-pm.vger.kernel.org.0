Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F832D68
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfFCKDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 06:03:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfFCKDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 06:03:52 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 87ce1feb74287f01; Mon, 3 Jun 2019 12:03:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during resume
Date:   Mon, 03 Jun 2019 12:03:49 +0200
Message-ID: <2718594.dmOzsuS6R2@kreacher>
In-Reply-To: <20190531161952.dps3grwg4ytrpuqw@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905311739510.1962@cbobk.fhfr.pm> <20190531161952.dps3grwg4ytrpuqw@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 31, 2019 6:19:52 PM CEST Josh Poimboeuf wrote:
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

OK, the v4 queued up then, thanks!



