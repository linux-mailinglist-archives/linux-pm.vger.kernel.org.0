Return-Path: <linux-pm+bounces-35123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB33B8DF53
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CC13BEAB5
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053C23497B;
	Sun, 21 Sep 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0YkirdK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3320232368;
	Sun, 21 Sep 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758471538; cv=none; b=cq3uyw2ROfEV3ye+1a6UeZRYzHUxJH+H6+TQgZyUyamfubs4WPS6zqTzfNkzKyR+LSsNegCnkXINGGZcHcJI2psMafVrOI7KZDt97KzTlDUrgkUW3RE/E6gDQNtlhNNp0UA9clC8dK5HRV9cwrBZOlPm1K/5YjePZgEK2I1QEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758471538; c=relaxed/simple;
	bh=tNt1C79v7ooKxo6ttTiw6plTbXJzVX61mmSGvgXDQRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ZWMN6i5Yp36V1imnpsG2W5nzk7wQUQOwva68QhPDGZCUIrWb39rK+55Qj7ItbzEpo/1+kXdbCQciX+kkftOy8TqZKdNji+TeWk8XlMifTP0IO1vVqUhZp9JT/iGnan34O7vN+k5akgaBa1/qaOiBk7sIyoKpR019pwXUtmMpcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0YkirdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FED9C116B1;
	Sun, 21 Sep 2025 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758471537;
	bh=tNt1C79v7ooKxo6ttTiw6plTbXJzVX61mmSGvgXDQRQ=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=X0YkirdK6o10JyKP5wIFLCySESz7yoxv3vF4kXkgZJEomjk+YhSa6fM1DB5S3Zmsm
	 ZFVwyaKVAWXFNruvEapkH4rmXBtmLv21+JPTAfgnw58/HPrxaq8CAQUGYE4DsIzWJi
	 oPTVpOKAyu4tWEjFpYgTPzdxPP0EVQIGmbnPfMnYAlAqWijkpUtB9uLJtGZfigARUv
	 Pjie0g1WSpvWTkM2itocRdaK2/rL0CyGi4fBc2LmJTw0QAqRfonL2k8NZT47dPLsNb
	 EnSS0xMKVvj6xd3M054ITh5CE1r8VR3T270IBV8x8Kw6w5auelmBD8nWOPQPMdXrI8
	 AezPuG+VanBUA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 18:18:52 +0200
Message-Id: <DCYM4TPGMFF5.3J6H7VPADC0W0@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: clk: use the type-state pattern
Cc: "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com>
In-Reply-To: <20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com>

On Wed Sep 10, 2025 at 7:28 PM CEST, Daniel Almeida wrote:
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a device.
> +    ///
> +    /// [`devres`]: crate::devres::Devres
> +    pub fn devm_enable(dev: &Device, name: Option<&CStr>) -> Result {
> +        let name =3D name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a va=
lid
> +        // device pointer.

It's not, since this calls into devres it is only safe with a pointer to a =
bound
device, i.e. you need to require &Device<Bound>.

You also need to justify the CStr pointer in terms of being NULL and its
lifetime.

> +        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(=
), name) })?;
> +        Ok(())
> +    }
> +
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a device.
> +    ///
> +    /// This does not print any error messages if the clock is not found=
.
> +    ///
> +    /// [`devres`]: crate::devres::Devres
> +    pub fn devm_enable_optional(dev: &Device, name: Option<&CStr>) -> Re=
sult {
> +        let name =3D name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +        // SAFETY: It is safe to call [`devm_clk_get_optional_enabled`] =
with a
> +        // valid device pointer.
> +        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(de=
v.as_raw(), name) })?;
> +        Ok(())
> +    }
> +
> +    /// Same as [`devm_enable_optional`], but also sets the rate.
> +    pub fn devm_enable_optional_with_rate(
> +        dev: &Device,
> +        name: Option<&CStr>,
> +        rate: Hertz,
> +    ) -> Result {
> +        let name =3D name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +        // SAFETY: It is safe to call
> +        // [`devm_clk_get_optional_enabled_with_rate`] with a valid devi=
ce
> +        // pointer.
> +        from_err_ptr(unsafe {
> +            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw=
(), name, rate.as_hz())
> +        })?;
> +        Ok(())
> +    }

I think those should be added in a separate patch.

> +    impl Clk<Unprepared> {
>          /// Gets [`Clk`] corresponding to a [`Device`] and a connection =
id.
>          ///
>          /// Equivalent to the kernel's [`clk_get`] API.
>          ///
>          /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.htm=
l#c.clk_get
> -        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> +        #[inline]
> +        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unpr=
epared>> {

Not related to your change, but I'm not sure we should allow drivers to mes=
s
with clocks when they can't prove that they're still bound to the correspon=
ding
device.

It's not introducing any safety issues or unsoundness, but it's not the cor=
rect
thing to do semantically.

>              let con_id =3D name.map_or(ptr::null(), |n| n.as_ptr());
> =20
>              // SAFETY: It is safe to call [`clk_get`] for a valid device=
 pointer.
> -            //
> +            let inner =3D from_err_ptr(unsafe { bindings::clk_get(dev.as=
_raw(), con_id) })?;
> +
>              // INVARIANT: The reference-count is decremented when [`Clk`=
] goes out of scope.
> -            Ok(Self(from_err_ptr(unsafe {
> -                bindings::clk_get(dev.as_raw(), con_id)
> -            })?))
> +            Ok(Self {
> +                inner,
> +                _phantom: PhantomData,
> +            })
>          }
> =20
> -        /// Obtain the raw [`struct clk`] pointer.
> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns
> +        /// a dummy [`Clk`].
>          #[inline]
> -        pub fn as_raw(&self) -> *mut bindings::clk {
> -            self.0
> +        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result=
<Clk<Unprepared>> {
> +            let con_id =3D name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +            // SAFETY: It is safe to call [`clk_get`] for a valid device=
 pointer.

What about con_id?

> +            let inner =3D from_err_ptr(unsafe { bindings::clk_get_option=
al(dev.as_raw(), con_id) })?;
> +
> +            // INVARIANT: The reference-count is decremented when [`Clk`=
] goes out of scope.

I know you're consistent with other places, but this seems a odd. This does=
n't
correspond to: "A [`Clk`] instance holds either a pointer to a valid [`stru=
ct
clk`] created by the C portion of the kernel or a NULL pointer."

> +            Ok(Self {
> +                inner,
> +                _phantom: PhantomData,
> +            })
>          }

<snip>

> +            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for

Missing backticks (also in a few other places).

> +            // [`clk_put`].
> +            unsafe { bindings::clk_put(self.as_raw()) };
>          }
>      }

