Return-Path: <linux-pm+bounces-30188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18275AF9BD0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53633B5AD7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F71E0DD8;
	Fri,  4 Jul 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipinztuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669012E3716;
	Fri,  4 Jul 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751662593; cv=none; b=jMTJAjlVHR6fsY2SlPmC2kqNZhvGChohOGxUuhL2yY0BEsDSZdCcA4Qy6MOfPbyCFZl2DYeP5ckyLzkqrowSVd9Qf++DReDd6V8XyJ96yJPKu4gR/n1dB12MyvtJVM74Qn8iYdXeBzoYGMFUBrQjSOV6MWGN2moOgAsyIf6VgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751662593; c=relaxed/simple;
	bh=/3YRFezrr8EJenY5ydJDWvYfG5QhETwTNQQul8BZb6c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=luLeybFfalGhcQ2TjPJGTbPSFEVAciI77Qd9h/Y3A1kkT/E3NH2qgoqtWINhpqd2DBsoLfzOJ6DOznQvYPG5BpytjpMcSRnX7BnTzMWS14pIagMdtjUnm3MlM6gMtalAmLBqeGYnQBlqYnhWB2EiEBHm4fl24W6QiUT8t5u/qCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipinztuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FCCC4CEE3;
	Fri,  4 Jul 2025 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751662592;
	bh=/3YRFezrr8EJenY5ydJDWvYfG5QhETwTNQQul8BZb6c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ipinztuMt5KUnYPucmuaBLL/D3ZjwbSEk29DsbdMnyTihYJQ/h8aTT79RZXRBsUUg
	 IQ++y/DN5GIoOwKnrgIyzWu5ezYoJgcY7FZQZADm/ybFUkzSa7dGcjFDvN3Zghb4qe
	 7g54DL9Xh8LsRjTYXcXpvAMZiyHE+wEpjEwISSaK3COf5nikr06bkAbaZwOeEdfC5q
	 0H6A6wH9QyrLAvqF80ij/J0zO+CBOkb80bpjpDx59yV/wxwiKoXfcQH7PnbnSGnW/A
	 v3FWOrVy6ksEmyDf63LIA9ipBiCGZvD4owM2J/ynbTEc6grg1SqeqGz5BDqBBDmEXK
	 MJc8UIEupH92Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 22:56:26 +0200
Message-Id: <DB3KKAZ4HJ96.YPY4C6W0Y5HZ@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix
 clippy::uninlined-format-args
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.20.1
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>

On Fri Jul 4, 2025 at 10:14 PM CEST, Tamir Duberstein wrote:
> Rather than export a macro that delegates to `core::format_args`, simply
> re-export `core::format_args` as `fmt` from the prelude. This exposes
> clippy warnings which were previously obscured by this macro, such as:
>
>     warning: variables can be used directly in the `format!` string
>       --> ../drivers/cpufreq/rcpufreq_dt.rs:21:43
>        |
>     21 |     let prop_name =3D CString::try_from_fmt(fmt!("{}-supply", na=
me)).ok()?;
>        |                                           ^^^^^^^^^^^^^^^^^^^^^^=
^
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#uninlined_format_args
>        =3D note: `-W clippy::uninlined-format-args` implied by `-W clippy=
::all`
>        =3D help: to override `-W clippy::all` add `#[allow(clippy::uninli=
ned_format_args)]`
>     help: change this to
>        |
>     21 -     let prop_name =3D CString::try_from_fmt(fmt!("{}-supply", na=
me)).ok()?;
>     21 +     let prop_name =3D CString::try_from_fmt(fmt!("{name}-supply"=
)).ok()?;
>        |
>
> Thus fix them in the same commit. This could possibly be fixed in two
> stages, but the diff is small enough (outside of kernel/str.rs) that I
> hope it can taken in a single commit.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +--
>  drivers/gpu/nova-core/firmware.rs |  5 +++--
>  rust/kernel/opp.rs                |  2 +-
>  rust/kernel/prelude.rs            |  2 +-
>  rust/kernel/str.rs                | 34 ++++++++++++++-------------------=
-
>  5 files changed, 20 insertions(+), 26 deletions(-)

