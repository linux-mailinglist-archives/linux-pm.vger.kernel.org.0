Return-Path: <linux-pm+bounces-26914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D15AB0DB1
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2291C25C91
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E5275874;
	Fri,  9 May 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMJXFD7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8227586B;
	Fri,  9 May 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780226; cv=none; b=gLsDhS8EuKJInHUC8qs8fIwCHq7e5dxTCMGbB2LLYYtq0DFy+dieuT6Qsg15v1jRUge8/nLi+wBZeAW/2X6ijrNH6/+MIAPxcaLaSyDhB29WKE+zb1emDz2Z3dVNaM0PI271VcOQRl7rIKoy1lbX7/rmDcJc87bPBnF0lU9BlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780226; c=relaxed/simple;
	bh=D+Z3MPOOomLStRJL1NiuAWmq/XdQJ45mhJewSQu6uSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwea1stYNHMpfu+MaPP6C4RkEkVaunQzn8rYmTSnVP0RSS2dINNvIubQrWsZB/Ebka5lQdPzRKGy1aAZZHwJQk6yw40g2sEzQ/lCQTr9ZW04fZnwwsXCVFGpW0u99ksa8juJYc8B/fOehKIp0j9Ul3NsH+mx+up5yqMNoETnOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMJXFD7i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e1597a5abso2870175ad.0;
        Fri, 09 May 2025 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746780223; x=1747385023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Z3MPOOomLStRJL1NiuAWmq/XdQJ45mhJewSQu6uSs=;
        b=RMJXFD7ijQWGBpHWufRoc7MieAPslSTryiZ/REJWFYnricDnpv9lTG071wK1DVYoSn
         pe9VgQ/BtEjMDB+zkLlOcOg7IrLeXK0sAktMDCiTVH+MUwP8PIhEqq4UqFUIgcJ7TnaC
         jvptc8GN1beSgf2K+J34t9mSREORt0IA2/H8dXRWvNb5vcOsf1wKFwDt3uEN3C577w/K
         ZO8RsBO4KKj58iLD/hH3IcZBa4PzuGMUmHNY+zRyDR1E/sZ06m9hDakUyJVa0Ue2p7iB
         YUIibXf2HLZbD6UGqHiAwLoYL0HS21KlZbHXFcXpU1zZFOxabtA0rL/DBGvSh2mWL+Py
         8TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746780223; x=1747385023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+Z3MPOOomLStRJL1NiuAWmq/XdQJ45mhJewSQu6uSs=;
        b=EeB5DaV5RCyOt3id9zm1mSnmowcquYJTlTbQqKPi5R66GINopTVGNJZ0qUQ2gt6YSz
         YC2lLh1nxJ0+UtsBKZ71a5H6Qa2fdC98/ESOJH9mAFp3sG5f91CXa2kqH7ECxAARvgBD
         HNUQkrmzlKxFv2YjL/FO4u9ZVkbF0PMsAQgf4/vQcqPcsNQiRyoxYHsuKxCUworEMNAQ
         i5t+PAaQRfvPDGnQXXRvyHFKpsAQL5JIPaUqPl98avU2M0LCXQPZO2y7WCFpINesuclb
         dTOoU4odNfFuZdUBqy7A2EWi698mu0SOrTDZOaQ7t7uAKQtNbuhMovAva5LeIeENRELr
         Mrqw==
X-Forwarded-Encrypted: i=1; AJvYcCUgrC5yKvkXZ7LdexIzg4TbDLNOcSbHuOx36QAHCsmHXHafy0XVAnvRSQg1o9aaWsaEHSKaQ6D4F8ihqgCa@vger.kernel.org, AJvYcCUrrDaVvi96hzlMbMn27F6PUhqE5QWPCHZ4ZDYTlk8dlNReV61ygPY+RgpLTEKEf8N6ojYXlFk/ZfY=@vger.kernel.org, AJvYcCVg+8QMZYTwaSmqDDhrgSRX2ibqWd/1GWkU7EkRiVNbR2xCI/5hZDfpxctZS9J/7U+pNfQTi1UoZV4=@vger.kernel.org, AJvYcCWN2XEDhdo7W8FF2Pl6d6PSeoiuSSVrMNikZdWpIq5OBeDHLJKLzFbE7btYMtxBPlMT5bwFvq1NMrWFeb8knw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKveKz5CriEX/rOcBmBO9ECDj/Bdm9Qe5R+wCDfSyITh/xv0N
	T1i28pPPUmalyIIhui/BmEznTjdwLdUeAlu7v1rWI1vPZE/H3/qh4NcUH/NXITcx4bpqj2hqhC2
	F124fXvFNVs0QngCQlP4Oz5HVD5U=
X-Gm-Gg: ASbGncseyCAdX6YeP7CgMUCmM10x6mNxvgogUUemomtdF+eZvP1bE6EHodE2JQsmDcx
	283lOiMYD9CMCYze9/0zPEyIM9zI4g7oImP7YoVMuBJoAAzat7Def3acWkdxZLYFre5ZTAX24tB
	N02WTS8UvlSDkSst5nXIF8Tw==
X-Google-Smtp-Source: AGHT+IEJ5b65Q0v/CP2S0OTkUGvauUws7VombfalBDLX8YTyGJdmjd6kE+QjHM7Qv0bMlOEC/TCXzyk6KW7sbDKSNtw=
X-Received: by 2002:a17:902:e54f:b0:22f:b00d:fe59 with SMTP id
 d9443c01a7336-22fc8d98a69mr14263115ad.9.1746780223105; Fri, 09 May 2025
 01:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7> <20250506101311.142475-1-andrewjballance@gmail.com>
 <CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com> <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>
In-Reply-To: <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 9 May 2025 10:43:30 +0200
X-Gm-Features: AX0GCFtvP7qV0uyKskrVkXxx4K1dOjHrcNE79kiWKdjUal4cdNNd8gXeg84r6B4
Message-ID: <CANiq72mSDEwDQx6ePq20SRi40aCs95mwo6fShZ0WCK9rmiWVVQ@mail.gmail.com>
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Philip Li <philip.li@intel.com>, kbuild test robot <lkp@intel.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, a.hindborg@kernel.org, alex.bennee@linaro.org, 
	alex.gaynor@gmail.com, aliceryhl@google.com, anisse@astier.eu, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	bqe@google.com, dakr@kernel.org, dakr@redhat.com, 
	daniel.almeida@collabora.com, gary@garyguo.net, joakim.bech@linaro.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux@armlinux.org.uk, linux@rasmusvillemoes.dk, 
	manos.pitsidianakis@linaro.org, mturquette@baylibre.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, robh@kernel.org, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, vincent.guittot@linaro.org, vireshk@kernel.org, 
	yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 4:10=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> That's strange. I have tested this earlier and made sure such issues
> weren't there. I tried "next-20250507" now for arm64 (with qemu)
> with and without CONFIG_CPUMASK_OFFSTACK and still don't
> see these issues.
>
> Anything apart from this ?
>
> CONFIG_RUST_KERNEL_DOCTESTS=3Dy
>
> Sorry for the trouble, I thought this is all covered already
> (apart from x86 failure).

No worries, it happens!

I can still reproduce it on next-20250508 with defconfig RUST=3Dy
KUNIT=3Dy RUST_KERNEL_DOCTESTS=3Dy and then running in QEMU with e.g.
`-machine virt -cpu cortex-a53`.

Cheers,
Miguel

