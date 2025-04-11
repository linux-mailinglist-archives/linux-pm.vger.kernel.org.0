Return-Path: <linux-pm+bounces-25288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CFA86535
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0349A2666
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB748258CE7;
	Fri, 11 Apr 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBErLamH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592F20F08E;
	Fri, 11 Apr 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394595; cv=none; b=bOSRdyMQkV8Assg9dULzi8KglOa/hpkFRymu9IP8Gjomnm3DjYUt8QgCvszItR0sdW2blbiaUgQ7l8pqa5BeOG8p/8e7fT8IzEoGM83605EHaxffIcxc/kFcGvD6v7fjDqOG1e5NbB14Le/luHh/Bybpo5Z9ffwt0fRHkUdtOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394595; c=relaxed/simple;
	bh=WkEFiBHfIO5jmz+oePTSYJtLhr8/7pRTP8FdSbo0DRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRO0+i2Udc/T3bNRgwnpL+wm6ZXB94uvv1kX/GtOJ0J7eIjkHB2wSQgOqGyl1ruJ27gSbN6MBJrcKKV2vp5D2pPBQQ3IXkvr+3u+hKprT/GdHSB0ifWG98y/7RV8e5hn68Bi8fQfzyHV9rV4LbEVcXR1yzJ3FQu3XlE/azNgW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBErLamH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08ECC4CEE2;
	Fri, 11 Apr 2025 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394594;
	bh=WkEFiBHfIO5jmz+oePTSYJtLhr8/7pRTP8FdSbo0DRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBErLamHQUxnHJPSUBr1MbBfvq4joYezZ4Tv91nkmPSkeyfyRQabkQ0PC2YFRAi+f
	 dRTuo3Zfws9w6Grxq98FAwT0GZBAs/9oujAIvnov/AorEZ0V9i4yhY+L8p3IEzOZ2+
	 2wUIVpf5FJ+79CaXE/CCgitlyarSvoRPGFq6MLZr2aAbNemQAOC4ggi5LKMCY5y0W7
	 b2Jwh/779qAluQjcDTKei3/0FykUwpefLmabh2MaPWUKjM87tUweCehu3EJ+poRZFm
	 T3b0IMSMNeUJouZGOTCUBh3zxeK91npz1yKSO5yTxfwbxvc32Dna3YY8yOVUsIzjhm
	 3Dt28LH9EAk9Q==
Date: Fri, 11 Apr 2025 20:03:04 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 09/17] rust: cpu: Add from_cpu()
Message-ID: <Z_lZWPr1vBCrYbkA@cassiopeiae>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <475bc73d8d11290446a4135af76aea123c6d80ee.1744366571.git.viresh.kumar@linaro.org>
 <Z_lAyGy1o80MPVOC@yury>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_lAyGy1o80MPVOC@yury>

On Fri, Apr 11, 2025 at 12:18:26PM -0400, Yury Norov wrote:
> On Fri, Apr 11, 2025 at 04:25:08PM +0530, Viresh Kumar wrote:
> > +/// Creates a new instance of CPU's device.
> > +///
> > +/// # Safety
> > +///
> > +/// Reference counting is not implemented for the CPU device in the C code. When a CPU is
> > +/// hot-unplugged, the corresponding CPU device is unregistered, but its associated memory
> > +/// is not freed.
> > +///
> > +/// Callers must ensure that the CPU device is not used after it has been unregistered.
> > +/// This can be achieved, for example, by registering a CPU hotplug notifier and removing
> > +/// any references to the CPU device within the notifier's callback.
> > +pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
> > +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > +    // a `struct device` and is never freed by the C code.
> > +    let ptr = unsafe { bindings::get_cpu_device(cpu) };

You don't need to justify the return value here, you need to justify why cpu is
a valid value to call get_cpu_device() with.

> > +    if ptr.is_null() {
> > +        return Err(ENODEV);
> > +    }
> > +
> > +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > +    // a `struct device` and is never freed by the C code.

Here, the comment is good.

> If you think that writing the same thing twice would help in SAFETY
> department, I'd recommend you to write it for a couple more times.

Fixing the above, should also fix the duplication. :)

> > +    Ok(unsafe { Device::as_ref(ptr) })

