Return-Path: <linux-pm+bounces-38929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF7C9530B
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 18:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500C53A246A
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89F17A2FC;
	Sun, 30 Nov 2025 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuhpQOOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F282222A1
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764524920; cv=none; b=JtsMs8dhCvtAmAyM8GU2CRYk0oUV1YWRg3Kii5XQuMJNvjgJ+RCVpwFtzVYLL9s/5dstQAqlOjjuifR3FFcbndeDcu0PKhiYCBwSVeEuYnbcox0cF6OGYjT7o9Vouglw2IN8MdN89CbXoFNo+RHKi8hyJu0eUecpX8vIjThmQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764524920; c=relaxed/simple;
	bh=ENHKHLuSnYs2YkjTDKE83XnIxIkg6P6Da60IQZLgvgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGHZ6EoXLxWy9706IYEmykOvvrTAWpUbCe8vb5fSUhEnlxkkDV3iIs7xNUAX+mZz9aSB3LrSO1wBHMpaT2iYdGNxj+8dPG7BTRiN1r3kh8YbWB82LTPoYiTkhckvZFV9KZLO2Qs5nchXmIqW7dC3f7x/VUUYNGlu+zeT9NSq+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuhpQOOO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ea936b39so12470145ad.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764524919; x=1765129719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENHKHLuSnYs2YkjTDKE83XnIxIkg6P6Da60IQZLgvgM=;
        b=MuhpQOOOp9bCV6FT+SOX2eNgG1GmKiCvj3O2Y1irOcb+ubbCvSROEppMtusXev0CAr
         91s+1NFctLP/8oRHEph5EQizsDQPT/8oHpB81CxvLIXIaV2fm70SUenmakniDQ/8mM2e
         e8joLg/yRsRp8z2hvRwcU76K1kGQCrjiI8JdZEtjrCSqCDoeYCrOz/llMY235+CYDxzc
         ODsocW8Qe58PcrSx4WXmHJMILBv7bDHehnWPHwwlj03Cr7Saerg3h34pOLwqnqfalCxJ
         lNWbhTan67BUQVy7KRNLSm+mMJ/GBg29Z1rJOjeqvurF8SCIh5s8JMB3f+DzPOZ2bQ+7
         s7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764524919; x=1765129719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENHKHLuSnYs2YkjTDKE83XnIxIkg6P6Da60IQZLgvgM=;
        b=PyLze6cbJbG9Vl2i4meAoqA0xiT+6EKjvK3r1go99IUr8qJhE7h4V+tpS5vJXHsCBZ
         j2u20+xio+fM2+LX/b8slFJAsk6WViSlmQeMglEr3iOwm1vvj3N/w4Dka0KysAZEnrnX
         CMU8TavamtDWpetZBHvGHLsVrr2hJDXypWMaCC5mM2XeVtBT8PU+2jomYVZvaRbR63IY
         NQvW4tmSTJGfWCM/kl1JP4jROvgFnOZgdmBgcsJoj7qOOvF6KarE/5gsYiJgSX8sIdws
         PSh264dd4jb4jswL3/KscYG8weD9PAN7+ZBedaZWPAqR4qLvM8MeWRLOQDOqZWIMoKge
         zMhw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/KGjf9zuseQAgthokFftOChuhPyx3tcgt3MESI//tJ0lh6sO9zY9pvBVZFE8GJAZPSdjfqmMNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJER4c7nsQpYB4m+0DFY1dfqbmXD3b4Ih8B53jE4a2PZhBBbr2
	VcKwQW5LnTFQN7XWvRWPnu4uF64qKut4pqCl2+ePzFdjMey1hIpJ4ZzGg1PXrI8qvVbykBxhjq7
	Ju6purKeNOjKQA0XIiU4ePdGLMrJYeew=
X-Gm-Gg: ASbGncthzX4/y4IJRaoObVzRiDXg7rsIB2l0vS6k+g9PQI2oDun7uXHXiv0vFjglijN
	DXiU2BEOlgUj8SBW2c10lOmyijN5iKARSMk4Ls/bXMCFERprE28ZsRYXvu2ChHEnpRqFlPaDfnm
	Gq+rp5WDfqEHp0WQwnFa0wHcGKkvzPsgTDTDdAQuvs9Jr1UiyW8Kic03CpWYOJyGW2k9e/lvY+P
	Eu1vJ/6Co3qGX7LIFscISoa8ZVf4/2MlBsrs/SHQReZYfBysm+6ZI1YN5sKgH5e3gK0bSNPMlgq
	GWoEbaBm+x5VBUB75JkiLg9WLeWgU/U8Q+gRFaIFKwaq6jpHOJA9krG5tuxWr6m3DrtIGzVi+3/
	FZ7gfBD3LrPltwMdIZAp8dBCj
X-Google-Smtp-Source: AGHT+IHaQbljRW3JXf4Me6UvkChwwjqlnlN4qWO8cOba3pFcBQeaqqHkhKuGpQIRmmBre+7aP8vHjxb9nEu324zXvPM=
X-Received: by 2002:a05:7022:68a1:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c9f216eccmr22574928c88.0.1764524918626; Sun, 30 Nov 2025
 09:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com> <0A952509-8A00-48A0-B975-C23608A6048E@collabora.com>
In-Reply-To: <0A952509-8A00-48A0-B975-C23608A6048E@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 30 Nov 2025 18:48:26 +0100
X-Gm-Features: AWmQ_bnG_6Xr4-eWihxCptboZrSfawc8mOHoTttjB1v-YXZ-LMcla2ImwpX_8a0
Message-ID: <CANiq72nSo4vuXc+XW6yynbNvpZi2vJEshXw2zA1RPgSUWwAZ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] rust: build_assert: document and fix use with
 function arguments
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:09=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Ah, should this have a Fixes: tag?

Yes for those that trigger an error, e.g. the `Bounded` one with -Os
in mainline soon. We probably want Cc: stable@ too -- it is not too
risky to add these anyway.

However, the tag should be different for each commit depending on
where each method was introduced. #1 and #7 are not really fixes, so
they don't need it.

Cheers,
Miguel

