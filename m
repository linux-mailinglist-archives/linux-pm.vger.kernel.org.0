Return-Path: <linux-pm+bounces-39777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17ACD6434
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9078C3088847
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031482E7167;
	Mon, 22 Dec 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ODA4sbpF"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716372631;
	Mon, 22 Dec 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411680; cv=pass; b=RMeEahioRh4WANtQhQzxsAGdMs5s+Fcw6AIxQH+8xQ/FCJBLQMxQZUF+Q0yQTtsxj63afU2Q+nptH1sxDoxH7o7kNj3cCoDquihHcUIUXH5fr45M7q73BYwUNglNBzmP0hvZOWQkc7u9+kq1rzwvwGUctMfBijN8qmV5X0TxvgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411680; c=relaxed/simple;
	bh=Ku80q/NEdh+uhGMUB9moAyteDRa8bVWjYZ9QTnSdhi4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=stEpKIvW1EcYi2jBHFwKwHbUBJRFfgE3XOjgtD7zVHWhr9DR6sC0IMZX+CAq2j1lWzOweJYKzr5dcJHnYOKCjlKhp7AB0ln0p7+FQX+XDODwyG9c2KXbfWxDqYE9tf4lz3bKnQ+7eGi0Ji83S1tvl8I56Ip9xmU67E3yfBk1Ebs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ODA4sbpF; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766411662; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ks+hU5qr7zZ0px/nuJTfsw+s8ZlywD7HDfoUq9tEGdXjJbH83Hmgk0oh8S/WMmNC9CjDj3YZF8FgcZHdKG94AKuWm/05qRtGUkwJhvtDt3CwPUmNSsvPJ38fpF9Zb9x6vR0TtaCdd4aeSh1z7ABIJe5DD26GE8Hnc0VXWsw2Sy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766411662; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/f6O2qfpzajxymZbMnV5GSEgODMPF/CEVJy5JW8HtAE=; 
	b=Xq6iTKGSiM2NdfTk+wS6+TnrHY1gdvTfhi65xZcAGrTzSMg0J/ox7EhXAW08OtL8t1Ws6oYzAgmwQWXubXCQXmRs5hpx3wR40GI4YP9VCJ/KLHtXHx726CDMISSluWIKqdA/McywdrNTXjq2QA6LPt288yJ4XHd2HCquguFdYQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766411662;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/f6O2qfpzajxymZbMnV5GSEgODMPF/CEVJy5JW8HtAE=;
	b=ODA4sbpFTI1cPQcJ/UmE366FSrMJ3RXx5DrxPLlmLah7UIYLUOp1oyMsV3Z2yAf8
	zh6rtGwtZN3TrDctOgFvHc9wsloJBymPQw+gGBScylWJzRKKLKGopus4+Mpry+8gIuW
	EqX1QNg2HfqzPfdFyi47ZScciD9fywlcbY5mbzAI=
Received: by mx.zohomail.com with SMTPS id 1766411659804363.92587177667974;
	Mon, 22 Dec 2025 05:54:19 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: cpufreq: replace `kernel::c_str!` with C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
Date: Mon, 22 Dec 2025 10:54:03 -0300
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51CD17B2-6167-46BC-948F-373CF46E1E04@collabora.com>
References: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:29, Tamir Duberstein <tamird@kernel.org> wrote:
>=20
> From: Tamir Duberstein <tamird@gmail.com>
>=20
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
> rust/kernel/cpufreq.rs         | 3 +--
> 2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs =
b/drivers/cpufreq/rcpufreq_dt.rs
> index 31e07f0279db..f17bf64c22e2 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -3,7 +3,6 @@
> //! Rust based implementation of the cpufreq-dt driver.
>=20
> use kernel::{
> -    c_str,
>     clk::Clk,
>     cpu, cpufreq,
>     cpumask::CpumaskVar,
> @@ -52,7 +51,7 @@ impl opp::ConfigOps for CPUFreqDTDriver {}
>=20
> #[vtable]
> impl cpufreq::Driver for CPUFreqDTDriver {
> -    const NAME: &'static CStr =3D c_str!("cpufreq-dt");
> +    const NAME: &'static CStr =3D c"cpufreq-dt";
>     const FLAGS: u16 =3D cpufreq::flags::NEED_INITIAL_FREQ_CHECK | =
cpufreq::flags::IS_COOLING_DEV;
>     const BOOST_ENABLED: bool =3D true;
>=20
> @@ -197,7 +196,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
>     OF_TABLE,
>     MODULE_OF_TABLE,
>     <CPUFreqDTDriver as platform::Driver>::IdInfo,
> -    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
> +    [(of::DeviceId::new(c"operating-points-v2"), ())]
> );
>=20
> impl platform::Driver for CPUFreqDTDriver {
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890..8be634eaabe9 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -840,7 +840,6 @@ fn register_em(_policy: &mut Policy) {
> /// ```
> /// use kernel::{
> ///     cpufreq,
> -///     c_str,
> ///     device::{Core, Device},
> ///     macros::vtable,
> ///     of, platform,
> @@ -853,7 +852,7 @@ fn register_em(_policy: &mut Policy) {
> ///
> /// #[vtable]
> /// impl cpufreq::Driver for SampleDriver {
> -///     const NAME: &'static CStr =3D c_str!("cpufreq-sample");
> +///     const NAME: &'static CStr =3D c"cpufreq-sample";
> ///     const FLAGS: u16 =3D cpufreq::flags::NEED_INITIAL_FREQ_CHECK | =
cpufreq::flags::IS_COOLING_DEV;
> ///     const BOOST_ENABLED: bool =3D true;
> ///
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-cpufreq-725cd36ca0f1
>=20
> Best regards,
> -- =20
> Tamir Duberstein <tamird@gmail.com>
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


