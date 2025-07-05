Return-Path: <linux-pm+bounces-30197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A75AAF9F51
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DF41C809B5
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C148204F8C;
	Sat,  5 Jul 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbXaelXj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F52E36EC;
	Sat,  5 Jul 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751706952; cv=none; b=IWR+JmA0/ScSJtZ82h4xZ/MPiYTly/KHOduf/SNYWxQ64qw+UcumxzbuuhIUd6nHaaraLKabL8CGsG9V1V1/heH9eiBCYcW9Oc9Mm6mJikxeYiUW+zJWWOs5MirlEzk5WFo9Q6ZzWaNw/z77Yn6UV1ghPRE6rOOjqYDG+f9PvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751706952; c=relaxed/simple;
	bh=zAAwL1qn9DWYaFXEYo3FHdzOi6eWfYIf0GhD/81me8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=URHhUSaT3lfcaexiZ2c468Vm15hmRMnW85Kzkn4XXXdrlNpnR2i86YslJqrArLUSPKapuIhAKYCiFjXh1zSbdWjLgKyP5+XV85X/Ehq6wvvGgIYX4keDzOH0rUs9ovZgABn0Qi+/QpT7grK3RvB+fY7vkq/Hh6+gaYzGEdFaPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbXaelXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB0C4CEE7;
	Sat,  5 Jul 2025 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751706951;
	bh=zAAwL1qn9DWYaFXEYo3FHdzOi6eWfYIf0GhD/81me8I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VbXaelXjrbmiJwwmiM8rVc2FLbx9FZq2GjG+M4uRZSSKbUGRyyKOGF8pC82TJ1Zwe
	 or72p6rhJA8vKjVtOiaX5p2KBpUUA/EaCkQ4HNOoNlR1omc9y0eiAqsevVZ+e2rLJF
	 SMhVZjwHdAGhc3H0hgXTkfLyhNSN1OD9sHfJhq9nFd05Yf1HA5LUQef20WzoVtNSVr
	 E9YT/jjS8tnvHtWwlElv0Y838z0aaLTbhzgYO2ZIs9TQq4ngbO8QjY2Jl6q/9/OTwE
	 Lj6wRBc1lwBLpAwtoTmH6EZoN58NHGrYN8lQst+JZi6lsjf94hqsTwp9hD5kFSP6dr
	 w56MSIa42VUWg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 11:15:46 +0200
Message-Id: <DB40ADOHZ908.3PN41XZ77MR29@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 5/6] rust: add `CStr` methods matching `core::ffi::CStr`
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
 <20250704-core-cstr-prepare-v1-5-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-5-a91524037783@gmail.com>

On Fri Jul 4, 2025 at 10:14 PM CEST, Tamir Duberstein wrote:
> Prepare for replacing `CStr` with `core::ffi::CStr` by soft-deprecating
> methods which don't exist on `core::ffi::CStr`.
>
> We could keep `as_bytes{,_with_nul}` through an extension trait but
> seeing as we have to introduce `as_char_ptr_in_const_context` as a free
> function, we may as well introduce `to_bytes{,_with_nul}` here to allow
> downstream code to migrate in one cycle rather than two.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/str.rs | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)

