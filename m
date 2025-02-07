Return-Path: <linux-pm+bounces-21531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8735A2C14A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768EB188D65A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB941DEFEB;
	Fri,  7 Feb 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5Wz4xXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085961DED64;
	Fri,  7 Feb 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926451; cv=none; b=jISeG3tUhw8mUSuZNYetO9N4ixx8GJX7uyiN0w/L8yYgPb/SK9XlYPpWGml8eTQuGd7/c2FesN7ob37vH5C2X40pt5/ir+rQpgETVDQQ0HitAbPnry7AFtWiS4CPZ/x9l16FN9gHv8UzrlqLEo5+Xw+EPG6qkDvYqk2Tjq6uQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926451; c=relaxed/simple;
	bh=tX2VhS1SeREZEEWfKhsYfi87lp8g4mnQweSe4p8Ykfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUpllPH95WWz8zl1uuQqzTrbqePOCZaqC07Am8G5bJJD0g+lUdJBnW5WlPQF57ziNj2/aRd1cSuD2iHkwDiX7KyL8TbNFOYcv1ciwn/auHaM1VoaFom5A4Zfz8sn2RsbKE5dzcJqIuUZz6Q8auXxpIA/ibGayxL8vZj9LfZfeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5Wz4xXk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso446302a91.2;
        Fri, 07 Feb 2025 03:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738926449; x=1739531249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX3UWjqcmjhwdy78xAQGr+U0/dUkqStaWJmr9P/RfFg=;
        b=O5Wz4xXk8syOtmtz7Y5fEScSZEfY/Yc9Hqlpi26kEML6CERHwaNQyLfYE6emw3lT7a
         UGfMrxn8s23j+hWnaCOXrfxN8ucDooibi3kcDWeIkOQSFDTOcBC0DMZjdBvRorDf2aum
         36khANTspF0hvAejbGYapyfPEdjoFmUEZ7v+z/uK6fQT0jhpFequyKfai9pZDM0pNRzc
         +laQ/d8fYa3fUBCPfUzTfr+VqAS6Hz/fSMh/+RiguQhXXAVnT7uyHMAfcOfPx46r7gtE
         vOskpPnCvxz4YR7IwwsDL/cMh3SCt6bE8WPENER5ciWCPRnnhNu4yA3XRZtUZOr5nnVk
         sySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926449; x=1739531249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX3UWjqcmjhwdy78xAQGr+U0/dUkqStaWJmr9P/RfFg=;
        b=EvnzIvBhBR9joyM39IcvVHCUmCGFxcGXM5U47YwnngiYBoQFdstkIQ2eFUo+w1delK
         8KhMtQNfTbjdXXNQmOVuhzpz6yQwZRhgKBkLZfKjE2P5blSMxo4KxZyOyOkZuCndnouA
         3+Aa4o8bdXpD+BiLhjepWeHa7uFyD73ntWuGMgqpnmtRiUXLCnzUzyHzOroO6R2sSaBz
         fy6iYN0HM2ao27kDalnaJoOt+bLMVGBrL0TTncQ587YbFP19hd6/AvmX824KKNGwLQxx
         KRIXiItevf67UEFTaSD8b6EmWj5ybj7m8JWcoOynhvud+s72KThhEv6UZLFFG5HFK4W+
         pgwg==
X-Forwarded-Encrypted: i=1; AJvYcCU9bizb3e671ENmJyqKLiHpS1AAKJv65ivr9+STyrTKn2DBH35vNSxough7zwbCN6lFUmz8YzJsQjZHuqkP@vger.kernel.org, AJvYcCVQydHdexinyMh2AzYCrDpPL7YrQRJBMmOfa9RC+xNIlzw+dUBdXtwXisK6JjdoChdDv/OSS7vELopEN5hOGm4=@vger.kernel.org, AJvYcCXgXvA3FqNCdIVR3xnJF69xICv+9Tpict2cT3vX80edXtjAxH3AILqQPS6mUnkaIfz+8448ygNzfGA=@vger.kernel.org, AJvYcCXuPRCIrJvvXRqQAd81BiAO1Q3kPEVvE9SnBLG23SGpQSmx4PwstntHsw9GNpMilH5KDo2A/8aXiik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6m6LkqGoq7UhFyYU4ApzmbHXw8MlQ5Dg8WQNTvIDE7cFjSWGg
	9TbYahPqCYcuKvkCbvUaxkfXIHL3CWrlei3W+rq6sEz5A7FqFCln2mlPbim1RUGqq9fvO1osGQc
	ivMgkbISTuKe3xRA2keNoCr1D1kQ=
