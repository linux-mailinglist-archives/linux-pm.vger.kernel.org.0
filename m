Return-Path: <linux-pm+bounces-28405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D8AD4019
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2D7A5A22
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49B242D73;
	Tue, 10 Jun 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrFUx3Jb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB07243379;
	Tue, 10 Jun 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575468; cv=none; b=lichv2TZfxptPNk0nl5IOBuCqZdzsV71gGLcLWhFQ2CJvZ/Ho7x7yoYXlSYD139VeCeqM4vXixF5hELuLJC5ZX6iIjxZAnXYpS5D9aN3fOlKIRe1+Iaw2ZggG/HqwR6kJvTR0BC2HKhlQWldEyk7KqGE1M3fCXuucmK1Ga2AGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575468; c=relaxed/simple;
	bh=BL6SOK46zmLH0bIebppxl38nXnx0NGMfPP3BDP/W5T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8Sf1QoZJR9FVNwy0gJgX4yIs8K0jTU84le3ML7M241UPMY++Qy2JRKBBGziECosPR2x0GY4kTuOWNTZQ+3mLZD4Jwz3yXatp6OmzwowW5LYhWyMBPJZTJJCYpE1cF0Y1cEaK/7LuXjopshESVXE0abltD/05h2DofwFSFpgzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrFUx3Jb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234ae2bf851so7981295ad.1;
        Tue, 10 Jun 2025 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575466; x=1750180266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL6SOK46zmLH0bIebppxl38nXnx0NGMfPP3BDP/W5T8=;
        b=SrFUx3JbfaeuD12oO+84nuAoTJiruus8QBNu9c+m//jYFEbq1lePuaeoCINfurjIPy
         sKjcFAxWzy6qVDA6cGHRzkbmWyU2CZa24/+pXXsFLW7JUNWZ1lAsd+T/xZo0Q1Gf78nQ
         0zBvF1GPYTeiqNwLKdQB6phDYini35VIQK680nH9VTDSc5y3VrOzS9lFqEsKUjQBZydH
         32R5Q4CTYLodLuqs04Cg27lAD2NXki5yNK/QuU3iUIwQCQ5IQzBrDptJ6no8KQhzcBvu
         QvrPhQsMpeuQjAvH+AgegjtShYbSec0jN6YXRKGOUp6RQ7LUFvtAGeuwDQnlYcv+HQzF
         1p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575466; x=1750180266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL6SOK46zmLH0bIebppxl38nXnx0NGMfPP3BDP/W5T8=;
        b=KxfO5FVlXm0S+eXEGLolv82yIWNOE2NtsNkS9o1j8iJooYFdccGTe4+/mzLHucUWQi
         aQlmYIi+fK0Ccvkhm+jL6Ckc512fHzsF1N6/cHDky71ywckA913P3WFOgl35yTVPnl6o
         j970zKvpSnyeTTvn+ESD8w3fe4tizsSwNbMULgsI5pbKfw9t7/onbLxquwgZjx8S68gT
         YWjEETi66KH4/ptmRADe2Vjg7Mk9oiVk9ZIg4MKBVhc433kVQ/3BvtBr36OKvWEmN85c
         +nduuld0rDHEKr7aDqF7hw1oH7AUQt7FoBsYWq2qtzITDv5UeCvhIc1OFEB3wPaAz3dl
         YReQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCJX1e1iK2kLhtL0UlEG2pspv7yw6Bj5LSuSnqadqQmPfSymlEZPfpFpFC2RTbtfb7m8moreGQ0RMGsJg=@vger.kernel.org, AJvYcCX7B7Agm78Rr5eDHA+k0wQbEXiHSJ/Q4sm5oHaAUwzr3VidI2nxrMMD5F6M+uOKmZ5/Hsasnok+H1k=@vger.kernel.org, AJvYcCXvW7qde2skjHgaaFn1QDKj3kwAthlMN54dcj7VLej9Vm0YC5B5AKGQFMBZ3nNFrzz7urxTHtx1Ic6QuJT6t6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lYpcof9BNFCv3SQDkp+u+CHbkVCpQR5jSv0Bntp8Hy0yV9wM
	Sa1SdKExXp4vFG+BafQRWKOWuw1HVp30T+7gp/NdH5TTca5EF8BmSd7QZd2WgoPE9m2/6XBXIRQ
	kCab+JcmQY9wc3TB7AacocDXwZuoQM/U=
X-Gm-Gg: ASbGnctVW+ZrNPzLV4okX1wFqeruk3YdPJJlot/dzM1s/LhULvZCGHLowAybctXmfce
	5wr/4pUjxMwgA0imY46MDEZz1X1gqKKqiRN2CqkPE/7t56ygc4uyplZfPGXOe54ERUMQuLnzM1U
	+j4hGi9Dwo4D0ZZZvhf9PiOks6KRmS9cTJ7l2Q8KkQghM=
X-Google-Smtp-Source: AGHT+IGCpC33KDLfv6JP/DS+0RU01EZtVeXaXEKkFm2FNxf9RusDakqopG6+qr3pZRcUloOWRGua17inPPOnWf8DImo=
X-Received: by 2002:a17:902:e544:b0:234:f200:5194 with SMTP id
 d9443c01a7336-23641a9ce87mr436185ad.1.1749575466277; Tue, 10 Jun 2025
 10:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749554685.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1749554685.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 19:10:54 +0200
X-Gm-Features: AX0GCFu9enr57T2syom2yaCJakHi_u4gxMwsHHNlRV3jpMHEUC5p0-wQQ5BMelU
Message-ID: <CANiq72mWAP5ZuOGTXZ1=zTOR_Y2YuqV2i8PberOeWOkx3VL0ew@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] rust: Introduce CpuId and fix cpumask doctest
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:22=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Here is another attempt at fixing the cpumask doctest. This series create=
s a new
> abstraction `CpuId`, which is used to write a cleaner cpumask example whi=
ch
> doesn't fail in those corner cases.
>
> Rebased over v6.16-rc1 + [1].

Given this is growing, should we apply something trivial right away as
a fix meanwhile? Or are you planning to send this as a fix during the
-rcs?

Thanks!

Cheers,
Miguel

