Return-Path: <linux-pm+bounces-31390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C9B10F32
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC955563073
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA432E973D;
	Thu, 24 Jul 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJMzFNTp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D4274FE8;
	Thu, 24 Jul 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372518; cv=none; b=Tahai+p9kTjDIIdY8kHYI2u5fWpKW8yDVQfZl8lBAdib8L73zKi5ZPdrEpWdPXNsX0VMBc/cUbWrzOaGxIct7cQmPJV2wCbhoSPZ/xvilSLeDJYop2cHzwd1HXA8Q89vzNdU74TM80EW4E6f2JZ7HVSkS0UgwtHblo5SM4fd2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372518; c=relaxed/simple;
	bh=EsIZpvN9Ch3cTP+9Ex/zXKHMeTPVN9yv0ivHS6Z8KKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENZO7JzrTVX6f3W+FtXKLk2EInuzYzRn6tKFyb4OWTTRd6bmsaDgx/J6bJ+M6dWhUMnU6s3lGZjtbGJH5OrnoXzYQ34vYWeGrXxfTuSwL9u/1DotsrzeSmeizFrrIvaF4PivCjZmgiAn5HadJ3aHHhn3ImDeBN9Zi4OC99EiXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJMzFNTp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3103237so19735ad.0;
        Thu, 24 Jul 2025 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753372517; x=1753977317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDNGFNvdoRGiaNnGVahZQG+zj4STjDcT82+GQkhVmQk=;
        b=YJMzFNTpzjFzAOR+eBQolicNqScTnnpgp5Pv29+lwJVQzFTz3z676+szcGVT/SRoOt
         sQFI3HPSJq2mMp6qJuLlGMbLf/Q2/O5C8Pq4O3xaINtZK4GJryh8klXuPowrhtfsfPo3
         O6QVra2rouiBAwTYfGb/rDBoTLmMreiyoyr2K5bp9HDCIuT7vE62pQNqB7Mtq75Uo4wW
         tYUpKxSAsUU3KKfu4LMpg1ShHm10xGexA0jWeWnt4ep88mv493f58kIiOP77c51okLQr
         BBN+XJ9Rkhze4XDfTlAoIVnRJYMyUkqQsAffBJr7jUiV5sdLYUPQFT47IuUaUzhA3+Sb
         +jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372517; x=1753977317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDNGFNvdoRGiaNnGVahZQG+zj4STjDcT82+GQkhVmQk=;
        b=DWkefm1wCkB/bwU0jA2dvOolUTJ0/M5ach+GzHdklwJt8UqQPocD6PEB3IX8tebSkh
         +asiqeA+LSlTTOqTDZfOPPzONUe46sNLerYNkzvu0gYT14DzHIf803vNyaqWsUpKH/Rp
         8ZBQU/v5vBACjY/rV374vUL/CXjyKv1OiT4QD8T1HNivCG3BzaULpiwgIT8/Zm7ySvmG
         ziHv/yzrB5iY9LVkUq0pGkaaXhdmbT7kQADTb13F2Ew5n6mzULpLXl340nNSQrJgPOMu
         BVp5Hqi3VvWFp3ad5zuaic14ORssk1U6HaCHdHW5jbkZA/Yn7WQK4/AWVB5Vj/uVkwjx
         fuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNaO/kPo39IW43Rjq8cg0lUeNM78bH6yG/G5c91sQNhUN8oxqxnYiCqBnJUyLvPAGW8ndQkuAXWlwX+l2uLJw=@vger.kernel.org, AJvYcCVv6TO0WfRkxTJR+gFLevjvNhyD6WR98D76DjZ2+MyKoY7wkgsEyXcxRq/7oJ6P7c8f0a3F/ML9KwQ4aH0=@vger.kernel.org, AJvYcCW917WofPOXebN2RouEOlsTDTLnob0lP6JVqowi0g9iibB1sHKjA+6VYrUUl0+PsxY/9386MdnTzIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/MYJw3lieUpvyqRLhVXYxjM12IOjQu8wD8zr7/Lw3XGEgBdZ
	1+kmanGI3Q9eV4HkMoVEYh9Wpy3SMLGYJsxKeOrQOxmbsMOgrsSZLCqGlCcI7LRg+qCLZdNRyKn
	g7Rhmk8ZAtSzrHWOTePMCjEUAK1ibtXA=
X-Gm-Gg: ASbGncuiXh72pLuzbKYn7BTkY6If3YfrPPbyWngF5USZV7rkry0P8nGBfFaO47zZSWg
	YX+GDIRUGdAGWbw1xpgZpnKd4MgFoVa0FR85Fpm1y+vI9H8ezXTPdBTv/qiBm673NxYpY7/m5lo
	mAqN6Hru9WXdSDVVSk8D06gPJE3lb8sXYc9YR2kHLJEDMmjHOT1XafbBompNr741E2ZxeBJr/tw
	GvAgOcV
X-Google-Smtp-Source: AGHT+IE9TH8HU85JOWM2XUgTJeIUAyMZz1QgX87GmzRjEtJOV2NYpn5aqC+FGTCUCJ6G3NKU158izj5o14hVG+dK26U=
X-Received: by 2002:a17:903:3e13:b0:234:d7b2:2abe with SMTP id
 d9443c01a7336-23f9815353fmr31098505ad.7.1753372516448; Thu, 24 Jul 2025
 08:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com> <9884efc6-c6c5-49f1-b582-55bba8397521@oss.qualcomm.com>
In-Reply-To: <9884efc6-c6c5-49f1-b582-55bba8397521@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Jul 2025 17:55:03 +0200
X-Gm-Features: Ac12FXzQMwnafpXjFV6CDFKO4uvN-01wgnqGuQBCiqSqrfTaP7C85N-A7DHR8uc
Message-ID: <CANiq72n31LBnLdAtZH0VBzVGau-ddWCp=5=Bra=boRE4RiCZGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:36=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> Regarding the users, I don't have any specific promises on a consumer
> of these abstractions in a short term, although the ICC API is rather
> common (especially across the major arm-based SoCs), so it shouldn't be
> long before someone needs it.

In general, abstractions cannot be added unless there is a known user
that is coming upstream (or developed in-tree over time, like Nova and
Tyr).

There is also the "Rust reference driver" approach/exception to help C
maintainers bootstrap the Rust side, which you may be able to take
advantage of:

    https://rust-for-linux.com/rust-reference-drivers

At the end of the day, it depends on the particular case and the
maintainers, of course.

I hope that helps.

Cheers,
Miguel

