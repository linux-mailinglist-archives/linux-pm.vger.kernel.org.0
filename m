Return-Path: <linux-pm+bounces-31608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74073B16045
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 14:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A249118925EF
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA826A09E;
	Wed, 30 Jul 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyFkl0x/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AC4C62;
	Wed, 30 Jul 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878266; cv=none; b=SGJFz0Tw3azVqbS0cD6P5ZQaXmRhemZrjrAwA3emWvyOk/z/7lfa3Gm22FUNxRrbbku+/SbXYPK5EEfvXKbVtSIG0j2yc4zvh1D955cppk5FMdzyH2iipYfr3OlIhWtroS8rQrtgIEYBzrthMBAoQI0WVP/vdwtUJd5A3fBT/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878266; c=relaxed/simple;
	bh=tQQZicxDg736Ne6joTSbh8xPl7JQMY4Q4BS9gTs+IhE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=MCGbR2Xjr5PJZf/sApdI/OdJW82y3PV7+3YPdB/+4VAun8i5vSqB8pms5EnRjwu3tFzl+bFgzO9/8GA6ttoE5isQCyglh9PgtuRUu0EzueqROcnYndbeHHpECobV90fJn6RzVceiWqSG/+hDMEj3L5RKvkH/4NXcg6m5vgneCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyFkl0x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531B6C4CEE7;
	Wed, 30 Jul 2025 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753878266;
	bh=tQQZicxDg736Ne6joTSbh8xPl7JQMY4Q4BS9gTs+IhE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=FyFkl0x/9xz9izBjyy9kkmMnRg1PSSoV5+Tix77/rwv8MKgFSWylUH/lyNw2bYvcp
	 SSu+SGraSK3Y+NPjFgXZcl8KKRMi+SyKrIcnbuzg5J4OkxZ8NeVpRsS7pzcjBXJamT
	 Rcgtl3obzAOTWK/uDZ98j2IeoEQLhN9lfWMbW4m3hpRJj4/34ZLZYfIF+tCX4c+lGh
	 SFYTZbMk2WfHE1U69jr33x88UjSHWhVQ+pyAJWyMf4rVEPtV6TNBVUKFgsFixAkCIJ
	 /fBi9ElWLl8RLZVftPF8V4ituLSV+h8aeUiuInCSuoNt23mWRr48ZLtHWe/qgJAsiV
	 7qk/wLAO4iCxQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 14:24:20 +0200
Message-Id: <DBPDYDSV2URD.G6L0VGU3IYAC@kernel.org>
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
 <DBP8EWLCAE4B.34Y4FBSH5BTB6@kernel.org>
 <086CDFC4-A9EE-40C7-89BB-D3B8CBFA01EA@collabora.com>
In-Reply-To: <086CDFC4-A9EE-40C7-89BB-D3B8CBFA01EA@collabora.com>

On Wed Jul 30, 2025 at 2:13 PM CEST, Daniel Almeida wrote:
>> On 30 Jul 2025, at 05:03, Danilo Krummrich <dakr@kernel.org> wrote:
>> On Tue Jul 29, 2025 at 11:38 PM CEST, Daniel Almeida wrote:
>>>     /// fn configure_clk(dev: &Device) -> Result {
>>> -    ///     let clk =3D Clk::get(dev, Some(c_str!("apb_clk")))?;
>>> +    ///     // The fastest way is to use a version of `Clk::get` for t=
he desired
>>> +    ///     // state, i.e.:
>>> +    ///     let clk: Clk<Enabled> =3D Clk::<Enabled>::get(dev, Some(c_=
str!("apb_clk")))?;
>>=20
>> Given that this is a driver API, why do we allow obtaining and configuri=
ng
>> clocks of any device, i.e. also unbound devices?
>>=20
>> I think Clk::<T>::get() should take a &Device<Bound> instead.
>
> Ah, this was a question I had, but that I forgot to mention here.
>
> The same can probably be said of the regulator series? i.e.:
>
> impl Regulator<Disabled> {
>     /// Obtains a [`Regulator`] instance from the system.
>     pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
>         Regulator::get_internal(dev, name)
>     }

