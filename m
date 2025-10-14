Return-Path: <linux-pm+bounces-36095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E5BDB195
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6CA3AE3AC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664C2D12EB;
	Tue, 14 Oct 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sNTtud1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3E2AE8E;
	Tue, 14 Oct 2025 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471045; cv=none; b=kGo7VwL1UecdbLGthxnjG9wNA4j8/nknbZQfDAPQwWma/xhLTQ4x9RcY2q4ihKcZ1rZLECt39de/1LzHmElBtOgatFeEhHrDwkWiBvrAiqPj6dNXFtulUtNYXT+gVvHWlT7qoGNfbED329rB57yhtZgZt4UAc6EL534hVXmSD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471045; c=relaxed/simple;
	bh=cXLhn0KRi6eyniZHa7VdFKl4UuLpG0p2jDwlx3Mrhoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrIGZPF4wvDImXrttMNLOpmUpDY+uWrFCxHf9AVHwP2MquKRqCuJ/GIoEq8yRcnqMPxvh58a23u708yRyirLFFWGE7gumyz2uS2yLLwGlCA2b73tatpDy98LNkyBzC+k3sV4UEHNNwQJhz7ir4GIJp6gllllY/259gEKhGoLLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sNTtud1P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1nE8cw5D6Mb0CxVyjs/vhyBUM+L8uBybSwi4xPX2yhE=; b=sNTtud1PY06YDon22UOTwM0MPW
	hxtghFrEDdjV1qSkSFvH5Xl10JJWv1t4zZlwGn5Y7la+ffkxPrXJ+0kA/BuIGjJ1TSb1usMUsZene
	XcaPydPfIWLIpXVgDjB0qz4EQLxY4Kj3/TlxvXxgvTKZTq3MfesqXfBfB7ujs4rrEIUsjlOljsyHf
	WjGvfPbQHLsEpaHYsOvtJoetvsrDe8TSFvasiLdzQ265qShrApLZvIMteg0biaSclXolhBKjmuvny
	r4bks+2UAaS4xDDhhVDvMP5e+5/jcPij0ufR05vGtr0G3DpJlgUVgL3o6SkQIaTpSUnC6711LWgLR
	M9ufNyUA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8kw1-0000000Gw4S-0KIH;
	Tue, 14 Oct 2025 19:43:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5498300212; Tue, 14 Oct 2025 21:43:49 +0200 (CEST)
Date: Tue, 14 Oct 2025 21:43:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
Message-ID: <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
 <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>

On Tue, Oct 14, 2025 at 01:55:47PM -0400, Joel Fernandes wrote:
> 
> 
> On 10/14/2025 6:48 AM, Peter Zijlstra wrote:
> > On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
> > 
> >>  #define __nmi_enter()						\
> >>  	do {							\
> >>  		lockdep_off();					\
> >>  		arch_nmi_enter();				\
> >> -		BUG_ON(in_nmi() == NMI_MASK);			\
> >> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> >> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
> >> +		__this_cpu_inc(nmi_nesting);			\
> > 
> > An NMI that nests from here..
> > 
> >> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> >> +		if (__this_cpu_read(nmi_nesting) == 1)		\
> > 
> > .. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.
> 
> This is true, I can cure it by setting NMI_OFFSET unconditionally when
> nmi_nesting >= 1. Then the outer most NMI will then reset it. I think that will
> work. Do you see any other issue with doing so?

unconditionally set NMI_FFSET, regardless of nmi_nesting
and only clear on exit when nmi_nesting == 0.

Notably, when you use u64 __preempt_count, you can limit this to 32bit
only. The NMI nesting can happen in the single instruction window
between ADD and ADC. But on 64bit you don't have that gap and so don't
need to fix it.

