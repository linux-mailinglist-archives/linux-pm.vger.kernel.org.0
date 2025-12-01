Return-Path: <linux-pm+bounces-38987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08247C98580
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 389693457F5
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC13358DD;
	Mon,  1 Dec 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En12ZCkS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6E3358B2
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607430; cv=none; b=donMHxF5wiGL6r40JJiKh6+c6u+J0ZROBUMn4C8bCwNuqLUgO04CJO1Dtdo0yKwQYyoEFBM8ewJqR/Xdv3JH+31oQH5xNqE6mBc+RtJTuMv2OOyNTplKFo9jdY8hZXgePf347raJT/dNc1HYYICXnZ5EmX0yl5C9XoZlUrf8D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607430; c=relaxed/simple;
	bh=TPEpVKpN4tB6KuM5JFxPyB/JvqizpFAH6dInpGZUQp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAt02BDibHyn4pK7ih7r2NZij+3q5z7bT0wdRa/0epMfKo+9W7vwEK7+dDYmYPRml00RR2YcOw3hRAlvwVCKhARwIEBgu1Q5zEtyU6oy7U9GiAv4CwmIQ/ErOENFfc9aJpGoYXS5CTniS4E+Vt0Zk54GV96gGTUEkE5wea4yj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En12ZCkS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso257075a12.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607428; x=1765212228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPEpVKpN4tB6KuM5JFxPyB/JvqizpFAH6dInpGZUQp0=;
        b=En12ZCkSSqDbgDpSS59pDlgUvKQYuSxaaZ8x7NBxOK8LA4p5otffcKRhx4c4P0AcVj
         9VMQMcMvEFp6IRLfZs0T5gzu9ap5LgZhnj6gbf+YfRiuUfMK0GjBzg+oL5l2MNctYTVp
         3vfA9z40tt5wbD4eoY4kP/UIVs+B+/fFXX9VYD6nlMK2H8ksm9BjDZ0LfiGxtunxPhxG
         /2U3nj1PBBVQnTVzYoboy+8Uo2DvjWxEQWMGGzYkJ6XFkspl56x+Oam058omKHrFZcey
         mUASlHlvtYn/nzYTR0angkjkjzC6qLFa2SIPmzEba4jBPAkhi2NYNhvZELGQqbkG7ogq
         vvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607428; x=1765212228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPEpVKpN4tB6KuM5JFxPyB/JvqizpFAH6dInpGZUQp0=;
        b=lO4dXVNVySr39n5Z46gOGr+sq+DyXd+T2eV72CyEMOOQnW7Et8HOptVUHpZ9Yr4+Zr
         i2dRTDRyW3gQxLGUJDWK5EmPeYRXXLJiPhJ01Zly5lQrWhREyGzLFvMKgpp5rMyRIBzH
         +C/aATPI3zz6gqUepSTc8wSvEQ1ROEe585gnOZziOo+XBsL6xJOAh0Nv8RXYgoMVVYO0
         IxjRD+WF9P68bJLAzSpV1wIAtFtLNvcjKKpRsXh0F+gq/8u6StztsM0cJjVmQ7Bob2XZ
         vw4xsf3gHkisQrHo630BQZLrkeXCXJWpWMBP+lDbJzHo3U/HPLnItKVkX8r7Zl3L6xKf
         nB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Cj393HjynN4coqlRsrQZ7vtjUIGhndNQv3+fg1cr+XQFLNyDSfGmISCXDADZBkYUfNz7GmxGAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGuWHVVJGcXTVYi5V72mKSMd/56XZ26pysBXM/ZK9aAETygus
	DuE5/A17IPGqXMlC0raW6pHYepClSV7tPDkfCuGMAnNaTm0fYJWKe5qQqKExAG1wmizoOWo/85W
	83dRFfWcZvMF6gmf04a7UdQUHXzqoBz0=
X-Gm-Gg: ASbGnct7s9GXtC0MfcAO/qXjyivnUM4G9oxP61cFnwJMfvuyDzL6XsCWDK7VhoP8qxB
	SWJo/y8hwhQDO57pDS9iQ0h3ga3ZnUyB0/dw2PbsUdX3ovPPXvGJMtWon7b7Jwf/IRfn2MBcD0w
	xN7VDKnD3bGmZB+6BwNm7SvTviQNUb7f91Q7Df05pK/3nUqpODhOSIckTXtTqXmI7RARGm4kbpn
	v+PVCvFkd6ox6Y9IkCEjFQXH7NWt/Gty4j3hQr6FGQsUXu+oMeTmkwD14Ogv8mPzHMIA6I4v6M/
	nAVdtXEu3CjATTf4CddzeDgpRQ9w0ISFn+dTbYF+JrmNLJvfJVwXw9P274Uaf915YhBuOW9Z9Eg
	L2qF4nGBwddM2VA==
X-Google-Smtp-Source: AGHT+IEFPKIvFdF0xEPYnADqwECRMouqixubdnTinjZbqQvI7iED4uFK2/xl2uu3oQITjah45Xb364mCIZvGJQjlY4w=
X-Received: by 2002:a05:7300:dc93:b0:2a6:9dbf:bbe1 with SMTP id
 5a478bee46e88-2a719324a83mr23545634eec.3.1764607428118; Mon, 01 Dec 2025
 08:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com> <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com> <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com> <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
 <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com>
In-Reply-To: <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Dec 2025 17:43:35 +0100
X-Gm-Features: AWmQ_blFfOOlsmhngh0j0WcChkaJRE0wkmIwqGkhRVgfInS-Pj4-ln8sReGsPeA
Message-ID: <CANiq72kAnY2035vc2vvXDpUV-_vM=0W2_-mBts846jHo1ri3Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:36=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> This seems strange: something called build_assert!() should not be
> put in places where it might not be possible to verify at build-time.
> It's built right into the name.

The build prefix means the assert is done at build time, not that it
can always be verified. Even other asserts could also "fail" in a
certain sense (diverging, conditional compilation...).

Detecting "unreasonable" uses that are likely to fail would be nice, of cou=
rse.

> So now we have to go around and annotate the functions that *contain*
> uses of build_assert!().

Only for those that need it.

> Otherwise we end up with an unreliable tool
> chain for developers. This is not where we should want to be, in the
> long run.

It is not a black or white issue. Conditional compilation also breaks
if someone misuses it, and that alone doesn't mean we stop using it.
It is a tradeoff at the end of the day.

Nevertheless, also note that the C side also relies on optimizations.

> Is there proc macro magic we can come up with? Or rustc or clippy
> changes? So that this is becomes a better foundation upon which to
> build?

Converting more code to macros has their own set of tradeoffs, but it
depends on what you mean. Do you have something in mind?

And yes, I have had it in our usual lists for a long time and we
mentioned it to upstream Rust and so on. We are well aware that
`build_assert!` isn't ideal, and in many cases it is best to avoid it
when there is a better approach.

Now, if a company has the means to improve the situation, e.g. by
sponsoring someone upstream to work on features like this, then by all
means, please go ahead! That would be very welcome, and we have some
contacts that could be interested in working on things like that, so
please feel free to ping.

Cheers,
Miguel

