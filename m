Return-Path: <linux-pm+bounces-31616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C293BB1618F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320873A4666
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572E2D3A80;
	Wed, 30 Jul 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="G/58tk3U"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27920E70B;
	Wed, 30 Jul 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882265; cv=pass; b=ddetZQW5UGAEp9atz7tbIkUC4yS4vTZM9m67clKlkXvIKN0M9VuTCK9USqL6l2DdI+ZKgbGKjG1ERdw7YpFtxXcgG2Vwz31nPnXx149XId6vbMxNqVbp7YxBwq753aN1gDP1gUU9uRLph2vr0v65aCnC9qsl6OiwHf+C3DGoXRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882265; c=relaxed/simple;
	bh=E1E/UGq3BHcSE9fkbNu6GvSmIKiyx2JmdosOu7FR3c0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MzGo7QNHulz1XxNjzEwgESjLqNDcPqxcNTuImyGUUdVHJmvoRjLFFAcc3PFdJaYHD3KOGDxBB6B6PGYZ6c99Yhz3fqLwze+g1b2IM+LhXgh5beAMC7NJMMD21LP+f/PvCE3k91qiaQ2qo6mWpD60u2YiZ1aF9OhSXTKJup+04Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=G/58tk3U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753882234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BSYbWpitIzZqpGdBXTmdG1G3kFYDxy0zB5a2/xc5vQL35zZqYxmNvyrCR2lZucNRIP2B8iMHCEq9neYLopCDOYJ06ZIAyC1dAxYKd31qIVJXWLYNCDqRrczh7ilQ11gyJ3cC8V87h/5m6kwp0TKVooCLqJ7B9A29SdrjrNDkGiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753882234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aOG5i7XVJ7pIXErWvvzQMg1MUQ9EHQQty2uAGcXcAlM=; 
	b=asvpx5PBcp2iRqClZpeawHaf0ICRY0KpNMnXD1S6fM22UkX3jhedvkfhzAxrlMvKmLlnKeZJitYjrkYm3ihZW3AjF0FsTFOrUW2OrkklnSc/aJ6G8GW1Y2Kx9Nz3Valqjdboca7Z3hRmxcdDG49b8tEaZLXLui0HjD8nTe6eGds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753882234;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aOG5i7XVJ7pIXErWvvzQMg1MUQ9EHQQty2uAGcXcAlM=;
	b=G/58tk3UU5GIcv3Ka2mO06gz3eHJFQql93iK5BODhbGuMgV10AbobqBuQ2xZH1iz
	HXYqypHqjlplTVXn5thnWrmZqryfDPaYefo4kd7rPHWR1FhgWmtXRvdrljGwFz4PjiJ
	0EyD9jLf9CNjkjJVq/GmZIEAQ9F/I/Ru/OjmuYEQ=
Received: by mx.zohomail.com with SMTPS id 1753882229988414.0615538796012;
	Wed, 30 Jul 2025 06:30:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
Date: Wed, 30 Jul 2025 10:30:12 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <01963F16-1956-4474-AF8D-68E9C5CB45BF@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
 <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
 <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
 <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
To: Daniel Sedlak <daniel@sedlak.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 30 Jul 2025, at 10:27, Daniel Sedlak <daniel@sedlak.dev> wrote:
>=20
>=20
> On 7/30/25 2:59 PM, Daniel Almeida wrote:
>> [=E2=80=A6]
>>> We essentially would like to have a `#[sealed]` attribute that we =
can
>>> put on a trait to avoid the `mod private { pub trait Sealed }` =
dance.
>>> (so a trait that cannot be implemented outside of the module =
declaring
>>> it)
>>>=20
>>> ---
>>> Cheers,
>>> Benno
>> This is not exactly what you said, but how about a declarative macro? =
e.g.:
>> macro_rules! sealed {
>>     ($($ty:ident),* $(,)?) =3D> {
>>         mod private {
>>             pub trait Sealed {}
>>             $(impl Sealed for super::$ty {})*
>>         }
>>         use private::Sealed;
>>     };
>> }
>> sealed!(Unprepared, Prepared, Enabled)
>> Note that I am just brainstorming the general idea here, I did not =
test it yet.
>=20
> I think that API-wise it would be better to have a proc-macro =
#[sealed], something similar to [1], as it may provide better error =
messages, when used incorrectly. So the outcome could look like.
>=20
> #[sealed]
> pub trait ClkState {
> =E2=80=A6
> }
>=20
> And then
>=20
> #[sealed]
> impl ClkState for XXX {
> =E2=80=A6
> }
>=20
> If you are interested, I can try to look into that.
>=20
> Link: https://crates.io/crates/sealed [1]
>=20
> Thanks!
> Daniel

If you have the bandwidth, that would be nice indeed! :)

=E2=80=94 Daniel





