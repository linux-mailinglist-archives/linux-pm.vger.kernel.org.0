Return-Path: <linux-pm+bounces-31577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A3B15A28
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68577A13E2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819B238C29;
	Wed, 30 Jul 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHSwnj7F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6F1D54F7;
	Wed, 30 Jul 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862634; cv=none; b=YUDRISL9fPcbH+C7bqee4cOmNnYNBYjEt7xfg1iysThMJnioXrTkEJUEGgwOKr54J/nOB71HTMna58+BCspdXFHKV0hizA0ZJa/v8bJgHraSve1d5rqqk0Q/EMtGJhFy3gLoWG+d6u52T9hJXP57+eEsYxRXV/RYAh/q+wo8QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862634; c=relaxed/simple;
	bh=zMori7sX/UDbxCNR2EI8mynJoVEW1MfajN3fR3vL3RM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=pEvazfwPOHK6m8LwRyq1q0dSgDD9Rze1P+L3zJOx4F5xHf5OVQEpuWEF0gMkp3QkaVQY1OxnljLofNgnpJuLnzqe/y4AS2CsiZUH9mCHnYevizwg+uEcl2sQmq53y1xLIXfszIJqc1/08DvPsHOX7eZebjI0OxEssE3cbaO9Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHSwnj7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D1DC4CEE7;
	Wed, 30 Jul 2025 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753862634;
	bh=zMori7sX/UDbxCNR2EI8mynJoVEW1MfajN3fR3vL3RM=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=GHSwnj7Fd1tMRkr9dNuz2ToiGvIRTK09AjT0F/4PshJ0Gm38xxbS+csJgHvu+5IVA
	 8gML/P1FOqVOjqDj1D2nJwUd4FCQjdeVanj9S1lWFQBbvIl4vsXteeuS8r8lRVSalW
	 LeTIiQ7YFMnmA+Y3fFFo3prUSPBJl/bmyA7sWEovGhNAMWjkStZFH3AbLY2nMHCqR9
	 AyZyBdGYR1yDv5b4NCnNysZJ86s2/Fac502hh+Mvjb2JODbv1JOTm5U+h5lw3nrKUO
	 5NEwA2gM4nbhR4AlRjLocgj24tNc/DdKcwSWH9Jr1mKKLS2XLIz3LFEmTEKR8ztxlf
	 eyqBm0VyYGdJA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 10:03:48 +0200
Message-Id: <DBP8EWLCAE4B.34Y4FBSH5BTB6@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: clk: use the type-state pattern
Cc: "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
In-Reply-To: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>

On Tue Jul 29, 2025 at 11:38 PM CEST, Daniel Almeida wrote:
> In light of the Regulator abstraction that was recently merged, switch th=
is
> abstraction to use the type-state pattern instead. It solves both a) and =
b)
> by establishing a number of states and the valid ways to transition betwe=
en
> them. It also automatically undoes any call to clk_get(), clk_prepare() a=
nd
> clk_enable() as applicable on drop(), so users do not have to do anything
> special before Clk goes out of scope.

That's a great improvement, thanks! Some questions / comments below.

>      /// A reference-counted clock.
>      ///
>      /// Rust abstraction for the C [`struct clk`].
>      ///
> +    /// A [`Clk`] instance represents a clock that can be in one of seve=
ral
> +    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
> +    ///
> +    /// No action needs to be taken when a [`Clk`] is dropped. The calls=
 to
