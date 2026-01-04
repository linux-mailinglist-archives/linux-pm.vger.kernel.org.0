Return-Path: <linux-pm+bounces-40165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627DCF08BE
	for <lists+linux-pm@lfdr.de>; Sun, 04 Jan 2026 03:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D643006A4A
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jan 2026 02:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8023D7D0;
	Sun,  4 Jan 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMWx9q+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1213A1E69
	for <linux-pm@vger.kernel.org>; Sun,  4 Jan 2026 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493935; cv=none; b=sOF5g2E2bDhr0GcRCHQnhQVmW2nRHURI3wg05NCwnCfAHHRyhaVDlOcznP+gNusj72+IZTdtERS9+L6oluFHZiW/SWpG9Y9poMW4ELfiMM1NP8+kUWy81jEdGtvMucm47g96dzSaUktU2gb7U07Szoiyk1BZDVMe3UCcvAAkqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493935; c=relaxed/simple;
	bh=xcM+YLFUx8G0Il6VzzTwhnM5NDW1r4MG6MfiLKv4KeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtGMr5+Jgt8hQbafL2V6ScWN3sHSdwfco8X2cTh1MOgSH4a1SMcAkhmO9rule+mPWW9/vGrFj5SgYFa4BUxhJZAJ2zrKXvc25Jv+34sYcVl+Gou3pyAS8Ce5niahghaanVOA2UMdhVR4XWwdDl88sioGadkvPJgQBC/MC6/O3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMWx9q+c; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-598f81d090cso13574489e87.2
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767493932; x=1768098732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRRDR0RGwV8zJoNlbb9Ju5idJudLKXD8B1yec8aLX60=;
        b=PMWx9q+c4PbvEKQ5VWVDCLHvYgLkNHjZBlbhSWqtQkizNJltEt20do1ViNwkbeLsmP
         8bARF5RJVQ1p82s/UbUxw0bdRnia37uLd3ukV/plomZWv//AM7PGmLKzSnKZc/HXM04i
         kEpN6XALqcQ2NZD8Jr6ThYiRQKc41J7YO6uaNqaiTGtltFQbtYD9no2iuj6nxbXsnlnM
         wWjcVjRjbIEg+yewXB4xJmOxfxNPVH88to18/1QJ9B6FpHuKxIVaQEblUE4sMcRtS7mn
         S9rkrbjl8dC8Bu3RQBmHtDra7FjP6ii5ENAoVKwMD0L6tk70zROe/WgxqwKUrtr3oWZ7
         Uq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767493932; x=1768098732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRRDR0RGwV8zJoNlbb9Ju5idJudLKXD8B1yec8aLX60=;
        b=LLxuGeVs8ajRrpKXzeebjzd/RaqMhf+Do2XICkmCdHa4PpTU/RbcW9K/RF24STzJdm
         GCsBrXkXP03RSXstEsY1LAuomiaeBQVOSqoheMqctzG8Vn1uEP9GCORCbij9Xc7KGimy
         UN+0ZR0Fl7Ki8JSCLOZsQbpKrOfhk9ot7C4L3yH/ryIufBUHOf7ehEoqe8ZAy3EslW6o
         MB5RteLZkGeesXM5NAmJgz+tjziDN6mFg9wPLgCybacRAvrCK/sI4DDN9pdmYeYHDDgN
         g/B10V95TWyhflrKSZXlIo8pIOSS8zA6s5xp8bvo5eTt6u8mHkMAPo1pTWgw+QRKlFg6
         ggSw==
X-Gm-Message-State: AOJu0Yyxv7v6QFP9u3yl4uNNLyCmrA6cLMzppNCL5Cyhsz9UGaQvFqlE
	zPR6R7IqCyuqcebI/bKWpUlxk+Y21ImMvYgG0Dqk8ojcpAjzoaVBw8gr3efymC7SqIBvzRyr/52
	pctxMN3vb5yQAGp3sDvcXWhgs28dmA5k=
