Return-Path: <linux-pm+bounces-21908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E1A317EA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2604D3A6798
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB512676CE;
	Tue, 11 Feb 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGN5w9gJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11D263F57;
	Tue, 11 Feb 2025 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309860; cv=none; b=HNfMvWccp7j9N0a72SVHTE8gMIku5dS56QJKSszp1exrL4Ne1IX93AsGg87Gz0CK19r8rrho2t+E8tLnd5V6mSuAaL5RlHdcDxAYyHcCgWEcYsgmdxn3ylvoqcPm9CJ9iuh2vqZ8PKMAUHBwEgMaCCjwe99b5rwONexTFcdFeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309860; c=relaxed/simple;
	bh=XKbAUeYtUw75h5ZAra0XFiv2T2PGq52hQCmLhO8mPb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoMmwHUAPbrjSVTXYlCNTpK7y74UAq8r7m/ZLQTjAhvXBE8SEPGlJvDr6RNMhRHv5YnxcPFFeneJmApRabVbrSFt0PTpt8px+CMqsLW7xAa3m6mNB2rvbaBa51Ev4Ut2iJidQSe6iTHiuA+UOMbI+wc+2DfKrwkOhhkZ5EFv1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGN5w9gJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa1c3ac70cso1334712a91.0;
        Tue, 11 Feb 2025 13:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739309858; x=1739914658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akzFHrt13Sf+zIMfS9Ii+SJ+PVxb1KqnXMwjp26RJ/w=;
        b=KGN5w9gJ31IcwtQzfHOx030GPXZeZFoVMpzZT8BxjJ4sGNaFaTksTSEve0fa3DGHKg
         bjgqwyxp0TsPOS+6+woLzQI7p99mJZFYXfLHtMs/U671izQgRvva6X+8dNxmc4nzc5ho
         Qtm/g6xQh4hy3PAZ6NwZjI4uRtTOX/dVV2/stG0jWjYKoolYNVbZh2sxfupwOVzRwSad
         kGxHeYDl0H4hckmsHLIWgz/kv6PJFtfhmE+UfIFC6MYiC+ltgwkbHAHOEERmO/dnJDHU
         8vXNUGQLkFnvmHFkN+1L/oP7tpccR3t+u8J00W20mb171Tpgu8lOZWqTo1GqzGpbQ1/v
         539w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309858; x=1739914658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akzFHrt13Sf+zIMfS9Ii+SJ+PVxb1KqnXMwjp26RJ/w=;
        b=vvYPMUDlDVyITis3v22ap86OUu4HfRetc4utT8iWyV1Ub/qsI3KEhQz1qswl1vf96Y
         1BGe1uy4bN1LRyTxplkQjIQXuCHzd4cnbVWZeS/h1lTA0Ko/Dxvl4s5qtC468jR9f6FT
         gAMvul21ah1dwepRmQKHh2Gl7+FmamyamdC04ZfiFxg6YxPW4wrxp6ZsjOVy1NFSbNu4
         /QpLbXJNjJnaDyl9p0oFsCVrsx+SyrP7LEy5VxEcvpsXbzkLq6ddydO1RiLyBW5x/tsi
         Ne3q/H2QSJv6OcGuIU1virak4/FWWXGYHWDlmizFL/DgfpmkrEXRYoqByOnRvhyyw+Ht
         5VAA==
X-Forwarded-Encrypted: i=1; AJvYcCVr3/uQe8WVfyzRGxt8FE7kK1KDhPB/edM67iluA8TLOKMxT9+dmCaufypE5B1Ep4PSmLeXg/AxLIJHW4Q=@vger.kernel.org, AJvYcCWRVQdeR1o71FmLixNioz08j8lw9hn6sQ/yDXfWiype6ls/VdJWOMEdrq8WPZi1Nv9CfIwdeti5vL8=@vger.kernel.org, AJvYcCXHQd1lrbumu6ZmjtK2Lr1kNEJnlLPFJylaC7PY7DQ08mm5TQ36DPUTNFtq2+JXatNb00PqFWP74/1dKduJRIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqTbp0vYlXyKrobY6WT/CygDASaryoTOIkh3vjYB9ftHemBpM
	2IIEcZSofHWqQU6lsYT4VRToCLbA3P1fcXKMhoev0eLcsqva14VMnjOJRMd9GeD33D/DNSCAeoQ
	GNa/K/IpwCUAYcZSm1mUVG8ewncY=
X-Gm-Gg: ASbGncuxI+ZqZP3J9jCwsR0ektC/u3m4Li7keZklcEjV0irtvPUw0GFMCh77IuVj0FX
	5Y890sWFNdqZ1w+t2S1qAYGZnY8KH4KjmZQ24yw+0xoL/lWNjJXvPrSrXqmyyR9bkNJ70k1s+
X-Google-Smtp-Source: AGHT+IGaXS1EDa6yC/VYlIlgcCMZhbiBlWn7y6h9gigI5MM1OjNIt2C44T9+/GZ4SCA6mmKeQDKqx9OcBnX/akiH2jE=
X-Received: by 2002:a17:90b:3845:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2fbf5bb8de3mr405275a91.1.1739309858447; Tue, 11 Feb 2025
 13:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7> <Z6t51xodSV21ER4M@thinkpad>
In-Reply-To: <Z6t51xodSV21ER4M@thinkpad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Feb 2025 22:37:26 +0100
X-Gm-Features: AWEUYZngWJ1M-awjFN_5Da2lJECVQzCBMpv2S6V7HN11_MwJfmvJvmjOQij9-yk
Message-ID: <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:24=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> No, not Okay.
>
> To begin with, this is the 8th version of the same patch, but you
> only now bothered to CC someone who is listed in MAINTAINERS. This is
> not how the community works.

Yeah, that is not good.

For what it is worth, we try to make this very clear:

    https://rust-for-linux.com/contributing#submitting-new-abstractions-and=
-modules

i.e. that maintainers need to be Cc'd and contacted as soon as
possible (possibly even before writing the code).

> You also made it a patch bomb that touches multiple critical and very
> sensitive subsystems. You link them to an experimental and unstable
> project, and do it in a way that makes it really easy to slip through
> maintainers' attention.

Not sure what you mean by "unstable project", but I agree that the
patch series, unless Viresh is the maintainer of the C side of
everything added, it should be discussed and maintenance discussed
accordingly before merging anything.

This is what we have done for everything else, and that has not changed.

I try to spot cases where this is not done, which is why I Cc'd you in
v7 and told Viresh to please do so, and he did -- I don't think he was
trying to bypass on purpose:

    https://lore.kernel.org/rust-for-linux/CANiq72=3Do+uc3ZnNrdkuoSGSL8apNE=
4z4QwpvsiLfGzXFywSLrQ@mail.gmail.com/

> That would make things even worse. Before you wanted me to maintain
> rust linkage. Now you want me to get approval from someone else who
> maintains rust linkage. In case I need to change something, I want to
> be able to just change.

Like Danilo mentions, there are several ways to go forward here. For
some ideas/context, please see:

    https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in=
-a-subsystem

(Thanks Jason for linking the page)

And, yeah, whoever ends up maintaining this, then they should of
course be testing it properly with Rust enabled with a proper config
for that and so on, just like one would do for anything else. By the
way, it is possible to request Intel's 0day to build with Rust
enabled.

(Side-note: to clarify, there are different parties involved here --
"Rust team" is fairly ambiguous.)

Cheers,
Miguel

