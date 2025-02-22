Return-Path: <linux-pm+bounces-22723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D0A408D1
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129CB7ADA7B
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494286325;
	Sat, 22 Feb 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBU8AN+2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493535949;
	Sat, 22 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232271; cv=none; b=GsEnd/wJER8T5VjmwZmecav5r/+/1iw9I0b03F+DlWABu6o0eYH5PhpBRT4mYTq+y7Dz6o6891KSXZaqgHl0ZfVMrjsDy/dRxGI3bqAkyYAPu2oTg8EZDxGrIOYABkBZ9aB/qtjwhNFDEqnz303kcmeY5KW6Z/yQKgrTiSijGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232271; c=relaxed/simple;
	bh=7XvebaarfPWYMLZS8DRSVmQKGFCvLowf4P4Z/yIOI4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieByRL9Jc/VB7kIpWaDvprDtGmAyGvvh8UZlxLLOY9Kbae46f4ImoDQwUkZOxRzGs5v6TrRflB68g9SYuvEjluhFXoduhcGo867CahkrtpK9YiWCCwpwMJu8NWWeYznqrMCJrxSdmAdVIIMfSrAWkS0zpbGsn/wjFCvGTPnfWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBU8AN+2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-548043a912fso344628e87.2;
        Sat, 22 Feb 2025 05:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740232267; x=1740837067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XvebaarfPWYMLZS8DRSVmQKGFCvLowf4P4Z/yIOI4A=;
        b=MBU8AN+2XkRKQ9cCFmyFfUlbI5GaEYHFtF4tkcgBAE8MXy+YR8/zsoPGXy6Bg9G5dV
         cJ37MoBpZth4O+lXgej8KZ27jDKiqzoPT/2bAYMIMSh2sGgcNKocPnoUoHHwuXchd62E
         MsRf16xMYtuSvsXeRIh61fuhySoLOBtqpr8QHWwQ012jN/b25oWQzAhBcFIOMq+mkjAs
         TaEVnonGNnatMf57xHRnQPksQ2QP1NMljdIp/nfd86Rc2X+EWi64ZJzxOUBnosZVVuLl
         UMZ3PvYaUrf4gg8vgNABndA0smDYeFFiOINfJ4dIFYT8kW28zSfPlzN9jmsQjEOzmd0/
         sN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740232267; x=1740837067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XvebaarfPWYMLZS8DRSVmQKGFCvLowf4P4Z/yIOI4A=;
        b=PJezCn2aGoTKItK0R6XINKGqPiKB5uLyBznqu1S3D1AGIDdKy9lo34eGa57Z67wFwP
         G4FqFHDtG8yBPJMyKPzM5/L7lB+p05Ivgc1FEQocQzW05OqZc7JTLpSA1Jv6qXqjAhS7
         kFf3MxoNaGo/bsf7LQd+1mFB6RN79d9SVvpzqHIjbb7+q8eG8gTrYoj1Ybu9wEv1NLAE
         z8PNz19nOw7vWOOAE8cdE84oJ7C8mmO++djEtyFuwixxT56+kes9mByhB1gMFH0ByRa1
         d0+EfbymJv7HKd0E0rTnj+/5u0Bw1MZGPvQXiBQIBdOCbvZR/OaaSvXzCC+hKOZ3Ur8E
         5a3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVib9HqF9j1wYHiFbPMTzib7wuGiWs8t8KstUWA64pEkciGi1GLGKzJxv+RaY6TUVp2VaYRZbhoCqGhCxsL6+U=@vger.kernel.org, AJvYcCW0dOHO3/+ZJbuC0Pwzr6zOyyFbhV9oz0Fim7Kv09LJB0bt7NwTROcbueFxGaX/6vpxnF5Q0hAcOUNNhu4=@vger.kernel.org, AJvYcCXwUznJOPFWzxxJpe99IjugZXr3gt6mc8QpJkAKZ/Svval8WOeXXY2o0cp3wqFn9PG+BTVrgctYyNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKQsUwfMAIXlr78a16I5Bfq6xxgNC7Nhy5oWxMKn6ejJFEu0P
	5aQ6ZWmMrZb5yo0fwgQsaN6FDD34JZKINocPnn84L6HZBZMsfPWMVl7QX6yvMNwdxqppuE2JHtN
	b356RL8FqKnd5AB1idCuIODWiSKo=
X-Gm-Gg: ASbGncsdLxioemT6qRS5J5Q3nBE8SKKntps+13yyDaWdgtLfM7m6LvajajzTtemtMRY
	m3xNWjw8pVok0hMzClm9SKCRX1oFuELpmDdzcH0z8CfpUOowGjeA/qxb5dvsFC+RcqGRWaOEHiz
	4hFdPHSsI=
X-Google-Smtp-Source: AGHT+IEiprFzehPTOxru2M93tQg4m3wL/6UlJh/OyAX0ySYI2kjESez6vGmCeLbUDX5qhzIjXc8BWzRwjAt+mbpFnZk=
X-Received: by 2002:a05:651c:1b14:b0:307:2aea:559a with SMTP id
 38308e7fff4ca-30a59997932mr9566891fa.9.1740232267051; Sat, 22 Feb 2025
 05:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221205649.141305-1-yury.norov@gmail.com> <20250221205649.141305-3-yury.norov@gmail.com>
In-Reply-To: <20250221205649.141305-3-yury.norov@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 14:50:50 +0100
X-Gm-Features: AWEUYZkMOIblNgQKZQV0DVwztTF32mbQDrM8xd4mK5hBqeEGuus0sxvxiKDGStk
Message-ID: <CANiq72=ctKoDz+Kf7UFBTD-oF17cTHBcrkNN_5cqxQeK609OVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:57=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> Bitmap developers do their best to keep the API stable. When API or
> user-visible behavior needs to be changed such that it breaks rust,
> bitmap and rust developers collaborate as follows:

If I understand correctly, you are proposing to a "temporarily stable
API", i.e. to add new APIs while keeping old ones for a bit until the
Rust side updates to the new one (including perhaps workarounds in the
helpers when needed). Is that correct?

In other words, while the entry is about the helpers file, the policy
is about all APIs (since some APIs are called directly), right?

(Up to you, Viresh et al., of course, i.e. I am just trying to follow)

Thanks!

Cheers,
Miguel

