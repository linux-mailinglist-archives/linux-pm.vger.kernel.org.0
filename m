Return-Path: <linux-pm+bounces-17563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FE9C896A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D498C2822D2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403251F8EEE;
	Thu, 14 Nov 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lc/iuUkB"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2EE1F891E;
	Thu, 14 Nov 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585801; cv=none; b=eEAXsatJUXCArkrlPxKjDJBwzGaNmTocOdJ1Oz3j99GzKEfyiNk23SlKnf52TMxt9WcP0VVXbQAqmYvPv+ZYU9BXpKQAm92EdRYinvTww17+gwMBoPFeXOnNQJMs9zmHJ53WRgjiMUAtIAGhOd9g8PLWxECML9XegzgKeqLodfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585801; c=relaxed/simple;
	bh=55j1lK+jj9pXxJatK8ezo7wSn74isLbzYBFTCu+VRtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFUU3oDB6cunfsHBOJtt74lbvIcAzRAPkddRL3YvZ8Jkd4cPRXj13oYj5SAH5WqfxF2qesuPu6AwGqO3B+lMcHJkoZ/2wR1XRqlvWOZJ6ViT6Rcc1okz17/ajyxTOLrf5opHGJRtfkmRzTtdWWJN+FjyO2XJ8ltP92vz8nUXn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lc/iuUkB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=enMm5XnKWK6twGKM9ijv9Tbp9O3QtMU/SVSExjaO4MM=; b=Lc/iuUkBUeae+OPlFTm5YkiO0y
	lw0Xi1VZhYNgrr1rD7sSykWOlv0pYKi6AA6HI87h6v10AGsHYMlhZOk0pQ7XOYwfcGlRdnP9o5xLq
	VT0TbDWzukHTkOso8ACKD9wGKpqrSf6dmT7xrLE1mb4S1ayczxvOAesX19ZEUdIWBUwJjMIr3fRhn
	ulkEOKeFckqHD2fcjZ0Kg56Ljv/e3jJxmuE1DCCCed8Y3hjZhRcnTJtj82gpoTzRclbODo5jGXePj
	u1U6f/W4EJ0vi5UoeHHoCnscago9U5cJkTeKxaC4e4E1Z0dqY7sH5uARRI3fHZ+UiE16eRi7myqgC
	p1FfcW1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYZA-00000000h0X-2X4L;
	Thu, 14 Nov 2024 12:03:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F27F5300472; Thu, 14 Nov 2024 13:03:15 +0100 (CET)
Date: Thu, 14 Nov 2024 13:03:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241114120315.GG38972@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
 <20241112140127.GH6497@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112140127.GH6497@noisy.programming.kicks-ass.net>

On Tue, Nov 12, 2024 at 03:01:27PM +0100, Peter Zijlstra wrote:

> No, not mwait hint. We need an instruction that:
> 
>  - goes to deepest C state
>  - drops into WAIT-for-Start-IPI (SIPI)
> 
> Notably, it should not wake from:
> 
>  - random memory writes
>  - NMI, MCE, SMI and other such non-maskable thingies
>  - anything else -- the memory pointed to by RIP might no longer exist
> 
> Lets call the instruction: DEAD.

So, turns out that when you send INIT to an AP it does the whole drop
into Wait-for-SIPI and ignore non-maskable crap.

The reason we don't do that is because INIT to CPU0 (BP) is somewhat
fatal, but since Thomas killed all that CPU0 hotplug crap, I think we
can actually go do that.

