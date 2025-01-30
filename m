Return-Path: <linux-pm+bounces-21114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27AA228C7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 07:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9567A295A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD019048F;
	Thu, 30 Jan 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b="1+hEJYBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pA19uaPq"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662811898F2;
	Thu, 30 Jan 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217307; cv=none; b=fFsG/rb0hvS0AvdzD+iWaZJlWl4NQplL1OOWKWi27ex9qcsWkjA0JF8+R3cniFSP71Q2l7j9Wi3zTVZqDnbu+5//Al+xwg73oWzQaVFl6IhATp8bxXSvwpTSL/kKEwfzrFKWHtJcrY6UqUvA8j7RI8QVsDLs6e5dg09jXJgjrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217307; c=relaxed/simple;
	bh=hWxX0k8NfWnIIBYC4hnebw+/2oeVHme7dZRUuFADz/Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U7LVDHutFs6wrizdckxUrwFFbdEl/zZYAPBY8AzM5L2jVuVvZwBgAI9dGKQbORDmvO2tYoE02joIzPAx6CpC0dGYAdRHA2QJn/TA1H6E2/O2IM0+QkxCKae4kyEtFSyur9jf8Oacf5QYwGgrbkyzN+mqy1X2O8XzjabrcSR3yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu; spf=pass smtp.mailfrom=astier.eu; dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b=1+hEJYBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pA19uaPq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astier.eu
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 12E321140168;
	Thu, 30 Jan 2025 01:08:24 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 01:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738217303;
	 x=1738303703; bh=eXlxeAbfF+h/MVR2CK24l8IlVBLEsznJYpx0+feHxYY=; b=
	1+hEJYBp5STrJrCmuvGpK9zMFz6e0UFBjwmO7gzlGRp5U/XTPWLSidnCvJbahlMR
	8/xFbwxHCeWgG0+vKcQaPY5K0Uw0P8+j77a+LPAhaBHMQisuvu6JVBZsD2kHdj8x
	uDwKJTs5RhEBZWFv/yhzeCK4p5uCLKIGi8sPG9EZFOTtBceNRbDurQc0+OxXfSXP
	2oMxgWrZ9RFL3LHU1GltFTlErl8rcpywhzFu1ZbNT1eSvfDW6DXLkikVp+4gi5AQ
	68hr9xgorfupFzW1DmjhKpCth7ULVOIXN/KfuesONQXu9bY8GAFeelW5gLSPyPH8
	Cls/emIrbsnlO/JTa5ojfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738217303; x=
	1738303703; bh=eXlxeAbfF+h/MVR2CK24l8IlVBLEsznJYpx0+feHxYY=; b=p
	A19uaPqwp/V7coy8JuMqKnU2g+QEzJYYk4KT/JyjIkMeqHO5CIXcETzDzscf5FbC
	5es2dPJa2p7DfCg7pCkMl+fC3lbeo2aXzpEk1j7Hdit0URZ7kHDGMF4oLrInBEZ2
	+9PVYPfXgcjtoom7CdpdQMorvpYLVG9oUMDy3suFRMnIIWmSDP9Ps3dv3OAh1cHn
	vGQMmsX7nkRn/ZHmHXQsGbIXHqjFMb/DHR98AIxdlr+Zbcfz4fRrybRjeiSj1lMD
	HHHeqw6TBQrGlYQUW1VQyEpAz1JkF2OE3LiQ8Uso16JGu0TPVI63wcGsAwFt0h02
	oDBcC5mT3+PW6gBZzUxGA==
X-ME-Sender: <xms:VxebZ_ZQzhcvFY4M0z4rNHy_bM8t_-LjrbhgL5CqrU8goOFacsUjmA>
    <xme:VxebZ-aYU76BpzFae4Nnr2HQomAYhkooQ1wWPBKKaOty129dFFT_rp_1KB87D0EZW
    wjQlMVtoFQDhPl93Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    ofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnihhsshgvuc
    etshhtihgvrhdfuceorghnihhsshgvsegrshhtihgvrhdrvghuqeenucggtffrrghtthgv
    rhhnpeelkeegvddtudduheeugfejiedvgffggeeiueeuveevkeelgeeljeefgedvtdeihe
    enucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrnhhishhsvgesrghsthhivghrrdgvuhdpnhgspg
    hrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprg
    drhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvhhinhgtvghnthdrghhuihhtthhotheslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:VxebZx8WX4TEvLHGAWX_jt1xf4PVNVADi63R3Yyb4S5VULGg3Ebaaw>
    <xmx:VxebZ1qx01XW7gelKc2dT7GkhXFW74GrRHj5I0OjXljHAq6O2Nlu1w>
    <xmx:VxebZ6ojtYOHwxNp0ZGZwXlwiNM74Zj6lyLDgZ0i49Ejcc0IY-WudQ>
    <xmx:VxebZ7SHyZ_0y1kP1PH5INzlSoCaHmBinlM62CLEhxMzJoKuuxaQww>
    <xmx:VxebZ1Bnfg7LN-2DJKoUhPrdmW9acqMiryilfD6EQ5z-oRP_Y7W_1RJu>
Feedback-ID: iccec46d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 73E5929C006F; Thu, 30 Jan 2025 01:08:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jan 2025 07:08:04 +0100
From: "Anisse Astier" <anisse@astier.eu>
To: "Viresh Kumar" <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, "Vincent Guittot" <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Message-Id: <4919d080-43e4-41e3-a392-fddb1aac2666@app.fastmail.com>
In-Reply-To: <20250130045814.ve2jsdi3wmzdlhbw@vireshk-i7>
References: <20250122131812.466080-1-anisse@astier.eu>
 <20250122133952.501055-1-anisse@astier.eu>
 <20250130045814.ve2jsdi3wmzdlhbw@vireshk-i7>
Subject: Re: [PATCH v2] rust: macros: enable use of hyphens in module names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Jeu 30 janv 2025, =C3=A0 05:58, Viresh Kumar a =C3=A9crit=E2=80=AF:
> On 22-01-25, 14:39, Anisse Astier wrote:
>> +    /* Rust does not allow hyphens in identifiers, use underscore in=
stead */
>> +    let name_identifier =3D info.name.replace("-", "_");
>
> With CLIPPY=3D1 W=3D1, this gives:
>
> warning: single-character string constant used as pattern
>    --> /mnt/ssd/all/work/repos/kernel/linux/rust/macros/module.rs:186:=
45
>     |
> 186 |     let name_identifier =3D info.name.replace("-", "_");
>     |                                             ^^^ help: consider=20
> using a `char`: `'-'`
>     |
>     =3D help: for further information visit=20
> https://rust-lang.github.io/rust-clippy/master/index.html#single_char_=
pattern
>     =3D note: `-W clippy::single-char-pattern` implied by `-W clippy::=
all`
>     =3D help: to override `-W clippy::all` add=20
> `#[allow(clippy::single_char_pattern)]`
>
> warning: 1 warning emitted
>
> This fixes it:
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 1eff30d2ca6a..2e740bbdb598 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -183,7 +183,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStre=
am {
>      let info =3D ModuleInfo::parse(&mut it);
>
>      /* Rust does not allow hyphens in identifiers, use underscore ins=
tead */
> -    let name_identifier =3D info.name.replace("-", "_");
> +    let name_identifier =3D info.name.replace('-', "_");
>      let mut modinfo =3D ModInfoBuilder::new(name_identifier.as_ref());
>      if let Some(author) =3D info.author {
>          modinfo.emit("author", &author);
>
>
> Will include it in my V8 now, unless you have any objections to it.

No objections and nice catch!

Regards,

Anisse=20

