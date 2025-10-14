Return-Path: <linux-pm+bounces-36094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB86BDB138
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A418356D63
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D582C324E;
	Tue, 14 Oct 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+A0hWuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077002C235A;
	Tue, 14 Oct 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470654; cv=none; b=IhSMwT1b/fzDW30gl3uAWRgseed6oms/iihzjY/FmzC6Yf/dkrUNkss3nn9hku8O02inKdUfQ+0xjDBkoHml0D/60YVa3eJEYjtkNKZBYUVxpLg8Cujx/Q3CuLPEfF+gz+Lr3pfp5HcwEY5QcoYozbMo9DcVYr61i5uI5BpAgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470654; c=relaxed/simple;
	bh=BU6xg7LenolCqLsgr+eH/7G0IDTRe5aGzNjgi8aWeD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvEQ12tH0KdB2TvZzdaJPWCKDYtEkROs+O4owJgMMbtio2YJUALh18iGpJCkCbHOUlUKGycTDAm1oXrzBA3+GyNdatWL7eucett7+nVTkZ7JkBkiF8Ap5NxvFzxGxXu5N6+tXa7zIxmDkSt0DpsTCHzl7dw64OEpEEdVjvFgnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D+A0hWuG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BU6xg7LenolCqLsgr+eH/7G0IDTRe5aGzNjgi8aWeD0=; b=D+A0hWuG98aQrhGuTLPXMMciqv
	H9yrWgfnQ/q2z5OzC/3m/EEV6B7dedLIEre4eu+6KSl6EFglnCo5M2avSsfgLtMuBf66ryObC5PAu
	YarYrdP3B+oiWw+DuYzLbaIcrLskzB7Cy+QsZKmzsC+HFLOKgHr1DiFY6LBFkRaKigu64qM9aRZ4P
	jJnsDZMWmMhnMyUUs33K7hlkPMDnvu4ZfkiDPdbyYx13TPCock6JoJmGGamatp3I2I2APs5moXJAf
	o8VjozrL8rztT98EP21VRvf4EzhofVXusoimqIZg3QNA8yVCFw4QsRyV1Jpe6mXTRZUWi9SqgDIqo
	mmGQathw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8kpc-00000005P6A-2fW4;
	Tue, 14 Oct 2025 19:37:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 997DF300212; Tue, 14 Oct 2025 21:37:11 +0200 (CEST)
Date: Tue, 14 Oct 2025 21:37:11 +0200
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
Message-ID: <20251014193711.GB1206438@noisy.programming.kicks-ass.net>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
 <d481f196-703e-4ed0-8db1-dbc3822c349e@nvidia.com>
 <20251014082506.GO3245006@noisy.programming.kicks-ass.net>
 <c58d01f7-2589-465b-b10e-ba39e01deee1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58d01f7-2589-465b-b10e-ba39e01deee1@nvidia.com>

On Tue, Oct 14, 2025 at 01:59:00PM -0400, Joel Fernandes wrote:

> Would that break 32-bit x86? I have to research this more. This was what I
> initially thought of doing but ISTR some challenges. I'd like to think that was
> my imagination, but I will revisit it and see what it takes.

You can do a 64bit addition with 2 instructions on most 32 bit arch,
i386 in specific has: ADD+ADC. Same for many of the other simple ops.
Its multiplication and division where things get tricky, but luckily we
don't do much of those on __preempt_count.

