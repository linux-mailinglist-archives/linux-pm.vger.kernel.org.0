Return-Path: <linux-pm+bounces-27653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E2AC3E51
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3788C176D98
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB71F7580;
	Mon, 26 May 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvv8IKZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88301F4180;
	Mon, 26 May 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748257751; cv=none; b=nJe/az0XbNBpYirCPRBq5T93coUsdsdaK5Cs9rxNiRkK81tVESxFw+xfHyK8opmYugzpTbxHtbPhaNtA32OFVpbyueoByOu01QoOSvkG2MGpOg3w6qhbVF0bm1A2sZ4AgNPhHUmMdTYUd6LDgM1p90zLmvgv8gNT5TkHENCtAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748257751; c=relaxed/simple;
	bh=AsfpaPTDC+OYbgOCC0jEDUUnbLPKEPdMFbZHZ4SKdh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/uRB4XMdoKgCLh5PK6r/lRoZaK6LdC74SI+ssvj9xmfdy/XuoB6ytL5YN5yeJ3HtFdGuqi72CfEPuSPY9Go6D1DXRmCkKTndMA/OWQlChyqcaCIK1CePPXBxiGYjJasQCXLW97/yE/66kEfR+gBg276AkEwHoVSdisU1fdtIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvv8IKZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189C1C4CEF4;
	Mon, 26 May 2025 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748257751;
	bh=AsfpaPTDC+OYbgOCC0jEDUUnbLPKEPdMFbZHZ4SKdh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rvv8IKZwV7//CReWxIASz+vn2B/lgb/ziIEmWFhe05CpYYODJr4yabe8Wrw1T3tna
	 I6z0oZkGKl0jb4krW/mmRXZJdrxdpai7TJ6kJyrcfc7yUt9C6QBBPbYiZDGm5pbhEL
	 RWHAcKg5ucUA9mPTQOXPuoGgGKAMEU1PvWF5rAFL4tkm9g+h1Kzob8YBhneNLAaYQk
	 K4BYv0QgjEp/mEqs66DzAzvk5d2Ux8f1LINwAHg08LOIz09wJrO/GsXGMw0+5R6TjK
	 MCCwsYWVEXenUMwCXQXSo+mh2pDdsgQQ0FDdTbWCzgD8PLqJFNHA/RGfXD61c5EQ+G
	 2kK/jLo4GoH1g==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-400fa6eafa9so1222041b6e.1;
        Mon, 26 May 2025 04:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3r8UbTf/OREUjbEZeEUJ1d0IWLANmulheGZorCeq0bNdbMrtKqlGP9jgtvMH9CPUrO/l58IdiK5Kk4Lg=@vger.kernel.org, AJvYcCUSP5MTW3bjpsabbac4/UPl/1nkXMB6Q1WIGald7CLGOgBUgCgd3PbZ86RSr74XeoWj8IUTkWcyX62XYlAN+eo=@vger.kernel.org, AJvYcCXrps8ELbxJJTOkF3c9h14ijzUmJngV2GyEj5J3ibg0vZGJuvbDwNOpzp6YbCGUbpETP6pYvkKjJkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8PBP/Mekcvhzp67oDK20Zo2oVAH+zWWzFT+PFc9MA/NdlZJA
	pd615W2DVbT19gqeeYgTUR5CAiMF2CsztCkKeJlG5AHE8+HDl3+sUEAk7dwlWHwwA6I3q7seAp1
	TE+CgfkN/gMGCVIq5aV6Hf73fBb2YYZI=
X-Google-Smtp-Source: AGHT+IFOeaPpPGmYn7dVAaU+KM8QqAb/9uaFoMYACp+Z/v1FEQ0CuwF9UtmQD2LKWYhzbyNsqmfJzpkzY3j5ntJfQuM=
X-Received: by 2002:a05:6808:1a24:b0:404:a009:630b with SMTP id
 5614622812f47-40646874847mr5236886b6e.39.1748257750304; Mon, 26 May 2025
 04:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a80bfedcb4d94531dc27d3b48062db5042078e88.1748237646.git.viresh.kumar@linaro.org>
In-Reply-To: <a80bfedcb4d94531dc27d3b48062db5042078e88.1748237646.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 May 2025 13:08:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5-8U5HbDHjx8C+Z3eX3M0sfE_FV+O29HY04eWoecfJQ@mail.gmail.com>
X-Gm-Features: AX0GCFtYCnEaJcZ6GzBtfXoM8p2Uo3heQzV1-lGDSlStuT03-KN64WF9iTd_FzA
Message-ID: <CAJZ5v0j5-8U5HbDHjx8C+Z3eX3M0sfE_FV+O29HY04eWoecfJQ@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: Make the doctest example depend on CONFIG_OF
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 7:35=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The doctest example uses a function only available for CONFIG_OF and so
> the build with doc tests fails when it isn't enabled.
>
>   error[E0599]: no function or associated item named `from_of_cpumask`
>   found for struct `rust_doctest_kernel_alloc_kbox_rs_4::kernel::opp::Tab=
le`
>   in the current scope
>
> Fix this by making the doctest depend on CONFIG_OF.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505260856.ZQWHW2xT-lkp@i=
ntel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rafael,
>
> Please apply this directly, if no one objects to it. Thanks.

Done, thanks!

>
>  rust/kernel/opp.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 212555dacd45..c2bdc11f3999 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -582,6 +582,7 @@ extern "C" fn config_regulators(
>  /// use kernel::opp::Table;
>  /// use kernel::types::ARef;
>  ///
> +/// #[cfg(CONFIG_OF)]
>  /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) ->=
 Result<Table> {
>  ///     let mut opp_table =3D Table::from_of_cpumask(dev, mask)?;
>  ///
> --
> 2.31.1.272.g89b43f80a514
>

