Return-Path: <linux-pm+bounces-36044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7EDBD82AA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D13B3144
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6AE30F925;
	Tue, 14 Oct 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOHaqeGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2F1A5B9D;
	Tue, 14 Oct 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430327; cv=none; b=gaUcJvTptybmTduKIKewyImboDDw6LQGom5rQCeO2hcil5qSCyn507LG3Se3QjoKFy/AVfPwMqCfv3F2ji/vO1tMG1jKAHquxW4xv6E/MF7NbOWxZsy+ydFh6TK1b93C5P0W/oaPeb2nB6TA5csswwP/unIGiTs1mJ/E9ByS3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430327; c=relaxed/simple;
	bh=Oi0ajjaYBL5gibdlh3zTqQ6DqbKpKPwrJ8y6TwvUO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHVvdRKHgX/VLF4ReiCm+Vt/aN2naqMiF5TzB2NJeaaeLO/ZKUkuwOF0Qp2Zninhk4C9b+ZtTp3LJ/mFFPk4G3ezuJJfNH+Ia4483mrISCchy6yEoAp9KNeak7zyOKF/zpW8p8E1MlwIOPXiZVdCWagGtOhaiw5wmFLe1aF/rag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iOHaqeGS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PoMkE0drhoxkBRiaU8xKzH/vd2BHx+rbYA+VLALgslc=; b=iOHaqeGSq0SzlI/U9aXjYdWlC0
	A9Xxfpx78nVmyCn2AovlkGm7QSS2jjmlyL6c5G3Hld7PODpnr0S7SRijWyUPFwAjd+0Ks/iiMclgL
	8ZtG4w+DDMVYOdA31xn10oSTMjJdPL9pGtO3abjJWhodnMD/wz6P9U/ngsEDjwefuOlQp1rgpqnEH
	fklQJLdQEcXiLvzO0v8ARhhFtmQKJQUwTRp9FEsPZN4CgmDz3/QGYPAoH+DiqjNaY9CEuZUy4m7ja
	nld/l+FIOwmKPPowFxzOIK5TSPg9S5VZBMCPFiqnMxmo05F61547NxmqXoR65MFjLWfcoGK282UIL
	Cy0pbqrg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aLB-00000006eCP-41nE;
	Tue, 14 Oct 2025 08:25:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1087E300212; Tue, 14 Oct 2025 10:25:06 +0200 (CEST)
Date: Tue, 14 Oct 2025 10:25:06 +0200
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
Message-ID: <20251014082506.GO3245006@noisy.programming.kicks-ass.net>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
 <d481f196-703e-4ed0-8db1-dbc3822c349e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d481f196-703e-4ed0-8db1-dbc3822c349e@nvidia.com>

On Mon, Oct 13, 2025 at 05:27:32PM -0400, Joel Fernandes wrote:
> 
> 
> On 10/13/2025 4:00 PM, Peter Zijlstra wrote:
> > On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
> >> From: Joel Fernandes <joelagnelf@nvidia.com>
> >>
> >> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
> >> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
> >> allowing those bits to be repurposed for other uses.  This also has the benefit
> >> of tracking more than 16-levels deep if there is ever a need.
> >>
> >> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> >> Signed-off-by: Joel Fernandes <joelaf@google.com>
> >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> >> ---
> >>  include/linux/hardirq.h   | 17 +++++++++++++----
> >>  kernel/softirq.c          |  2 ++
> >>  rust/kernel/alloc/kvec.rs |  5 +----
> >>  rust/kernel/cpufreq.rs    |  3 +--
> >>  4 files changed, 17 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> >> index d57cab4d4c06f..177eed1de35cc 100644
> >> --- a/include/linux/hardirq.h
> >> +++ b/include/linux/hardirq.h
> >> @@ -10,6 +10,8 @@
> >>  #include <linux/vtime.h>
> >>  #include <asm/hardirq.h>
> >>  
> >> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> > 
> > Urgh, and it isn't even in the same cacheline as the preempt_count :/
> 
> Great point. I will move this to DECLARE_PER_CPU_CACHE_HOT()
> so it's co-located with preempt_count and run some tests. Let me know if that
> works for you, thanks!

Well, I hate how on entry we then end up incrementing both. How terrible
would it be to make __preempt_count u64 instead?