> +    /// `clk_unprepare()` and `clk_disable()` will be placed as applicab=
le.
> +    ///
> +    /// An optional [`Clk`] is treated just like a regular [`Clk`], but =
its
> +    /// inner `struct clk` pointer is `NULL`. This interfaces correctly =
with the
> +    /// C API and also exposes all the methods of a regular [`Clk`] to u=
sers.
> +    ///
>      /// # Invariants
>      ///
>      /// A [`Clk`] instance holds either a pointer to a valid [`struct cl=
k`] created by the C
> @@ -99,20 +160,39 @@ mod common_clk {
>      /// Instances of this type are reference-counted. Calling [`Clk::get=
`] ensures that the
>      /// allocation remains valid for the lifetime of the [`Clk`].
>      ///
> -    /// ## Examples
> +    /// The [`Prepared`] state is associated with a single count of
> +    /// `clk_prepare()`, and the [`Enabled`] state is associated with a =
single
> +    /// count of `clk_enable()`, and the [`Enabled`] state is associated=
 with a
> +    /// single count of `clk_prepare` and `clk_enable()`.
> +    ///
> +    /// All states are associated with a single count of `clk_get()`.
> +    ///
> +    /// # Examples
>      ///
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.
>      ///
>      /// ```
>      /// use kernel::c_str;
> -    /// use kernel::clk::{Clk, Hertz};
> +    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
>      /// use kernel::device::Device;
>      /// use kernel::error::Result;
>      ///
>      /// fn configure_clk(dev: &Device) -> Result {
> -    ///     let clk =3D Clk::get(dev, Some(c_str!("apb_clk")))?;
> +    ///     // The fastest way is to use a version of `Clk::get` for the=
 desired
> +    ///     // state, i.e.:
> +    ///     let clk: Clk<Enabled> =3D Clk::<Enabled>::get(dev, Some(c_st=
r!("apb_clk")))?;

Given that this is a driver API, why do we allow obtaining and configuring
clocks of any device, i.e. also unbound devices?

I think Clk::<T>::get() should take a &Device<Bound> instead.

> -    ///     clk.prepare_enable()?;
> +    ///     // Any other state is also possible, e.g.:
> +    ///     let clk: Clk<Prepared> =3D Clk::<Prepared>::get(dev, Some(c_=
str!("apb_clk")))?;
> +    ///
> +    ///     // Later:
> +    ///     let clk: Clk<Enabled> =3D clk.enable().map_err(|error| {
> +    ///         error.error
> +    ///     })?;
> +    ///
> +    ///     // Note that error.clk is the original `clk` if the operatio=
n
> +    ///     // failed. It is provided as a convenience so that the opera=
tion may be
> +    ///     // retried in case of errors.
>      ///
>      ///     let expected_rate =3D Hertz::from_ghz(1);
>      ///
> @@ -120,104 +200,172 @@ mod common_clk {
>      ///         clk.set_rate(expected_rate)?;
>      ///     }
>      ///
> -    ///     clk.disable_unprepare();
> +    ///     // Nothing is needed here. The drop implementation will undo=
 any
> +    ///     // operations as appropriate.
> +    ///     Ok(())
> +    /// }
> +    ///
> +    /// fn shutdown(dev: &Device, clk: Clk<Enabled>) -> Result {

You don't need the dev argument here.

> +    ///     // The states can be traversed "in the reverse order" as wel=
l:
> +    ///     let clk: Clk<Prepared> =3D clk.disable().map_err(|error| {
> +    ///         error.error
> +    ///     })?;
> +    ///
> +    ///     let clk: Clk<Unprepared> =3D clk.unprepare();

I know you want to showcase the type state, yet I don't know if we should
explicitly declare the type if not necessary. People will likely just copy
things. Maybe a comment is better to emphasize it?

> +    ///
>      ///     Ok(())
>      /// }
>      /// ```
>      ///
>      /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
>      #[repr(transparent)]
> -    pub struct Clk(*mut bindings::clk);
> +    pub struct Clk<T: ClkState> {
> +        inner: *mut bindings::clk,
> +        _phantom: core::marker::PhantomData<T>,
> +    }

<snip>

> +    impl<T: ClkState> Drop for Clk<T> {
> +        fn drop(&mut self) {
> +            if T::DISABLE_ON_DROP {
> +                // SAFETY: By the type invariants, self.as_raw() is a va=
lid argument for
> +                // [`clk_disable`].
> +                unsafe { bindings::clk_disable(self.as_raw()) };
> +            }
> +
> +            if T::UNPREPARE_ON_DROP {
> +                // SAFETY: By the type invariants, self.as_raw() is a va=
lid argument for
> +                // [`clk_unprepare`].
> +                unsafe { bindings::clk_unprepare(self.as_raw()) };
> +            }

Nice! I like this cleanup. However, don't you still need to call clk_put() =
to
drop the reference count?

Also, given that this is a device resource, don't we want to take it away f=
rom
drivers once the corresponding device has been unbound, i.e. use Devres?

>          }
>      }
>  }

