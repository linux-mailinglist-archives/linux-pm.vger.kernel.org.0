Return-Path: <linux-pm+bounces-31585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F7B15AB7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51521899637
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD384291C3E;
	Wed, 30 Jul 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WILiZVJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58426657B;
	Wed, 30 Jul 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864170; cv=none; b=TqkB3ZsQyXZz1ZJRF8pc/DLoQE2NWmseeFzR9nz6c9ABVs8KSXrLf1wWzE1setzKykuj8mQd6dA7ae8MdaKmwQa6mtuea0FgpP/D3x7ZDB5n1/Y8lQhUqr9l9L5v66XmbJ93247qJYK9wFew623U2UhnmDjkATk3HdLSIvRpX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864170; c=relaxed/simple;
	bh=Rg10b4JNCmDsD0iq5OysxPQp6E6bCpSKW+A6zmsmiwQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iIWbyo9bpj990YO4HGgC/HBg2QrYzhwZfhGqigSfvtvN2kYuC+TK29eBswFqYAtcdn6spX8VGZ0qoHOaCV9TqfMKH/hav1uP6XR4h9k/dZj8NNUpKcP+B57lwUTYqqFCKXoIUS79XHfWfNKGrOREJvWR2sHRdHKXSRPhnVZhTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WILiZVJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47595C4CEE7;
	Wed, 30 Jul 2025 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753864169;
	bh=Rg10b4JNCmDsD0iq5OysxPQp6E6bCpSKW+A6zmsmiwQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WILiZVJ3JC5fOeTWv/GCr1BzfmOPciUU9DM62CqChBO/pQpSt/ARfuPYzAsCcN36F
	 WlAgaZ6a462uaTbjV1hKYpOS07RELFpL4ckb/KMNrlJNhvM3hwJ72OqPG4dDawpJzR
	 4qAY4yjOcIS/exu5h/0zu1UUoQJgki1+zTBnY53b+g13PoWS8/67OIzrg3AGjFUPsu
	 ViYsw9/obD3d7Y9ug4nw2UrjSuZp6JbOh8JmH0LYxnPftZV5Q0KTrPgJa0lR6ZIq9u
	 ASoCPDxqlFTp2iZADwabn/wqBVTeWCYbMnloegZoMCgmv7RTrgrshjQW8VG7L3XnMD
	 H2AT8Jl5PHNig==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 10:29:24 +0200
Message-Id: <DBP8YI8BA4PL.RG9D2ZL8SBR5@kernel.org>
Subject: Re: [PATCH] rust: clk: use the type-state pattern
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
To: "Daniel Sedlak" <daniel@sedlak.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
In-Reply-To: <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>

On Wed Jul 30, 2025 at 9:29 AM CEST, Daniel Sedlak wrote:
> On 7/29/25 11:38 PM, Daniel Almeida wrote:
>> +    /// An error that can occur when trying to convert a [`Clk`] betwee=
n states.
>> +    pub struct Error<State: ClkState> {
>
> Nit: IMO we mostly use the `where` variant instead of the colon.
>
> 	pub struct Error<State>
> 	where State: ClkState

For such simple struct definitions with just a single trait bound it's not =
very
common to use a where clause. I think the definition is fine as it is.

