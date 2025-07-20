Return-Path: <linux-pm+bounces-31131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A20B0B8E3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593FD177E3A
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA181DE3C0;
	Sun, 20 Jul 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCC6EGbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF713BB48;
	Sun, 20 Jul 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051055; cv=none; b=lfI3b7de+3wl0dwrcAR5usaQ95RWnBT+2gKBc7OMnPI7+herfNEfHpBAro8V4kW3fsovianjlwH+xqmoe3kfkhPN+o7EevgQjZt80X1gIgk8NsFeywB3mDlt72juGdCbTgL/EK5lkNT0houHdrcp0mK01v1BcYkKdESY7rKYE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051055; c=relaxed/simple;
	bh=kdUw/pZMaU0Ir4P1orWl8JNS6xpN1Y3f1hcA0PcAv5o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=rr1VaNXF6kEJXhcjD012y4LwwNk759l8z1ItPTWhBGlURFL1IAJKzFGbq7kCx0OSSkVZqlO1CzqsmY5zJCb/wtJlk3PYFQCkppVCw+PibC9LACE5W6UrdMdBzD8KzS3xBimRV/ztHstHB2EYMcGohEqm8XFna8pNTl7Vk0KqdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCC6EGbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64BCC4CEE7;
	Sun, 20 Jul 2025 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051054;
	bh=kdUw/pZMaU0Ir4P1orWl8JNS6xpN1Y3f1hcA0PcAv5o=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=aCC6EGbt783gh3Ztm0yFdCp6NSvd5ya72MZ2dbBq/7HauFmIu2yZ5IwkeUBmbyBfL
	 SxN0FcNk+U3B4aEE5efAFFXdE+ia2+oFY2My1f8oOAhkrx5qSLaxbNl1EBz/iADoOt
	 KsnOHptvYVt3TRmODE+w133jbsQmvVFqrRl/ZZ2KYvjmxVP7Q2g4yd4Zk0O84BMsb6
	 0ELvo/ZXACZNNla4GRFHdLdifbk8L1sMAJYajKi6TQFQo3uj16VLY+DUF0RWW8JlLY
	 NirS+fB23fTSf1tyMIv2lQDlTQDP2TXe3QbruOTQjFQ+RpQ4ilKOXiH3Y8kZQCnnjZ
	 yBTec5gu9/Xqw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 00:37:28 +0200
Message-Id: <DBH8QE1NZVB4.2VJDAL24XIHG4@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix
 clippy::uninlined-format-args
Cc: "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
 <CANiq72mjiBK+DE-NOx1p+wWuZpnK=aPtgnMUUEzig+4jHZzemA@mail.gmail.com>
In-Reply-To: <CANiq72mjiBK+DE-NOx1p+wWuZpnK=aPtgnMUUEzig+4jHZzemA@mail.gmail.com>

On Sun Jul 20, 2025 at 11:24 PM CEST, Miguel Ojeda wrote:
> On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +--
>>  drivers/gpu/nova-core/firmware.rs |  5 +++--
>>  rust/kernel/opp.rs                |  2 +-
>
> Danilo, Viresh: I assume you are OK with this, but let me know
> otherwise, thanks!

Sure, feel free to add

Acked-by: Danilo Krummrich <dakr@kernel.org>

