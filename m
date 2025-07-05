Return-Path: <linux-pm+bounces-30196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EBAF9F29
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8655825E6
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057D287272;
	Sat,  5 Jul 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxNsaGXm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393E2749E3
	for <linux-pm@vger.kernel.org>; Sat,  5 Jul 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751704543; cv=none; b=LIf044NKakXIhMb2S9vBTmWtsYkV+vYehMBHT9oGhs7iodtY+IEm31zbEpOykptvsLjau7r6dfDEk0EuzjMJkKXR7Yu3AmS3NMt3tV1h73pST0ko5CWhw8FWo1mxapAR1FyUumacmwwXLbOq17KpPbnpHGL6WeoPlg6GXzYDKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751704543; c=relaxed/simple;
	bh=ah4SIvptMdwSFRwkpjHC9dZIrJE8W7eJFE6nNgvIwz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXkPUGtzdFqF4Wl3fzpSK844KoG3HkhmArTz8XpAJ8NFN4G3Pj3/xiW9nst8pAnVv9AMSLyfslAqZTzRmjWx8q9FjpactrIzh0V1w5vrnv6LjPDS3n8DK/PddAXVfSqbfyr9R5XRBmRriYrFEGgTju/ZzL6fqIFzMKzoaPVqXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxNsaGXm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1068820f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 05 Jul 2025 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751704539; x=1752309339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah4SIvptMdwSFRwkpjHC9dZIrJE8W7eJFE6nNgvIwz8=;
        b=VxNsaGXmpFBZzbGKOd6IK9X/JtW/udqf/QFYkdXLMxRPH8E9mWRWHzOT+AbD9nMkC1
         vaV1j7SBSvjfLydUz29ox3rRRDZpZzJRbQEGkh0GwAz2fLNT0dw0/NXxuNgJZeLMROHS
         Q349P3/x4ugtlRCxNp3zhbinpl0JTgQokNMmBk+oqFHEDeRH/44vvvHgcyhH1S3X3GX2
         tz3pFZw9743bK2bsHftHI6JlopBSveB0xVs+haMSn7ibzFOVJFyTRP0hnMuIk6GPjdpz
         HNHvsXdqQc6gu8JSIiWFTUtYBokNkCcIauhl6GCovDOlUxd6nSbvcDR5KxM1IgzY4s7/
         oyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751704539; x=1752309339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah4SIvptMdwSFRwkpjHC9dZIrJE8W7eJFE6nNgvIwz8=;
        b=HWp62Z4tzTFADdU5w0q/rDg0P76HvaIrQEfWt6G3qmMt0OukkUPm7MDHuJr5hY3tul
         S1j+g2ZbLXnt3nJWeHeW9R2Ja53UN/BNmxtsvXIFBQPRo4TPJnV9nzJOSgD4rkD7WtAH
         f2pS6rcGjc48DgZ93Ts3UWYFO7LIoeu2KPZSLldADeqby8fL1VQ5q3pPUqlaAJbx9s4Y
         EB9uCo7D1CAY/JIfEKUzd0T+6Htyckl2aKii1D1s+FTcl8b+2r3Mqk/hHL+ddjk3/es+
         DAKDE5j/QNZ4H2wFfoJBviF3pFOwjmHA51+SkYPurG/hBhoMpdGf19VIRGZrJZQJfGxO
         a97g==
X-Forwarded-Encrypted: i=1; AJvYcCVCghQ6B/E2TS2oVnVfo0CGVhAQZYKB0RiEO2m2F/kPwf74A1aHUqUXp9mi6zpPO7opLVLtGCoKhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGM//v+p3SvVjIxbMHg6Lvt2/oZld3TgtWIGOKj1McOPycE15s
	vkl17nlDwMDRET1u5cupGJPb3UNHIa0sfuaEX9GkaSWrMuyF53N31TL3bzEReNjXXNQaeLMmcio
	beRXZERhrPZZOjU8/XmuN2wZBBNWsfp25W75WsoAR
X-Gm-Gg: ASbGncuSmh1AhzFGpm/mmucUozPyZWynbRq6cdbZzY91OMdH3vGRXtzsQFhOmbYGumf
	b0WzY3XgvHFmir8vQkUs+xeheNaad0fRe3YWYhukTr32FGCPqo0wz1FM6dpkCYoMd+SagTlktR2
	Q5ZVsY4RySBXuCR3okWATCYyCvMeqkg0UmD2cBbOQlqDYpnkr0ngR36/o=
X-Google-Smtp-Source: AGHT+IH/pkllT3Sy9Cb1lHriZM/tG78khhI42JnRhbPr8kP9tTs+gtmjri5ZYwhkuP07q9yAkZH9HXYofTd095qzzFE=
X-Received: by 2002:adf:e18f:0:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3b495cc4ea6mr5351566f8f.25.1751704539369; Sat, 05 Jul 2025
 01:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com> <20250704-core-cstr-prepare-v1-4-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-4-a91524037783@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 5 Jul 2025 10:35:27 +0200
X-Gm-Features: Ac12FXyGVQLpnmxvOqtVG7V_plS_x4VHl-FkqPG4Jcdo-zfXWt7_Lhls-5TlbKw
Message-ID: <CAH5fLgg=4ZqKh1hqFD9bmGJwUf3LK3=K+Q4tTRPnT+NaMubpLQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] rust: str: remove unnecessary qualification
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> `core::ffi::*` is in the prelude, which is imported here.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

