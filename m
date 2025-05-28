Return-Path: <linux-pm+bounces-27737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA63AC6AE4
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2877D1BC7B53
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D874420;
	Wed, 28 May 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="scTt5q38"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F9548EE;
	Wed, 28 May 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439955; cv=none; b=WnimeS+kbFsO4WnCtMxerkCTruznvBz0EEEtYSJXQuAwIOdm4yMZl54KMlNwrLGHdaZNbXstEcnmo2TsxL+t0QqtB+lJuUyvUIF1kCt19JdZ64xtCbD6UvL4BgUzAkTYq+7QEyMlv/PfggB8G2f0+SyladBo/jUjldzTudHDbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439955; c=relaxed/simple;
	bh=NhKDJGKersmYwYbpcpxHMhulBIGoduKgjFIZ/h9f4Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCEgospQB4bkgYCFNtaes4dWdzzphmVPGuvbqvWReomQoQrngOoyPLUZ9RvBDYAuP/dBIKPvqxhj7CQDv18RwVUQDA54BRtsMeFfbQLYVfnk3GdU++iucElUcoTe8lL0ZF/3EMsrMv+o2nIAtZ2OhdCM8oJ0sPwysYF1bXJCyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=scTt5q38; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RJTCnxK1El4r0A3ClIoA68ji0JX4Tz5IvIhvEj1UhXI=; b=scTt5q38Q6lSPhAtr0dXmNDhgM
	ypwqrkoRXPv+Wr1bHPWDqTleGFtWeH8JtWgbfSFW2jYuJXfFy31HjlTskC5j2MxDwzAF5bmkEok7M
	RvyRjS8LR45QPKIX7+qEZ0SeB70ER9Ka4tjMekrJQMvOJxgj7ARhL0X//KM+m3Ij3/vu3S8TdZVkQ
	NoU9mTK/gy0ewgbiQHpUP+7HfUV2Yz3cu+6YT6gtwEy7fQ0dZ7nOYGZAY+ozfohpc0UOxo3D+TKyW
	CCDc7GLIArvxmWTnFGpO9hxQB/u256zJLc9603181iKRgzrkzOletd86sPjCovJleSPuMf2dEy35W
	/xes/BuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKH6J-0000000DhDE-3k3S;
	Wed, 28 May 2025 13:45:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 791A9300263; Wed, 28 May 2025 15:38:07 +0200 (CEST)
Date: Wed, 28 May 2025 15:38:07 +0200
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
Message-ID: <20250528133807.GC39944@noisy.programming.kicks-ass.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
 <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>

On Wed, May 28, 2025 at 03:20:16PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 28, 2025 at 3:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 28, 2025 at 02:53:13PM +0200, Rafael J. Wysocki wrote:
> > > Hi Everyone,
> > >
> > > Commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
> > > that shipped in 6.15 introduced a nasty power regression on systems that
> > > start with "nosmt" in the kernel command line which prevents it from entering
> > > deep package idle states (for instance, PC10) later on.  Idle power, including
> > > power in suspend-to-idle, goes up significantly on those systems as a result.
> > >
> > > Address this by reverting commit 96040f7273e2 (patch [1/2]) and using a
> > > different approach, which is to retain mwait_play_dead_cpuid_hint() and
> > > still prefer it to hlt_play_dead() in case it is needed when cpuidle is
> > > not available, but prefer cpuidle_play_dead() to it by default (patch [2/2]).
> >
> > I don't understand. The revert says the reason it regresses is that it
> > goes into play_dead before cpuidle is initialized. The fix is then to
> > call cpuidle first.
> >
> > But if cpuidle isn't initialized yet, how does that fix anything?
> 
> The revert fixes the bug.

This is not what I asked.

> The other patch does what the reverted commit was supposed to be
> doing, but differently.

No, it does not.

The whole point was that mwait_play_dead did not DTRT because hints are
stupid and it could not select the deepest C state in an unambiguous
fashion.

And now you're restoring that -- code you all argued was fundamentally
buggered.

Yes is 'fixes' things on old platforms, but it is equally broken on the
new platforms where you all argued it was broken on. So either way
around you're going to need to fix those, and this isn't it.

Now, SMT siblings are all AP, by definition. So can't we simply send
them INIT instead of doing CLI;HLT, that way they drop into
Wait-for-SIPI and the ucode can sort it out?

