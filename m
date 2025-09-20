Return-Path: <linux-pm+bounces-35082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E2B8BF7E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 07:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53BB54E06E8
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 05:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5F21D5AA;
	Sat, 20 Sep 2025 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8csHsX3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD664A21;
	Sat, 20 Sep 2025 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758344806; cv=none; b=CzJ5O4rvz23a2RT+g4eK4jEOj3wUr/WR03LskyR78mQgFoSa0rySfPqVza9vRiCdplSD2k6t8RMtBqVcAPocUcYGCB9oLOMxC4gc69ZBZUVGgXtvgP3KIohrsoCGVH4SRcwu0p0/WVLPmdoyDRJsTEhMfll7s0rFTkDRewbV6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758344806; c=relaxed/simple;
	bh=0UDfmZ7DaFZLTqzi59DgWOG0qhddX+UAkuVNJQTlmKQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=WrMpLawEVfa11E40d3danWwU7+BQ/yrqdnOpnCrq9kS7FNAa59vW3KKxiVoP4U0jmkJRYFw+oDto+S/YF16ExcHSNzyJWz2DH/Y2BS9Ilz34zq1X1MZ70OTpfLLkSRKbrK6ph+DUzC/w8GVJWQbwhvOQb8m6Q2maUmVc6G+T2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8csHsX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D92C4CEEB;
	Sat, 20 Sep 2025 05:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758344805;
	bh=0UDfmZ7DaFZLTqzi59DgWOG0qhddX+UAkuVNJQTlmKQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=r8csHsX35fQg5mQ46THNN6En77PyJ8zJJ+Evlg4sO9JjPNoGFZGFxhnil5hO7rjiP
	 jXDcBh4nQaWIvR2PInQuH6NpNK+rDtnhSXpsVFi2TUAe3AVkB/VTzk6Kq7gV1T41a4
	 YLBJEsw7zEzJuimXE/j6gfHtU8amKJB97pHHvOi3Owl1naqchh/VIcT5rnkGSIKxhi
	 fEZyY6YV7FCW0wgZV2mAJ61ygSE0xjDIflPdwKzxcs3XWmDugYd9y7GgpGO206i4TY
	 nzR7LtRzvACwJPmy8/KS4nfboL0bUunZYiLJts9WEPvdKPmL8iDoOE39bgIJ5+UP6k
	 fb3/Be+H5wTHg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com> <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com> <aMG6JVMcMxVuX7De@tardis-2.local> <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rafael J. Wysocki <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 19 Sep 2025 22:06:44 -0700
Message-ID: <175834480479.4354.6269916774389395049@lazor>
User-Agent: alot/0.11

Quoting Daniel Almeida (2025-09-10 11:47:30)
> Hi Boqun,
>=20
> > On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
> >=20
> > On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
> >> From: Alice Ryhl <aliceryhl@google.com>
> >>=20
> >> These traits are required for drivers to embed the Clk type in their o=
wn
> >> data structures because driver data structures are usually required to
> >> be Send. See e.g. [1] for the kind of workaround that drivers currently
> >> need due to lacking this annotation.
> >>=20
> >> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc=
9da95@collabora.com/ [1]
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >=20
> > This tag list looks a bit weird to me. Why is there a SoB from you
> > before Alice's SoB? At least for the usage I'm familiar with, outside
> > the case of Co-developed-bys, multiple SoBs is used for recording how
> > the patches are routed. For example, if I have a patch that has my SoB
> > and I send it to you, you queue in your tree and then send out to other
> > maintainers for merging, in general you would put your SoB after mine in
> > that case. But I don't think that's case here? Alice's patch has only
> > her SoB:
> >=20
> > https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48d0=
23320eb8@google.com/
> >=20
> > What's the intention of the SoB tag here?
> >=20
> > Otherwise the patch looks good to me. If we get the tag list resolved,
> > feel free to add:
> >=20
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >=20
> > Regards,
> > Boqun
> >=20
>=20
> You have to include your SOB when submitting patches from others.
>=20
> This is something I tend to forget often, so I made sure it was there. The
> order may be indeed off though.

Yes the order is wrong. The first SoB should be the commit author.

