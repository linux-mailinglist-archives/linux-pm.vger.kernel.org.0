Return-Path: <linux-pm+bounces-31607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77078B16002
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB28B18C6EED
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D66293C6C;
	Wed, 30 Jul 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OwvZ+7jR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2253FE5;
	Wed, 30 Jul 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877696; cv=pass; b=o7+IXwjnYgMXfIObDegS/Ly36JXyLKV1t+TtBpjVRwsg5MKRlmxlxe11A6dINJhOi9F6Qk28vIum9YNDqQ0BuznIMMDe5T7u7ESNPHmA2wMsDx/LkMCyu5AidOYbEHcyu2E04xp3FhfSkoSaKd6+JfS5WzPfNrKHpxC3g+H98sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877696; c=relaxed/simple;
	bh=MJr6t1BtBiLGwOJrWZI3GkXsGiXtGndz3Bsl8aCXD+g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I79CsgIZhSHdeEYoeylVPF7zxpSRJx9P3QiHIaOCRdd8gGn1ha9+2y+85Qf0mG1QxIJa9vB/sNBgJjWG75S+3iup0YGp/x8RVn+wzzh+u+NvyODv94s0FDaXSRDA8LeekQtw8x46V5TiXPFsn0ftbJT0/IhLfVsjki6z2oqQjhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OwvZ+7jR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753877660; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BTtWjBu78T4K4p4DAbV00CQxqFcyQX//7jU/o2Ent7wT62szX9hAczBtFfalr5q4WF/AQPOgDIAS3OEWjUCMXHtYn5t+CuT8JApMULgK7bsmuL7g68Yk5aXLcJtQrm6e4RFiEllohlOzSiBnJUId62cnWWTb8paHI4XcK13e3NU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753877660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cvk/NZkWXutHuBZDgvvw0GnGlhYqcEb5gqbSSddkwpE=; 
	b=NUyAscFzvgevk/dDAFGjTPvPFsnVfBo+l/B9JyGluJzGB12zCVxJykjKErPRLv8ObNmtDPl9HEvMPEqmxjAS7Qm9oKpCa0o1fDQn/yn5QoY2yg3FibTNU1GN3y/2vfoelH9CooqesHAMUziBrtv8JdDgc//cZZv4bHrF5kF4qYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753877660;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Cvk/NZkWXutHuBZDgvvw0GnGlhYqcEb5gqbSSddkwpE=;
	b=OwvZ+7jRT07UJCP6CeqVSPLqXrDu5ElvsX51d7TTTsiFP95uTDfJm9GqRuvLs0C3
	SLTMf29rTLIqls6QAn5VwqBAfnDREOo3cc9iDj6FkiuE5B+mOqQN8EfbVO8ictn+80z
	7fXhyAu/ORQRu+ndu/gH+xiJEgho50V8WR5z0ImI=
Received: by mx.zohomail.com with SMTPS id 1753877656376634.2090583909618;
	Wed, 30 Jul 2025 05:14:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBP8EWLCAE4B.34Y4FBSH5BTB6@kernel.org>
Date: Wed, 30 Jul 2025 09:13:59 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <086CDFC4-A9EE-40C7-89BB-D3B8CBFA01EA@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <DBP8EWLCAE4B.34Y4FBSH5BTB6@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 30 Jul 2025, at 05:03, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Tue Jul 29, 2025 at 11:38 PM CEST, Daniel Almeida wrote:
>> In light of the Regulator abstraction that was recently merged, =
switch this
>> abstraction to use the type-state pattern instead. It solves both a) =
and b)
>> by establishing a number of states and the valid ways to transition =
between
>> them. It also automatically undoes any call to clk_get(), =
clk_prepare() and
>> clk_enable() as applicable on drop(), so users do not have to do =
anything
>> special before Clk goes out of scope.
>=20
> That's a great improvement, thanks! Some questions / comments below.
>=20
>>     /// A reference-counted clock.
>>     ///
>>     /// Rust abstraction for the C [`struct clk`].
>>     ///
>> +    /// A [`Clk`] instance represents a clock that can be in one of =
several
>> +    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
>> +    ///
>> +    /// No action needs to be taken when a [`Clk`] is dropped. The =
calls to
>> +    /// `clk_unprepare()` and `clk_disable()` will be placed as =
applicable.
>> +    ///
>> +    /// An optional [`Clk`] is treated just like a regular [`Clk`], =
but its
>> +    /// inner `struct clk` pointer is `NULL`. This interfaces =
correctly with the
>> +    /// C API and also exposes all the methods of a regular [`Clk`] =
to users.
>> +    ///
>>     /// # Invariants
>>     ///
>>     /// A [`Clk`] instance holds either a pointer to a valid [`struct =
clk`] created by the C
>> @@ -99,20 +160,39 @@ mod common_clk {
>>     /// Instances of this type are reference-counted. Calling =
[`Clk::get`] ensures that the
>>     /// allocation remains valid for the lifetime of the [`Clk`].
>>     ///
>> -    /// ## Examples
>> +    /// The [`Prepared`] state is associated with a single count of
>> +    /// `clk_prepare()`, and the [`Enabled`] state is associated =
with a single
>> +    /// count of `clk_enable()`, and the [`Enabled`] state is =
associated with a
>> +    /// single count of `clk_prepare` and `clk_enable()`.
>> +    ///
>> +    /// All states are associated with a single count of =
`clk_get()`.
>> +    ///
>> +    /// # Examples
>>     ///
>>     /// The following example demonstrates how to obtain and =
configure a clock for a device.
>>     ///
>>     /// ```
>>     /// use kernel::c_str;
>> -    /// use kernel::clk::{Clk, Hertz};
>> +    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, =
Prepared};
>>     /// use kernel::device::Device;
>>     /// use kernel::error::Result;
>>     ///
>>     /// fn configure_clk(dev: &Device) -> Result {
>> -    ///     let clk =3D Clk::get(dev, Some(c_str!("apb_clk")))?;
>> +    ///     // The fastest way is to use a version of `Clk::get` for =
the desired
>> +    ///     // state, i.e.:
>> +    ///     let clk: Clk<Enabled> =3D Clk::<Enabled>::get(dev, =
Some(c_str!("apb_clk")))?;
>=20
> Given that this is a driver API, why do we allow obtaining and =
configuring
> clocks of any device, i.e. also unbound devices?
>=20
> I think Clk::<T>::get() should take a &Device<Bound> instead.

