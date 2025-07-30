Return-Path: <linux-pm+bounces-31612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B673DB160E5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D25C3B4FC3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626229A9C9;
	Wed, 30 Jul 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HZIaxOh1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B0256C70;
	Wed, 30 Jul 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880407; cv=pass; b=FsxeD2phGhq8Q1OZoiAku063pIgqrHo1UgUnGOB+Ev36JQzMCQSjs+pLiJrmWk2sq5NNf01Gnd4wCdT/OIldH+NskV4X3NY4hsd4vVlHcbkfRrdpdiqMC/gD4NpYNY3f4DzH9h+BLfoDWPBv/adJKUY1QUD5ZKsdcg619apnfPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880407; c=relaxed/simple;
	bh=Sp+wKxi8YgsnfIS5fAsGa8LBsrANp2jAeEo1D8telc4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=caCFniBqadvKBN9pgVSl/XjLQSxF6MePgBOKgjDyLTwtEQzmeRX25J8ar4PSYBDokVLwArLyl3id3E7rfx27pkgBQjxpDTGkXAalae6i/adCjGzKCN4JUYKbGjOBoWR7P6KiJIlqUXo8qnej1UpD071dXrKttZ8R6GZRO4UKWBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HZIaxOh1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753880382; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eJV343i9OO9SW5SSN9xw13OxC3LNfIbWweaCDjqQVGOFcgQ2NILllfs96rW5VPJlDj6EYSdM50pZM1YQfPMivIWoRutqSbk2pqGx1/+P49zsujsn5xE0IV2150Zi1udo7/6yQZsgiVkKvBgxAkffeupXEig+1BpIDFWanIsMBvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753880382; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lFUfIzxeqLwZEbvC55PqViWhH39Ua5QrSdIlYLNSW30=; 
	b=RdJyuAWqNftaNV3AeyEky9G3w5HTnTxuQNEWMr37LNueZkbdjQgJq7UuWpgkDIJLtb9SGGsCrXwyZBMfyVuofKKcTlKeR2RO7g/DiTxG+ON6wjtmQhPSJOnjek6t0EJZCg9LykaiTntc7UOg5EFce56l2hc8fmkfFiykQob3WBk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753880382;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=lFUfIzxeqLwZEbvC55PqViWhH39Ua5QrSdIlYLNSW30=;
	b=HZIaxOh1olRyxs1Gslt+udIN3STLtEahDVo02auOU9ksk6s3wVsIuhdaJCr6hgqo
	NRrGKkNop5ZkKYfB9jZ8DNZILPVHlEb6pS6Ek2lYdx9lW7U5GuyAfsJZrhQ5ebbxi/7
	iPg5QPFx/EoUwbNx9NpnzBLjWM9KxAf3G2+7J+RU=
Received: by mx.zohomail.com with SMTPS id 1753880380483790.9531132596521;
	Wed, 30 Jul 2025 05:59:40 -0700 (PDT)
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
In-Reply-To: <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
Date: Wed, 30 Jul 2025 09:59:24 -0300
Cc: Daniel Sedlak <daniel@sedlak.dev>,
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
Message-Id: <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
 <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

[=E2=80=A6]

> We essentially would like to have a `#[sealed]` attribute that we can
> put on a trait to avoid the `mod private { pub trait Sealed }` dance.
> (so a trait that cannot be implemented outside of the module declaring
> it)
>=20
> ---
> Cheers,
> Benno

This is not exactly what you said, but how about a declarative macro? =
e.g.:

macro_rules! sealed {
    ($($ty:ident),* $(,)?) =3D> {
        mod private {
            pub trait Sealed {}
            $(impl Sealed for super::$ty {})*
        }
        use private::Sealed;
    };
}

sealed!(Unprepared, Prepared, Enabled)

Note that I am just brainstorming the general idea here, I did not test =
it yet.

=E2=80=94 Daniel=

