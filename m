Return-Path: <linux-pm+bounces-27734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5ABAC6A2B
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDEC9E329D
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F9286889;
	Wed, 28 May 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyQhrn7j"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505123CB;
	Wed, 28 May 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438289; cv=none; b=iv8vbPE+6URVp+mL0sdWjZ0b3wBNhquIzsd55JgTLG5z22fEQpyxKEK/RKMnzbNFXOX27KfRfKlXrUYv71iFNo+JlqKDEIZC2l01pIyuVsb93jo5O7mNQqwdIB6BIAbZOXSkKwcSWyBscfXRHSHlSQ3yIhDYdLserpaTlACrbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438289; c=relaxed/simple;
	bh=JyQ/g7Kg5zGeYkYRJRGiz+qenkQhnkpuUKlYzzPl8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k10uxEPoW4O1DGTReVXmhqk2H7NJQUiLrzTLY/PqtDoCKVogPLnDC5hdp1IM4NePk0HAwPSA6zEjIgSUSxkG4Tu3SJFaX+xKf1GrUzN8l4eImPEG0NGTi+F/d1NVvJq6xLRg9jaYTNs7CCku47Kd1xhIaXPD3J7cBGgPDnVZYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EyQhrn7j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AVELsSfT+NEsd6GMqBswfz7jVJ/MdJvCvrkyarXhQCQ=; b=EyQhrn7jpycft0MeKIZGHyWnJS
	ibq1GqgdSdrU8tsQyawklHn+12vyeXjBzV6dery6l2SD8cOTNx5/oB1HNcGEL27lWhewnxWPye9Js
	nA79OsaIKp86WbLInP4ThC6poftelv6zYQUUzgfcoTLjXC6WNJkI5k9klFu3NHap01jEkk9HkQwIF
	1727Xlwu+i8z1/1hu9w0iIHPk1ptBXXpHj7GNzKXQip+nCN7GB54WuQaRC65UPCcEp8Yt9Cv/ibPp
	4gfdH+rM+/abnV9+WYPqErR8508sW8sjHs6pNJ4MCMF1J3d1B+PElS4/YArtLUsBm97tBYSup/C9n
	BerYQpKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKGfS-0000000DfhL-3vdd;
	Wed, 28 May 2025 13:18:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D91C9300155; Wed, 28 May 2025 15:17:59 +0200 (CEST)
Date: Wed, 28 May 2025 15:17:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by
 commit 96040f7273e2
Message-ID: <20250528131759.GA39944@noisy.programming.kicks-ass.net>
References: <2006806.PYKUYFuaPT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006806.PYKUYFuaPT@rjwysocki.net>

On Wed, May 28, 2025 at 02:53:13PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> Commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
> that shipped in 6.15 introduced a nasty power regression on systems that
> start with "nosmt" in the kernel command line which prevents it from entering
> deep package idle states (for instance, PC10) later on.  Idle power, including
> power in suspend-to-idle, goes up significantly on those systems as a result.
> 
> Address this by reverting commit 96040f7273e2 (patch [1/2]) and using a
> different approach, which is to retain mwait_play_dead_cpuid_hint() and
> still prefer it to hlt_play_dead() in case it is needed when cpuidle is
> not available, but prefer cpuidle_play_dead() to it by default (patch [2/2]).

I don't understand. The revert says the reason it regresses is that it
goes into play_dead before cpuidle is initialized. The fix is then to
call cpuidle first.

But if cpuidle isn't initialized yet, how does that fix anything?

