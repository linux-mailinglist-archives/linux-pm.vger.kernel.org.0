Return-Path: <linux-pm+bounces-30199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CCAF9F5A
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 11:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A2118881C8
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108D241679;
	Sat,  5 Jul 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS9aTiEu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819ED1E4AE;
	Sat,  5 Jul 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751707438; cv=none; b=NPMOOi5QXWZSbibwa6jh2t/hvs87+fGTWx3iqHRZkYe9D6xbaM9JbDHo9dxmo9GcPBkhSqXZ/SlEvaob69NUeHZX+DCcS1pwCULXuPUgYWBjGLb9J+m+efWGI0GAMz99FrjspJl2OiUoqnzsbj+ae0mFMNIupXA0bP8smkk32PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751707438; c=relaxed/simple;
	bh=BgGICVAG3ufzyD8EANR6r892lXXUNui3d8R5OQencmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mYAesK5VqBiQqK7ej3Iv0rShQJl28XHEBhG//74/xva/OBVb7wgvcmt9hDjfcyuG7jWej6ZaNfMcCu8lv3MdxeXzFb0wPXl0BVlyhhHrgjU5iEjCCn88WXiuW7J8pvmivzTqG10OeFHymmPCNeWjeRB0tU1i+upRCfS7kMNBQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS9aTiEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDD1C4CEE7;
	Sat,  5 Jul 2025 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751707438;
	bh=BgGICVAG3ufzyD8EANR6r892lXXUNui3d8R5OQencmU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZS9aTiEucOKW5yPsPtD1gjQDbHT88+6an4F4oCrjx99JSv6bCia0h6Xjm91nZMUFj
	 nmzNTuLPhAKEqwDKhwyuLsCjB+5/ze8q1gYN+3bF7wjL08B9aFGUuY/zFus3o+X1ku
	 zVEklmoRntvsvmhunellnN5YuEVati9qGT+eqyx4/FU/Rat0ZXCQl+aJ5ohGJTBDVf
	 enA5hk2Mtv5SAA8jlBySwuFL9R+hwJqxnrvzwVlUN0j3Kp6OC9Brtfr8SfBkOVx5P8
	 c+cHJ1HyoF87IKnLFcwNotT+80S85I/03H3gdkqW4naX3QGFXLg2CGGMs1I3M9/Hhz
	 AUzmaGvlxNdcQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 11:23:52 +0200
Message-Id: <DB40GLDJNB8Y.2HP3DHHVU0Z8Q@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/6] rust: use `kernel::{fmt,prelude::fmt!}`
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
 <20250704-core-cstr-prepare-v1-3-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-3-a91524037783@gmail.com>

On Fri Jul 4, 2025 at 10:14 PM CEST, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/error.rs            | 6 +++---
>  rust/kernel/print.rs            | 6 +++---
>  rust/kernel/str.rs              | 2 +-
>  samples/rust/rust_print_main.rs | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

