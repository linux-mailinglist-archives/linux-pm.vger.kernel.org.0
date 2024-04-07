Return-Path: <linux-pm+bounces-6013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F189B02C
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F841F21637
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA617573;
	Sun,  7 Apr 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MYK1Z1b2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9263B8;
	Sun,  7 Apr 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483669; cv=none; b=Gi2l03KCUg/sTFvOfseSqjb1L8/XSV3lXg44QjozEhkL/CtqUPL7XBM36pwbpV6Uss0y1bxdrlkqkrK+gl5rPqosLj97973HSfIkcgUcCuCCewjBAYDgT1tHodiVwKK4ifF80OthwwOiC2oGQ01YaBd0Vlyg+SHPBiRf/PWwPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483669; c=relaxed/simple;
	bh=rJcdmdSVaCU80ztqbZrjQkcR0aAJtLC4psVNrXmv+os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFPc0+FDsN9+4zNOShUvZD7Ce16JPl1XDWNQWlaWZoEQmaHO14lt73u3ahfPTmb6B2J9Y6jYf/auIrrWjsMG/qroatZ5Q98HpEEmm+cEJBusAJ3eU+zsYJA9uZWuVXZRjjvXM6UkCiahSvvu0+UjV26VzF0Ni311HM5Kqdxmsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MYK1Z1b2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712483666; x=1712742866;
	bh=8YZS8eu/oWRcKM7mzkufE33UHJldzqwP/IUT97Ck+U8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MYK1Z1b2S7tyd+lWOKFF1lJUt5Nf0YKgLQis4kkW0p0q3IGOs263WaOyQAJFKuCO+
	 U0Pwn5PPgZ0CpQKxJICDRSoa0nr6hrnYBgXUztWL35ZHiGJBxvojxRDNPLpIiDQ/Ep
	 d9RJY7NqWtRYfqZSuXBxMuEIIryPMP6WCbmMZkYbK6WPhXdTS9xosvMi95FkEIZHbN
	 kjTwMtbzo+XSbSobQDoX6+i3+NfslCtKPb4toLrlWdYXcICviA/RBLY1nnJUa6vtrs
	 2p8fjvGMvtPuO5B+UNLXWCOoDITUXsVf4E18RCeHMWfbCitY/WzRGheZEBkuMP3463
	 bzpeG9vAp0VSw==
Date: Sun, 07 Apr 2024 09:54:22 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me>
In-Reply-To: <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.24 13:09, Viresh Kumar wrote:
> +// Finds exact supply name from the OF node.
> +fn find_supply_name_exact(np: *mut bindings::device_node, name: &str) ->=
 Option<CString> {
> +    let sname =3D CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
> +
> +    // SAFETY: The OF node is guaranteed by the C code to be valid.
> +    let pp =3D unsafe { bindings::of_find_property(np, sname.as_ptr() as=
 *mut _, ptr::null_mut()) };

Drivers should avoid calling `unsafe` code as much as possible. They
also should not be calling `bindings` code directly. Please write (or
find) abstractions for these `unsafe` calls.

--=20
Cheers,
Benno

> +    if pp.is_null() {
> +        None
> +    } else {
> +        CString::try_from_fmt(fmt!("{}", name)).ok()
> +    }
> +}


