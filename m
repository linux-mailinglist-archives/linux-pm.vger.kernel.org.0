Return-Path: <linux-pm+bounces-31618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC0B161A8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D74546D83
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C32D6406;
	Wed, 30 Jul 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFZmi5Gq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782A2D46A9
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882774; cv=none; b=ruy+FfX5QZ9g2hDC4UN5g6nIeXR6UR8vU3f/GoEIQ5c0fPZHhscjSLMkvHi2B1lralKfeomvwKDFFji2BhwmdgTODGoD2u+ML+XuLtYx+n9rqXyE5u3MFYPvqN64EKJH2uoN8a2qGRUXpmiX8c7fyh3xcslagnWGuGbY7MKwLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882774; c=relaxed/simple;
	bh=8msNZxV4vzYZHV5zdjpoumhb4VdGCiYWL1hPZvJX9ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnREWXyh6T7z+9bAAjWGxUQCILHzNElSzdG2DdsEVVajvh8Ja+LAs9pdAM7RJN8+CCrN7Wc18WsDNTv+ocB9SYvjIrRxS+s3wp58+ogjDTUbzm3NRX3F8gs1X4zGNha01/99N3kSjwqg4eL8bkyx+yFDPVZ6L63/dq3V618CplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFZmi5Gq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b785a69454so2418139f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753882771; x=1754487571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItEELH3cRLVD+iAArrenHRjEW7ZVw4L4zIbc9jOQ2nI=;
        b=pFZmi5GqnR6GCsyM7o5Av0AxoSdCeD7pPeOmwSCVKPQplZBdXensaOdktyKZ1qdsa+
         9AFPFuxDmgPN4meywZDgABDdxhK9uP6cugI6sFD+cELkcoRoJW4m1JJE8ziFdQHYfBJP
         jwHbG1n5xbsTb++splsKifgnu1aBlavrAjoWI9QDlP49P7W1rYSDvHOjrBR78Ilsecap
         mfzAVOoGiX9L/a3iYTBA6gnYPJfXzSoW3lEgMa/410Pz6XhKhNw+YiXC+uImFs1ZdAZ3
         xeKgfuJhiAxowTu4nyIv9YBIuUrf+yB+ATSXWfcJjmQ76lUZf+N2MrOmKK+aHICjluyu
         xR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882771; x=1754487571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItEELH3cRLVD+iAArrenHRjEW7ZVw4L4zIbc9jOQ2nI=;
        b=jOr36eQbTk2MNJVQBkjihf/FPD/XxCAnnDboK9g6PfSO3u5ZA71BOhI8UkZMRYfdEv
         dxRzxoGTX69Q+nYe2by/8ugYzQxLisBzkGq4OxmQhxMH5alZ+ji0H+JIcWYSGgyhBVdZ
         h4QW/X6R8Vcurvhp4ItPbL/V7KkGdd8WyXsm1w74UAz4aDOCYctu+FjGLEKVPtRtr56S
         Y4d6z1gOw3zdkP1qDu1YNaOzg55MJY3aSEyelFqJXpZrRBiE4n+j/1/ZoXyDLcLgUS8P
         H534zBSe5tDh45rEq0Y3ZmcTwLk33u8H32ZcMzA08ZzvqoCdyl8T/NJHsWSJZseh/ON1
         Howg==
X-Forwarded-Encrypted: i=1; AJvYcCVLjh7nWv3tIh346c32ZidV22Nvi+/dhG/u38Gu2MwiKoZbF5GnScgPvLRuRYYfAC4/eQBDFEx02w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4MIK1DZEej66dsrMp7NyLra9FeeS2tc3Z7U1l+mYE3n6H4bj
	R0gXyJV+U1qLt7fJFbQuKylj5zuYPlBReS2Ui7gEeJFZI9SjLA47IIHSnn3QVmC1Mz0y6iDbq71
	n4TgeDzP6GdXXGrYSt2ai/s4J3+h48SCBKJ9ZvwQE
X-Gm-Gg: ASbGnct+4ytlNJ63QOw0SNTMOQSP8nodpUS8yIwyiaEbRayglfQ87reguLKws5pY53j
	YDMf/mWWTsvDWp+qrpyyCr1k8J2+Rqe/VmsUK9A3jU/ewjZKrGAxUQQhJJcL012UDvtET5cAKD0
	FnNH2IpHe8+En94fMllzF9WJv4hlG8FGnh6cjvYzax6tKedqmHedJoqSUFwRAG391iqwHLBzz5C
	c7b9fEJ
X-Google-Smtp-Source: AGHT+IEyr2t9aHif2RFUX92J/+mKbiL5ER5m1V7hwBgTcdhRVH7lV6emYSvc7TOE1oUP0faIrNPGeGeGOw3MAShGOAw=
X-Received: by 2002:a05:6000:288c:b0:3a4:eae1:a79f with SMTP id
 ffacd0b85a97d-3b794ffd043mr2795662f8f.33.1753882770587; Wed, 30 Jul 2025
 06:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev> <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
 <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com> <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
In-Reply-To: <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Jul 2025 15:39:18 +0200
X-Gm-Features: Ac12FXzumko90MY33tXnHyIvT1ML5t_t7BouF-ETji09Sr887Pkg4SW4INEXrAY
Message-ID: <CAH5fLgjBQF+AGWQ-rKowViiL1kK47FZ80QfEa58Cx9bk11cjAw@mail.gmail.com>
Subject: Re: [PATCH] rust: clk: use the type-state pattern
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:27=E2=80=AFPM Daniel Sedlak <daniel@sedlak.dev> w=
rote:
>
>
> On 7/30/25 2:59 PM, Daniel Almeida wrote:
> > [=E2=80=A6]
> >
> >> We essentially would like to have a `#[sealed]` attribute that we can
> >> put on a trait to avoid the `mod private { pub trait Sealed }` dance.
> >> (so a trait that cannot be implemented outside of the module declaring
> >> it)
> >>
> >> ---
> >> Cheers,
> >> Benno
> >
> > This is not exactly what you said, but how about a declarative macro? e=
.g.:
> >
> > macro_rules! sealed {
> >      ($($ty:ident),* $(,)?) =3D> {
> >          mod private {
> >              pub trait Sealed {}
> >              $(impl Sealed for super::$ty {})*
> >          }
> >          use private::Sealed;
> >      };
> > }
> >
> > sealed!(Unprepared, Prepared, Enabled)
> >
> > Note that I am just brainstorming the general idea here, I did not test=
 it yet.
>
> I think that API-wise it would be better to have a proc-macro #[sealed],
> something similar to [1], as it may provide better error messages, when
> used incorrectly. So the outcome could look like.
>
>         #[sealed]
>         pub trait ClkState {
>         =E2=80=A6
>         }
>
> And then
>
>         #[sealed]
>         impl ClkState for XXX {
>         =E2=80=A6
>         }
>
> If you are interested, I can try to look into that.
>
> Link: https://crates.io/crates/sealed [1]

It seems a bit much to have macros for everything.

