Return-Path: <linux-pm+bounces-35120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D256B8DDAA
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0517646B
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0B38F9C;
	Sun, 21 Sep 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl7tP4qK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF5B652;
	Sun, 21 Sep 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469685; cv=none; b=emLwlyhDoD8rq3ReUHT+mUmmpmEeoQJ2JtoY/OKK6owoo/eok8sL8g1p0hKU4ChNw9nxICzeoQxdBxRLdzsiB21kTFNXHTj3fWGrt/MDdVoFp/pTiZsDwRdwgIH8KtS5J298T6KD5DAzmwUKWadNQV8uozze3xjioPR3WH19n54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469685; c=relaxed/simple;
	bh=lB8jKzCoilWGhPypSz0chPua50YkWHfd1+UXohEc1Jk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=stSLAVCJ2y6J8kjQdQa3U+H7xZ10zfgtNS2Mh9QUHBqLyUZ/M3sw3AcN9MbcRwQcKHUVxCYlIQyx71kT4sM4yj0lTrZH/8bW+PbaZAK+YNJKWlLMl+GY/x0ZvjaWRy34pu0jyRr71m5HBTTbHC3eH+tJ4iHCFgiTZk+ikero4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl7tP4qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9E4C4CEE7;
	Sun, 21 Sep 2025 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469684;
	bh=lB8jKzCoilWGhPypSz0chPua50YkWHfd1+UXohEc1Jk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kl7tP4qK79Aohs/Pt+Nq71nF+CkGK9E1dSdHd6aSIL8G03sn6w2jyE0bRbn3xbDI6
	 JEmExm6wIV4Emx9pNvsyaWHtaGxZceCa+lMCzanp4GIPSdnD/QYHSq092HqgKMTaNE
	 u7c4w+ks8EE8bQCpzXc5yn6DViYB2erVbWZzbOUjAY5cpo1NTxCJE8GMKxFJ2tz7ye
	 QPygwhgSMCI//SZ75SQYlZ/UdBaheqDxFwfqpCECHdPxPVKF03BYF/ttDaGG8UXf77
	 ZHJXYxvAvLtOR12vwX1fqDIBoQvO2uCkJJLeW3gUSzewPBi8+IeChJ151AL5sBIRuT
	 gd8UOLvt8YLyw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <11324A9C-F7CC-47C7-B225-59A96C333A82@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com> <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com> <aMG6JVMcMxVuX7De@tardis-2.local> <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com> <175834480479.4354.6269916774389395049@lazor> <11324A9C-F7CC-47C7-B225-59A96C333A82@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Stephen Boyd <sboyd@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rafael J. Wysocki <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
To: Daniel Almeida <daniel.almeida@collabora.com>
Date: Sun, 21 Sep 2025 08:48:03 -0700
Message-ID: <175846968308.4354.2923659909996682902@lazor>
User-Agent: alot/0.11

Quoting Daniel Almeida (2025-09-20 03:33:07)
> Hi Stephen,
>=20
> [=E2=80=A6]
>=20
> >>=20
> >> You have to include your SOB when submitting patches from others.
> >>=20
> >> This is something I tend to forget often, so I made sure it was there.=
 The
> >> order may be indeed off though.
> >=20
> > Yes the order is wrong. The first SoB should be the commit author.
>=20
> Do you want me to send a new version, or do you prefer fixing this before=
 applying?
>=20
> For trivial changes some maintainers prefer the latter to reduce the amou=
nt of noise.
>=20

You can send another round. I'm waiting to see if anyone will review the
second patch. Maybe sending another round will prompt a review.