Yes, that's a device resource as well. We should only give it out to driver=
s
when they're actually bound to the device.

>>=20
>>> -    ///     clk.prepare_enable()?;
>>> +    ///     // Any other state is also possible, e.g.:
>>> +    ///     let clk: Clk<Prepared> =3D Clk::<Prepared>::get(dev, Some(=
c_str!("apb_clk")))?;
>>> +    ///
>>> +    ///     // Later:
>>> +    ///     let clk: Clk<Enabled> =3D clk.enable().map_err(|error| {
>>> +    ///         error.error
>>> +    ///     })?;
>>> +    ///
>>> +    ///     // Note that error.clk is the original `clk` if the operat=
ion
>>> +    ///     // failed. It is provided as a convenience so that the ope=
ration may be
>>> +    ///     // retried in case of errors.
>>>     ///
>>>     ///     let expected_rate =3D Hertz::from_ghz(1);
>>>     ///
>>> @@ -120,104 +200,172 @@ mod common_clk {
>>>     ///         clk.set_rate(expected_rate)?;
>>>     ///     }
>>>     ///
>>> -    ///     clk.disable_unprepare();
>>> +    ///     // Nothing is needed here. The drop implementation will un=
do any
>>> +    ///     // operations as appropriate.
>>> +    ///     Ok(())
>>> +    /// }
>>> +    ///
>>> +    /// fn shutdown(dev: &Device, clk: Clk<Enabled>) -> Result {
>>=20
>> You don't need the dev argument here.
>>=20
>>> +    ///     // The states can be traversed "in the reverse order" as w=
ell:
>>> +    ///     let clk: Clk<Prepared> =3D clk.disable().map_err(|error| {
>>> +    ///         error.error
>>> +    ///     })?;
>>> +    ///
>>> +    ///     let clk: Clk<Unprepared> =3D clk.unprepare();
>>=20
>> I know you want to showcase the type state, yet I don't know if we shoul=
d
>> explicitly declare the type if not necessary. People will likely just co=
py
>> things. Maybe a comment is better to emphasize it?
>
> Ok
>
>>=20
>>> +    ///
>>>     ///     Ok(())
>>>     /// }
>>>     /// ```
>>>     ///
>>>     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
>>>     #[repr(transparent)]
>>> -    pub struct Clk(*mut bindings::clk);
>>> +    pub struct Clk<T: ClkState> {
>>> +        inner: *mut bindings::clk,
>>> +        _phantom: core::marker::PhantomData<T>,
>>> +    }
>>=20
>> <snip>
>>=20
>>> +    impl<T: ClkState> Drop for Clk<T> {
>>> +        fn drop(&mut self) {
>>> +            if T::DISABLE_ON_DROP {
>>> +                // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for
>>> +                // [`clk_disable`].
>>> +                unsafe { bindings::clk_disable(self.as_raw()) };
>>> +            }
>>> +
>>> +            if T::UNPREPARE_ON_DROP {
>>> +                // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for
>>> +                // [`clk_unprepare`].
>>> +                unsafe { bindings::clk_unprepare(self.as_raw()) };
>>> +            }
>>=20
>> Nice! I like this cleanup. However, don't you still need to call clk_put=
() to
>> drop the reference count?
>
> Right, clk_put() was totally forgotten.
>
>>=20
>> Also, given that this is a device resource, don't we want to take it awa=
y from
>> drivers once the corresponding device has been unbound, i.e. use Devres?
>
> Do you mean to have the get() functions return Devres<Clk>?
>
> Also, is this applicable for Regulator as well?

Yes, drivers shouldn't be able to mess with device specific resources once =
they
are unbound from the device.

