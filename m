Return-Path: <linux-pm+bounces-25283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B60A8640E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23471BC3FAD
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68464221FC3;
	Fri, 11 Apr 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfUvvKxc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA727221FB8;
	Fri, 11 Apr 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391123; cv=none; b=nr8GZLKvmsh0HP1meAi2vFb/9AVF85E6O9o7PyZsOFvliRGZnvxGKysfesxtwBbFzHJiKwnNpKc+j02Oyn19ojFBi0lnAjBXOaNN+GoSV9e6dUCgkmusuDGtAYRKIBqWFJRYoCn8ZhSx76TpFGLZTpWRCEAwZNf0DxUHtC2sKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391123; c=relaxed/simple;
	bh=buv6tJFU81bfMwxhN4X5pTfsZqKCjfGk62wzBC7Mcdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCLzjeG8CHv/kycPFBED8hhdEYj+AeK2ahszgpLJ+43jKrOemJCSj6ltXDQrZ8W8nnonImXLXefjWYWHO/n0LA6ZiwT9CpJjQnA4baIOy+gtC6XJ+Patw2C3kG+nveVwy7s4y0tSityj/Yk4AVMiVvvxfiM1J+vF0B7Z+iLl9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfUvvKxc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f7b10cbbso2149175ad.3;
        Fri, 11 Apr 2025 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391121; x=1744995921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buv6tJFU81bfMwxhN4X5pTfsZqKCjfGk62wzBC7Mcdc=;
        b=WfUvvKxcdt6TLJM82RLdPNjUmoE8/TJ6ZpJ/NU3/7L/cEOnYhQHHDQqHzysILgCSF0
         mOYHoyPT91scseaR7//A4aBp2bbBGY86M8A2MQWOw7Vdn4y8mFI6DwHzqRj/nLUc6PXp
         /H+pc3PUOYooCz3eNtQaEXoxC2mIoH6Y0K2LG7giuAl+NN3tOSKkQcNIeb6lRe0ZwP1I
         +vKIMpnJIXhoei7aq1fLTZOHyGLw4GNrO6iVXDsmdP/xq13zVIXJtcs4MooSh2ikljIx
         4kUaX/1PxwqSE3Ftq27PhRrW0GpQQANZidXgQ24/eTL6ArkDyff8WOQBsOGQUzPNtdgh
         36Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391121; x=1744995921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buv6tJFU81bfMwxhN4X5pTfsZqKCjfGk62wzBC7Mcdc=;
        b=kMFyLgTObZ1R+TcpUyrc1hirI5/2X+kcPZpTf+H0UuHlxG7nNOsTYcy67jRxKfaxC2
         H1LKA98ti54bl1K/TvDxy0ShDttAryRJIoVFikVKog0aqegDcWYQLm5NyPZlUaQFtHO9
         h+EjbOf8p6WZs/BQS68A91Gt5bPQZ6DTsyKFqgJxNWFPzT4TxCna0IemwqQTGa4UjlQ/
         xvPXYCmfUDsNgtHLTSwJKiGhBscg0/LqkCPktXnCft/VlIqo7gwp0VW2lrl6kZit/FDr
         2HodmvwdDlMC+bp0bKxmYujm4wLVwAhN56fw6+UyXv5pnA/40dZw8dv5e4yAVPE7zz6Z
         gnJg==
X-Forwarded-Encrypted: i=1; AJvYcCU+wnhbUQTdjEGZAGah/0mQN5b0zsG4IyKRj2/nhNPA6KZdx0EiD5GBpiVtKucDYbkZ8YJT6RxCM+Q90XsWljM=@vger.kernel.org, AJvYcCUXoTtX3uGZn8MqSdYAB57KnaY5dFxRBxuqPrn5yh5KqGa0oRoUBpnQymphjuSRwOrVP0dZsEAMCdU=@vger.kernel.org, AJvYcCVukGN2LY8l8pbV6vV9/osh7snsxcx75swC1NQIwas3qftzOzrNgIxzPCsEzqRUa4a+eMWTtk7UvDw=@vger.kernel.org, AJvYcCXpPDiFhGGeT8GAU+dC1yftLXUMFjv7q6isAHmBPUADYt+Nc6cOu/hwsgB7z/Jyul1/xO/cUW3fWXgiH8jY@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNrAUUsoZC+U8Ogjn6TfXz/e3XwE70DzTJsabs8AfUrZ6HaEo
	g70Oy8o/bx/z3hc1iHvU47uI4EHdaL7SroerxtF/fnf9iyaHkR9LY7Lc+clel8dTNF0hPRbGTOB
	YLMUWQtHWfMgme5/NX0FL8z3WqUs=
X-Gm-Gg: ASbGnctMxpvfjiGzJZJ3ipRD2xjjXT7M6p6khVygs80aWalu5djOizRTMx6HXEGPYHR
	RwRB2OLvQjG4+JxePH7n6eJ4mNHDGpNxEvzHUPmyLvz2fCpxfw1SXTNtYXbhhhk6doii7cjilFL
	m0gxMr7IZDeQzV+0Kd1AhVsw==
X-Google-Smtp-Source: AGHT+IF4aatQf3rnY6osYH3EMe4i9rbmYsDluNQrPMOtOIVHemw9VZIB+8OoMzzvtyR1YTkT45UxmOnvrh1DXifR7sI=
X-Received: by 2002:a17:903:1b2c:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-22becc4dcddmr17546085ad.10.1744391120834; Fri, 11 Apr 2025
 10:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744366571.git.viresh.kumar@linaro.org> <efbdd8212a90175c293313de961c34d13b9f4b43.1744366571.git.viresh.kumar@linaro.org>
 <Z_k-TFCkLWu9eiFt@yury>
In-Reply-To: <Z_k-TFCkLWu9eiFt@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Apr 2025 19:05:07 +0200
X-Gm-Features: ATxdqUGsS-qbRPikOYkiQqiZ2TOsQj8myZv74OnTvJYe0U7MJJlY5XaRE0u-Ujs
Message-ID: <CANiq72=8iokcwv8zG81oxi9_+8p3_X2s8dRgrXi9DGjaSaDDMg@mail.gmail.com>
Subject: Re: [PATCH V9 08/17] cpufreq: Use enum for cpufreq flags that use BIT()
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 6:07=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> The BIT() is as simple as '1 << nr'. How that it's so complex for that
> tool to realize that '1 << 2' is the constant?

It is a C macro which requires evaluating a C expression as the C
compiler would.

A solution (a workaround, really) in `bindgen` is coming, that
essentially forces `libclang` to evaluate it for us, but even if it
works perfectly fine already, it will require upgrading the minimum
version and so on, so it will take time.

For the moment, either we do something like this (a similar approach
was used for some `enum`s in Binder) or the values can be replicated
on the Rust side (ideally with a test somewhere to ensure they are in
sync). The latter may be best if the values have not changed much over
time, i.e. if there is low maintenance required.

I hope that helps.

Cheers,
Miguel

