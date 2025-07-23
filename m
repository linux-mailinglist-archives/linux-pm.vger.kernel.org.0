Return-Path: <linux-pm+bounces-31321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D17B0F022
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CC5962723
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD92BDC15;
	Wed, 23 Jul 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL12AZzw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1129E11B;
	Wed, 23 Jul 2025 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267362; cv=none; b=nwXuQZ05G2zt13VcWlB84OMeRGexnUqwDBUn7ASw/etcBdWFx1dwGbTUJTrK7qmk8wmRMoOqOCo7F0yNGz6XwXuoTkhpSthCE613Pb66cu2fM2E4Y7/1dJZcDhs9dQ6upqq/P0kPNthf9wDGW/pLJF5NN+PKuwvMIu2Js8C/1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267362; c=relaxed/simple;
	bh=+9tuVR4nouAHVpeWB2PYkNO5oDVhEoD8b4T8d6O2Ajo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSGLotjrlEtqGwwjsO4ZzZHtb0Vibg6IDpLaMr+dKpYRKz1QsC7hgauq8UJoLVf1JKiEXGBQJ1CR4BJPca1Q06vKttpzToxqCFTM8i51c6iliRt89oId3PSh01A1xpGypBh2Jg4EOvEduZiGOn/V6X2d3YBNz0BD+HPoNUs/cZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL12AZzw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313290ea247so1139092a91.3;
        Wed, 23 Jul 2025 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753267360; x=1753872160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAuuZmOFH+W/jVW863c0NGno6eBeeHPuYTr+Gg9Lqgo=;
        b=WL12AZzwc7H4eyILbYcgrlyNEo1+bwEd29OfXVJN35jH86QkJD6/txWqAJ03blAE07
         rKM/cTVXUz+b1qUr409CD7by/2owsNVzpMdZcvhVqYL0/99n0Xlu/7d5TpkFv9qQPdJ5
         J4hKCSGdhoE26oD7T8iZ7wo4RMqj2lIhVhVTEKI2B2cb6lKweR3fLuhbMR4nrUmHzzaT
         t38oyvISfq892ydNQJrmt6C0qnEQgypnYCCf5UzgtFht/8F8ALPg+vOzIDCAgkPFShYS
         edb9Nn4/KKgoW9ZUfOEsOOx3OHRwMTV7Jbhgl+I2KRSATFy/L2XVeoQrS3uDDxSTLsWo
         Ku3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267360; x=1753872160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAuuZmOFH+W/jVW863c0NGno6eBeeHPuYTr+Gg9Lqgo=;
        b=KfZwpvBtDqQrvxrI2+1pHOA2WCnr6lxnZT6HHIwEs/PEqm8M4CWeMSlpRwC+bqgDJo
         sE59Yv0tkmogmRcyd5mgCWBVOqo2VNK0baGTfai9R0FKOMvKd8G6Gu3VJNWnaHqXIb6d
         K3u0YptTzY9Q1E84BkBI3EeJV7XG70S5CvoaCN/VLhT+jthsaEYbMj0/ujOKsS6688OC
         fzRUzqob+43qkpYG/HIEK0wTLHNLviTpelj0UlIptYkjBe5ID8aLzZ+GBuu9qX1zTmiz
         YU9K4ldjrSCs1Azq6J4iLQkHahsOgRaiThX3jQ3WlnVIvo4qgNAftNys/sWkpyeGiu53
         lGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP/3QiThlnitLVgCKk3gls2LLFZDUzdn2gXOnQXmAoRPBTdqsHNuh2SinsoeTHrfqzn5pDum6rx6ONkzFAGrs=@vger.kernel.org, AJvYcCWcLfqdz2lxq3OKfQxnSrwBUaQ/o8kzLwWi8+liRPJEISeQ/OPV3IQZ7dJQJnixvd4Q4OwYjoaccj8=@vger.kernel.org, AJvYcCXH8KRzIG/XsTDJtdESdqPqiDpEKrVN45bVk0XtyfryAWFxp3WQBIOE/YHU3iwu5NHrQxclFLz62qy0wT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydWDWJd6sxtyv7Bv9i8gETeoKxjM/2trO0Rf1MtBPS3c7n9Tiu
	jACs6X1AhPO/bQZzYJ15rp4BTu+bmbVLWw6J/Ux8puRgNvvuaM/xIkTXy+OeNvYI2fdAe6SELdw
	O2mTbno/IhtRjA1/C4FmCXXBCljBH6jI=