X-Gm-Gg: AY/fxX7AsY/ipEARoALzFsAgLzJXw0YK/YuJjtzR6IOL70dLojBJcLOROpuXFX/UfgC
	JBPBIOv9qcKVPI39uBgt1F5ekg4rTbKPZlorjl5kHQRwmJSP+Kvx/T8eKsnkhu+bue57Oa/SMuE
	JHsQAXICEW7q5mOMm7NDFjmAAceZqizNd9teO045R52NOfeYJheax70shNf/LJpRyTJ3Lu1awzW
	ssBwh06Qg0LIuDeO2j1cvjIpVPdoSSaA35+PLw3APwAmMXvqcIqwWMqpvxMjarX2RcrXdhp3OFc
	4DDavoUjrb1DbwfaBAOhqUQonj8fZLvlAhcbnD3MMBvNGR+jujKiBZeHNZ971PV+Bu3iDocfA3Y
	FW9SXhNlM8OVYwpfehD4xEHrMVY6RTlAXeZ88UQEEgg==
X-Google-Smtp-Source: AGHT+IELCR4Bl92Ks7kkheBZ9OTIGG+ewGhSD3ldOmcO++J6QAm8jenR0KGpzbz8OcrdZJ8zxSNacE2uInicHqw18Cs=
X-Received: by 2002:a05:6512:3088:b0:594:2e7b:6f9 with SMTP id
 2adb3069b0e04-59a17d3df9dmr17434108e87.27.1767493931905; Sat, 03 Jan 2026
 18:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
In-Reply-To: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 3 Jan 2026 21:31:35 -0500
X-Gm-Features: AQt7F2qDqrCh6YZBHksL2dCmEjW9ezDLpdifIRWg3bBC_CeEcK74u_6KV4PSzvI
Message-ID: <CAJ-ks9mgxBhiOo=zoV3+gQeqndiJ1giQNp+a6vzCGHJRncEAHA@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: replace `kernel::c_str!` with C-Strings
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:29=E2=80=AFAM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
>  rust/kernel/cpufreq.rs         | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> index 31e07f0279db..f17bf64c22e2 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -3,7 +3,6 @@
>  //! Rust based implementation of the cpufreq-dt driver.
>
>  use kernel::{
> -    c_str,
>      clk::Clk,
>      cpu, cpufreq,
>      cpumask::CpumaskVar,
> @@ -52,7 +51,7 @@ impl opp::ConfigOps for CPUFreqDTDriver {}
>
>  #[vtable]
>  impl cpufreq::Driver for CPUFreqDTDriver {
> -    const NAME: &'static CStr =3D c_str!("cpufreq-dt");
> +    const NAME: &'static CStr =3D c"cpufreq-dt";
>      const FLAGS: u16 =3D cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufr=
eq::flags::IS_COOLING_DEV;
>      const BOOST_ENABLED: bool =3D true;
>
> @@ -197,7 +196,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
>      OF_TABLE,
>      MODULE_OF_TABLE,
>      <CPUFreqDTDriver as platform::Driver>::IdInfo,
> -    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
> +    [(of::DeviceId::new(c"operating-points-v2"), ())]
>  );
>
>  impl platform::Driver for CPUFreqDTDriver {
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890..8be634eaabe9 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -840,7 +840,6 @@ fn register_em(_policy: &mut Policy) {
>  /// ```
>  /// use kernel::{
>  ///     cpufreq,
> -///     c_str,
>  ///     device::{Core, Device},
>  ///     macros::vtable,
>  ///     of, platform,
> @@ -853,7 +852,7 @@ fn register_em(_policy: &mut Policy) {
>  ///
>  /// #[vtable]
>  /// impl cpufreq::Driver for SampleDriver {
> -///     const NAME: &'static CStr =3D c_str!("cpufreq-sample");
> +///     const NAME: &'static CStr =3D c"cpufreq-sample";
>  ///     const FLAGS: u16 =3D cpufreq::flags::NEED_INITIAL_FREQ_CHECK | c=
pufreq::flags::IS_COOLING_DEV;
>  ///     const BOOST_ENABLED: bool =3D true;
>  ///
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-cpufreq-725cd36ca0f1
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

@Rafael could you please have a look?

Cheers.
Tamir

