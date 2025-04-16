Return-Path: <linux-pm+bounces-25536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA24A8B6CF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B206190001E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24519F133;
	Wed, 16 Apr 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmpCJHzu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE82A48;
	Wed, 16 Apr 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799491; cv=none; b=rCrnJgELSWuhxkGvO38R3kdL+qIT4DQCoEb8bm2hQs8zX6TssUoXogpaxESRoWKA10fozmrzHGFuh10XD1hNvy3dYXwkv2oRjMgrrn6bbCoVPCkbKt/Bsep9njqwZUKF5ao6+Hvrv4+DZ3Y9NLbG6hOImd2acY8ZmhWyDEu/1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799491; c=relaxed/simple;
	bh=27OkYuOGUUdfi84lVV+j7hZS96O8AIg0mm1ln73wz2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHqkAKcu18oqPq/dPRAGyoK2e8hT788ji88E3KCbWBVIJ/OlL7REruUxrHBmJAXE5stcwT6eLpolozfd/ijmEmK5qz0mZ1P8Sj+opCBUwWDoK21dqWOiYT3RHgXV/k7XUGEDZosq/RF9QnxGOvKN7irdVOkMpkU6qQ/v3iYOGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmpCJHzu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51b57ea41so740185a12.2;
        Wed, 16 Apr 2025 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744799489; x=1745404289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D32T0CdHiX9syEkUflCYMqiwWk+v9ZkYuzEGhhatH7c=;
        b=KmpCJHzuyaGMZWFEAj/ZE3XqoJTj5BvPTBaApxLkYIlTHN1AZlY3RI218nOMdDOaAw
         E+46PPDWSjFZUJRXNiw055ZJKrFXOh3aF+rDJzx5YTebgchDB1pK6XGv4STxSVYsyNI5
         S1NGp3KvWsI0U1SyTTKHACloAI4hI8blnppKsK2uWyKr06EFgwKz2DuPnN1d6kcN6Be3
         Et7WSCxrqxMcJGmeB/mpUVx9acDyuT0SA6VLLdQfYgl4Un4CoFhIYiwYwrmOkLJNk8+l
         NNi44Nh5sYd0Bs7ql+kTITW/dTFlFb5TqNSyhEZmZDx3RjOehpzXG23zXeVP/FjJlFco
         3qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799489; x=1745404289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D32T0CdHiX9syEkUflCYMqiwWk+v9ZkYuzEGhhatH7c=;
        b=IkXwP4kNNZ8d/0QPMJtV9n1U9vWkYIY/acWNJqgWZ18KOpU4NMRRKyrU025x6iJ+TB
         XlEdldW8gMgghPfmnMeKoJP6BkI5j8Bk0uXdjUoD/QvAfj00PaTenKyLqJGrYOYhIgXu
         6UsMjhV7O+5hjz4voi2EBwUSJuW6iUdFcKwikE3jVOkR/ldIk7lPG7LsrhM/SfMM1ZuS
         Xpnk+Crn7B8XhVefEAddffisCJMjLWQCI2cTuo05kg/MMt5N0QDCAtQSmFqBuy1LVR/z
         i/fZZyA6GRy0i2wtN50C5ZTZKn4k8Qgx6U3EMP/t9tavwreMeeoatHcqB6zLkBdf1Xwl
         rUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNiVyAdqs+l7iAEhjjmxaA4nBCr85B8b6NAEzYXXLrYYf6UeflOV8E1AqagDkLDBppFyxf7ueSTjPmAMgEto=@vger.kernel.org, AJvYcCVxUy5FDr5/11TaZj/R3T+H5HuSRoee9TaFqRUD9Rn8nWRof+0TwwgL4GCgBEyiOTIMM5EQo8UfLwo=@vger.kernel.org, AJvYcCWfksMHXV2k5Ns0nH+BWtXFfBz6hyu3aWO3om7xwagglCEkQPcRZjWup1Zutwg/FKq2KFDUA8r+8Gctz+VH@vger.kernel.org, AJvYcCXVnVM3u0056L8wmoE0T7qS7LhNlVm5UryfxdvH1d5EUanba9e4yGpnxFzVg3vwCYzcwIweDqrzxcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPxDA7GznUmCWjeBSX+UDAaWZb1sZTIdxy2t30lzdBkhfIxey
	2lCq8+w7Fjj321pA9clFawby8laJ5FgBquPBPRlkQ610QKRoYNyRiSiJDdPqfaWB89XM1W71eN4
	8pwoojxJ4jqe6EaTYZhUC/7+unYg=
X-Gm-Gg: ASbGncu18noJEV3q7iJ/Wm5uNfBRj9ef7RuyfFOW40flo72lMDZkH3yiuf/kXvgMl5f
	3jUaitGstjFvtGLuL9v0oUCdSPMwHOSmdgwipMeM6AxsYiGYEq7IZ9fxB6xfaIlGWuSlR4/DFhX
	DhELqLGh21zclBFWitMZcMhg==
X-Google-Smtp-Source: AGHT+IFVBaVeklhFg8vEKdkB2fU0sPCoOXzPDv4HLRejSpcwC67vDdNf8GRCCAZbvABUaNnJmQbyKhcm13MHSpEKRG0=
X-Received: by 2002:a17:90b:1a91:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-30863d1dd1fmr578755a91.2.1744799489076; Wed, 16 Apr 2025
 03:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744783509.git.viresh.kumar@linaro.org> <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
 <Z_9v24SghlIhT62r@pollux> <20250416095943.f3jxy55bamekscst@vireshk-i7>
In-Reply-To: <20250416095943.f3jxy55bamekscst@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Apr 2025 12:31:15 +0200
X-Gm-Features: ATxdqUHNYlnL63Hpr69yW0Crawd1jAldhqFU9ww-cyVEd4_IloUCg4Z3mAOaEKI
Message-ID: <CANiq72=MQmUop5UzeeN-r7gAE0ep8Z+EUaLuA6exeazhZCHqLw@mail.gmail.com>
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with cpufreq support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:59=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> +// Frequency table implementation.

///

> +        // Returns a reference to the underlying [`cpufreq::Table`].

Ditto.

I wonder if we should have a `checkpatch.pl` warnings (not error) for
this -- it is not always a mistake, but there is a fair chance it is.
The likelihood increases if we notice things like ``[`...`]`` there.
Added:

    https://github.com/Rust-for-Linux/linux/issues/1157

Cheers,
Miguel

