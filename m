Return-Path: <linux-pm+bounces-31610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33686B16054
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E33BA620
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1927AC34;
	Wed, 30 Jul 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XjNwG/Xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E91CFBC;
	Wed, 30 Jul 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878479; cv=pass; b=o56JnNultkOSjhs9Ymn4oGMh+xP6skm3faY/RcgqIcOXd/X7SfGkomz/BWgyrDTbugML8QkRvWEVwlgS4qycryPVM6tTaEZrlb3QVXZ+NWXOrRl6eiSbXWliTxOU9FczP2wRueEHT0lGpcssjj7jMPBGvAoufxymt67pUth8NZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878479; c=relaxed/simple;
	bh=1u5nCh/OB64p+3fygbatYMm5eLb4AW5nGEdzsz0CuuQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CGnrpfQSBzHHB1iOGWGr+sR4L1eLh5dKLJQfQZrAhWzD5D6TJI3NlNbVoXzc6z0rEPwLh3SHBbxFchWo89+uUOuGTggiScRr2kltJMELBLAq68mHzVxxsUnyPFwemBzmkrXQMH68ph3YQDiYV7MuQoHPJ0lgcVBEKZf0CMnidIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XjNwG/Xg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753878458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aa+JvgvjUZLRkUGGezY4GcgyoF06A8LYgj8541vK9kM3Tr+OyQWCHR3x//m0utO33aeA+WZ8Ys1ks2d+XxjasHSKhwKpm1RBotJ5jSXhgcYYqy5nqjkI/4JOkvBvS7d2m394HRhX6+U2fQwRtAFjAmtFmZFpB7bhi8A7ZY/c4gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753878458; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Oh/5HLcjYMuz4jd5BSONf5KBlrnXjhIJw2EBlDJFW6o=; 
	b=MJpyr71yo3wRBDWrkMENS0iS+u1v5mmiFJLtLoR4bjj3c/Wh7FtckhoER2uvL+S0C2mktbxf3KwKDAWDmFlmJ2t5+inEDNlTLjMRgv7DTDEfx6ybxKXBkBgrUpXdR7ajA6QO0Awi5dfHkKqh9Y2GjqOzwq0pomskGDz+OfH3Mk0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753878458;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Oh/5HLcjYMuz4jd5BSONf5KBlrnXjhIJw2EBlDJFW6o=;
	b=XjNwG/XgSrIe7SIL9LpVG+dcL+TYhQzQJ0XZDaBneAXCCxHL2pLI28ntGR3WCLYe
	bW1JuwwgRdDc0I4hZWbOsBK48rcbKUTmu3YGJqG2Q06XYvu+CI2z2ubvHtKErZiPxCJ
	BXJXwZnoObZhHDuGDCoR7Is0lkm4rjdhN3d5kBwE=
Received: by mx.zohomail.com with SMTPS id 1753878454937281.63399144933067;
	Wed, 30 Jul 2025 05:27:34 -0700 (PDT)
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
In-Reply-To: <20250730062355.bqifrzvxfmaaugnk@vireshk-i7>
Date: Wed, 30 Jul 2025 09:27:18 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9746F6D6-488C-4562-8FB1-BE268C69BA97@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <20250730062355.bqifrzvxfmaaugnk@vireshk-i7>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Viresh,

> On 30 Jul 2025, at 03:23, Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
>=20
> On 29-07-25, 18:38, Daniel Almeida wrote:
>> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
>>     /// A reference-counted clock.
>>     ///
>>     /// Rust abstraction for the C [`struct clk`].
>>     ///
>> +    /// A [`Clk`] instance represents a clock that can be in one of =
several
>> +    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
>> +    ///
>> +    /// No action needs to be taken when a [`Clk`] is dropped. The =
calls to
>> +    /// `clk_unprepare()` and `clk_disable()` will be placed as =
applicable.
>> +    ///
>> +    /// An optional [`Clk`] is treated just like a regular [`Clk`], =
but its
>> +    /// inner `struct clk` pointer is `NULL`. This interfaces =
correctly with the
>> +    /// C API and also exposes all the methods of a regular [`Clk`] =
to users.
>> +    ///
>>     /// # Invariants
>>     ///
>>     /// A [`Clk`] instance holds either a pointer to a valid [`struct =
clk`] created by the C
>> @@ -99,20 +160,39 @@ mod common_clk {
>>     /// Instances of this type are reference-counted. Calling =
[`Clk::get`] ensures that the
>>     /// allocation remains valid for the lifetime of the [`Clk`].
>>     ///
>> -    /// ## Examples
>> +    /// The [`Prepared`] state is associated with a single count of
>> +    /// `clk_prepare()`, and the [`Enabled`] state is associated =
with a single
>> +    /// count of `clk_enable()`, and the [`Enabled`] state is =
associated with a
>> +    /// single count of `clk_prepare` and `clk_enable()`.
>=20
> You have mentioned the `Enabled` state twice. Also clk_prepare() ?

Ah, thanks for catching that.

What=E2=80=99s the issue with clk_prepare? You mean that the parenthesis =
are missing?

>=20
> No objections from my side. Thanks.
>=20
> --=20
> viresh

=E2=80=94 Daniel


