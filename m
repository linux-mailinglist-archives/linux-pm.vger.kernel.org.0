Return-Path: <linux-pm+bounces-32654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F1B2CA60
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A2B7BAC95
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD172FC89A;
	Tue, 19 Aug 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+wvYJZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FB28504F;
	Tue, 19 Aug 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623890; cv=none; b=d/BqYmQzC5AbBqAHaevzv4ro6vFAG8qs85WshxLg7QegSTfAGLhdAOk4VNScor5cs2ZaNhDt/rESy3QTj99Y213aTw2cnr9mgip8j29Bq/sfrPi2HUmhO1b0ok1ZEQCG4Sl77+dRD0hJhkjt6MKtxxopBpUhcBfobHOVoL2o/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623890; c=relaxed/simple;
	bh=tqGC5+6p0FosnS3CJFmcEsP5jw9irXYLL7GUFPYGMME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PHYPvyQBt/G07oe6M765DCLbqLlePfmWo/eX98F6zSNQ52QxWy8WBYENBocTW3emW1vDTEpNtRtnmvIsb+XuVaXSln52jXENiCZr+6s5lJHJEevSAFkBZ/M8QMyfr5OPI4HrKDmsSEWMFdF1M2OLTS3W3D7mPOoo9RWSpqatwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+wvYJZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247C3C4CEF1;
	Tue, 19 Aug 2025 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755623890;
	bh=tqGC5+6p0FosnS3CJFmcEsP5jw9irXYLL7GUFPYGMME=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=M+wvYJZYPgO9MAXtUQRoQX/UQeCRvr3rSjaxHGJ0zvbIeJvjkS2FmPZWZHFN/+jBq
	 3XzWdchIPvMn2R3Lm7bFUG21DhExUpg7mLZPIxYwwmbEQdlhdpgmG8R2VaQa0KOVLn
	 MCggChlqrxl1vizUzWN2pdnBhspI2R8Y+o8hJVlzFupp78nKznTYNTHC46yZ/2sXVl
	 a+AY2h6ezhTQmg31QzayjL3NGezCu8890D6l/R+BkHNU8FnigijCROhlY7mADdmXPa
	 wum/bKqCwBUU2vUKPCWkFkKr2Grku1EUmVnuAY76RPZCdtqbnA4kPbLvurrq4KKJ1Q
	 BMckMymKaG+qg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 19:18:05 +0200
Message-Id: <DC6KQ6LWY3C5.3OSHWTFYM0CDO@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-pm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: opp: update ARef and AlwaysRefCounted imports
 from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Viresh Kumar"
 <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250815174521.1413560-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250815174521.1413560-1-shankari.ak0208@gmail.com>

On Fri Aug 15, 2025 at 7:45 PM CEST, Shankari Anand wrote:
> Update call sites in `opp.rs` to import ARef and
> AlwaysRefCounted from sync::aref instead of types.
>
> This aligns with the ongoing effort to move ARef and
> AlwaysRefCounted to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> Changelog:
> v1 - v2 -> Fixed mistake in the commit message
>
> Patch description:
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/opp.rs | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

