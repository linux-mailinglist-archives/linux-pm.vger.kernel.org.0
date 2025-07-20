Return-Path: <linux-pm+bounces-31133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8EB0B909
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251403B7769
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3C1EE019;
	Sun, 20 Jul 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEEbA7qZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008C74C08;
	Sun, 20 Jul 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052680; cv=none; b=p611KJjarUNSqDq/OiY2ua67t4pmcdHGW25ovdP6Jxix0yoWnNfmdSK1g5j8J514wPLQzZCpYx0L5PzTVqcONbHmNDpDHXgImDPNBCzXKwTD391pWTlJZq94o7fKS7c4bfnUUWhYwG5eaBfg0ejP+RO7LjE81j4PAnzX7Iwt7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052680; c=relaxed/simple;
	bh=DqzhcMKuF4YJhM8qX6ANTGfJdeWxmY6ujyFF/XUbNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYJU13gp1B2EHpPxLqbffgGnIzbLK8drteStKKrvIBRk06LBjKNtjeSSQkA8spxo1F8Y0hzyJqZLDKbm5WvHeKV+Wv1FCwivsPY9Kjfo8qKMm7iUU0bg2i9/WRIX3LbHOm5zUXHI+yAxELfEAmfvwsvhush+w31gutdqD7j48k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEEbA7qZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so28172281fa.0;
        Sun, 20 Jul 2025 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753052675; x=1753657475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xkw3NwxWxg5J2ji88ScO8XA3YV0z1vRakGJn9oB0XE=;
        b=fEEbA7qZeaPKmbSGc0LpfkgCNPpcE1/aFE4WJCoVqvmDM15Ww2TFq+jr3yJtGV9EGJ
         5zM9u58hJobhjXsajqOarwNyfhhS1Frux9teDdv4ysDGX3MZhiKc+TTyOpbkp9sqYhCE
         oRW7piJaJM80B3Eo5pCbJD6USc0mdZjpNnPrE6Dn28x2qKcPNvdctVhAU8VuzCYkRg3e
         m2g+s8uRJoq3EoPozbMMVQU2cQv3CQcu8owZH9TuxUo9/Wdpq33Pb6+t8N2b9wlhHC5X
         iev6YvHXabzE8q8IZGo8yymG08he/MKxsIMzK3+xiFRUHO0Uwp3EjoFURGKFedrqFPiP
         GoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753052675; x=1753657475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xkw3NwxWxg5J2ji88ScO8XA3YV0z1vRakGJn9oB0XE=;
        b=imTAg288hzkPG3KQYl1vuOXH2NoGPZuevBKbbBya4LE5tLRX5pku93SjuHPBXF5ewG
         Ucb31tSR4Tc4R4wMm4zO6aaovl3o+hV0tSUf47OEDhQm0/KLiUhYXshz1lUdEsRUY0uD
         SbNGi8bxsut4CB0MjneEvgllIHQDWuLQoFpMGG8a1Khu18JeK7Ld23hEAe6pax4gRuxs
         z80KWlrgPP5moNQUXsS/UprTH/CSzQAn6ZL1aRx/OXkT+Uxq06obQwJuE9AXe1pID/Ng
         xrdG1c0gzq6xWgsd9YFGZ3TvxH3UXvZSkb0j+w+gk9v3Ghss5p+Gw2KI+O1qs8tBfnil
         yi9w==
X-Forwarded-Encrypted: i=1; AJvYcCUxt5Uip54nFm5RW4ghnUHoajYKL6h+RDFtmIELdPd+H10SaraTpWHOBJbhVtDojtL6O+dVvXK3gh7CLzY=@vger.kernel.org, AJvYcCXKId7rhchD3iQOWNLk5MLYTVpeZSj9/um7fR4GXpWbW0FIjlKGGCosZKDTqn0NAPtEd71FJk2HuR5QJzxhfUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC735Uv96s7pK10PFzWzFtCf+zuOHx9/NAWF0X0Cw26crWcgFq
	8gClesC+7IGHGI9lIzTkQfVGqbNnkepcpfcBXfX2qVJKw2gPg5KH4wWozTSQaA0D5nEDeWSnI65
	6z3jDX4yg0LHVn43cMfPUWwNJFuNPDeY=
X-Gm-Gg: ASbGncuViHeh4MkXXx66vWzUlIDT5SA32leQ8rRfLXZhzcZ5EPRo2nGTcqaa0tc/p0Z
	XXovd11zym8vEMsj9mTRSvG+3Dmu4K9KdKOVSUOcPfUSzE9I1CoMU788W/VLxYMf8gjZ4OBRR+I
	TtMbKPnlT0ypasc2EijKsoBX+BOrm0WCStO1+CXIP78h1SO8cOnCtDNzPxJDTGBqHSTggeRnrya
	5fHW1FqKSTcjnu/lY1GhXo+2Q3ollpbbNQmxH7RWw==
X-Google-Smtp-Source: AGHT+IHU8gAlgJi0gfSerHmpP+XVcJCFlizdHXk2oE9KNpuvqKE3vWLus6ifQ6OwXOlfO0aS5Oo9wOl6ZRFYMwgCbm0=
X-Received: by 2002:a05:651c:41d5:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-3308f5b6b0emr51195791fa.20.1753052674651; Sun, 20 Jul 2025
 16:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com> <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 19:03:58 -0400
X-Gm-Features: Ac12FXyBZv6-1-SR-r4N9df7hS6FD2nQrghFQr18iPYH2j0BNLVFQznx1RbMWtg
Message-ID: <CAJ-ks9nBrT4C5xYk4eWUFX_nX5XXBYHEGo+fLtLWJE-D9Y5hKQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 4:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Rather than export a macro that delegates to `core::format_args`, simply
> re-export `core::format_args` as `fmt` from the prelude. This exposes
> clippy warnings which were previously obscured by this macro, such as:
>
>     warning: variables can be used directly in the `format!` string
>       --> ../drivers/cpufreq/rcpufreq_dt.rs:21:43
>        |
>     21 |     let prop_name =3D CString::try_from_fmt(fmt!("{}-supply", na=
me)).ok()?;
>        |                                           ^^^^^^^^^^^^^^^^^^^^^^=
^
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#uninlined_format_args
>        =3D note: `-W clippy::uninlined-format-args` implied by `-W clippy=
::all`
>        =3D help: to override `-W clippy::all` add `#[allow(clippy::uninli=
ned_format_args)]`
>     help: change this to
>        |
>     21 -     let prop_name =3D CString::try_from_fmt(fmt!("{}-supply", na=
me)).ok()?;
>     21 +     let prop_name =3D CString::try_from_fmt(fmt!("{name}-supply"=
)).ok()?;
>        |
>
> Thus fix them in the same commit. This could possibly be fixed in two
> stages, but the diff is small enough (outside of kernel/str.rs) that I
> hope it can taken in a single commit.

Just noticed a tiny typo here: it should say "can *be* taken".

Miguel, if you can fix that on apply, please do - but if not, no worries.

