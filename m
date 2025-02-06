Return-Path: <linux-pm+bounces-21469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52620A2A7EE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D7C16460C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B122B8CD;
	Thu,  6 Feb 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB8/8/mc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D5214209;
	Thu,  6 Feb 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842769; cv=none; b=h7nHgbov0lLOrf+8DeBnzwGaZx+Rh8xdT2Gs/5blQ66DGyQjrJDb4K0g9w6id+AZFjX49TC8MfRPkTbdcgnsMqJjmXHukUmm1Xof+tIHC7RYh92EPoM2Xa/6gQzPGniXMkWPuEWIrAEtCdCuE/VXySbPSc+RWxTgShsYqr5xEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842769; c=relaxed/simple;
	bh=avabfQ8Dl/T55XPfuG4fHovvp9LBLIUXUO2RKxv80cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3jYS/W8Bcfa0n3WesZ+2/LGFbD7sFnWcsNfr99leyDUVPlMBJyt/H8wML2IuRCCqDX7mJpFS1pPYUUq80W7APKOk73ouGyzyFbDbJ0tNSmob9AlSLWRnYuSpmLCI5mHFHzw+3U8osPRCSko37GMAIe3Qpuy8bLwjIQpA+Ei474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB8/8/mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42364C4CEE0;
	Thu,  6 Feb 2025 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842769;
	bh=avabfQ8Dl/T55XPfuG4fHovvp9LBLIUXUO2RKxv80cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB8/8/mcvuf/aOBOYUwqgFnMIFNSCCjNGwL+TafnUo9sqeTlzDRa2aW6qutGjj/P6
	 9KsypobBkZc0rFIzBWN3cRc4eZeKO2QjGK6IYBdLE2FCmeUJr4C6DrHWqwZfl2Tg9+
	 cJm8tAKJksto7L6R28xVhlKj6Gm1pBx41ZTAPvJh0HThmQ05hFwlz0WP9d4CD6U/+9
	 nMMB50Pt7fod/0UxuNX3djEIjm/4WsdvjjQZUIO2HeAfKdCGJCGvP0KaJq5JzIgym0
	 pCAN0rDweh5iaZEm+L/abPRGYqzYwzxNCiO3qhYKr6BhWAB9dAAimavE3trIa0hTUC
	 ix4CoInDCDfIA==
Date: Thu, 6 Feb 2025 12:52:41 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
Message-ID: <Z6SiiRubSXGInbgj@pollux>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <Z6ShsuLykigNscz8@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ShsuLykigNscz8@pollux>

On Thu, Feb 06, 2025 at 12:49:14PM +0100, Danilo Krummrich wrote:
> On Thu, Feb 06, 2025 at 02:58:27PM +0530, Viresh Kumar wrote:
> > This adds very basic bindings for the clk framework, implements only
> > clk_get() and clk_put(). These are the bare minimum bindings required
> > for many users and are simple enough to add in the first attempt.
> > 
> > These will be used by Rust based cpufreq / OPP core to begin with.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  MAINTAINERS                     |  1 +
> >  rust/bindings/bindings_helper.h |  1 +
> >  rust/kernel/clk.rs              | 48 +++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |  2 ++
> >  4 files changed, 52 insertions(+)
> >  create mode 100644 rust/kernel/clk.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ff4511914e0a..604717065476 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5780,6 +5780,7 @@ F:	include/dt-bindings/clock/
> >  F:	include/linux/clk-pr*
> >  F:	include/linux/clk/
> >  F:	include/linux/of_clk.h
> > +F:	rust/kernel/clk.rs
> >  X:	drivers/clk/clkdev.c
> >  
> >  COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 59b4bc49d039..4eadcf645df0 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/blk-mq.h>
> >  #include <linux/blk_types.h>
> >  #include <linux/blkdev.h>
> > +#include <linux/clk.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/cred.h>
> > diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> > new file mode 100644
> > index 000000000000..123cdb43b115
> > --- /dev/null
> > +++ b/rust/kernel/clk.rs
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Clock abstractions.
> > +//!
> > +//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
> > +
> > +use crate::{
> > +    bindings,
> > +    device::Device,
> > +    error::{from_err_ptr, Result},
> > +    prelude::*,
> > +};
> > +
> > +use core::ptr;
> > +
> > +/// A simple implementation of `struct clk` from the C code.
> > +#[repr(transparent)]
> > +pub struct Clk(*mut bindings::clk);
> 
> Guess this should be Opaque<bindings::clk>.

Sorry, I meant NonNull<bindings::clk>.

> 
> > +
> > +impl Clk {
> > +    /// Creates `Clk` instance for a device and a connection id.
> > +    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> > +        let con_id = if let Some(name) = name {
> > +            name.as_ptr() as *const _
> > +        } else {
> > +            ptr::null()
> > +        };
> > +
> > +        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
> > +        // code.
> > +        Ok(Self(from_err_ptr(unsafe {
> > +            bindings::clk_get(dev.as_raw(), con_id)
> > +        })?))
> > +    }
> > +
> > +    /// Obtain the raw `struct clk *`.
> > +    pub fn as_raw(&self) -> *mut bindings::clk {
> > +        self.0
> > +    }
> > +}
> > +
> > +impl Drop for Clk {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> > +        // relinquish it now.
> > +        unsafe { bindings::clk_put(self.0) };
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index ccbf7fa087a0..77d3b1f82154 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -40,6 +40,8 @@
> >  pub mod block;
> >  #[doc(hidden)]
> >  pub mod build_assert;
> > +#[cfg(CONFIG_COMMON_CLK)]
> > +pub mod clk;
> >  pub mod cpu;
> >  pub mod cpumask;
> >  pub mod cred;
> > -- 
> > 2.31.1.272.g89b43f80a514
> > 
> > 

