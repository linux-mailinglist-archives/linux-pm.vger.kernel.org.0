Return-Path: <linux-pm+bounces-22868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF5A43A34
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA863BAAAD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739F266B4D;
	Tue, 25 Feb 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iqgJce1V"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD2266B4C;
	Tue, 25 Feb 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476661; cv=pass; b=kwtj1PxDCYNx2cE3yeWOz/evwpjWnKBIom4n2A6IgIZdv/ncy1A5kAL93K3UjoadBh+6gXl6mMPxgy9OXwxZW+YZGvUM99DjSaO92OxpqZZ2jv4v24YzSvlLyMcU2cmsOJFy+49xp+b5DO//GimwvWyS54FlDpys7QAo/bYCCLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476661; c=relaxed/simple;
	bh=mGa1ZVpVEgPerlEBMmFu55L7BuMoyO1RjFa7unAYWsE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EdUrn4zDv/ltTlBViPNAbMqdvNn8uKluYKoup+WKgpe1X6lzAKxM9iRNZtzY5u+TG+38UgxvIiZzZthkiw8tcEKYU4OzspM4JXeBcVbQcHZSoHiseBCVx4JBBr5y9+oUcQRq56u9c0fetV0IwxczNnSJ3El7Cz4pUtnxgDcqI6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iqgJce1V; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740476632; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hOAzLH10upnYM8mrUCJKeSFvpPQF4X8pbBP9U6Ib/J7wI6gKqAAg4x5D8BL+LJz18gdMEEWwAOxYCaGB97NqmdSU4Xz4JctrwSmMqKO9GpxyVOLWKq8sK6uAxreSaYlvk4vvl1ENV/rdNL4B5qdfc1L4g5M0KIhNUyee/Ieo3Po=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740476632; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mGa1ZVpVEgPerlEBMmFu55L7BuMoyO1RjFa7unAYWsE=; 
	b=BwekNULxccjsZMNQ2D+mGAlVx8pLyZLfiTRT1g3RySnmMJIStUHZZKlEhWhVwJxxEd6p1vIZPnqpvUlbigZAxhB5E1Hy5GNbgXQh2WXOti62u5uusjvrOPXHDRq4sWrPJcXhLUwnHn5kZ+vo9PTAuEzWTWZEskE2BQE9FJm3FcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740476632;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=mGa1ZVpVEgPerlEBMmFu55L7BuMoyO1RjFa7unAYWsE=;
	b=iqgJce1VS9nGMtrO+a5XqdIt09odx5cAGf8CDtM6aHzUc5+szZL4elVjc0e0UpLt
	z7pqmLPMaT3PTcEfQGp+ogA6fT9gsY08KsVPuJ6exnvUVafH9iI/udDcI36SC3G/y3Q
	F4Mr6GwIXFKpwtTinI4J1RbPqVxQIDfj7as9+YUo=
Received: by mx.zohomail.com with SMTPS id 1740476629225362.08681216406217;
	Tue, 25 Feb 2025 01:43:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224233938.3158-2-yury.norov@gmail.com>
Date: Tue, 25 Feb 2025 06:43:31 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-pm@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>
References: <20250224233938.3158-1-yury.norov@gmail.com>
 <20250224233938.3158-2-yury.norov@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Yury,

> On 24 Feb 2025, at 20:39, Yury Norov <yury.norov@gmail.com> wrote:
>=20
> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> In order to prepare for adding Rust abstractions for cpumask, add
> the required helpers for inline cpumask functions that cannot be
> called by rust code directly.

I don=E2=80=99t understand what is going on here. You apparently did not =
provide the
Rust code itself.

Usually, when I see a =E2=80=9Cin order to prepare for =E2=80=A6=E2=80=9D =
I expect the actual patch to
follow in the same series.

Right now - and correct me if I'm wrong - it seems like you=E2=80=99ve =
essentially added
dead code.

=E2=80=94 Daniel=

