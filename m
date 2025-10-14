Return-Path: <linux-pm+bounces-36060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1CCBD8CE4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC0C9351900
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9D2F99AE;
	Tue, 14 Oct 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lCLA3pdV"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E42EC0B2;
	Tue, 14 Oct 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438940; cv=none; b=jDUn3zIcj/uaJk7rRaYThpBzvzYO0tU2puwvUcbBUrRbJS+KykrV4wz4NvyCoybu24booOBPVA1ymFG48jJcw/+V3N2Vqx7lBGtEPNYPDlYYxSONzZM77V0USw39cS0lHdbqUdIxgRa4p4vl1H2r+9CGQpnFpyti3pE834ZBsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438940; c=relaxed/simple;
	bh=jsZ35PKJoIyRJL+lhaOaWpvfX5vguopAXv8JOUir99c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjZG8ACHyFKOMK9mViuzKn7tE2oKQmPQv17QFRw20zEGx8jXCXiXYafyhj14yCavhnehYkE+Q5pwmoDwLIIwjq2V1tj5qDB9X4oN13ioqEvsSVbmXKyEdYrsI/Heapx1BRldMSZnPUbF+kSMJf9+TRmzYUZ1ndDQc+aledymCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lCLA3pdV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4TK3DsBWtfaz0TuDxRr37u83eeyXIsUWSIrJ5//loOc=; b=lCLA3pdVWW5yhqAcccqogx0EQm
	kcFkufSMqfEj7xlRtiCtgniW17DK8YiIlxRl+Apd5hcLMLiRRxexqvWbTZZJdA+GmcaPHNMkhy8yp
	TcEwNdjyNJWU2mk9r8rNPvGPmdV+b27FYAXJhquXvpZ78womnf12J3RutLlYDu8zT2nwvAsABEf/5
	Z6l63Oql5hRbwZIrrU4kpIqdQ3PyyNEinCMk04PFBTN4olBD1JwI0IL1KfF3y9HRi/XmAqv78U10B
	jf7PGzQkN0aQUaLbuYQ8xxfKL1o8LKq9JLvR7G55ZfPYdUoHX7CiB6+y+UF/7SlEcxQKKKA8bogyy
	zXlTAQgA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ca8-000000056MU-06Jf;
	Tue, 14 Oct 2025 10:48:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53B15300212; Tue, 14 Oct 2025 12:48:39 +0200 (CEST)
Date: Tue, 14 Oct 2025 12:48:39 +0200
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
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
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

>  #define __nmi_enter()						\
>  	do {							\
>  		lockdep_off();					\
>  		arch_nmi_enter();				\
> -		BUG_ON(in_nmi() == NMI_MASK);			\
> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
> +		__this_cpu_inc(nmi_nesting);			\

An NMI that nests from here..

> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> +		if (__this_cpu_read(nmi_nesting) == 1)		\

.. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.

> +			__preempt_count_add(NMI_OFFSET);	\

