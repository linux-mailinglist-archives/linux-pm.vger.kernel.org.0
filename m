Return-Path: <linux-pm+bounces-30194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B8AF9EFF
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C48A1C231FF
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A332701C7;
	Sat,  5 Jul 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyGAt+uj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE6218827;
	Sat,  5 Jul 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751702675; cv=none; b=g7SLJI9DF6v8UnwJBXPBkbO5UnNp+Xn3vIK8qnSM0UT0uv2QUsqj9Pv631sQhOAfUxgiQxl5v+RVhBbm/15IUtWc6C4b79SDcBs7b7SxpSUG+/9yCA/UFNStsIDyOSxGO5b4jVwdOggGmH+2FDLx5jWrdxJW70ePnBrn1mJVm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751702675; c=relaxed/simple;
	bh=gno/0LEj5ipEWscOXuFUP5p23Zzxa+r2Bh8Hv/hJ5GQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IG/HDievZW0RRFpA2H0Qa0KBRIUfKAGrpKrLoxnrr/6kNbSv5h36MBdd4km54cX8sgGdFUl9EGKsVt04OuJC+YLJBFvEoLvlt+vZIFTtJpOuqbomCg59qF+cLE6AwpzgQkJwz9KU/ott7oMH5qVqeH8nditCocaj/5MixDUEeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyGAt+uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A94C4CEE7;
	Sat,  5 Jul 2025 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751702674;
	bh=gno/0LEj5ipEWscOXuFUP5p23Zzxa+r2Bh8Hv/hJ5GQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UyGAt+ujqFDZpp0LdmolpxWu5svih6F5sD6IBytgX99q2v7Y0ipuz2k3Sr8Doxaw4
	 +PfDTDaltJq8WKa0xmXkchGcMTia5mOVKOp9PS7q0qKexSZXm0jTUHt/ws2Kcd9kNA
	 NR0DMVoP7SrS312+w548r4N4Q/RNP4mZEKQ1oyEqNnThA10JzLG0oVe3WC55nfD27h
	 3OHamxalhB7m+kAipSlJwkr2KTyO65HaHtWEF9vIS4QbtzL39sIJcIK+hPFN6jgyo4
	 FHv3MIA4Vbo3fb/OSQpxxjyKYDQvSbPYTqhUZcUkYU/fxJnCz42RNtxSny5Jy/6ptN
	 E4q4OovmoPf8w==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 10:04:28 +0200
Message-Id: <DB3YRSRVRGVN.B7EBLCMSZG3P@kernel.org>
Subject: Re: [PATCH 4/6] rust: str: remove unnecessary qualification
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
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-4-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-4-a91524037783@gmail.com>

On Fri Jul 4, 2025 at 10:14 PM CEST, Tamir Duberstein wrote:
> `core::ffi::*` is in the prelude, which is imported here.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/str.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

