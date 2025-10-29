Return-Path: <linux-pm+bounces-37040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24727C1B504
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888B3587FC1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF94289378;
	Wed, 29 Oct 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDvjonVW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395122505AA
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747986; cv=none; b=UhDVgnVtASutnAmrVVykBpBGsB6J25PJQRY0DOVNp4+6DKxyVyv5RQhsN08ubwASnGe8qeDnv5xukn2cmBPOKfsrfEbrkAzmcZTHJhslrEeZBQTWbRpqyyXJCDqmCA6f2iCQBvGtNff6RAnfsdeDi8P87d3jTDWpT54XDAzC28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747986; c=relaxed/simple;
	bh=deFMZQXNY8fLOTRmMsgqeUpBMjR1GPSusJKEB2KZqZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvL9iQSnIzYF4irn9QmvmZVOddUOVRnzIhBsasI0bqyEyBxxauwqeN0SB/MBtXGt8vDLuVTXaJKfSbSxp0aG01HnSwoeFh1KFicEKZums6orwPBmZuGO1TEzars/Uu2Og5SPlc0lRdKc+Jk1I/kUqs395GPRabPyWVBrUhUElEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDvjonVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3657C16AAE
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747985;
	bh=deFMZQXNY8fLOTRmMsgqeUpBMjR1GPSusJKEB2KZqZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDvjonVW3y52MO5l9LcJGfcIzDHlrYpReo/+R+YmWkfQkczPAlj3cHhKwvrTw6s92
	 mXXjiDGDc5rDrjOG1sRuotntAK80LIVSU082OmDEsrJ8vcsDzGNXX4dP1kPUH8DSnA
	 CSo0tD39o89iYeccOHLm0fkUakyUOkmUvxbtA4ZYG0JVuji1Fm/MV54TVTIXBNaYQf
	 yKlEqP0iQQmt5UMldwvcCN63qIwH5rqGvrbdd6sP0Cxn/b5XhHnbcmtP9G1bjfc/TG
	 mqPX1i1dsokmuVJ0xhgov6wVVqCRqBGbS0cLuu9WyHlZnJmuFLDHY68A2oQyzmTDqV
	 67MrYhYPv/y9A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso78856871fa.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 07:26:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs9iJkUNfR/8y72jOWG+4ZmGBQFPlZhKn9zvHOZqIiKEXf1lpRfhU+IwJItqbyNTbYpTx4BxJLTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSYOa3lOtllk5CqR6fnflhODQuGp1gzx/HNwYJiw6duoviruQ
	MC8HYV0I1QzqVyZQBLdPm/tTALSObgLZlmbRawytcJatIoox3wDesskjs7WmTVPGuENYUm5cEmS
	e7MPkzTkix0CuiCcFLaQa0QGC7d5fWak=
X-Google-Smtp-Source: AGHT+IHtLPnk0JPcDIdcJGoxq1gKZPYo4bxdkb3wqnmpt7pouFgu14zB6uLReROjFscAOSMw0bvQHWgOcApBd3m3W5A=
X-Received: by 2002:a2e:a98d:0:b0:378:e84c:d159 with SMTP id
 38308e7fff4ca-37a023b0513mr11407331fa.5.1761747984618; Wed, 29 Oct 2025
 07:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>
 <gjlcd7nrmipdpim4dr2kfrk5mleo2yt2btwbhxdflzfcpckjjl@fieqlaavqja2> <CAJ-ks9=QNo670XQ11TsDMorgsRz4g1VhX_9qVUf8Za3Q44Jh7g@mail.gmail.com>
In-Reply-To: <CAJ-ks9=QNo670XQ11TsDMorgsRz4g1VhX_9qVUf8Za3Q44Jh7g@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 29 Oct 2025 10:25:48 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9nP6sWg4sR33caTDs3rr7Qkv=fg0LQQ4eCpjKA7VPF=mA@mail.gmail.com>
X-Gm-Features: AWmQ_bkcBbckDOJo8gs6NJc7cFiyvba2tnkwitSB4WrtxXYEDF5uJbanvPwcfrE
Message-ID: <CAJ-ks9nP6sWg4sR33caTDs3rr7Qkv=fg0LQQ4eCpjKA7VPF=mA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: opp: simplify callers of `to_c_str_array`
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

On Wed, Oct 29, 2025 at 10:24=E2=80=AFAM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 11:23=E2=80=AFAM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> >
> > On 23-10-25, 09:59, Tamir Duberstein wrote:
> > > Use `Option` combinators to make this a bit less noisy.
> > >
> > > Wrap the `dev_pm_opp_set_config` operation in a closure and use type
> > > ascription to leverage the compiler to check for use after free.
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> > > ---
> > > Note: this diff is much smaller with whitespace suppressed (`-w`).
> > >
> > > An alternative approach to compiler checking for UAF that doesn't cha=
nge
> > > indentation is to add `drop((self, clk_names, regulator_names))` afte=
r
> > > `let ret =3D ...;` but that felt more prone to becoming out of date i=
f
> > > more owned data needed to be added to the function scope.
> > > ---
> > > Changes in v2:
> > > - Avoid use after free; add compiler checking. (Thanks Viresh!)
> > > - Link to v1: https://patch.msgid.link/20251020-opp-simpler-code-v1-1=
-04f7f447712f@kernel.org
> > > ---
> > >  rust/kernel/opp.rs | 112 +++++++++++++++++++++++++++----------------=
----------
> > >  1 file changed, 58 insertions(+), 54 deletions(-)
> >
> > Thanks, tested this and it works.
> >
> > Lets see if someone has any more inputs, otherwise I can apply it.
>
> Thanks for testing! Doesn't look like anyone has opinions. Good to go?

Ah I see you've already applied it. Thanks!

