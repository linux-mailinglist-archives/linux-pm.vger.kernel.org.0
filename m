Return-Path: <linux-pm+bounces-27637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0ABAC3AD1
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 09:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F38173D3B
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3461DFD8B;
	Mon, 26 May 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EmOA5WEH"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADDEAE7;
	Mon, 26 May 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245277; cv=none; b=sbx71HWaHAtnLC9aGyJxKYAn6L6IH6gaLexIO+oezZyG6wcPIt4J9sMu0NZU/OcZ/3KD+vlVL4sFqt3i6hYx9R41foZsYfJFAjeiBI7H31VqLJr6EF5ZNyxd595q4rcMu0bK+O7RQfS5lc8XL7edlRSEpulGAY6opWvLZryhtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245277; c=relaxed/simple;
	bh=FgX5VP4Nr5JPgohwHg1gzZ/wBJraMjfjuAcUeaP3HpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNXGt+hfIlFqQcqcz/B1IUV3ZkJDHeU8IEsRGdMBwZB5d+GC70GngLBZZss2cJBGN2sxoW5HZ723y6HYU0MBvuoZuLjxrx4ApYiSYF971GojHpSkG/Jo4Pq7AIzMGUyJSxQ61IULCHyfqeFGswDPW1KpoE1SdSGYTLIA+5CrGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EmOA5WEH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6IowXKFCaW0eMmyZa1R4nxggZczUD7aPjyxTK5Xzgks=; b=EmOA5WEHQAR4NSmICKFVRQ5Hs9
	I927RE4s4drG/8sRtRZ4tLwv0FzPaTZfqFD63Ro0YKpiz1pFAP5TwxG7jg8/RFEKNt9p4X+lXYrBc
	iV8a/P2HitF9KuJXD1M+MXeI3RaU8/trFy3PKC4E7PkHUVUwWzeVqrz0oo4pJN9/6R1Ag0h3h3Vv1
	eARaHHh9mYNp+6Po2HWp1gdRPNdtq2T4M2IaJhVBxtENzWQHixE7YIQpU4W1i0uKkZTE1GbBRn8kc
	jaPgrORANK3ZO3FAR9XF6t3zLHEtxFaK/b0A15+RLhduDIPB4rLUTPcHuM8Uct2svad/ivw8TfKRX
	Gp6KVWWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJSSK-0000000B9Ce-072R;
	Mon, 26 May 2025 07:41:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6D545300472; Mon, 26 May 2025 09:41:07 +0200 (CEST)
Date: Mon, 26 May 2025 09:41:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org,
	hannes@cmpxchg.org, surenb@google.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250526074107.GP39944@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
 <20250523164914.GO39944@noisy.programming.kicks-ass.net>
 <20250523140935.556fdede@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523140935.556fdede@gandalf.local.home>

On Fri, May 23, 2025 at 02:09:35PM -0400, Steven Rostedt wrote:
> On Fri, 23 May 2025 18:49:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> > > 
> > > Due to the weird Makefile setup of sched the various files do not
> > > compile as stand alone units. The new generation of editors are trying
> > > to do just this -- mostly to offer fancy things like completions but
> > > also better syntax highlighting and code navigation.  
> > 
> > To be fair, by far the biggest help has turned out to be to get instant
> > compiler warning/fails while you type code. This has drastically reduced
> > the stupid typo, doesn't compile, try again cycle.
> > 
> > Code completion is 'cute' but I'm not really limited in typing speed,
> > getting pop-up function arguments while typing is useful.
> > 
> > The better code navigation is also very useful.
> 
> Is there an emacs extension? (I'm sure there is, I'm just too lazy to look ;-)

Google redirected me here: https://emacs-lsp.github.io/lsp-mode/page/lsp-clangd/

