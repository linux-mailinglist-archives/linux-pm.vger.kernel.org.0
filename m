Return-Path: <linux-pm+bounces-17605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FF9CDC23
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0211F21040
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972081B218D;
	Fri, 15 Nov 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioKmH2PM"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF218F2DB;
	Fri, 15 Nov 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665245; cv=none; b=XgfxMUhkivTKflsyjQS/2YvPxyFCo2vZCgesKgJH6wVe0IlFpA1aLgALL5nLQ1ZmtEhpXRS763ixuPYdBBYdwsKOw0CDn3uRmQSxXPO6uTVse6uFhiciTkD3BQs1PLghoZfRlw1B93djZpY2Af/xjKWSeLDzPqI7Pb+uC6UAc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665245; c=relaxed/simple;
	bh=eR1elGuHTa+AuiFbSFwD/2uXQpuh7yQV1dHuSLoJgL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLU9RS/Wg+pn36vFHz52m6D4yfKStEpI24UU3Ea/zZ2scBEUrxryv8QCz+JV70K50vj2OAiN77RDZA83wB0OHbo7IxkzP4RAIxJ2FA6uHbMtD0ndKmPbYpkF5dUYIEqji9zt+f+S5Tg4PB7DLgNs2AQK6w4Q6rXJPOOqu+V9pBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ioKmH2PM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yy6mGqiTIOOkjx8B+/2J4ZI1bZZeEzPCqJytp3mW3+8=; b=ioKmH2PMrdZruKQihlgkZt3nZ0
	y63XPX+5Vrv31Q5QqFtAsKk1L0IVKlz5vpO/UUb6YE5wJRJzHVQj5WdXzafes0EdQ7qNu0Jaojnfq
	Cr3Gzdty41tyaR5qPxoAXEol5W+mhDCqcicw0P3Y9C/cQeXnczZou7i2qNlh1MoYrHsshXndyXguQ
	pWH+xF2VqUqKEGLCNGvXk9FYOAGOgbsctR6juYm6XCjGZmZSfgDyt3QsES5AuX8F5uKbNV6qHQZqx
	4XBKRKU1npxbvYTLH6+bDKuaM9ie+QVGhiXB1WhXj75zEhoarJHrC/4LIsu8Xv1vTVZitNvJccB5t
	OMVnduSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtEW-00000001DdI-0bgl;
	Fri, 15 Nov 2024 10:07:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBF3830066A; Fri, 15 Nov 2024 11:07:18 +0100 (CET)
Date: Fri, 15 Nov 2024 11:07:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241115100718.GY22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
 <20241112140127.GH6497@noisy.programming.kicks-ass.net>
 <20241114120315.GG38972@noisy.programming.kicks-ass.net>
 <871pzd1ecw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pzd1ecw.ffs@tglx>

On Fri, Nov 15, 2024 at 02:21:19AM +0100, Thomas Gleixner wrote:
> On Thu, Nov 14 2024 at 13:03, Peter Zijlstra wrote:
> > On Tue, Nov 12, 2024 at 03:01:27PM +0100, Peter Zijlstra wrote:
> >
> >> No, not mwait hint. We need an instruction that:
> >> 
> >>  - goes to deepest C state
> >>  - drops into WAIT-for-Start-IPI (SIPI)
> >> 
> >> Notably, it should not wake from:
> >> 
> >>  - random memory writes
> >>  - NMI, MCE, SMI and other such non-maskable thingies
> >>  - anything else -- the memory pointed to by RIP might no longer exist
> >> 
> >> Lets call the instruction: DEAD.
> >
> > So, turns out that when you send INIT to an AP it does the whole drop
> > into Wait-for-SIPI and ignore non-maskable crap.
> >
> > The reason we don't do that is because INIT to CPU0 (BP) is somewhat
> > fatal, but since Thomas killed all that CPU0 hotplug crap, I think we
> > can actually go do that.
> 
> Instead of playing dead or to kick out CPUs from whatever dead play
> routine they are in?
> 
> playimg dead is to stay because INIT will bring back the MCE broadcast
> problem, which we try to avoid by bringing SMT siblings up just to shut
> them down again by playing dead.
> 
> You need a MCE broadcast free system and/or some sensible BIOS bringup
> code for that to work...

Isn't INIT a better state to be in during kexec than HLT?

