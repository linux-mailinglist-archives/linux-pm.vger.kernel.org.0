Return-Path: <linux-pm+bounces-30198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5CAF9F56
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3931C80C86
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186572063F0;
	Sat,  5 Jul 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMkdMpG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96311CA9;
	Sat,  5 Jul 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751706987; cv=none; b=YGE5yk58VUt+44g8wRN/ZOATLBDc14gKO/fnTcV8vBCAGmX+eCYwAa9N76LA+8cpXwEj1WLib0vuEj6+I6V8PwjL3ROpPH3vG4A5NC/T3gF+sNiatrIhmnPpLQdhJvOyv7Nmq2yqeFrh92dI2aI0JbSnrPUF4RfW9zacrEiz6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751706987; c=relaxed/simple;
	bh=M6bMzxg09V9B8u3UKAzQBjLxSHYceHj0mjWXmolGqNw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gu0Ag+vNhqgkhlcdnLPebtB5V53Zt0ZSGflZjNtCvhV5yd36HN5nBTPN46KuGIEhmuTr/ELhMXSsU3CWiuJdDxzsypfjBztO+xLbcIZuwuYqYzWgC2djgOc9QyWhwhTnfnvM3V+obnatLe3eUJkoV5z9jqaSQ8uwpjTutLOil9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMkdMpG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C56C4CEE7;
	Sat,  5 Jul 2025 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751706986;
	bh=M6bMzxg09V9B8u3UKAzQBjLxSHYceHj0mjWXmolGqNw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oMkdMpG6H1c3z5A0dIkQpg4Oi3naBJbm+sgnfh179Uylqsp06Uc0K3SC9AqnmmcI/
	 KPQPJYN3kQ1UbXYP0nXyRmH4raYzrK99Mx8X8JVrY/XFT7v+pJRB5Sflzs8hZLRPkd
	 snCEH3QDE5K2Pnw8wORthL1/h0u3qfZDogPB4Dq/nxBgj3YeTR9VCvo81UaGMh3Z2D
	 sYvGwEXN+U59HOV0ME9e1Y6iRuCyFfVJXFpY9pRdPip2PyI7W5oTHHUlscRJpVaNGV
	 FsGpG0aI3hAg2jCWnhkyVBYOLC75Wzt2d4Fw82hfADOFWugqBzdX+M31PsHaHl9ZUd
	 3xzQJSeV6pZ2A==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 11:16:20 +0200
Message-Id: <DB40ATQ74EOZ.31YEPO3YH5O3B@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 6/6] rust: use `core::ffi::CStr` method names
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
 <20250704-core-cstr-prepare-v1-6-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-6-a91524037783@gmail.com>

On Fri Jul 4, 2025 at 10:14 PM CEST, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoiding methods that only exist on the latter.
>
> Also avoid `Deref<Target=3DBStr> for CStr` as that impl doesn't exist on
> `core::ffi::CStr`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/error.rs |  2 +-
>  rust/kernel/str.rs   | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

