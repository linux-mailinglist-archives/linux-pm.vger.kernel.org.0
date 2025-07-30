Return-Path: <linux-pm+bounces-31583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C10EB15A63
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C282E189911C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEA2512D7;
	Wed, 30 Jul 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujUMUQwd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F127187326;
	Wed, 30 Jul 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863616; cv=none; b=n2UZNjatVxqYdA9hkuQwwNGeHLhORD9N1haZHUj7BbAAY8DEepYCZoAXBBLNjjZCrOzW3VY4a9xBWnrbJZmDCOZEKU4ERczZPyLS/gk0TQsWxu+GA1J7HoeUBNItBWnREGdKm4IKpteoxgse+9fFdfC5J62TIVZIYGXTg6jIA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863616; c=relaxed/simple;
	bh=Phr/wSUV51OEITszg2jpDf0As0Xj1xb0ldJvvV08SSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SQxYiZVlmg/px2Mxw7bKOJWmB5bPHHNj0DjIhrQhvaK0KQiZH9+GbpdySulm4ccGCiEU6TbQg5FFG/owP3ehNigRUFAEDAZaZ5LJmnBlLdxIvzxe/0KaJ90t5eLxk4VIanlrPttiYGx8mg3GXcLKDRPZUo2lahpWO47mdHCctM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujUMUQwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F288AC4CEE7;
	Wed, 30 Jul 2025 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753863615;
	bh=Phr/wSUV51OEITszg2jpDf0As0Xj1xb0ldJvvV08SSk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ujUMUQwdpi9GTAiTU4VMsiaGO6jWXajJ7UTBEXRzWLx+5gsKj2amEtx/tEsADmfU0
	 m1w2EawF2e9WWQvCWQdV4jURjTn/L9D8avLtR6+VqCzafSTVFZXeVoNMbeKoaOWjsO
	 A4OiFV/ghM7Phw/Zt+HWUNL3Sx90jLUby56WuQDoTn5J0EaMTXawn00AYWGcItAgEZ
	 2vwUEvplAFUtLhN0bk94J2GgBlsC2Le8TKlh/kMyd3VS0AFVlbXgJwPuN49PaPUH+n
	 KeIDYAqxcA8oN5GcxdH8Tchjyu7MGmV2aXRvFtUbQtcbOZuFp2NIzcbxyJ3P6Jg8z3
	 BznIejWeHaqSQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 10:20:09 +0200
Message-Id: <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] rust: clk: use the type-state pattern
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Sedlak" <daniel@sedlak.dev>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
In-Reply-To: <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>

On Wed Jul 30, 2025 at 9:29 AM CEST, Daniel Sedlak wrote:
> On 7/29/25 11:38 PM, Daniel Almeida wrote:
>> +    mod private {
>> +        pub trait Sealed {}
>> +
>> +        impl Sealed for super::Unprepared {}
>> +        impl Sealed for super::Prepared {}
>> +        impl Sealed for super::Enabled {}
>> +    }
>
> I just noticed we have plenty of Sealed traits scattered across rust/=20
> folder. Do you think we would benefit from unifying it to a single=20
> location to prevent duplication?

I don't think we can merge the various `Sealed` traits we have. They are
implemented for different types and ensure that only those selected
types are allowed when `T: Sealed`. If we merge them, then that is no
longer the case.

We essentially would like to have a `#[sealed]` attribute that we can
put on a trait to avoid the `mod private { pub trait Sealed }` dance.
(so a trait that cannot be implemented outside of the module declaring
it)

---
Cheers,
Benno

