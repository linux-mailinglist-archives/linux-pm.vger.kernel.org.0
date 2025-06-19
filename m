Return-Path: <linux-pm+bounces-29055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27AADFEBC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818A41898F9C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C902376E0;
	Thu, 19 Jun 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7CnDMOz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E591624FE;
	Thu, 19 Jun 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318341; cv=none; b=gGO+Pi+rMwiES1ClRPAVRr3fXQQ5SqrvjIVkVOrqZW5HR5gbdYPvnbeE2dACj2pL7diV10J9h6V0UZU+2i06ymfuhER+YHsYcfAFo820uQpXUHdqTKURl6xBsgH0IsXkjw7kT5kV3GI2/yuNc3iSrY7L3KDtME6kLO1ffeAs+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318341; c=relaxed/simple;
	bh=TvAQgk4aBUxBjS5hE6KPaEHvXSZd9cEcLLnRmixSYPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsBHbVdaFSA7HrUn4ZoMQGfXhvC4e37rggQhpFsVPTQb3mXN5Ma24oXJuoDP8X2kWmjJBQYmRsUacJ3ogBavji9U1rgrLF8iCB5P6G1lpgSoPwtMeWS/OrG2DzraUn8q8AVbJf2I3emDwsegkgf9goRkXRjDQex5PKYhYQn+7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7CnDMOz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313290ea247so91323a91.3;
        Thu, 19 Jun 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750318339; x=1750923139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsLzT9QmvCMN7j+9yVbwOwRf832rY8j8xMjKnCP+ElA=;
        b=m7CnDMOzecil4uF6EmU6Q6Cf8Om/VP71awob1lqo1iTBPOr1uli6/K8jtquDpcBuuD
         ngm5bnDVXLwbuJCEZQoXLvnkTNe+yxZN/FxesT0TG7ffIYVykoQlTJ6Cru1sT+P3tGlS
         vzaEaG7CXAHe0BW7JozcS9v2IJJDQqjxbeV/LwELlrh/j3gLJpsXbNTCLZnsimxfi/JL
         RT8I5q7jGzccez51zCeEh1AhLZU3j6ea3i5KHZo9Mv6eG8FHptMbJy5G7b/ccn2mWY5K
         iL3teD/RhKAcTGaaDvlKH2OPj0GvO085wjatToUQTailPHtUTTEt7mUmVEAXGOmCZ8hT
         XCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750318339; x=1750923139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsLzT9QmvCMN7j+9yVbwOwRf832rY8j8xMjKnCP+ElA=;
        b=uzi8tFz0Giz7c0dCSUhkV5t/BVYxPlaZIdj9gvwjDzPMFiWq2fYIb898S+hZVJ9rc1
         mp7zB9lI+ZjjpHYYQnFcVn16KYRPOXQSrC8LomaGdXqH2hNIi3YdXtt36yGBH5hfWKf3
         KtIU4LsJSuJ1QNOQLMqYDC6OvIFTcXifcGAj66OhbdherKohuy3YvMZlrS7FvZzzJmpz
         Tx5h235SCuczxy1qsEEJLuXVubgrQRkedyLJq7rJzGmN3SRVIa+whWfWSUL6sQMX30sK
         M5CSHowsTlynRO7yNCdxsSXGuXgT8cnPOkKITah7PvBXGCo5pK0qWV5mCK1nczAJWxQl
         Crpw==
X-Forwarded-Encrypted: i=1; AJvYcCUDACS2O0UymU7WmecV7RAnpUIkou7qWzHB1QTgPR9M+MrNmSrKZynfmZKKOZ/+uZXS54n8gW0V/Hk=@vger.kernel.org, AJvYcCXVeM/K+d6eNw4cN3j16sxpTPpxe58zS5jQShQhbN/pzXBljrr3MQYgUD1w4yiTIAx8NLkAzM2JYmwOsjT+1j0=@vger.kernel.org, AJvYcCXkB8ni3cHZ/H5Go82zeI8JRDv3HuBnFl0B9H0Ur9ZgRPNN+iMg7/lskcTKolmmeHYPvzSbawD0e0P/xBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRvpBXxOLoZLR1Cr+0xZIAc0lITHDZJezztVgqlwpPlJL2l3p
	71msBOxoTLlKz28KnOP5vKQKSIeaNQJWzkH9C6gMFJ9zBoVjuxwrRfJwBEMOMHks4ryFKvTXePo
	7T6C1ouy8q9TuwZJD3/88Kf0+TZhQJ1FW5AMoAgI=
X-Gm-Gg: ASbGncsZNEAmCasT3iwzRH1G6M736Ri4gFY6eGTZppsXjjAL4xizYHIngldI/DjEUGt
	GnaQIqDOLAyR8iA7newoDe8QI71R53chpXQWGvV5jnwFtRQr+QAy7vSvFPRoCY89j0BzooZPZYG
	1XRJRuCJ7NFudtVkA3rWIIyppNu8CJ2moWzz01FN3GwQTpmMfHIbBVEg==
X-Google-Smtp-Source: AGHT+IGYc1kFLHc13LSr9sTw75f7dYYCV2w7aJLJ+zTMy3pNH7Z+g+cv0wn2Fno90pkGHyXQa9nQnlPwCBNm8rFAU0E=
X-Received: by 2002:a17:90b:2b48:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-3158bfbd6f0mr1518019a91.4.1750318339096; Thu, 19 Jun 2025
 00:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613101815.18092-1-abhinav.ogl@gmail.com> <20250619065713.hm5ye2uhikaei2xo@vireshk-i7>
In-Reply-To: <20250619065713.hm5ye2uhikaei2xo@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jun 2025 09:32:05 +0200
X-Gm-Features: Ac12FXxtX3FmmCUDQ1aYO_4RkcRm8PpniSAq_qct3zSY4-xU6fk1kCCgSJ7D8oU
Message-ID: <CANiq72muPYoPGLrb7jYWMqbWgknMuWJSPMdFPRQMFduFsDTs0Q@mail.gmail.com>
Subject: Re: [PATCH v3] rust: cpufreq: Ensure C ABI compatibility in all unsafe
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Abhinav Ananthu <abhinav.ogl@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 8:57=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> I think the one in prelude points to core::ffi::* instead, while we
> want to use kernel::ffi::* ?
>
> Miguel ?

The one in the `kernel` prelude points to the kernel ones (the core
ones should not be used anymore).

> Also why does prelude use ::ffi::* instead of kernel::ffi::* ? I was alwa=
ys a
> bit confused about it.

It is because we define them in a crate called `ffi`, not in the
`kernel` one; and we also re-export it in `kernel`.

In any case, from now on, one should just refer to them directly as
`c_*` (please use the `kernel` prelude for that) -- please see:

    https://docs.kernel.org/rust/coding-guidelines.html#c-ffi-types

I hope that helps!

Cheers,
Miguel

