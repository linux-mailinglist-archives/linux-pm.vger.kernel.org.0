Return-Path: <linux-pm+bounces-36002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB4BD605A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087CC18A4B09
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E727BF6C;
	Mon, 13 Oct 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSBwjuFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636C1D618E;
	Mon, 13 Oct 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385658; cv=none; b=r0CRkmxeMCEop/9WELGG3DZIlUJoRphfMLFO2cpbcjVtN7+GsTJPyiUKZvbUZXdI5g0WkP3XmK4fwCaQVAZQT431mFzSua69WXBbqfoo5+auEslJWUElalnzDoTrD3u3EZh0ZvnpZdbGyqm4ey7Ps2EagCkLH32ypFFUgK5MgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385658; c=relaxed/simple;
	bh=zK/h1j9uSm+vtfJpmxcjfhnJmJ+TGvAA6H86W0HuMYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApIv6loivTwyv4vfOW7ELfE/pgdH2jRFBE19MJNzZbsxnjM5QagCoLNXiqJQiU549ytSmXLWIjDqJx+mAAXHb0AQLUmTE9Tc3CzSfDndp+b4SQ5FUiBEDk/GJFQ7rU5yWnHDuJnSy7THEaPuXXxJIJXRVCOThdCks+P+lAo3TD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GSBwjuFS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lEm7yIMBT7J/1bIdNVjWS9w3zLGCQP6Egg4jF75zs68=; b=GSBwjuFS9ascXsK+XO3fdWLhUM
	NRvd0kvKUjENPZwoCqPMEV3NIq2w0Uqwc8SstTx26HH7X2bOBjV/M5T3QlMuRSD3PwSgZ8FSlivke
	ZGFY/jPwSL8tWM74/ipoV2W96GRztQAGk4otKSL8OO+AZ9GAs9/khnxICPb/7wW8drchMB099IAIU
	zfyKTQPitOQBGECf9JAeRzXDfe1A+EvC+xgyDzPqy+mlAI3npD6MUw8FRhpnra9pR+1BYT/cpTklq
	DPhpEtWF1nWlN1/gIZLjDRBfTzZ4vIkZR+D2h1sQQCSGk/Uu3PFv3RwCsAALVgnAPqtawyhmzEgnL
	S2MLGDkg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Oij-00000004bXP-0UgF;
	Mon, 13 Oct 2025 20:00:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D908300212; Mon, 13 Oct 2025 22:00:36 +0200 (CEST)
Date: Mon, 13 Oct 2025 22:00:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
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
Message-ID: <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013155205.2004838-2-lyude@redhat.com>

On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
> allowing those bits to be repurposed for other uses.  This also has the benefit
> of tracking more than 16-levels deep if there is ever a need.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/linux/hardirq.h   | 17 +++++++++++++----
>  kernel/softirq.c          |  2 ++
>  rust/kernel/alloc/kvec.rs |  5 +----
>  rust/kernel/cpufreq.rs    |  3 +--
>  4 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index d57cab4d4c06f..177eed1de35cc 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -10,6 +10,8 @@
>  #include <linux/vtime.h>
>  #include <asm/hardirq.h>
>  
> +DECLARE_PER_CPU(unsigned int, nmi_nesting);

Urgh, and it isn't even in the same cacheline as the preempt_count :/

