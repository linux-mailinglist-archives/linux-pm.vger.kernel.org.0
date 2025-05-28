Return-Path: <linux-pm+bounces-27744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20945AC6D7C
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F81A168354
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BA28C011;
	Wed, 28 May 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRhyVEya"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1234244670;
	Wed, 28 May 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448331; cv=none; b=qjMG5YNxS4sD4R99YagF1DS401evkXmYD1Yu/4oujVGm69Z6X7CS7wTdkE0ZBWivqa0brEU8yyGMBwvWDTpeitcgv6LmeYznKc//uwwU8gnCuC2Sr23LsfboyQq4hXQiyL+Am7iEbNJa8+kXNn4Roriz9fU2PIeURW2zT8HIu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448331; c=relaxed/simple;
	bh=iN66LX31eETjv33P4suFvIHOxzRjRyd7W6pMLndTMzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzszWUcnNFN5aJqOTEGryOUDh2I/C50rtJep9xiZ/GQqf7AEUbRz/G+CTXpD48bbq94eGA4/1Gs/d/1OCItvP8kXOAK1JBVarpGrB785307d+E4IY69RKr1/19sD8NmXk3hVu7ZOw/jdzieniNFE+XLHj9XVtrZMaCmJ/WARRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QRhyVEya; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+DHCZse1DSsGRv64acL++yjtliJ9RC7E53xqlL/i0E4=; b=QRhyVEya/Kyx7XVjlP806y5ZZ6
	O5wfe0vQ5BwtOl46ZG9IMAg+JoCkBi7vrrYnN2gFmg9QxxiAPhM4WBXjKfpZiABWdqtN+oV+LYS3g
	nR98+V21vDdA5W1LSKCA89Tdsv+LomvjrKX13b6TCBZi+X/79jvAIJB8sijgoPNHY/41rBf+JD6t+
	jXWo4wM15RUdIDcue/YohT1RZvTJZrBf2fG/Fb77TM7Mt2O12E2cN1sU1Dvm0JXw5JORqtaDIPqxp
	XnQ2r9a0R473o3LAz0QuDeWkPEFRB14RP76PQFoCMHdWEdufpAJRt11h9Yh549vEaG957oWjn6+oj
	H6UPZVdw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKJHQ-0000000DpAN-1XZ6;
	Wed, 28 May 2025 16:05:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7D5F3005AF; Wed, 28 May 2025 18:05:23 +0200 (CEST)
Date: Wed, 28 May 2025 18:05:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	x86 Maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by
 commit 96040f7273e2
Message-ID: <20250528160523.GE39944@noisy.programming.kicks-ass.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
 <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>

On Wed, May 28, 2025 at 04:25:19PM +0200, Rafael J. Wysocki wrote:

> If cpuidle is available and works, it will do the same thing.

Why can't we make it available sooner? But no, cpuidle does not do the
same thing -- it was argued it does the right thing because it has them
tables with C states on and doesn't try and divinate from CPUID.

> > The whole point was that mwait_play_dead did not DTRT because hints are
> > stupid and it could not select the deepest C state in an unambiguous
> > fashion.
> 
> Yes, on some systems.

The 'on some systems' thing is irrelevant. Either it always works, or it
doesn't and we shouldnt be having it.

> > And now you're restoring that -- code you all argued was fundamentally
> > buggered.
> >
> > Yes is 'fixes' things on old platforms, but it is equally broken on the
> > new platforms where you all argued it was broken on. So either way
> > around you're going to need to fix those, and this isn't it.

> The commit reverted by the first patch removed
> mwait_play_dead_cpuid_hint() altogether, so it never runs and the only
> fallback is hlt_play_dead(), but this doesn't work for disabling SMT
> siblings.

It should either be fixed to always work or stay dead.

> > Now, SMT siblings are all AP, by definition. So can't we simply send
> > them INIT instead of doing CLI;HLT, that way they drop into
> > Wait-for-SIPI and the ucode can sort it out?
> 
> No, I don't think so.  I don't think that Wait-for-SIPI is an idle state.
> 
> But we are discussing patch [2/2] here while really the problem is
> that the commit in question is broken, so it needs to be reverted in
> the first place.

No, you all very much argued that mwait_play_dead couldn't be fixed, as
such it must die and stay dead. Sometimes working is worse than never
working.

So no, I very much object to the revert.