X-Gm-Gg: ASbGncvcM96aWTBUw2ECDkrFUUX2Akgc/TXQinwGUTzgF/q64MJuYeXiJLGdR2Q1xqD
	NBIkc8GugVvEkrewO8JWBZQVWaEcZWXiWa2LwVr49hR2TqOBSERPvY1zit8aPsenuWgXYA0Hsfy
	FWAikIw0V6GvULVzfeohemAmMy232KCkLaWOoi5/oaYSGb0kfm8xjqQlUrMflLP9P+kOPcxfT2s
	NaJ366M
X-Google-Smtp-Source: AGHT+IFFCZCT0ofZYjyZFGteyXAUIYA+5ZedU961XooANvsay5UfRw4uYozQNmnNUjCP0VbWtYYTh+HT21vc4V60b+w=
X-Received: by 2002:a17:90b:1b07:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-31e507e7767mr1712396a91.4.1753267359918; Wed, 23 Jul 2025
 03:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com> <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
In-Reply-To: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 12:42:27 +0200
X-Gm-Features: Ac12FXzx7YzWGMIPWojNZRDJWiRGDclI6az_LyKYTAK7y0jh4ycpj5ifeQLxQgo
Message-ID: <CANiq72nPLn+3V_DhN9_dmKnRrb5mfjzQ67Utz7HdtOY3McpweA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konrad,

Some quick mostly doc-related comments...

On Tue, Jul 22, 2025 at 11:14=E2=80=AFPM Konrad Dybcio <konradybcio@kernel.=
org> wrote:
>
> +//! Interconnect abstractions

Please follow the usual style, i.e. ending sentences with a period.

> +//! (based on clk.rs)

Is there a reason to mention this in the documentation? If not, I
would probably mention it in the commit message instead.

> +//! C headers:
> +//! [`include/linux/interconnect.h`](srctree/include/linux/interconnect.=
h)
> +//! [`include/linux/interconnect-provider.h`](srctree/include/linux/inte=
rconnect-provider.h)

Please see if this looks as expected when rendered -- you may want an
" and " or a comma or similar.

> +/// The interconnect framework bandidth unit.

Typo.

> +/// Represents a bus bandwidth request in kBps, wrapping a [`u32`] value=
.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +pub struct IccBwUnit(pub u32);

Since there are accessors below, do the internal details need to be public?

> +    /// Create a new instance from gigabytes (GB) per second
> +    pub const fn from_gigabytes_per_sec(gbps: u32) -> Self {
> +        Self(gbps * 1000 * 1000)
> +    }

I guess this means callers must call this with reasonable numbers and
otherwise it is considered a bug, right? i.e. this could overflow, and
thus panic under `CONFIG_RUST_OVERFLOW_CHECKS=3Dy`.

> +impl From<IccBwUnit> for u32 {
> +    fn from(bw: IccBwUnit) -> Self {
> +        bw.0
> +    }
> +}

Is this needed since there are more explicit accessors?

> +#[cfg(CONFIG_INTERCONNECT)]
> +mod icc_path {

Maybe a different file?

> +    /// Rust abstraction for the C [`struct icc_path`]

This intra-doc link is probably broken, since it refers to C --
normally you need an explicit link for this. Please check the docs via
`make .... rustdoc`.

> +    /// The following example demonstrates hwo to obtain and configure a=
n interconnect path for

Typo.

> +    ///     // bus_path goes out of scope and self-disables if there are=
 no other users

Please follow the usual formatting for comments, i.e. Markdown and
ending with a period.

> +            // SAFETY: It's always safe to call [`of_icc_get`]

Comments don't need intra-doc links, since they do not get rendered
(sadly -- a long-term wish of mine is having `rustdoc` link those in
the source view and thus checked too).

> +            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for `icc_enable`].

That seems like half of an intra-doc link :)

> +// SAFETY: An `IccPath` is always reference-counted and can be released =
from any thread.
> +unsafe impl Send for IccPath {}

This gives an error, right? Was it meant to be inside the other Rust module=
?

Also, please also run `make .... rustfmt`.

Finally, the examples in the docs are converted automatically into
KUnit tests (under `CONFIG_RUST_KERNEL_DOCTESTS=3Dy`) -- the examples
currently have build errors.

We have some extra notes at:

    https://rust-for-linux.com/contributing#submit-checklist-addendum

on things that are useful to test/check.

I hope that helps!

Cheers,
Miguel

