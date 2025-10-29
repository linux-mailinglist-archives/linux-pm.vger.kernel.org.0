Return-Path: <linux-pm+bounces-37039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F90C1BA98
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E049A4639BD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA827A462;
	Wed, 29 Oct 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giJvfqVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C41279DA2
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747901; cv=none; b=d9PtNIjp5JK04LweOmGAZKwJEvIVw2ZDma3eVMSQaJpdwszFXQQCDk7xbc35LPV7/I2uSmnTPec7dD6MhT5Atc+u//LzoDKHzCydWqVnDrgeMymdlXPU/lZLOtngzCuHlkljMG6raPfuskEVwm5GhuzOf1G+7yzBXAQKWeHDkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747901; c=relaxed/simple;
	bh=dqZSqtntTOipLiF8oPEqjYXjSpDiaCNQdpkQoZsoi3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMoBzcJtmBrP+5a+HCTo1RGkYU8yNwPtTFnH01yFtTNpEVy77N+Ib1+ejTdPQqyX/j6WC/VAEf649x4okQgLqTh6WhWkWe4Pr0gu0oSwvlYsKujd0VBjluKt6bW2KSFgTDlCk1ftVPNF2WfVv1KDNFs6dylgd1TwRVM2B/FVL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giJvfqVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D1EC4CEFF
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747900;
	bh=dqZSqtntTOipLiF8oPEqjYXjSpDiaCNQdpkQoZsoi3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=giJvfqVwZOy7YjzoM3Fpj/jgMIWEVlqIf4WDD6V5T8ulveqP991QN3A2nk6UzKS4y
	 Pkv2D2tdt3GzxzgoFJHtj6vsN+7eWKra4Xcs/Sux/J6aJSrv+IZMmt/jArGV0VLSY3
	 +7+gbEfrnRkBo6fZDLvcSuz5I8pj5w1pJ/YrA854MZmulEjYFuVvo8+418ZXhS/f4w
	 bozEZ5kgqfG4Cmgec2IwGPObJUO1fV9V8JrXub3RuXcJB127tdggRby83sM0X74rPC
	 NMmajcpVIxNVPUv7L95BHhRONAJXD/DhMo2t3TnIcvpd+P7pzX0tMYsDTU5momvEuo
	 g4PSkXKd75i6w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378cfbf83f2so78229501fa.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 07:25:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTugKVtgl15ULBBm5JGbR/sXW6eB1jF17bWzhontFPe6WTcn/4JOz9K+xgeK3mA4PuTWErF3ix+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmL+CB2f1wmuJ6pa5+ypp8sUCLtBQbhMUvu0KcTaO0H3BM+4W
	6uF+mzHFE7SoR/ywXjulbk832ZGSvbf+xAiSiKxp5kaWgN/7HQCd8z9TiThWlui2B5WaB5jnSVs
	eH0Xq7m2kHPAQvMvyIRdQRs/HNkV8fnQ=
X-Google-Smtp-Source: AGHT+IG08iR/V42mpNB35NOAnu0WR91SrLZTaX7XGur3BfecVN0sXWpkJXNZietA4D5t9rmA0IoHL1UMvAvSjZy9kH8=
X-Received: by 2002:a2e:a9ab:0:b0:36d:4996:1c26 with SMTP id
 38308e7fff4ca-37a052df5b6mr9418971fa.11.1761747899137; Wed, 29 Oct 2025
 07:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org> <gjlcd7nrmipdpim4dr2kfrk5mleo2yt2btwbhxdflzfcpckjjl@fieqlaavqja2>
In-Reply-To: <gjlcd7nrmipdpim4dr2kfrk5mleo2yt2btwbhxdflzfcpckjjl@fieqlaavqja2>
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 29 Oct 2025 10:24:22 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9=QNo670XQ11TsDMorgsRz4g1VhX_9qVUf8Za3Q44Jh7g@mail.gmail.com>
X-Gm-Features: AWmQ_bmXTyiyHdJXy1DaEY9XPIqnjeI1PZ2QkmBXT8wyfiHJcaumtKIkHOAH4nw
Message-ID: <CAJ-ks9=QNo670XQ11TsDMorgsRz4g1VhX_9qVUf8Za3Q44Jh7g@mail.gmail.com>
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

On Thu, Oct 23, 2025 at 11:23=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 23-10-25, 09:59, Tamir Duberstein wrote:
> > Use `Option` combinators to make this a bit less noisy.
> >
> > Wrap the `dev_pm_opp_set_config` operation in a closure and use type
> > ascription to leverage the compiler to check for use after free.
> >
> > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> > ---
> > Note: this diff is much smaller with whitespace suppressed (`-w`).
> >
> > An alternative approach to compiler checking for UAF that doesn't chang=
e
> > indentation is to add `drop((self, clk_names, regulator_names))` after
> > `let ret =3D ...;` but that felt more prone to becoming out of date if
> > more owned data needed to be added to the function scope.
> > ---
> > Changes in v2:
> > - Avoid use after free; add compiler checking. (Thanks Viresh!)
> > - Link to v1: https://patch.msgid.link/20251020-opp-simpler-code-v1-1-0=
4f7f447712f@kernel.org
> > ---
> >  rust/kernel/opp.rs | 112 +++++++++++++++++++++++++++------------------=
--------
> >  1 file changed, 58 insertions(+), 54 deletions(-)
>
> Thanks, tested this and it works.
>
> Lets see if someone has any more inputs, otherwise I can apply it.

Thanks for testing! Doesn't look like anyone has opinions. Good to go?