Ah, this was a question I had, but that I forgot to mention here.

The same can probably be said of the regulator series? i.e.:

impl Regulator<Disabled> {
    /// Obtains a [`Regulator`] instance from the system.
    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
        Regulator::get_internal(dev, name)
    }

>=20
>> -    ///     clk.prepare_enable()?;
>> +    ///     // Any other state is also possible, e.g.:
>> +    ///     let clk: Clk<Prepared> =3D Clk::<Prepared>::get(dev, =
Some(c_str!("apb_clk")))?;
>> +    ///
>> +    ///     // Later:
>> +    ///     let clk: Clk<Enabled> =3D clk.enable().map_err(|error| {
>> +    ///         error.error
>> +    ///     })?;
>> +    ///
>> +    ///     // Note that error.clk is the original `clk` if the =
operation
>> +    ///     // failed. It is provided as a convenience so that the =
operation may be
>> +    ///     // retried in case of errors.
>>     ///
>>     ///     let expected_rate =3D Hertz::from_ghz(1);
>>     ///
>> @@ -120,104 +200,172 @@ mod common_clk {
>>     ///         clk.set_rate(expected_rate)?;
>>     ///     }
>>     ///
>> -    ///     clk.disable_unprepare();
>> +    ///     // Nothing is needed here. The drop implementation will =
undo any
>> +    ///     // operations as appropriate.
>> +    ///     Ok(())
>> +    /// }
>> +    ///
>> +    /// fn shutdown(dev: &Device, clk: Clk<Enabled>) -> Result {
>=20
> You don't need the dev argument here.
>=20
>> +    ///     // The states can be traversed "in the reverse order" as =
well:
>> +    ///     let clk: Clk<Prepared> =3D clk.disable().map_err(|error| =
{
>> +    ///         error.error
>> +    ///     })?;
>> +    ///
>> +    ///     let clk: Clk<Unprepared> =3D clk.unprepare();
>=20
> I know you want to showcase the type state, yet I don't know if we =
should
> explicitly declare the type if not necessary. People will likely just =
copy
> things. Maybe a comment is better to emphasize it?

Ok

>=20
>> +    ///
>>     ///     Ok(())
>>     /// }
>>     /// ```
>>     ///
>>     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
>>     #[repr(transparent)]
>> -    pub struct Clk(*mut bindings::clk);
>> +    pub struct Clk<T: ClkState> {
>> +        inner: *mut bindings::clk,
>> +        _phantom: core::marker::PhantomData<T>,
>> +    }
>=20
> <snip>
>=20
>> +    impl<T: ClkState> Drop for Clk<T> {
>> +        fn drop(&mut self) {
>> +            if T::DISABLE_ON_DROP {
>> +                // SAFETY: By the type invariants, self.as_raw() is =
a valid argument for
>> +                // [`clk_disable`].
>> +                unsafe { bindings::clk_disable(self.as_raw()) };
>> +            }
>> +
>> +            if T::UNPREPARE_ON_DROP {
>> +                // SAFETY: By the type invariants, self.as_raw() is =
a valid argument for
>> +                // [`clk_unprepare`].
>> +                unsafe { bindings::clk_unprepare(self.as_raw()) };
>> +            }
>=20
> Nice! I like this cleanup. However, don't you still need to call =
clk_put() to
> drop the reference count?

Right, clk_put() was totally forgotten.

>=20
> Also, given that this is a device resource, don't we want to take it =
away from
> drivers once the corresponding device has been unbound, i.e. use =
Devres?

Do you mean to have the get() functions return Devres<Clk>?

Also, is this applicable for Regulator as well?

>=20
>>         }
>>     }
>> }
>=20

=E2=80=94 Daniel


