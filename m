Return-Path: <linux-pm+bounces-31620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62484B161EE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA56162AB8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2302D94BD;
	Wed, 30 Jul 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="E9hdR0Qi"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410D2D97A8;
	Wed, 30 Jul 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883617; cv=pass; b=toZJHqXNjkVtBrc4wzZVKtbujyoP3n/P2buTth07DbwkPnZyVxR+l/Tx2bvYCAFq36T6u1454+ANyI41tdFzdhFDZhYHWrx+geKbu26rwsPIoh0f7e/gwBQwa9cljFkr3CO0aPRcUjmWU4W+8OUD1AXzhGCLPAibYSPj4wzR/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883617; c=relaxed/simple;
	bh=Jx1Dkak9qnVIvoXGG0Fyb1u3c00AFlts7wrW5uDa+Hc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YY7jq9fJjd/pfM4GaOy3zotYLuJ8tVepibQCJKeUHLpRmuNUDhsyAos+ufAMocie7gKZRkDby1suR/kwcuVI7LuqmcMyYSCjIW4ENm6F8mvjIIASXGpGkkcElYxfXoWnYmh0Cr9nzImIDl+Xix1/WgVbZT+K5xxK2aA4yWbtmDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=E9hdR0Qi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753883595; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mv2jCEPms2pSZJRfqTnkUNFI2eX/giXyFEi5WWe4va2FykTEwZX/9r2XLO8CmKGTmhAvElh2HIOLRgnj7c49DLubRv5jEPjysh/KqmSioFVF3uUt2wWmxRE347l+shEY1DWcB3NU0nbRcd0WyG5XHZyeyk72GdMElKmRZSK5JU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753883595; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FRDg6VhwDKyAPe3WRc3tkSs9KfKtj9WJq1E9k2oIvow=; 
	b=kPPp+B7wAn8By9QuWOUNYDiOK6Olq1ERtMjf8KQm93/0lH5zHJCkIygr6dmwwCpkh+dVlgRHIDVig66Qh5luLHiS5K2isDY5nDIVrrfk3r8ihS4alYKzws6KZhLg4KbRhPp3dmLHIQEYJZRBD52bsV73/e3cpySKzNW7Ty8rAUY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753883595;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=FRDg6VhwDKyAPe3WRc3tkSs9KfKtj9WJq1E9k2oIvow=;
	b=E9hdR0QiA/QoiQuQx/wi4ft63vU1OT7wmus5I6T87oZReJgY2ukfUChWDUwm4O8i
	bHQoLn+H2fd+ba4SPlDSkf/AHEezILA8An/PkxY22Y2R7rTz+fSCXyXoe904ELGBBSG
	jePzVHwtwcIdB367tMx96Im2VaqhUIQSYD5DVoaU=
Received: by mx.zohomail.com with SMTPS id 1753883592221643.0644285011297;
	Wed, 30 Jul 2025 06:53:12 -0700 (PDT)
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
In-Reply-To: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Date: Wed, 30 Jul 2025 10:52:55 -0300
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EDE1C11-8654-404D-98AC-0D102090C15F@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External


[=E2=80=A6]

>         }
>=20
> -        /// Enable the clock.
> +        /// Attempts to convert the [`Clk`] to a [`Prepared`] state.
>         ///
> -        /// Equivalent to the kernel's [`clk_enable`] API.
> +        /// Equivalent to the kernel's [`clk_prepare`] API.
>         ///
> -        /// [`clk_enable`]: =
https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
> +        /// [`clk_prepare`]: =
https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
>         #[inline]
> -        pub fn enable(&self) -> Result {
> -            // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for
> -            // [`clk_enable`].
> -            to_result(unsafe { bindings::clk_enable(self.as_raw()) })
> +        pub fn prepare(self) -> Result<Clk<Prepared>, =
Error<Unprepared>> {
> +            // We will be transferring the ownership of our =
`clk_get()` count to
> +            // `Clk<Prepared>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, self.0 is a valid =
argument for [`clk_prepare`].

I just noticed that some comments still refer to the old =E2=80=9Cself.0=E2=
=80=9D field, but that doesn=E2=80=99t exist anymore.

I=E2=80=99ll fix that in v2.

> +            to_result(unsafe { bindings::clk_prepare(clk.as_raw()) })
> +                .map(|()| Clk {
> +                    inner: clk.inner,
> +                    _phantom: PhantomData,
> +                })
> +                .map_err(|error| Error {
> +                    error,
> +                    clk: ManuallyDrop::into_inner(clk),
> +                })
>         }
> +    }
>=20

=E2=80=94 Daniel


