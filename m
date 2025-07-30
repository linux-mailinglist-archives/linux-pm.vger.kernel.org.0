Return-Path: <linux-pm+bounces-31609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FDB16052
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9703A35AA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E0295D91;
	Wed, 30 Jul 2025 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ec0MmWcK"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D292B3E;
	Wed, 30 Jul 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878391; cv=pass; b=rdvBoEZnl+bX1oxDtuoN/HjxVYTZctP9DIgvaaCJBI3BDx9wwRcJ6x270DPz/JDY28Ktnq/Acv2lkbTq4QRTio/X+3LcfTJftkfQtYQGOmUZaduF8gMyTGzWIfQfQ4v/PXmfPLnvYxxUZ5yPVJ8Kgt7QqaRSV2Fjt1sWIheLIWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878391; c=relaxed/simple;
	bh=Q6oQXPc0uUIXKVAaxW26JT+8u/fuAMuSKd+0dC8qmUU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uNZQQbgxiUm0FrD9zUwwDimIPV3YQehAns1uPLEDAIp01vcFx2TRgMfDorArQt3dP+jO5voQhLlwER9qKM02Ektr3L0e46Qea2RJJ8Pdi/tcIk/1nwwiU/JejjSpW8Ry3wK1cKjcu3Ioi/PPiyXoD+Tk9zAqyA8WylBjjTRFI0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ec0MmWcK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753878371; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E5Ij+vKWOvKdNDa/G4T+pXm0WxamYVDvI1aGt+s8bQazMLbU8yflr9HUdNiiq0f5QTT5yVuhPvUEFujoj3VFZORe9NL/aMh11FPhGAd/vkcGFuGGQ7aLV/u1oPrhqGDTI+odSvNJbTVU6d4rEhO1J/B1VsUzdUv0yr+OcP7+tf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753878371; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZAn/LS7lWGDlLcV5/c1TbKTMhX/5ghkEvmsY8L1tCU0=; 
	b=i6EnZl62jX6nLa7Z39XV9P3SJnkqMPLZi2NSGVljHVLxALe/f5RlutCnbtLwyvY4wHYuBfCLN0GDUgNOQTWoMCRQJcLPF9zCebiwTXOr4AKu2r/IRqOXysB7nO8Q1UrXCLnyyNfdZt13cBCFEpjWtaa6pXuitKYEmAw08vuFWQ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753878371;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ZAn/LS7lWGDlLcV5/c1TbKTMhX/5ghkEvmsY8L1tCU0=;
	b=ec0MmWcK3Vm6CAKnyFR9UwhlNpKugOoP1f+uAWH8znmo0A0NkdtCVFIthNXxzkzj
	CQbHrDFgG7kNwPWFbS7+e8FbSMcbF/kSrFryQ9LQXb9UCfBLfarXK0kFbaa6NPPncwQ
	77knDkhhl6Q0VjDXQYUnAjGAtk1YaJ2k2jVnwL2w=
Received: by mx.zohomail.com with SMTPS id 1753878369632893.3488341415878;
	Wed, 30 Jul 2025 05:26:09 -0700 (PDT)
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
In-Reply-To: <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
Date: Wed, 30 Jul 2025 09:25:53 -0300
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
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEDA91F1-B6FB-4A28-8B34-4811CE683514@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
To: Daniel Sedlak <daniel@sedlak.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Daniel,

> On 30 Jul 2025, at 04:29, Daniel Sedlak <daniel@sedlak.dev> wrote:
>=20
> Hi Daniel,
>=20
> On 7/29/25 11:38 PM, Daniel Almeida wrote:
>> +    mod private {
>> +        pub trait Sealed {}
>> +
>> +        impl Sealed for super::Unprepared {}
>> +        impl Sealed for super::Prepared {}
>> +        impl Sealed for super::Enabled {}
>> +    }
>=20
> I just noticed we have plenty of Sealed traits scattered across rust/ =
folder. Do you think we would benefit from unifying it to a single =
location to prevent duplication?

Benno replied to this below.

>=20
>> +
>> +    /// A trait representing the different states that a [`Clk`] can =
be in.
>> +    pub trait ClkState: private::Sealed {
>> +        /// Whether the clock should be disabled when dropped.
>> +        const DISABLE_ON_DROP: bool;
>> +
>> +        /// Whether the clock should be unprepared when dropped.
>> +        const UNPREPARE_ON_DROP: bool;
>> +    }
>> +
>> +    /// A state where the [`Clk`] is not prepared and not enabled.
>> +    pub struct Unprepared;
>> +
>> +    /// A state where the [`Clk`] is prepared but not enabled.
>> +    pub struct Prepared;
>> +
>> +    /// A state where the [`Clk`] is both prepared and enabled.
>> +    pub struct Enabled;
>=20
> I would put a private member into the structs so the user of this API =
cannot construct it themself without using your abstractions.
>=20
> pub struct Unprepared(());
> pub struct Prepared(());
> pub struct Enabled(());


I don=E2=80=99t think it=E2=80=99s a problem if they construct these. =
They can
construct e.g.: Unprepared, Prepared, etc, but not Clk<Unprepared>, or
Clk<Prepared> and others without going through the right API.

>=20
>> +
>> +    impl ClkState for Unprepared {
>> +        const DISABLE_ON_DROP: bool =3D false;
>> +        const UNPREPARE_ON_DROP: bool =3D false;
>> +    }
>> +
>> +    impl ClkState for Prepared {
>> +        const DISABLE_ON_DROP: bool =3D false;
>> +        const UNPREPARE_ON_DROP: bool =3D true;
>> +    }
>> +
>> +    impl ClkState for Enabled {
>> +        const DISABLE_ON_DROP: bool =3D true;
>> +        const UNPREPARE_ON_DROP: bool =3D true;
>> +    }
>> +
>> +    /// An error that can occur when trying to convert a [`Clk`] =
between states.
>> +    pub struct Error<State: ClkState> {
>=20
> Nit: IMO we mostly use the `where` variant instead of the colon.
>=20
> pub struct Error<State>
> where State: ClkState
>=20
> But does it make sense to put the bounds on the structs? Shouldn't be =
enough but but the bounds on the impl block?

This does have some implications in general, but in practical terms, I =
don=E2=80=99t think it
matters here.

Also, the bound on Clk<T> is somewhat warranted even though we could =
probably
get away with having it only on the impl block. It correctly encodes =
that a
Clk<T> should only _ever_ exist if T is one of the states.

=46rom the above, it follows that Error<T> also needs the bound on the =
struct,
otherwise this will likely not compile.

>=20
>> +        /// The error that occurred.
>> +        pub error: kernel::error::Error,
>> +
>> +        /// The [`Clk`] that caused the error, so that the operation =
may be
>> +        /// retried.
>> +        pub clk: Clk<State>,
>> +    }
>> =20
>=20
> Thanks!
> Daniel


