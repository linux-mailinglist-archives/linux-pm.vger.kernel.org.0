Return-Path: <linux-pm+bounces-38928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E251C95218
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53873342904
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9905823EA88;
	Sun, 30 Nov 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Sw07uOnG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD81E51EB;
	Sun, 30 Nov 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764519011; cv=pass; b=iQbztFOnOgJYVvpoSUFv5yMv/Q7vDL6Rl5QLK6jOSd3a7PS8Vapm/+mlmBDcZM3rrC2AWlTlsLwHwkG82c9oRlZYnegn9Xf8RSveok6QyboaaepVoGLevmJQIO5UObHsE6fdv8FS263iRBOvCj2K+SGaD+CFWjkwN5VOhXAKDp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764519011; c=relaxed/simple;
	bh=Ky5BCREuCQSf6V05RZSL5DPlBZvRAcJsTXd3VV3wAds=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dP/zff+51fjTi1k6d5BiZNycYXJdf2jbeOhlA5mBkHIf9nkDdTii118XnyKyxhhpWkzPIe5EUfz0k1/im3j5ugS46I4+sO386tc8sJI42MG9BrKyngElH8MPlQmr0lWum9tpkTJp6qko3m8dJJGNlEsP4bon6x1+JTyynvEVOKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Sw07uOnG; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764518970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lZNGPS8/yzplH+/lZnmpT0u0XgfKQzV5Ebc62X7LhYm4h9mo+s5ulxjvCWO31ZngO30oC6jsBiyoRXh6+x2lq3rQmmHLxAadt7oAa2v0xL4VEFanYSFXzr4ffLQXM29Q1FmZlJmWW4StaTDf8Zqre+KBQvvGJs96TFBCwDiD8BA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764518970; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ng1aOetX8xPcmZ+/SsN+zhM8qMmEe1qTFrEk8t2JxZM=; 
	b=SjGrEAdbb9i3f5Gvevo4Ix2gNMDXPWl+H9fG5jiX1vgVKmKLU4ZC4Dfa6InO+y8HC24sy8cQBPYXEh4DNWrUysUS6XU1RYmJAnmvzJRxfZJtFEW0xwGYvkmJ1Xd+nAANv0SaTrvQZBbjqkvGqOEIlpwb9ieMyi0k1PPv9Bd4/zs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764518970;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Ng1aOetX8xPcmZ+/SsN+zhM8qMmEe1qTFrEk8t2JxZM=;
	b=Sw07uOnG3HQBIV67l0L5pf6jOXLN3f498urFbg9hk1eDdUf9x7pgs4SMHetJ0YDZ
	F/HP/644vDP8qSB3RNJJCkUTYeS3ZUmcxdmEJwQTTnId/2hjE+Qw0Mf3HQApo0/Y+fR
	9rjGpbZDcnGWYxugCD8zFK2jBP5avH+lk1VpDzSk=
Received: by mx.zohomail.com with SMTPS id 1764518968022925.5408583981418;
	Sun, 30 Nov 2025 08:09:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 0/7] rust: build_assert: document and fix use with
 function arguments
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
Date: Sun, 30 Nov 2025 13:09:11 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A952509-8A00-48A0-B975-C23608A6048E@collabora.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 27 Nov 2025, at 23:11, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> `build_assert` relies on the compiler to optimize out its error path,
> lest build fails with the dreaded error:
>=20
>    ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
>=20
> It has been observed that very trivial code performing I/O accesses
> (sometimes even using an immediate value) would seemingly randomly =
fail
> with this error whenever `CLIPPY=3D1` was set. The same behavior was =
also
> observed until different, very similar conditions [1][2].
>=20
> The cause, as pointed out by Gary Guo [3], appears to be that the
> failing function is eventually using `build_assert` with its argument,
> but is only annotated with `#[inline]`. This gives the compiler =
freedom
> to not inline the function, which it notably did when Clippy was =
active,
> triggering the error.
>=20
> The fix is to annotate functions passing their argument to
> `build_assert` with `#[inline(always)]`, telling the compiler to be as
> aggressive as possible with their inlining. This is also the correct
> behavior as inlining is mandatory for correct behavior in these cases.
>=20
> This series fixes all possible points of failure in the kernel crate,
> and adds documentation to `build_assert` explaining how to properly
> inline functions for which this behavior may arise.
>=20
> [1] https://lore.kernel.org/all/DEEUYUOAEZU3.1J1HM2YQ10EX1@nvidia.com/
> [2] =
https://lore.kernel.org/all/A1A280D4-836E-4D75-863E-30B1C276C80C@collabora=
.com/
> [3] =
https://lore.kernel.org/all/20251121143008.2f5acc33.gary@garyguo.net/
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v2:
> - Turn into a series and address other similar cases in the kernel =
crate.
> - Link to v1: =
https://patch.msgid.link/20251127-io-build-assert-v1-1-04237f2e5850@nvidia=
.com
>=20
> ---
> Alexandre Courbot (7):
>      rust: build_assert: add instructions for use with function =
arguments
>      rust: io: always inline functions using build_assert with =
arguments
>      rust: cpufreq: always inline functions using build_assert with =
arguments
>      rust: bits: always inline functions using build_assert with =
arguments
>      rust: sync: refcount: always inline functions using build_assert =
with arguments
>      rust: irq: always inline functions using build_assert with =
arguments
>      rust: num: bounded: add missing comment for always inlined =
function
>=20
> rust/kernel/bits.rs          | 6 ++++--
> rust/kernel/build_assert.rs  | 7 ++++++-
> rust/kernel/cpufreq.rs       | 2 ++
> rust/kernel/io.rs            | 9 ++++++---
> rust/kernel/io/resource.rs   | 2 ++
> rust/kernel/irq/flags.rs     | 2 ++
> rust/kernel/num/bounded.rs   | 1 +
> rust/kernel/sync/refcount.rs | 3 ++-
> 8 files changed, 25 insertions(+), 7 deletions(-)
> ---
> base-commit: 54e3eae855629702c566bd2e130d9f40e7f35bde
> change-id: 20251127-io-build-assert-3579a5bfb81c
>=20
> Best regards,
> --=20
> Alexandre Courbot <acourbot@nvidia.com>
>=20
>=20

Ah, should this have a Fixes: tag?

=E2=80=94 Daniel=

