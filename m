Return-Path: <linux-pm+bounces-25538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF9A8B726
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F713BC654
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12423BCE5;
	Wed, 16 Apr 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSChzAS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AC238D42;
	Wed, 16 Apr 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800464; cv=none; b=Zq4CWxr3e3nSG4m3j3RDf5eFFd8sVaZkpeh3Ew7KYtZPsiYkZF24Vnd4d9Usxmpk4xLRKV+A/jB2CE7DKpSDn7qruQpSuDBYEYbeKjS4Nk/npzoQoiIIBguMSD/69isCiwJBvqkGrrZUow4V3Lo/47c29TrDRXWHFeNaiGErNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800464; c=relaxed/simple;
	bh=AKAtxKxHEbNndxthyMFOt5Doy9+4gnYnfNZL6gRkCQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XArwclMkfEI++nejfV1SRujZzTEd3WWxBxabTTF9YRpoIicaPH5e1gxwE6CHiMJTcB0a3Bgh/w8z7EA0UDVUplQ8Yiq0gAo7q3GYCE2Ug07KGIAgUCxrAukF5hBRHzEbJPkWlME6SlmJN9qHmgZpi7aMtbNzIQFzW+Xnu1iZGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSChzAS9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1158672a91.2;
        Wed, 16 Apr 2025 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744800462; x=1745405262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKAtxKxHEbNndxthyMFOt5Doy9+4gnYnfNZL6gRkCQ8=;
        b=jSChzAS9JAiOe0iXGSwZk2+2gD8sc48d57x6IkHGfLBQ7lba+/vVd63aOvro/UfmjM
         IJ9yHdZ9+AaQkdTwUExQOVHDClxkKbINoJn/KU9809/VHl1pqwdfn35wQ0rA/MRTI20G
         shsUi2GS7Qofs1Tlk2T3f86ri9ZB3eAmg+YYQeJ6Qpw3yvIVsZMzkV7ZctWxzQuUZP6J
         fTItvfI2oHuLNFzXvXy+vyWECtz6LEMN3p0d0A7Jr39dkESv1QxWvayevswjbimtt/s7
         yYWv6RIFVW2+oqZ3B75Dj46R8gTiAff2X0d0rI39JzxcyS/iKlqzzQZAFpiVYJFD71ZO
         VB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800462; x=1745405262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKAtxKxHEbNndxthyMFOt5Doy9+4gnYnfNZL6gRkCQ8=;
        b=cmzLI9yxXyPuItQjJAmADLoZ/nJm1gN2Yff8enHPeTSvMcTlQ2+MjrTE7NTAqUTSjS
         x3pI0tPqcS7zS20L7B1QZRC5xHgyW5vXCybqj6aVN9xsNm//MlpC0sOvHKV8Xd0lTGh8
         gMYx9GJfArSjZQUQ3fHFgCSJ6ZF0GgQmeBTVSQ7x6KX5CivmFj4ppPnbzEmj9g5gPg7n
         hTNFAZmn4OZCYzmCz71YWuh3lZHKx5JSL6DEDCXDZ2oMJ4Um0xkFafpz/uCkHazbZ0jH
         pcLPlBka+FbT7HPRCOE/MU6hOx7hPNogmgsjlbfdyIzOI2EfKonB+byV96FGG2RSwfe4
         YYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP8UBDwVVkt+AUrmP4D6Zr8ZQSJDObqFn07xDCNjtI5ZVnQCLDr8NQ6+PFbGTOZbosjmAkIMAGHSvTIDQ2@vger.kernel.org, AJvYcCVPVViGNr5pvIFMtHTWsY6XkDnQD5ZsJ5FjVFhgeb1fxrU5gjQp6/TNKES4+99vCNmsbxC1bCMVmsQ=@vger.kernel.org, AJvYcCWG1kpfuUH4zvO55Qd88zcI4rMZYA2OFfkuppJWQHgM+iyX0OP/zoa59eyRBIthYwKFpdG4D7hLZb0=@vger.kernel.org, AJvYcCWkmR6Wj4dNvjTVs8eRftLohptBwVEn87pF4hBvsvJjJX2uYe1HQ5XU4w7eh7t39GMqrlLCGsQy4DPm0dxGuxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TOzfuPbiwwZi//qj2JlMjgtiCvx563QZdtZvXVWC6OB2y+XH
	dCpoHETzWvLncl3tG2Mff9wy6t2twyci4hd1tmtoSlsSW35nj+GoigM3qhQFUZP3jBzRGcD9aio
	vqQfQ7GxNJlzxu2wh129GAOP2ghU=
X-Gm-Gg: ASbGnctlzsJgQoKouMiIjWFnEkOH6z+c5ZgKxP7J1nnXAi0ICmIQiQhwcBHCMOd75Mr
	tXHQAXp2XYjT/cYc1hzArRqb6tA3W2BHMmTCRnmrp01zhhoc8Kea9uZyddpuPcgp0Ru9fDfy5Bz
	7U16vF8govYHjvGLqdOAMxzQ==
X-Google-Smtp-Source: AGHT+IF+dncUXWnx0EzdqNLpUw8XtGCzn6I013BV2E8CUIDxHGdzKISwy1kjLUwzdJ1fqs4XDuN9MvkGSDRxFxsHv/Q=
X-Received: by 2002:a17:90b:4a02:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30863d25d60mr750410a91.1.1744800461399; Wed, 16 Apr 2025
 03:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744783509.git.viresh.kumar@linaro.org> <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
 <Z_9v24SghlIhT62r@pollux> <20250416095943.f3jxy55bamekscst@vireshk-i7>
 <CANiq72=MQmUop5UzeeN-r7gAE0ep8Z+EUaLuA6exeazhZCHqLw@mail.gmail.com> <20250416104016.mkzyitdm4moz4qts@vireshk-i7>
In-Reply-To: <20250416104016.mkzyitdm4moz4qts@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Apr 2025 12:47:29 +0200
X-Gm-Features: ATxdqUHKfBTXzLSDrW2xujcnncTYdm2oAZvbxQ6Loe_steYjGW0fEulLUDrmdeA
Message-ID: <CANiq72n_C7exSOMe5yf-7jKKnhSCv+a9QcD=OE2B_Q2UFBL3Xg@mail.gmail.com>
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with cpufreq support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:40=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hmm, I did not use /// as the comments were added to private
> definitions.
>
> Sorry for the dumb question, but why should we use /// in such cases ?
> They will never show up in documentation anyway, right ?

It is not a dumb question at all!

The reason is that using `///` is not just for `rustdoc`, but intended
to convey it is documentation for the item, rather than a comment that
talks about implementation details or things like TODOs.

So you may have both `///` or `//` even for private items, and it is a
meaningful difference for the reader. Plus it makes it consistent with
the public ones.

Moreover, if we ever move to documenting private items, then we will
want these to be correct -- `rustdoc` supports generating docs with
private items (e.g. it puts a cute lock emoji on private items in the
lists etc.). I think some kernel developers would appreciate it -- we
could offer both versions in rust.docs.kernel.org with a toggle, for
instance.

Cheers,
Miguel

