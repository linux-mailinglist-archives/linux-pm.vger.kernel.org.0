Return-Path: <linux-pm+bounces-27319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5142ABB6AB
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5683B5D71
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC711F03D4;
	Mon, 19 May 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWHW5T38"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8F142E83;
	Mon, 19 May 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641636; cv=none; b=JW2UxB6ITkMW6srQVKMwt+PN0E7GfwAvs8zXUzX97YK7gs16MEMqYeHs87KBfmisY1wxCxhxjviY4yjgMmufQC1kLUGJkHVYiksy5EMz0WRzoCZqeXLIKUrAwFpWT2gfE1MXxIe1BLl1m2tFYXGdNE1N0vOFvGPnmRAEVcFc/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641636; c=relaxed/simple;
	bh=8NFJmtCrqy2M+sgpOfFXk1sfROnmArrwPBKg4L1GLXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sfWgzB7Ueyh5u5hzph/u5CNRrI6h/YoF2WoZUyN5oNwD1u1RFAJFDG44ALPmcMig7GPYTNYzFB7n97Cez7taTnVeGMvBDJ+oDU5w4t0q7dj6lgtLbhdELhuEI0wOlUGoP0xyI2PfxzAvhwtu/z+twXzETndlnvIUNpKq02P7fOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWHW5T38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B6AC4CEE4;
	Mon, 19 May 2025 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747641635;
	bh=8NFJmtCrqy2M+sgpOfFXk1sfROnmArrwPBKg4L1GLXI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oWHW5T38bj54HB2n5rv0HTOKrEyKNgsfQ9EwaIV41lzuCXOfDAiB6EEeOMnF/dxme
	 q5jHVXwoLZhsfUms3QfthBspiyV79nhxwuhuANNGvGLo9mxH962hBWGGdWC4LpLCmt
	 hEgqTfgW50KDGDkIe5EUGYO91SVSGjo48xg+1tRgDi2Hy1KHSCVVg7ZyNdhdizt6TA
	 Ku+aYrnVPS3lXgM2MRovs5QQ3edkIrceJ//XlCHSODIdkueKrpYDctUr2pnm3LxvlA
	 Qdl3z/FKHk9DdoGl3ymJ7iojBdSCXTa6meqGmGuXmH1g1xkvFcX36KxbGC/apxxjGy
	 S56JPPm2YIf/A==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:00:27 +0200
Message-Id: <D9ZZ93ZGKC3N.9VGUE5QBJS4H@kernel.org>
Cc: <linux-pm@vger.kernel.org>, "Vincent Guittot"
 <vincent.guittot@linaro.org>, "Stephen Boyd" <sboyd@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, <rust-for-linux@vger.kernel.org>, "Manos Pitsidianakis"
 <manos.pitsidianakis@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Joakim Bech" <joakim.bech@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Yury Norov" <yury.norov@gmail.com>, "Burak
 Emir" <bqe@google.com>, "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Russell King" <linux@armlinux.org.uk>, <linux-clk@vger.kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Anisse Astier" <anisse@astier.eu>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 06/15] rust: macros: enable use of hyphens in module
 names
From: "Benno Lossin" <lossin@kernel.org>
To: "Viresh Kumar" <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Danilo Krummrich" <dakr@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>
In-Reply-To: <21b4c30db60f22d56cc6386a18564705ad3a6f4a.1747634382.git.viresh.kumar@linaro.org>

On Mon May 19, 2025 at 9:07 AM CEST, Viresh Kumar wrote:
> From: Anisse Astier <anisse@astier.eu>
>
> Some modules might need naming that contains hyphens "-" to match the
> auto-probing by name in the platform devices that comes from the device
> tree.
>
> But rust identifiers cannot contain hyphens, so replace the module name
> by an underscore anywhere we'd use it as an identifier.

I think this is supposed to read "But Rust identifier cannot contain
hyphens, so replace them with underscores.".

> Signed-off-by: Anisse Astier <anisse@astier.eu>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> [Viresh: Replace "-" with '-', and fix line length checkpatch warnings]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/macros/module.rs | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

One nit below, with or without:

Reviewed-by: Benno Lossin <lossin@kernel.org>

> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a9418fbc9b44..27cc72d474f0 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -185,7 +185,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
> =20
>      let info =3D ModuleInfo::parse(&mut it);
> =20
> -    let mut modinfo =3D ModInfoBuilder::new(info.name.as_ref());
> +    /* Rust does not allow hyphens in identifiers, use underscore instea=
d */
> +    let name_identifier =3D info.name.replace('-', "_");

I think we could just name this variable `ident`.

---
Cheers,
Benno

> +    let mut modinfo =3D ModInfoBuilder::new(name_identifier.as_ref());
>      if let Some(author) =3D info.author {
>          modinfo.emit("author", &author);
>      }

