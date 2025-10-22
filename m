Return-Path: <linux-pm+bounces-36646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50CBFBA06
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3B11A06390
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA57336ECE;
	Wed, 22 Oct 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMEdatID"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777F334C36
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132188; cv=none; b=d5OP9UuguvTnCBi1FWv4t2gnAQe0inZ/FIfrFkO8hG+9wtuz+pcqrFosE61inq3UAVN0LKs/JVUqmoEWLmsgyKId0zv10VLYJP4Hsu+kqM6XeM24xlY5AgttgPIYmm7V9FPAclQgUYssaE4pUPmrlWqCBJSrHTK2x4lyamW5QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132188; c=relaxed/simple;
	bh=U0afa7d7wN4Xz1LbwkrFQCZXyat5WIi7Xyd+OHpZ2ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVrScVcPo/PT/iLOK2RPTpE4JXhpiuLnD3pPvCnZWAgdCItPRMSLWHi8uDEJ8iN2k+rLYzT3mxkUk9nucxBe78cgWj0TusJ9TJMAYtl3EkbhFAUTh6DUfFeHI1CYPtcKzpS0V0fKvtabbYMM6Iy4H/Fp6BqJTlk4diZl0bzbM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMEdatID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8200BC4CEF5
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761132188;
	bh=U0afa7d7wN4Xz1LbwkrFQCZXyat5WIi7Xyd+OHpZ2ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iMEdatID3HOuLP8OxKUNxtY/DGYO5fVTCGYNvclUj8yCdpVxPPCr9qaoTo1q6Me+9
	 B/DJGe8a646tHOnuQnxC7Qb2fxtzOTPfSUWqGp0nFc9/SJlJz2F10lUXicDX8uOyuR
	 lPOt0s/zY5MA+y8+wGq12Fe3zh/ae9i4mw+jPTtBHF9McrY5VqqC0DXsEjAVsWh2sj
	 lyOAozkiKgS3xzJRH4kSHcwIbKrmBjkvzEeV0exhieqcbL9fkQqSZa5CnSP9IPT50L
	 nj3fPNYrPMXN3I+T27GYn1Zwv0se6+MPxqk0HM0TxxK7XPjO04/iqpjK0MRZVwFQor
	 ooYkQOL+nOvUg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3637d6e9923so66067181fa.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 04:23:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxtV8pOta5Dn2Jft+0KxeWR1Eygq60UApz4NZp4H2ocChe2UUiuMvxkKnyhp2j5jDyQkYkJxa3Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQbHADGv8rW85yYgIo7mIZ3XYeGr3Aa+kCstAQUew69zv7mkZ
	El+0yglGsoIk23fLNBClPn28bX4p2sKeWUJDEYBIy9WhUilZ/tiiUXGYaNK4sPBJhKJji7RBxHA
	vzKCVtq16GRqcLeXmC9qlFRn+aH1YSNg=
X-Google-Smtp-Source: AGHT+IEbfW6o3NNRtEXdirHPWU6pJ57k7CZI4qIRqa+ZAlqNl+Wj6afptSFsAfW1J/oIYaqkLaBi3TvCZ6hOEaHvc+o=
X-Received: by 2002:a2e:a542:0:b0:337:e697:c9aa with SMTP id
 38308e7fff4ca-3779777d21amr59192211fa.15.1761132186886; Wed, 22 Oct 2025
 04:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org> <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
In-Reply-To: <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 22 Oct 2025 07:22:30 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>
X-Gm-Features: AS18NWCWh65WLuww185GeoIVtS_Sp3w1lr2gaYX18mEhtaHFucdu4WNH68pAuMk
Message-ID: <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: simplify callers of `to_c_str_array`
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Wed, Oct 22, 2025 at 1:40=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Tamir,
>
> On 20-10-25, 09:07, Tamir Duberstein wrote:
> > Use `Option` combinators to make this a bit less noisy.
> >
> > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> > ---
> >  rust/kernel/opp.rs | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> >
> > diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> > index 9d6c58178a6f..b84786f45522 100644
> > --- a/rust/kernel/opp.rs
> > +++ b/rust/kernel/opp.rs
> > @@ -443,23 +443,14 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) =
-> Result<Self> {
> >      ///
> >      /// The returned [`ConfigToken`] will remove the configuration whe=
n dropped.
> >      pub fn set(self, dev: &Device) -> Result<ConfigToken> {
> > -        let (_clk_list, clk_names) =3D match &self.clk_names {
> > -            Some(x) =3D> {
> > -                let list =3D to_c_str_array(x)?;
> > -                let ptr =3D list.as_ptr();
> > -                (Some(list), ptr)
> > -            }
> > -            None =3D> (None, ptr::null()),
> > -        };
> > -
> > -        let (_regulator_list, regulator_names) =3D match &self.regulat=
or_names {
> > -            Some(x) =3D> {
> > -                let list =3D to_c_str_array(x)?;
> > -                let ptr =3D list.as_ptr();
> > -                (Some(list), ptr)
> > -            }
> > -            None =3D> (None, ptr::null()),
> > -        };
> > +        let clk_names =3D self.clk_names.as_deref().map(to_c_str_array=
).transpose()?;
> > +        let clk_names =3D clk_names.map_or(ptr::null(), |c| c.as_ptr()=
);
> > +        let regulator_names =3D self
> > +            .regulator_names
> > +            .as_deref()
> > +            .map(to_c_str_array)
> > +            .transpose()?;
> > +        let regulator_names =3D regulator_names.map_or(ptr::null(), |c=
| c.as_ptr());
>
> I had to keep _clk_list and _regulator_list earlier to make sure the list=
 isn't
> freed while its pointer is still used (sent to dev_pm_opp_set_config()). =
Won't
> this change cause an issue here ?

I believe the `{clk,regulator}_names` vector bindings remain alive for
the whole scope, even if they are shadowed. See
https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2024&gi=
st=3D800b334c514c2024d7b5e47fc54c1f2d.

Cheers.
Tamir

