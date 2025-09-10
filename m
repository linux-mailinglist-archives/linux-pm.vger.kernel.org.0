Return-Path: <linux-pm+bounces-34410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D0B52064
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AEB1BC2A9F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66D2D0610;
	Wed, 10 Sep 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GkcNQmbd"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266692C327D;
	Wed, 10 Sep 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530088; cv=pass; b=tpEdN0abXrvFlQ3ezMJW/OWvYDv9WqQiXlWVDSpVT2rnET6hKmO6NuQr4QAJ9DvxgSllJN2xGUqe99GkIkRoYsDUB29GliMCkbC+/I2NIDsJg6PJ6u5jXUa6mTBI8ZlQj2RIhfTyC+64zC60asE9Mh8c7ML/+Etx57eaPqtFyJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530088; c=relaxed/simple;
	bh=kHtbzXKfHdHrysnt3opP0i4Y53tRzGXtXRDDkUtThCY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V0qOpMy8ZCMqwNTPjrBBBetNh2OiONTlZYL/z6oUgkZ3QoduhTAn0UYnRSYhXHO3LklCpMKZP7j+3yyKVBY4PX3CnmBqo3xYsWOwqhqrPQiqNjG/oC/0S6eoGcaH7zgVE3DN2wKJrUl3PJMoh86Tgk4g6idJbLA1an3MhJXAZHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GkcNQmbd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757530070; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DEHYULVKqa84NpaY5mX0necWyQXRRqKVtyHInBjSxbq7JsY4OKKXdEunDua8IkwgmZjaRP36QSWoBWmxxOQWsW8CDOBV0KxIX0cYsMazeFGd8p02TLOjuWalWbSZI/Pg8HHa83fNP+//HJ1XnYDrCXi65xmBeBUK/6Cnp9UtK5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757530070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kHtbzXKfHdHrysnt3opP0i4Y53tRzGXtXRDDkUtThCY=; 
	b=b0WdN9xvHz+MkXLfrtGG088aYKr53XVlKZTNFqDrr7cNNEV3ZTRejDQ9YLpCCXjhtxECu9fg/GxQQ8NvLhaN43WWmeN3P+K15zyLcFtL+SlO5hlmQNNpNo4zYRYNS0UvfSjvybGjpCw/rfA+zJ+qsM/iA+zAijqMQxkNPlS11rg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757530070;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kHtbzXKfHdHrysnt3opP0i4Y53tRzGXtXRDDkUtThCY=;
	b=GkcNQmbdQ8xOJJGKK6p2Qe1XPK+A6s5ZtaIn4+kJSPpgNcAaYoqD9+YXoW9jj0IU
	oJliIdYPAxQZ3Li/yShpgQgvkyPCvF5PtUkhs2ZI/G98hiBjV9RVMG9bQv7/r9i0Fb/
	zcCc2KVf/H5CnhbQf6V4ZSy3DpQ//j1fYYCZ3KEk=
Received: by mx.zohomail.com with SMTPS id 1757530067158368.13632757724474;
	Wed, 10 Sep 2025 11:47:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aMG6JVMcMxVuX7De@tardis-2.local>
Date: Wed, 10 Sep 2025 15:47:30 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
 <aMG6JVMcMxVuX7De@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Boqun,

> On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
>> From: Alice Ryhl <aliceryhl@google.com>
>>=20
>> These traits are required for drivers to embed the Clk type in their =
own
>> data structures because driver data structures are usually required =
to
>> be Send. See e.g. [1] for the kind of workaround that drivers =
currently
>> need due to lacking this annotation.
>>=20
>> Link: =
https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@coll=
abora.com/ [1]
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> This tag list looks a bit weird to me. Why is there a SoB from you
> before Alice's SoB? At least for the usage I'm familiar with, outside
> the case of Co-developed-bys, multiple SoBs is used for recording how
> the patches are routed. For example, if I have a patch that has my SoB
> and I send it to you, you queue in your tree and then send out to =
other
> maintainers for merging, in general you would put your SoB after mine =
in
> that case. But I don't think that's case here? Alice's patch has only
> her SoB:
>=20
> =
https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48d0233=
20eb8@google.com/
>=20
> What's the intention of the SoB tag here?
>=20
> Otherwise the patch looks good to me. If we get the tag list resolved,
> feel free to add:
>=20
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>=20
> Regards,
> Boqun
>=20

You have to include your SOB when submitting patches from others.

This is something I tend to forget often, so I made sure it was there. =
The
order may be indeed off though.

=E2=80=94 Daniel