X-Gm-Gg: ASbGncu6WMPS+7e1Ru0Jnpz1lXudBoB/PbJus2k3TxELs4rpXWM6djzqinq2fJQjjiA
	XvXNU+9oDRggSRzHAmtXgR2QpC3kDJLSLV8dIDn+R1sCVGhgpHxsQduMBIq4MAWhc/XJZ6D6C
X-Google-Smtp-Source: AGHT+IE/3gWtecB4TuXpei0yuNOQwHNbelMV9DCjald55tyxQFeC6FoGlBVQILPWu4B8zeWlzZ2N/WpKVfFEjQUhemA=
X-Received: by 2002:a17:90b:3903:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2fa243ed977mr1750269a91.5.1738926449145; Fri, 07 Feb 2025
 03:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <Z6Sgwbgfp-9SCr8Y@pollux>
 <20250207071538.xjxauatta2jsedz4@vireshk-i7>
In-Reply-To: <20250207071538.xjxauatta2jsedz4@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Feb 2025 12:07:14 +0100
X-Gm-Features: AWEUYZms7tganxn6t-nVTSipJtfvYNnMyzk79dgVfbWiEhhyHiIvoGcdoMyxUWw
Message-ID: <CANiq72k4N_bD3_QxFKveyjGsSeXJX7y6fKU4EVt0hBOcq9q7tA@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] Rust bindings for cpufreq and OPP core + sample driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Trevor Gross <tmgross@umich.edu>, 
	Viresh Kumar <vireshk@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Anisse Astier <anisse@astier.eu>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:15=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> If I move the code as suggested here, then I get warning about not
> adding a SAFETY comment for unsafe code (which looks to be a tool
> specific bug).

The warning is there even if you don't run `rustfmt`, and it does not
look like a bug to me -- what Clippy is complaining about is that you
don't actually need the `unsafe` block to begin with:

    error: unnecessary `unsafe` block
    --> rust/kernel/cpufreq.rs:631:22
        |
    631 |         attr[next] =3D unsafe {
        |                      ^^^^^^ unnecessary `unsafe` block
        |
        =3D note: `-D unused-unsafe` implied by `-D warnings`
        =3D help: to override `-D warnings` add `#[allow(unused_unsafe)]`

since those operations are safe. Or am I missing something?

Then, when you remove it, Clippy will complain that there should not
be a SAFETY comment:

    error: statement has unnecessary safety comment
    --> rust/kernel/cpufreq.rs:625:9
        |
    625 |         attr[next] =3D
addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as
*mut _;
        |
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
        |
    help: consider removing the safety comment
    --> rust/kernel/cpufreq.rs:623:9
        |
    623 |         // SAFETY: The C code returns a valid pointer here,
which is again passed to the C code in
        |
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^
        =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#unnecessary_safet=
y_comment
        =3D note: `-D clippy::unnecessary-safety-comment` implied by `-D wa=
rnings`
        =3D help: to override `-D warnings` add
`#[allow(clippy::unnecessary_safety_comment)]`

And `rustfmt` will put things in a single line, since now they fit.

I would suggest reviewing all the SAFETY comments around this code,
i.e. something may be wrong, since these were not needed, and thus you
may have wanted to describe them elsewhere.

In any case, passing `rustfmtcheck` is a requirement. So in the worst
case, if you do find such a bug in e.g. Clippy, you may always
`expect` or `allow` the lint or disable `rustfmt` in that region of
code. But that should be really rare, and in such a case it should be
reported upstream.

I also found other build issues in the branch you mention in your
cover letter, so please double-check everything looks good before
adding it to linux-next. Please also make it Clippy-clean.

I hope that helps!

Cheers,
Miguel

