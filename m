Return-Path: <linux-pm+bounces-8777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061EF900137
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E9B231D9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9F1862A1;
	Fri,  7 Jun 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln5YiZc6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7E186281
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757509; cv=none; b=DgroqGwXd+CKYVmLJMYr5GvTQAbgTeYbz5TY03cwdomznILipcve+U2f+kPzV2BrG0Z1uneBbK5YdjYQFPfUmzlJwd7uRqq/nZkNseUJy29qSaGbx5/cu+/cpbXVIF0ozPMucctetFTsa22QQaFWfmbYSLyNsprp6AoL/IIcIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757509; c=relaxed/simple;
	bh=FFbj21ozJQKf4i41vhO+He8GzAZG9POBGWSpHtgddTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckEi7DXUIAP7uqMy8jXJk1SnrT37Q/ZhBOngGK9yt2QVuy7YaHD3JUXyA5MO5bC1teFwxHYst3C2csuJ8gWfkYVy0AUGlRJSkSxBspR8SGhVBt2XaxzzI5eaFQAmq+oXxoljklaq8alDDzF6Fmzi/H9U5xP4eufoue1/UCe9KXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ln5YiZc6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso19834761fa.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717757506; x=1718362306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmeXUhFF655AvDeF8viECIcXvU5zP377LCGo+5Zcuww=;
        b=Ln5YiZc6E7N94HOps5slmYwc9HJA7Ba9+LauR5+WSsJFdeB1/iRMZEPKoD7NO8ajvv
         mGHMtcmji+J5fTo5hVYtcV6AzKYTJDluItgCGWyt7yGpxPrvmB/qX/uObZ4/AgRaf8fU
         W6Kxh+S4AaXzcl41LmkI+uVRGOV3J34hidxM/S5ym2zsHs45iWNpBpSxoYaJmqFA3lWX
         A6XGlNxINwrX5KBuKArVbh92vUuQVPMmesL+J/O7b7+cjlSYIF3p11dyV7l5jzE+w7Tw
         3WQXijnJQbjl+X5hFbKzogmnfHPc4+wHjl5h1tBZsL9Boqu5t+oKqpm1iSRQ0vJ8iggM
         +FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757506; x=1718362306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmeXUhFF655AvDeF8viECIcXvU5zP377LCGo+5Zcuww=;
        b=wQ8xDhF4VuD9Yn2ycp1YE/gQTVJ6etVoSQxqD55tNPWKAGv9X4bVavVFhB9ES+7CU8
         pswR/Bt94PKjov6oTz7c89Ci+qQ0DEwnOfb4hQZ93GnK3VbRDQ6pTfbxls14NoOVp/6r
         QLaauu6zrcBDPXUJ0H0hhk99O6IcCbv6mxn2l1M5QJcj14WGX2LV6kiXBCQI2xOzsrNF
         aOKVzSuQc605bwefWjleiLAQbQZoFy9WFfSq5oi3QS48d+GjZd/qeEjz/KiW7dYWh5Yl
         LEboyOH4+jj7YRhWbPRVr0vl8g9vv0qwwADpxZ29UeG9BarBj2LHAYBgKuxct8lTrE8g
         rsFA==
X-Forwarded-Encrypted: i=1; AJvYcCXRkxS3nVENqkdWP29Cg8a6DYbDQJ4hDtvpj0BcKgGEfXF1EGtqxGJfrnkNQCGh126Er3FsDH/61+CPoYaElFmWGZo+7RjLSNQ=
X-Gm-Message-State: AOJu0YxbjOTHkRRVwZTqcZ5rw7rhaOHFasLEAN25yXof7b4T3v8SzuA6
	2RAr93QDTVc5k/aFpt41RH3SS14OpSv6suSqn4vucN3ga2Yyr2Q7vY1yepvXfr2OmgwexE2fPrs
	UoCCpu4z2kUqWLGgrjgH2/Me7UCR0YDeYqPn+
