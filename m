Return-Path: <linux-pm+bounces-22867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB677A43963
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A33F169699
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9CD261361;
	Tue, 25 Feb 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5XcvCDH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E779260A54
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475478; cv=none; b=qm2K++3lmX+NNkgTG2hYOdQ9uFbtPevKfv8iUaNx3dmk1tkpjNRZegjfXpFqxMqT4bLjuXW8uRTtvkradzQ3pgypJNaUzSQEwcRAe9VZbnn1gdtvezQ+IBedaIRfJNggljzBmWl64G49V/pgaLsyXjazgaVnAIteKagqYTi9Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475478; c=relaxed/simple;
	bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrNgq+7571XjYui+M+IdZKwcUNnt4SkJ390XCcFN0MKjT4M1H4pMsCaWVyTvx4F+rE6I1WkwByXK+k4M29hKS8yQFb1KHcn21BLx8TuAFrXJ2gpKrtrNWeeiFoKZWj0sdvX0kpzRuUBNi306G2Lv75plLNtfqVi7KyDnN8xmYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5XcvCDH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a823036so50756185e9.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740475475; x=1741080275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
        b=Y5XcvCDHhUN6wP/Or88y8pLdm+Ovk5Pw6CLGC1Qyd39u77j01hU/lacZJUHL71kkw2
         K7LIrXkoe7uIIZ2JhvwvqJNs66BpNGL2RD2u29VgBibJPsY/+FuIsK1k7wmwMZE2zKFQ
         HYyUkEt9Ms81hATP57YpXRw8NS3lTYur9ZlAVCIWN72eJP4yh1R3C1g5x6PuntPWEq0H
         7EgCDy5ofNCDp3eKUdJ1hQoCaEFCe7oA1aQm2DrbRtmZ6jl7auAMhmbZMwRpEmbmL1ab
         Z0+9Muxvj9ryygzGNltP7gaCgPxrjDBcsmvgplBBtakUZNvsb21+sqoovw7zE0+gcmXU
         72nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475475; x=1741080275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
        b=JRkTYXv0XL4l6CkH4gl7v9mISXWQQ06CQLxPgUvtL71fPwBPibbU7V0hC2OD7KuN/J
         vGwdoo+nxHAbUeGs2wetL2O1j+vw6HFmFK+hkvDHcVDGUoAZIYrJ91rjk2uyLl0DYsEv
         eUJQkcrP94qnV65daBKL8+4n3Hs2lfEZgwCl2cTScltTgn73G2RLJPRbSowwNKa2Ext6
         D7P/tTQE7R2ytZOApAP1+41c5xkPrgDp4BpZHKpViuxJtQYEEfC7KV5wOr9Pt6Ea+ckd
         NciOBv06YoQBjO1y1CrtvC84GTMmie3nRi39cbSuVjYU+/OCPz4bh3HHMBuNW+yWsMLr
         V59g==
X-Forwarded-Encrypted: i=1; AJvYcCXcG+jwyrkKON9pxHozj6dQ/IfDwkLmFHj8+dp6aOA0eZBTTV5aQWGEjgQ2+jOXS1Ormwzh6VdMgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeB+jHY091J3G+z6frT23nkkE160TAiNYnLxtvr+H9idsVlXi
	SYX2BpLzDU3u6+jY02er0dE8Q48yZsZokhU7pJkHNdcQvy9oBAAqNyrovNIHjbgJtP4v4aQGxL5
	0sDbE+pOp8IPYnWqY4YhBb8T8X8sjsy0Wa4FB
X-Gm-Gg: ASbGncvqRFe81AoGg1XNzDTAtiJ//OMm0dVRFRcGA/TQGjguGCjO1Jvc+3f0xcJhQZM
	WNIPEaApg7s+NkDQQpVdEqhnfwc2cE/35xL4fzp4leR2jCdaJWvfOtdkS4NLcDU9WiBsCRmGypB
	wM9otfiOfyMpOK58CyaoxZ92OjXhbcgp9uhPTdRw==
X-Google-Smtp-Source: AGHT+IGQHSzoQSkPlTwNA0fxypnA/os2iIyhXnWMnuOEfnVFkcbcWJzo4J+RgQk5Yx7RRkNXXrVU9KuiyHJ1mGA4DK4=
X-Received: by 2002:a05:6000:1844:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-38f70826ea0mr15050496f8f.44.1740475475410; Tue, 25 Feb 2025
 01:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224233938.3158-1-yury.norov@gmail.com> <20250224233938.3158-2-yury.norov@gmail.com>
In-Reply-To: <20250224233938.3158-2-yury.norov@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 10:24:23 +0100
X-Gm-Features: AQ5f1Jommy2ub_3vQwqnVtD39tTTKNsZezOyKXgy7B1RbabnHE7_Zcs3Cv7hZ9A
Message-ID: <CAH5fLggk9tus1KmEw-Ox0buFLLhN0VajKCXYdxiFncjnbLGatg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Erik Schilling <erik.schilling@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:39=E2=80=AFAM Yury Norov <yury.norov@gmail.com> =
wrote:
>
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> In order to prepare for adding Rust abstractions for cpumask, add
> the required helpers for inline cpumask functions that cannot be
> called by rust code directly.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

