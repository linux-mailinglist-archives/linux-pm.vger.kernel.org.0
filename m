Return-Path: <linux-pm+bounces-32871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA62B30DE6
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3471889A4B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF628AAEE;
	Fri, 22 Aug 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="comBnp5l"
X-Original-To: linux-pm@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084AEC2;
	Fri, 22 Aug 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839985; cv=none; b=Ze+8rpe9Z/ZThC5JJidZLWq9oTdTJxKbDODd+PWp2kkuVSCh4bDDpUuW+bGHWXg3x+AZ0xiVAfy9oPCPcx6j8e6rMCs3JQvXDT5IL6SvUjSGXpaHIAsmcU5eYMAMvDADqsHX+xCveqXijV++ifBOlrP5No7ynia085phmtuPXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839985; c=relaxed/simple;
	bh=yDltWIurWHSj98BfITo9fI6oEAxULSFiwhBkEYZybB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9o6aVUwbKUmUNYGlfORMEMC/YTKIx86OUarcRXsR6OeOBoyMkYbPDLwDm3158Uj1yAZIpiJ3fRU1JS+/w/E/RAWVesVebBvAP0OuiGdB8wG+TWEaKhbD0lc2GHdErmUfwhohewWlAZ3xLJqSHNbR13qDZdJt4+NbGuE/hNW7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=comBnp5l; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1f21:0:640:a2e6:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 9FFA980F75;
	Fri, 22 Aug 2025 08:13:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kDML0F8Mn8c0-YATuAjhl;
	Fri, 22 Aug 2025 08:13:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755839630;
	bh=vXSYq5gxkBuW0CJdxd13UHRDVKuqteSU5VS1DhuTh94=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=comBnp5l+KTUZWjLohAMmx23tCbrutpzp/+LisNRGjWxlhFVY+yxsIa2JUQtiGBdB
	 js9UO9O7yB1nlW5u8niU12o4WKhUl5fVNLttepGasnPhKGiCwdHYzbB9syZSaiGQwn
	 TKiUKP4AllJM2i8ITcu04RRJHgXTDIYOS2AHmN2s=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Fri, 22 Aug 2025 08:13:43 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
 sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250822081343.4041a3d5@nimda.home>
In-Reply-To: <20250821092137.wttiixhiidt27hnq@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
	<20250821092137.wttiixhiidt27hnq@vireshk-i7>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 14:51:37 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 21-08-25, 12:16, Onur =C3=96zkan wrote:
> > Simplifies error handling by replacing the manual check
> > of the return value with the `to_result` helper.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/opp.rs | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> > index 08126035d2c6..9d79c2816af5 100644
> > --- a/rust/kernel/opp.rs
> > +++ b/rust/kernel/opp.rs
> > @@ -12,7 +12,7 @@
> >      clk::Hertz,
> >      cpumask::{Cpumask, CpumaskVar},
> >      device::Device,
> > -    error::{code::*, from_err_ptr, from_result, to_result, Error,
> > Result, VTABLE_DEFAULT_ERROR},
> > +    error::{code::*, from_err_ptr, from_result, to_result, Result,
> > VTABLE_DEFAULT_ERROR}, ffi::c_ulong,
> >      prelude::*,
> >      str::CString,
> > @@ -500,11 +500,8 @@ pub fn set(self, dev: &Device) ->
> > Result<ConfigToken> { // requirements. The OPP core guarantees not
> > to access fields of [`Config`] after this call // and so we don't
> > need to save a copy of them for future use. let ret =3D unsafe {
> > bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
> > -        if ret < 0 {
> > -            Err(Error::from_errno(ret))
> > -        } else {
> > -            Ok(ConfigToken(ret))
> > -        }
> > +
> > +        to_result(ret).map(|()| ConfigToken(ret))
> >      }
> >=20
> >      /// Config's clk callback.
> > @@ -713,11 +710,8 @@ pub fn opp_count(&self) -> Result<u32> {
> >          // SAFETY: The requirements are satisfied by the existence
> > of [`Device`] and its safety // requirements.
> >          let ret =3D unsafe {
> > bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
> > -        if ret < 0 {
> > -            Err(Error::from_errno(ret))
> > -        } else {
> > -            Ok(ret as u32)
> > -        }
> > +
> > +        to_result(ret).map(|()| ret as u32)
> >      }
>=20
> I would get rid of `ret` as well in both the cases, like it is done by
> other users of `to_result()`.
>=20

`ret` is returned at the end unlike other `to_result` usages in other
functions.

-Onur