X-Google-Smtp-Source: AGHT+IEFeA+ZKzhPTRkU9THjSAXPFZL65kZKzyqLrJjbcP6cigRGWjQ8n8Uxp6WFaK9P/DGcdNOxRalnf+pNS3YoNsA=
X-Received: by 2002:a2e:88c6:0:b0:2ea:8291:c667 with SMTP id
 38308e7fff4ca-2eadce24b75mr13406881fa.13.1717757505728; Fri, 07 Jun 2024
 03:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717750631.git.viresh.kumar@linaro.org> <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Jun 2024 12:51:33 +0200
Message-ID: <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:12=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> This commit adds initial Rust bindings for the Operating performance
> points (OPP) core. This adds bindings for `struct dev_pm_opp` and
> `struct dev_pm_opp_data` to begin with.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

> +//! Operating performance points.
> +//!
> +//! This module provides bindings for interacting with the OPP subsystem=
.
> +//!
> +//! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux=
/pm_opp.h)

Please use srctree links instead.

C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)

> +impl OPP {
> +    /// Creates a reference to a [`OPP`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for=
 the lifetime of the
> +    /// returned [`OPP`] reference.
> +    pub unsafe fn from_ptr_owned(ptr: *mut bindings::dev_pm_opp) -> Resu=
lt<ARef<Self>> {
> +        let ptr =3D ptr::NonNull::new(ptr).ok_or(ENODEV)?;
> +
> +        // SAFETY: The safety requirements guarantee the validity of the=
 pointer.
> +        //
> +        // INVARIANT: The refcount is already incremented by the C API t=
hat returned the pointer,
> +        // and we pass ownership of the refcount to the new `ARef<OPP>`.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }
> +
> +    /// Creates a reference to a [`OPP`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for=
 the lifetime of the
> +    /// returned [`OPP`] reference.
> +    pub unsafe fn from_ptr(ptr: *mut bindings::dev_pm_opp) -> Result<ARe=
f<Self>> {
> +        let opp =3D unsafe { Self::from_ptr_owned(ptr) }?;
> +
> +        // Take an extra reference to the OPP since the caller didn't ta=
ke it.
> +        opp.inc_ref();
> +
> +        Ok(opp)
> +    }

I would recommend a slightly different approach here. You can provide
a method called `from_raw_opp` that takes a *mut bindings::dev_pm_opp
and returns a &Self. The ARef type provides a method that converts
&Self to ARef<Self> by taking a refcount. This way, users would also
be able to call OPP methods without giving Rust any refcounts. You can
compare to my file patchset, where I am going to rename the equivalent
method to `from_raw_file` in the next version.

As for `from_ptr_owned`, I would probably rename it to
`from_raw_opp_owned` or similar. It's often nice to use a more
descriptive name than just "ptr".

> +    fn as_mut_ptr(&self) -> *mut bindings::dev_pm_opp {
> +        self.0.get()
> +    }

I think most existing examples call this `as_raw` and mark it `#[inline]`.

> +    /// Adds an OPP dynamically.
> +    pub fn add(dev: ARef<Device>, mut data: Data) -> Result<()> {
> +        // SAFETY: The requirements are satisfied by the existence of `D=
evice` and its safety
> +        // requirements.
> +        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_raw()=
, &mut data.0) })
> +    }
> +
> +    /// Removes a dynamically added OPP.
> +    pub fn remove(dev: ARef<Device>, freq: u64) {
> +        // SAFETY: The requirements are satisfied by the existence of `D=
evice` and its safety
> +        // requirements.
> +        unsafe { bindings::dev_pm_opp_remove(dev.as_raw(), freq) };
> +    }

Is it intentional that these methods take ownership of a refcount to
the device that it then drops after calling the C function?

Also, why are these methods defined on OPP when they appear to be
methods on Device and don't take any OPP argument?

Alice

