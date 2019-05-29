Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3F2E2FC
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2RPk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 13:15:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2RPk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 13:15:40 -0400
Received: from [207.225.69.115] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hW2Aa-0001c2-BS; Wed, 29 May 2019 19:15:20 +0200
Date:   Wed, 29 May 2019 10:15:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190529170048.GD2623@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1905291006540.24611@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm> <20190529161028.a6kpywzpjazgql5u@treble> <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
 <20190529170048.GD2623@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 06:26:59PM +0200, Jiri Kosina wrote:
> > On Wed, 29 May 2019, Josh Poimboeuf wrote:
> 
> > > Is there are reason why maxcpus= doesn't do the CR4.MCE booted_once
> > > dance?
> > 
> > I am not sure whether it's really needed. My understanding is that the MCE 
> > issue happens only after primary sibling has been brought up; if that 
> > never happened, MCE wouldn't be broadcasted to that core at all in the 
> > first place.
> > 
> > But this needs to be confirmed by Intel.
> 
> (I'm not confirming anything, as I've no clue), but that code stems from
> long before we found out about that brilliant MCE stuff (which was
> fairly recent).

Actually we knew about the brilliant MCE wreckage for a long time and
maxcpus was always considered to be a debug/testing bandaid and not to be
used for anything serious used in production.

Of course 'nosmt' changed that because that is aimed at production
scenarios so we were forced to deal with that 'feature'.

We could do the same thing with 'maxcpus' now that we have all the
mechanisms there at our fingertips already, but I'd rather not do it.

Thanks,

	tglx

